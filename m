Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754632AbeE2GWF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 02:22:05 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35232 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754205AbeE2GWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 02:22:02 -0400
X-Google-Smtp-Source: AB8JxZq6KhbtwEaeR/jwjBbI5/+CriVs0iWY3hKp5Pt8NhSQA2PrcvEDCuyQ5K3cbRGQfGxr+S2W/Q==
From: Nick Desaulniers <nick.desaulniers@gmail.com>
To: tytso@mit.edu, adilger.kernel@dilger.ca
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: prefer strlcpy to strncpy
Date: Mon, 28 May 2018 23:21:53 -0700
Message-Id: <1527574913-10561-1-git-send-email-nick.desaulniers@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a stringop-truncation warning from gcc-8.

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
---
 fs/ext4/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index eb104e8..d47c85f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -323,11 +323,11 @@ static void __save_error_info(struct super_block *sb, const char *func,
 		return;
 	es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
 	es->s_last_error_time = cpu_to_le32(get_seconds());
-	strncpy(es->s_last_error_func, func, sizeof(es->s_last_error_func));
+	strlcpy(es->s_last_error_func, func, sizeof(es->s_last_error_func));
 	es->s_last_error_line = cpu_to_le32(line);
 	if (!es->s_first_error_time) {
 		es->s_first_error_time = es->s_last_error_time;
-		strncpy(es->s_first_error_func, func,
+		strlcpy(es->s_first_error_func, func,
 			sizeof(es->s_first_error_func));
 		es->s_first_error_line = cpu_to_le32(line);
 		es->s_first_error_ino = es->s_last_error_ino;
-- 
2.7.4
