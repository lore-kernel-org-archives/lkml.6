Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9768C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B6220851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="nGkqjhI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B6220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbeLMCHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:07:03 -0500
Received: from mx.aristanetworks.com ([162.210.129.12]:58337 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726344AbeLMCHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:07:02 -0500
X-Greylist: delayed 559 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Dec 2018 21:07:02 EST
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 1075F2CDC;
        Wed, 12 Dec 2018 17:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1544666263;
        bh=eUtNXhHcs9ueVbI76Nf8KJFcSlkSxX6dwssFf0NIdJI=;
        h=Date:From:To:Cc:Subject;
        b=nGkqjhI7z14HXrw/HXIhrMN6ZjshMkCshLElXXcTdxyDsw2ka+5KOw+7gEX/RWB4M
         Dc2ESvHYpvsGQuc1Q8CH+TzU8/IssSnFkj+ehtGObBNCZm+NChqILKW0sjrdFrI5lV
         MWJ6ulSWQvGc9IYE1y/CCC1mNoURdieNfBC5zJGLfjI6uMAlvao2m5+Fu4XiN0xlsx
         1UCjpFeWuzk1uBe8FtXinm+Bt3YkKTqwHMzYN17bBTkoiesbE1S/7IGZmoGCzll8E8
         Gwiqiu3+3UbglrVxJteqAvMdbpYtfoofiJTdjvgdYGmFFyOfo+DtNruWnDc1ecJtvX
         elZI/8MqCAtNA==
Received: from visor (unknown [172.20.208.17])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 01FC62C82;
        Wed, 12 Dec 2018 17:57:43 -0800 (PST)
Date:   Wed, 12 Dec 2018 17:57:43 -0800
From:   Ivan Delalande <colona@arista.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc/sysctl: don't return ENOMEM on lookup when a table is
 unregistering
Message-ID: <20181213015742.GA28776@visor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

proc_sys_lookup can fail with ENOMEM instead of ENOENT when the
corresponding sysctl table is being unregistered. In our case we see
this upon opening /proc/sys/net/*/conf files while network interfaces
are being removed, which confuses our configuration daemon.

The problem was successfully reproduced and this fix tested on v4.9.122
and v4.20-rc6.

Fixes: ace0c791e6c3 ("proc/sysctl: Don't grab i_lock under sysctl_lock.")
Cc: stable@vger.kernel.org
Signed-off-by: Ivan Delalande <colona@arista.com>
---
 fs/proc/proc_sysctl.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 89921a0d2ebb..834be5bc3d07 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -474,7 +474,7 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
 	if (unlikely(head->unregistering)) {
 		spin_unlock(&sysctl_lock);
 		iput(inode);
-		inode = NULL;
+		inode = ERR_PTR(-ENOENT);
 		goto out;
 	}
 	ei->sysctl = head;
@@ -549,10 +549,11 @@ static struct dentry *proc_sys_lookup(struct inode *dir, struct dentry *dentry,
 			goto out;
 	}
 
-	err = ERR_PTR(-ENOMEM);
 	inode = proc_sys_make_inode(dir->i_sb, h ? h : head, p);
-	if (!inode)
+	if (IS_ERR_OR_NULL(inode)) {
+		err = inode ? ERR_CAST(inode) : ERR_PTR(-ENOMEM);
 		goto out;
+	}
 
 	d_set_d_op(dentry, &proc_sys_dentry_operations);
 	err = d_splice_alias(inode, dentry);
@@ -685,7 +686,7 @@ static bool proc_sys_fill_cache(struct file *file,
 		if (d_in_lookup(child)) {
 			struct dentry *res;
 			inode = proc_sys_make_inode(dir->d_sb, head, table);
-			if (!inode) {
+			if (IS_ERR_OR_NULL(inode)) {
 				d_lookup_done(child);
 				dput(child);
 				return false;
-- 
2.20.0
