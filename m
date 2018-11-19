Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97D8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B44224B3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MD/AICP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B44224B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406095AbeKTD1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:27:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405038AbeKTD1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:27:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3F48224E0;
        Mon, 19 Nov 2018 17:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646973;
        bh=tpyAANvdiwHuwLWmd0rVF2bEisx3TxO39w8DPFCbWvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MD/AICP4n7wn9R4idSdxDSXR7Hlw/TmGZS0/EbKDfpuh0lftAEAJThQn4FZWFmx7I
         nXTtL+IKQ3lcPGPsEeADKIBDnyA96aazz1sVwUlf2byFSXv7vwzWwjjbbdBLfViPGY
         nCD+VtYIxsie68skglFverJ/Lj8246f8w+ZJhpnI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.4 149/160] mount: Retest MNT_LOCKED in do_umount
Date:   Mon, 19 Nov 2018 17:29:48 +0100
Message-Id: <20181119162644.023073628@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric W. Biederman <ebiederm@xmission.com>

commit 25d202ed820ee347edec0bf3bf553544556bf64b upstream.

It was recently pointed out that the one instance of testing MNT_LOCKED
outside of the namespace_sem is in ksys_umount.

Fix that by adding a test inside of do_umount with namespace_sem and
the mount_lock held.  As it helps to fail fails the existing test is
maintained with an additional comment pointing out that it may be racy
because the locks are not held.

Cc: stable@vger.kernel.org
Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Fixes: 5ff9d8a65ce8 ("vfs: Lock in place mounts from more privileged users")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/namespace.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1584,8 +1584,13 @@ static int do_umount(struct mount *mnt,
 
 	namespace_lock();
 	lock_mount_hash();
-	event++;
 
+	/* Recheck MNT_LOCKED with the locks held */
+	retval = -EINVAL;
+	if (mnt->mnt.mnt_flags & MNT_LOCKED)
+		goto out;
+
+	event++;
 	if (flags & MNT_DETACH) {
 		if (!list_empty(&mnt->mnt_list))
 			umount_tree(mnt, UMOUNT_PROPAGATE);
@@ -1599,6 +1604,7 @@ static int do_umount(struct mount *mnt,
 			retval = 0;
 		}
 	}
+out:
 	unlock_mount_hash();
 	namespace_unlock();
 	return retval;
@@ -1681,7 +1687,7 @@ SYSCALL_DEFINE2(umount, char __user *, n
 		goto dput_and_out;
 	if (!check_mnt(mnt))
 		goto dput_and_out;
-	if (mnt->mnt.mnt_flags & MNT_LOCKED)
+	if (mnt->mnt.mnt_flags & MNT_LOCKED) /* Check optimistically */
 		goto dput_and_out;
 	retval = -EPERM;
 	if (flags & MNT_FORCE && !capable(CAP_SYS_ADMIN))


