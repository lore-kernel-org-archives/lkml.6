Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA631C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E7220673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E7220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeK3KR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:17:27 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54226 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbeK3KR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:17:27 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gSVRp-0006Xt-4E; Thu, 29 Nov 2018 23:10:17 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: mgr: altera-ps-spi: make array dummy static, shrinks object size
Date:   Thu, 29 Nov 2018 23:10:16 +0000
Message-Id: <20181129231016.4580-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const array dummy on the stack but instead
make it static. Makes the object code smaller by 26 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
   7371	   2032	      0	   9403	   24bb	drivers/fpga/altera-ps-spi.o

After:
   text	   data	    bss	    dec	    hex	filename
   7281	   2096	      0	   9377	   24a1	drivers/fpga/altera-ps-spi.o

(gcc version 8.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/fpga/altera-ps-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 8c18beec6b57..678d0115f840 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -205,7 +205,7 @@ static int altera_ps_write_complete(struct fpga_manager *mgr,
 				    struct fpga_image_info *info)
 {
 	struct altera_ps_conf *conf = mgr->priv;
-	const char dummy[] = {0};
+	static const char dummy[] = {0};
 	int ret;
 
 	if (gpiod_get_value_cansleep(conf->status)) {
-- 
2.19.1

