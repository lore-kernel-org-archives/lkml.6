Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDA3C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383C0208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Uz8P+fE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383C0208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeH0SZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:25:03 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:49060 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeH0SZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:25:03 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 53ED910C1653;
        Mon, 27 Aug 2018 07:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535380689; bh=q3YqdrjAJZNRdEQQIlBP0LhqGoSbVJw0DCfhY77+6fk=;
        h=From:To:Cc:Subject:Date:From;
        b=Uz8P+fE/sB5SsoQD8hceADdrJJSp2Bh2Ne4c2X0USfD47mfhJNd3EuqqDybRVzkcT
         5LOa2gtbbbkW3NeVgSS3sEmsskuA01H8jxTJaqq7dRH7S5UHSGKHeUd8csZc0YEY9p
         /UpG2VqrDeofwWgKEBiYfby+fKZVMuUpUmwjLMvabXm6yalQ6IhL4dCNP5hHKF2H0r
         kzy5dno4+gMZftaX6Dx9WUJUwiB9/OnMGBY/rOziPvEc4kcpC2b/4X/UOy2aKH48pm
         sZ+iaN3I+I++uKxluCnUib31HoNKDMAVj4hG2/WGy+uYaNmVCBNr95BZwpCByZ+bP5
         oEXa52Pca+zyw==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.36])
        by mailhost.synopsys.com (Postfix) with ESMTP id B3E8755E0;
        Mon, 27 Aug 2018 07:38:06 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: HSDK: improve reset driver
Date:   Mon, 27 Aug 2018 17:38:03 +0300
Message-Id: <20180827143803.28178-1-Eugeniy.Paltsev@synopsys.com>
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
.assert()/.deassert() callbacks to avoid each reset controller
user adaptation for work with both reset methods
(reset() and .assert()/.deassert() pair)

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 drivers/reset/reset-hsdk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/reset/reset-hsdk.c b/drivers/reset/reset-hsdk.c
index 8bce391c6943..1fd91df91343 100644
--- a/drivers/reset/reset-hsdk.c
+++ b/drivers/reset/reset-hsdk.c
@@ -86,6 +86,8 @@ static int hsdk_reset_reset(struct reset_controller_dev *rcdev,
 
 static const struct reset_control_ops hsdk_reset_ops = {
 	.reset	= hsdk_reset_reset,
+	.assert = hsdk_reset_reset,
+	.deassert = hsdk_reset_reset,
 };
 
 static int hsdk_reset_probe(struct platform_device *pdev)
-- 
2.14.4

