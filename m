Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4AEC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD9C2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD9C2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeIHCUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:20:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52542 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbeIHCUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:20:23 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 34356D6B;
        Fri,  7 Sep 2018 21:37:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.9 52/63] ubifs: Fix synced_i_size calculation for xattr inodes
Date:   Fri,  7 Sep 2018 23:10:23 +0200
Message-Id: <20180907211015.839807423@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907211012.965501324@linuxfoundation.org>
References: <20180907211012.965501324@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -661,6 +661,11 @@ int ubifs_jnl_update(struct ubifs_info *
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


