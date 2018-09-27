Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035C9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5C72152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5C72152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbeI0PhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:37:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56266 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbeI0PhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:37:15 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8717C110D;
        Thu, 27 Sep 2018 09:19:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Joel Stanley <joel@jms.id.au>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.14 39/64] Revert "ubifs: xattr: Dont operate on deleted inodes"
Date:   Thu, 27 Sep 2018 11:03:56 +0200
Message-Id: <20180927090255.591958407@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090249.801943776@linuxfoundation.org>
References: <20180927090249.801943776@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Weinberger <richard@nod.at>

commit f061c1cc404a618858a77aea233fde0aeaad2f2d upstream.

This reverts commit 11a6fc3dc743e22fb50f2196ec55bee5140d3c52.
UBIFS wants to assert that xattr operations are only issued on files
with positive link count. The said patch made this operations return
-ENOENT for unlinked files such that the asserts will no longer trigger.
This was wrong since xattr operations are perfectly fine on unlinked
files.
Instead the assertions need to be fixed/removed.

Cc: <stable@vger.kernel.org>
Fixes: 11a6fc3dc743 ("ubifs: xattr: Don't operate on deleted inodes")
Reported-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
Tested-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ubifs/xattr.c |   24 ------------------------
 1 file changed, 24 deletions(-)

--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -152,12 +152,6 @@ static int create_xattr(struct ubifs_inf
 	ui->data_len = size;
 
 	mutex_lock(&host_ui->ui_mutex);
-
-	if (!host->i_nlink) {
-		err = -ENOENT;
-		goto out_noent;
-	}
-
 	host->i_ctime = current_time(host);
 	host_ui->xattr_cnt += 1;
 	host_ui->xattr_size += CALC_DENT_SIZE(fname_len(nm));
@@ -189,7 +183,6 @@ out_cancel:
 	host_ui->xattr_size -= CALC_XATTR_BYTES(size);
 	host_ui->xattr_names -= fname_len(nm);
 	host_ui->flags &= ~UBIFS_CRYPT_FL;
-out_noent:
 	mutex_unlock(&host_ui->ui_mutex);
 out_free:
 	make_bad_inode(inode);
@@ -241,12 +234,6 @@ static int change_xattr(struct ubifs_inf
 	mutex_unlock(&ui->ui_mutex);
 
 	mutex_lock(&host_ui->ui_mutex);
-
-	if (!host->i_nlink) {
-		err = -ENOENT;
-		goto out_noent;
-	}
-
 	host->i_ctime = current_time(host);
 	host_ui->xattr_size -= CALC_XATTR_BYTES(old_size);
 	host_ui->xattr_size += CALC_XATTR_BYTES(size);
@@ -268,7 +255,6 @@ static int change_xattr(struct ubifs_inf
 out_cancel:
 	host_ui->xattr_size -= CALC_XATTR_BYTES(size);
 	host_ui->xattr_size += CALC_XATTR_BYTES(old_size);
-out_noent:
 	mutex_unlock(&host_ui->ui_mutex);
 	make_bad_inode(inode);
 out_free:
@@ -497,12 +483,6 @@ static int remove_xattr(struct ubifs_inf
 		return err;
 
 	mutex_lock(&host_ui->ui_mutex);
-
-	if (!host->i_nlink) {
-		err = -ENOENT;
-		goto out_noent;
-	}
-
 	host->i_ctime = current_time(host);
 	host_ui->xattr_cnt -= 1;
 	host_ui->xattr_size -= CALC_DENT_SIZE(fname_len(nm));
@@ -522,7 +502,6 @@ out_cancel:
 	host_ui->xattr_size += CALC_DENT_SIZE(fname_len(nm));
 	host_ui->xattr_size += CALC_XATTR_BYTES(ui->data_len);
 	host_ui->xattr_names += fname_len(nm);
-out_noent:
 	mutex_unlock(&host_ui->ui_mutex);
 	ubifs_release_budget(c, &req);
 	make_bad_inode(inode);
@@ -562,9 +541,6 @@ static int ubifs_xattr_remove(struct ino
 
 	ubifs_assert(inode_is_locked(host));
 
-	if (!host->i_nlink)
-		return -ENOENT;
-
 	if (fname_len(&nm) > UBIFS_MAX_NLEN)
 		return -ENAMETOOLONG;
 


