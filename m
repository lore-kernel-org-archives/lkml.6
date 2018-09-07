Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9689AC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571B42083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571B42083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbeIHCMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:12:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48982 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbeIHCMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:12:33 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5B2D3ED1;
        Fri,  7 Sep 2018 21:29:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.14 73/89] ubifs: xattr: Dont operate on deleted inodes
Date:   Fri,  7 Sep 2018 23:10:07 +0200
Message-Id: <20180907210900.996405531@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210852.341064285@linuxfoundation.org>
References: <20180907210852.341064285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Weinberger <richard@nod.at>

commit 11a6fc3dc743e22fb50f2196ec55bee5140d3c52 upstream.

xattr operations can race with unlink and the following assert triggers:
UBIFS assert failed in ubifs_jnl_change_xattr at 1606 (pid 6256)

Fix this by checking i_nlink before working on the host inode.

Cc: <stable@vger.kernel.org>
Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ubifs/xattr.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -152,6 +152,12 @@ static int create_xattr(struct ubifs_inf
 	ui->data_len = size;
 
 	mutex_lock(&host_ui->ui_mutex);
+
+	if (!host->i_nlink) {
+		err = -ENOENT;
+		goto out_noent;
+	}
+
 	host->i_ctime = current_time(host);
 	host_ui->xattr_cnt += 1;
 	host_ui->xattr_size += CALC_DENT_SIZE(fname_len(nm));
@@ -183,6 +189,7 @@ out_cancel:
 	host_ui->xattr_size -= CALC_XATTR_BYTES(size);
 	host_ui->xattr_names -= fname_len(nm);
 	host_ui->flags &= ~UBIFS_CRYPT_FL;
+out_noent:
 	mutex_unlock(&host_ui->ui_mutex);
 out_free:
 	make_bad_inode(inode);
@@ -234,6 +241,12 @@ static int change_xattr(struct ubifs_inf
 	mutex_unlock(&ui->ui_mutex);
 
 	mutex_lock(&host_ui->ui_mutex);
+
+	if (!host->i_nlink) {
+		err = -ENOENT;
+		goto out_noent;
+	}
+
 	host->i_ctime = current_time(host);
 	host_ui->xattr_size -= CALC_XATTR_BYTES(old_size);
 	host_ui->xattr_size += CALC_XATTR_BYTES(size);
@@ -255,6 +268,7 @@ static int change_xattr(struct ubifs_inf
 out_cancel:
 	host_ui->xattr_size -= CALC_XATTR_BYTES(size);
 	host_ui->xattr_size += CALC_XATTR_BYTES(old_size);
+out_noent:
 	mutex_unlock(&host_ui->ui_mutex);
 	make_bad_inode(inode);
 out_free:
@@ -483,6 +497,12 @@ static int remove_xattr(struct ubifs_inf
 		return err;
 
 	mutex_lock(&host_ui->ui_mutex);
+
+	if (!host->i_nlink) {
+		err = -ENOENT;
+		goto out_noent;
+	}
+
 	host->i_ctime = current_time(host);
 	host_ui->xattr_cnt -= 1;
 	host_ui->xattr_size -= CALC_DENT_SIZE(fname_len(nm));
@@ -502,6 +522,7 @@ out_cancel:
 	host_ui->xattr_size += CALC_DENT_SIZE(fname_len(nm));
 	host_ui->xattr_size += CALC_XATTR_BYTES(ui->data_len);
 	host_ui->xattr_names += fname_len(nm);
+out_noent:
 	mutex_unlock(&host_ui->ui_mutex);
 	ubifs_release_budget(c, &req);
 	make_bad_inode(inode);
@@ -541,6 +562,9 @@ static int ubifs_xattr_remove(struct ino
 
 	ubifs_assert(inode_is_locked(host));
 
+	if (!host->i_nlink)
+		return -ENOENT;
+
 	if (fname_len(&nm) > UBIFS_MAX_NLEN)
 		return -ENAMETOOLONG;
 


