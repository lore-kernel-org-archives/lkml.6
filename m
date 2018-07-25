Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EF2C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FD920882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FD920882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbeGYOuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:50:18 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.47]:15324 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728529AbeGYOuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:50:17 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 6575410894
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 08:38:34 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id iJzuf4HgUBcCXiJzufhtql; Wed, 25 Jul 2018 08:38:34 -0500
X-Authority-Reason: nr=8
Received: from [189.250.102.68] (port=38786 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fiJzu-004Agd-0X; Wed, 25 Jul 2018 08:38:34 -0500
Date:   Wed, 25 Jul 2018 08:38:32 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] fsi: master-ast-cf: Fix memory leak
Message-ID: <20180725133832.GA20837@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.102.68
X-Source-L: No
X-Exim-ID: 1fiJzu-004Agd-0X
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.102.68]:38786
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case memory resources for *fw* were allocated, release them
before return.

Addresses-Coverity-ID: 1472044 ("Resource leak")
Fixes: 6a794a27daca ("fsi: master-ast-cf: Add new FSI master using Aspeed ColdFire")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/fsi/fsi-master-ast-cf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
index c4a3557..e39a4630 100644
--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -861,7 +861,8 @@ static int load_copro_firmware(struct fsi_master_acf *master)
 	if (sig != wanted_sig) {
 		dev_err(master->dev, "Failed to locate image sig %04x in FW blob\n",
 			wanted_sig);
-		return -ENODEV;
+		rc = -ENODEV;
+		goto release_fw;
 	}
 	if (size > master->cf_mem_size) {
 		dev_err(master->dev, "FW size (%zd) bigger than memory reserve (%zd)\n",
@@ -870,8 +871,9 @@ static int load_copro_firmware(struct fsi_master_acf *master)
 	} else {
 		memcpy_toio(master->cf_mem, data, size);
 	}
-	release_firmware(fw);
 
+release_fw:
+	release_firmware(fw);
 	return rc;
 }
 
-- 
2.7.4

