Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E94C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 12:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B054420868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 12:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B054420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbeKXXWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 18:22:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35393 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeKXXWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 18:22:33 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gQX8V-0004SV-8a; Sat, 24 Nov 2018 12:34:11 +0000
From:   Colin King <colin.king@canonical.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] altera-stapl: check for a null key before strcasecmp'ing it
Date:   Sat, 24 Nov 2018 12:34:10 +0000
Message-Id: <20181124123410.7356-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the null check on key is occurring after the strcasecmp on
the key, hence there is a potential null pointer dereference on key.
Fix this by checking if key is null first. Also replace the == 0
check on strcasecmp with just the ! operator.

Detected by CoverityScan, CID#1248787 ("Dereference before null check")

Fixes: fa766c9be58b ("[media] Altera FPGA firmware download module")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/misc/altera-stapl/altera.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/altera-stapl/altera.c b/drivers/misc/altera-stapl/altera.c
index ef83a9078646..486b8aa63869 100644
--- a/drivers/misc/altera-stapl/altera.c
+++ b/drivers/misc/altera-stapl/altera.c
@@ -2176,8 +2176,7 @@ static int altera_get_note(u8 *p, s32 program_size,
 			key_ptr = &p[note_strings +
 					get_unaligned_be32(
 					&p[note_table + (8 * i)])];
-			if ((strncasecmp(key, key_ptr, strlen(key_ptr)) == 0) &&
-						(key != NULL)) {
+			if (key && !strncasecmp(key, key_ptr, strlen(key_ptr))) {
 				status = 0;
 
 				value_ptr = &p[note_strings +
-- 
2.19.1

