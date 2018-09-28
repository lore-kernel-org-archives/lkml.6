Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A59C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED1C2064E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="W945o5qf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED1C2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbeI1Wxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:53:34 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:37098 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeI1Wxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:53:34 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D8BBB24E0F92;
        Fri, 28 Sep 2018 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1538152142; bh=/JD/Tezb0aJc21feiQLo0Y5EimHxriYofNL0REfYIeo=;
        h=From:To:Cc:Subject:Date:From;
        b=W945o5qfft6UFKptw47HnpTR+WFORpIgObxryPUfGufSSwORZmXZbmNIGlFEzDTI1
         0Pe9ZXNT4Sz9Iy0vIYqiueeJkcXqbrPxVw79HrFGE2qdHTbMpfKreNePQfwJuBafHw
         ZoscynmNfsDnrCK5R8x6IGcZl7I8riP2jaimG08U2qndFdFWoAGsVgXgtfdW6dSLbM
         1WRrjW5V+52YK1dmFs+EN1jqDduTJnmsK2uNZgBdXJbc2GUgi3GuMSCt3B4BTw+Uyj
         3meGSD/xGI1n5D9uKycz0xXrw+CXp7WrMA3jG9MWOKKcIpusau/odQmFbNNdQRZ//b
         VuEgS85lV0OMw==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.38])
        by mailhost.synopsys.com (Postfix) with ESMTP id 92412349D;
        Fri, 28 Sep 2018 09:28:59 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2] ARC: HSDK: improve reset driver
Date:   Fri, 28 Sep 2018 19:28:56 +0300
Message-Id: <20180928162856.4726-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As for today HSDK reset driver implements only
.reset() callback.

In case of driver which implements one of standard
reset controller usage pattern
(call *_deassert() in probe(), call *_assert() in remove())
that leads to inoperability of this reset driver.

Improve HSDK reset driver by calling .reset() callback inside of
.deassert() callback to avoid each reset controller
user adaptation for work with both reset methods
(reset() and {.assert() & .deassert()} pair)

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Changes v1->v2:
 * Don't call hsdk_reset_reset in .assert callback.

 drivers/reset/reset-hsdk.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/reset/reset-hsdk.c b/drivers/reset/reset-hsdk.c
index 8bce391c6943..399440f197c5 100644
--- a/drivers/reset/reset-hsdk.c
+++ b/drivers/reset/reset-hsdk.c
@@ -84,8 +84,21 @@ static int hsdk_reset_reset(struct reset_controller_dev *rcdev,
 	return ret;
 }
 
+static int hsdk_reset_dummy(struct reset_controller_dev *rcd, unsigned long id)
+{
+	return 0;
+}
+
+/*
+ * Doing real reset from .assert isn't necessary/useful here. So we pass
+ * 'hsdk_reset_dummy' to .assert callback to prevent -ENOTSUPP returning by
+ * reset_control_assert() to make happy drivers which check
+ * reset_control_{assert | deassert} return status.
+ */
 static const struct reset_control_ops hsdk_reset_ops = {
 	.reset	= hsdk_reset_reset,
+	.assert = hsdk_reset_dummy,
+	.deassert = hsdk_reset_reset,
 };
 
 static int hsdk_reset_probe(struct platform_device *pdev)
-- 
2.14.4

