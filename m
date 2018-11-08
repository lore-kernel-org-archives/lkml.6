Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F72ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0600F208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoFTr2iL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0600F208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbeKIHfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:35:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:52208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbeKIHfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:35:23 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 689E620892;
        Thu,  8 Nov 2018 21:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714275;
        bh=c6aHQjGN6dS0t7GTmSvC8qInOTRIBgOm32XxxhMt4PE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JoFTr2iLtI7H3ubb/jKkWY4rcwKpOPiLmFXns/UiEi73cBt/zsusSyTa4gdN5EgHs
         FbUKIrl+CPe/td/9IhEadekwyQeIErqgYE8QDThkeG/ZLca25HOu6wXKrG550odHyq
         645QTRDoDsk8C+e1hIzxlzg4l30FGY0e/AQN/Y78=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH 3.18 141/144] cachefiles: fix the race between cachefiles_bury_object() and rmdir(2)
Date:   Thu,  8 Nov 2018 13:51:52 -0800
Message-Id: <20181108215108.413520368@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 169b803397499be85bdd1e3d07d6f5e3d4bd669e upstream.

the victim might've been rmdir'ed just before the lock_rename();
unlike the normal callers, we do not look the source up after the
parents are locked - we know it beforehand and just recheck that it's
still the child of what used to be its parent.  Unfortunately,
the check is too weak - we don't spot a dead directory since its
->d_parent is unchanged, dentry is positive, etc.  So we sail all
the way to ->rename(), with hosting filesystems _not_ expecting
to be asked renaming an rmdir'ed subdirectory.

The fix is easy, fortunately - the lock on parent is sufficient for
making IS_DEADDIR() on child safe.

Cc: stable@vger.kernel.org
Fixes: 9ae326a69004 (CacheFiles: A cache that backs onto a mounted filesystem)
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cachefiles/namei.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -317,7 +317,7 @@ try_again:
 	trap = lock_rename(cache->graveyard, dir);
 
 	/* do some checks before getting the grave dentry */
-	if (rep->d_parent != dir) {
+	if (rep->d_parent != dir || IS_DEADDIR(d_inode(rep))) {
 		/* the entry was probably culled when we dropped the parent dir
 		 * lock */
 		unlock_rename(cache->graveyard, dir);


