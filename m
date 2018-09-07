Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31578C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36BA2086B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36BA2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbeIHCNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:13:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48990 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbeIHCNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:13:08 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C6087E84;
        Fri,  7 Sep 2018 21:30:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.14 74/89] ubifs: Fix synced_i_size calculation for xattr inodes
Date:   Fri,  7 Sep 2018 23:10:08 +0200
Message-Id: <20180907210901.067933547@linuxfoundation.org>
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

commit 59965593205fa4044850d35ee3557cf0b7edcd14 upstream.

In ubifs_jnl_update() we sync parent and child inodes to the flash,
in case of xattrs, the parent inode (AKA host inode) has a non-zero
data_len. Therefore we need to adjust synced_i_size too.

This issue was reported by ubifs self tests unter a xattr related work
load.
UBIFS error (ubi0:0 pid 1896): dbg_check_synced_i_size: ui_size is 4, synced_i_size is 0, but inode is clean
UBIFS error (ubi0:0 pid 1896): dbg_check_synced_i_size: i_ino 65, i_mode 0x81a4, i_size 4

Cc: <stable@vger.kernel.org>
Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ubifs/journal.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -665,6 +665,11 @@ int ubifs_jnl_update(struct ubifs_info *
 	spin_lock(&ui->ui_lock);
 	ui->synced_i_size = ui->ui_size;
 	spin_unlock(&ui->ui_lock);
+	if (xent) {
+		spin_lock(&host_ui->ui_lock);
+		host_ui->synced_i_size = host_ui->ui_size;
+		spin_unlock(&host_ui->ui_lock);
+	}
 	mark_inode_clean(c, ui);
 	mark_inode_clean(c, host_ui);
 	return 0;


