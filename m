Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68737C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7B22070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277431;
	bh=Am3eF2pvMwoLihAow5lwxK2Uo4dnNlBKQTQSpbFKJEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ri9xFCQaUk3JhUf0TSBfRtabmz8HgaI6v6m+ed88cT57OIspPQzK0/udJ04ysg4cd
	 0pWhRmBCVOeLYY/zV+/J1fwmKt0UgVY0ql8KYRPoBQ99eRFETeUlSPuDu/LVg+OiCN
	 N8IF1hlIxNyHe6gPyL16DRseFgjES52pBHsCCFxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbfBDKu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:50:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:48284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731575AbfBDKu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:50:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78680217D6;
        Mon,  4 Feb 2019 10:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277426;
        bh=Am3eF2pvMwoLihAow5lwxK2Uo4dnNlBKQTQSpbFKJEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+fzUq6nZwXCmry/inT264vBnqZ3u0qCcWttztq1ynUadAkARQ/ycjKxyeacmrfw6
         5A64YOV1zEqeAJZ7Gy00P0tBLmt7Ji3BkTg5wwMB6905hHXdag2XtJQ78ab4cZtk10
         UQreMCIlbtx3kKP4ICWu+0z8zE1dvZjkY0gZz7jU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 60/74] btrfs: On error always free subvol_name in btrfs_mount
Date:   Mon,  4 Feb 2019 11:37:13 +0100
Message-Id: <20190204103627.804873370@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric W. Biederman <ebiederm@xmission.com>

commit 532b618bdf237250d6d4566536d4b6ce3d0a31fe upstream.

The subvol_name is allocated in btrfs_parse_subvol_options and is
consumed and freed in mount_subvol.  Add a free to the error paths that
don't call mount_subvol so that it is guaranteed that subvol_name is
freed when an error happens.

Fixes: 312c89fbca06 ("btrfs: cleanup btrfs_mount() using btrfs_mount_root()")
Cc: stable@vger.kernel.org # v4.19+
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/super.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1677,6 +1677,7 @@ static struct dentry *btrfs_mount(struct
 				flags | SB_RDONLY, device_name, data);
 			if (IS_ERR(mnt_root)) {
 				root = ERR_CAST(mnt_root);
+				kfree(subvol_name);
 				goto out;
 			}
 
@@ -1686,12 +1687,14 @@ static struct dentry *btrfs_mount(struct
 			if (error < 0) {
 				root = ERR_PTR(error);
 				mntput(mnt_root);
+				kfree(subvol_name);
 				goto out;
 			}
 		}
 	}
 	if (IS_ERR(mnt_root)) {
 		root = ERR_CAST(mnt_root);
+		kfree(subvol_name);
 		goto out;
 	}
 


