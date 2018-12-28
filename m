Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B398C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DD22148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999331;
	bh=yI0MqnuWgBm4DRSxQ7CUx+PxBvmsb5JnRpnqpvXjh9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u5ZllIMHOCJy5fOzVcUxpT+sKRR3aOYHW+bj8zYnncn5lUy0jyQRIO+gHVZfke2Ez
	 IhrUoQbHEUMxdrge41U/E+3f5cGOooym9lAfZIEFmg9guGZUHeDDU/JZfxSH//IAG8
	 cTKB4HafadpzfiMSIWG90sIQrEo+oVGwnxb1To+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbeL1MPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:15:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732244AbeL1MP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:15:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB371218F0;
        Fri, 28 Dec 2018 12:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999326;
        bh=yI0MqnuWgBm4DRSxQ7CUx+PxBvmsb5JnRpnqpvXjh9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sf+UMwpbeDew9iAA2Ug/cV6TIbjTPMOob67iVhS49BobTehIheS188Guy08myBSNJ
         qPa5xFlitXfUdJryvviaxm2ZfS4uY/IxDXYvP8NWFXPm6bkGdqXMFKPG87KS2Pwwgi
         17qOHQs49TmMKkdDh9by6iZssYV4mPRPdydBuNsk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ivan Delalande <colona@arista.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.19 45/46] proc/sysctl: dont return ENOMEM on lookup when a table is unregistering
Date:   Fri, 28 Dec 2018 12:52:39 +0100
Message-Id: <20181228113127.606449021@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
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

From: Ivan Delalande <colona@arista.com>

commit ea5751ccd665a2fd1b24f9af81f6167f0718c5f6 upstream.

proc_sys_lookup can fail with ENOMEM instead of ENOENT when the
corresponding sysctl table is being unregistered. In our case we see
this upon opening /proc/sys/net/*/conf files while network interfaces
are being deleted, which confuses our configuration daemon.

The problem was successfully reproduced and this fix tested on v4.9.122
and v4.20-rc6.

v2: return ERR_PTRs in all cases when proc_sys_make_inode fails instead
of mixing them with NULL. Thanks Al Viro for the feedback.

Fixes: ace0c791e6c3 ("proc/sysctl: Don't grab i_lock under sysctl_lock.")
Cc: stable@vger.kernel.org
Signed-off-by: Ivan Delalande <colona@arista.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/proc/proc_sysctl.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -464,7 +464,7 @@ static struct inode *proc_sys_make_inode
 
 	inode = new_inode(sb);
 	if (!inode)
-		goto out;
+		return ERR_PTR(-ENOMEM);
 
 	inode->i_ino = get_next_ino();
 
@@ -474,8 +474,7 @@ static struct inode *proc_sys_make_inode
 	if (unlikely(head->unregistering)) {
 		spin_unlock(&sysctl_lock);
 		iput(inode);
-		inode = NULL;
-		goto out;
+		return ERR_PTR(-ENOENT);
 	}
 	ei->sysctl = head;
 	ei->sysctl_entry = table;
@@ -500,7 +499,6 @@ static struct inode *proc_sys_make_inode
 	if (root->set_ownership)
 		root->set_ownership(head, table, &inode->i_uid, &inode->i_gid);
 
-out:
 	return inode;
 }
 
@@ -549,10 +547,11 @@ static struct dentry *proc_sys_lookup(st
 			goto out;
 	}
 
-	err = ERR_PTR(-ENOMEM);
 	inode = proc_sys_make_inode(dir->i_sb, h ? h : head, p);
-	if (!inode)
+	if (IS_ERR(inode)) {
+		err = ERR_CAST(inode);
 		goto out;
+	}
 
 	d_set_d_op(dentry, &proc_sys_dentry_operations);
 	err = d_splice_alias(inode, dentry);
@@ -685,7 +684,7 @@ static bool proc_sys_fill_cache(struct f
 		if (d_in_lookup(child)) {
 			struct dentry *res;
 			inode = proc_sys_make_inode(dir->d_sb, head, table);
-			if (!inode) {
+			if (IS_ERR(inode)) {
 				d_lookup_done(child);
 				dput(child);
 				return false;


