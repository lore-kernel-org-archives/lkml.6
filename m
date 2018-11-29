Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B54C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953C420673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953C420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeK3KXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:23:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54302 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbeK3KXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:23:08 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gSVXI-0006oL-Jd; Thu, 29 Nov 2018 23:15:56 +0000
From:   Colin King <colin.king@canonical.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: ti-st: make array read_ver_cmd static, shrinks object size
Date:   Thu, 29 Nov 2018 23:15:56 +0000
Message-Id: <20181129231556.4776-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const array read_ver_cmd on the stack but instead
make it static. Makes the object code smaller by 42 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  17262	   6928	    192	  24382	   5f3e	drivers/misc/ti-st/st_kim.o

After:
   text	   data	    bss	    dec	    hex	filename
  17156	   6992	    192	  24340	   5f14	drivers/misc/ti-st/st_kim.o

(gcc version 8.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/misc/ti-st/st_kim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index 1874ac922166..8e82983bef9d 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -211,7 +211,7 @@ static void kim_int_recv(struct kim_data_s *kim_gdata,
 static long read_local_version(struct kim_data_s *kim_gdata, char *bts_scr_name)
 {
 	unsigned short version = 0, chip = 0, min_ver = 0, maj_ver = 0;
-	const char read_ver_cmd[] = { 0x01, 0x01, 0x10, 0x00 };
+	static const char read_ver_cmd[] = { 0x01, 0x01, 0x10, 0x00 };
 	long timeout;
 
 	pr_debug("%s", __func__);
-- 
2.19.1

