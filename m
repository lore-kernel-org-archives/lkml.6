Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68D0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65014224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdlT8hbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65014224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbeKMACo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:02:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:42734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729794AbeKMACo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 19:02:44 -0500
Received: from localhost.localdomain (unknown [49.77.232.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C577223DD;
        Mon, 12 Nov 2018 14:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542031758;
        bh=IdEl2x0qXIxEuJEoYzMyC9ssnI2eRPYK/waE/G7nqOg=;
        h=From:To:Cc:Subject:Date:From;
        b=GdlT8hbBAQAnyFrS75IciNMgCHJ6hz57yqX1LPDl6ZJlmQrSL0630We91SWGDV0b4
         dmIPttMI8hjJ552TYFNB6nqXprO9im2Rkm01P9FxGgk4k+7C4OiM9kLvInQhIW/Hhb
         z1Rlig11u0J8gOJwO1IVXD6sc2slyFC4+KXqC7ns=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3] f2fs: fix to be aware discard/preflush/dio command in is_idle()
Date:   Mon, 12 Nov 2018 00:55:44 +0800
Message-Id: <20181111165544.14667-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

This patch adds missing in-flight discard/preflush/dio command count
check in is_idle().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- add in-flight r/w dio count check as well.
 fs/f2fs/f2fs.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 97c35036bf49..b1d5031be2d5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2157,7 +2157,11 @@ static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 {
 	if (get_pages(sbi, F2FS_RD_DATA) || get_pages(sbi, F2FS_RD_NODE) ||
 		get_pages(sbi, F2FS_RD_META) || get_pages(sbi, F2FS_WB_DATA) ||
-		get_pages(sbi, F2FS_WB_CP_DATA))
+		get_pages(sbi, F2FS_WB_CP_DATA) ||
+		get_pages(sbi, F2FS_DIO_READ) ||
+		get_pages(sbi, F2FS_DIO_WRITE) ||
+		atomic_read(&SM_I(sbi)->dcc_info->issing_discard) ||
+		atomic_read(&SM_I(sbi)->fcc_info->issing_flush))
 		return false;
 	return f2fs_time_over(sbi, type);
 }
-- 
2.18.0

