Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746E8ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A1A2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="beRoVN4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A1A2151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeJQWBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:01:50 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:42056 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJQWBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:01:50 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D0CE310C12FE;
        Wed, 17 Oct 2018 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1539785159; bh=J7xcbxXKC3aKcLaVm5lUnbVtbt6PuirkVMw2rCg6bxc=;
        h=From:To:Cc:Subject:Date:From;
        b=beRoVN4xoj5BPkmikl5VmL1YfFNhXqQV7GZyNanrDnJhQggTZhYoSIM3OhWQ2XjwX
         tBMksGHo+Eb2V31q0as6aU+1Po4qbfHo8z60OhFtvksCr/ezBaCScHfc1MS4gR8Gqq
         vXME6NxWoD5EPjK8gpSWA7cAD9a09tB9QIW+2vrxBDljOvSma8+D5HoP+KPAivhTDG
         B1eucfnJjwoZbPtOUvE9+B2tBAsHkobl6O4DZRJrEk3RZ8TLlp3FAOUXUdN6NDgDjN
         Pz7+NruN7bHMKq2pr0tghliNPpPBIBPqrMArm69jiK3xfsbbqlihhdKodF6b7gaQd1
         fVeFHFAY9iQFQ==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.38])
        by mailhost.synopsys.com (Postfix) with ESMTP id BF5AC3866;
        Wed, 17 Oct 2018 07:05:56 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v3] ARC: HSDK: improve reset driver
Date:   Wed, 17 Oct 2018 17:05:52 +0300
Message-Id: <20181017140552.7331-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As for today HSDK reset driver implements only .reset() callback.

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
Changes v2->v3:
 * Drop dummy .assert callback.

 drivers/reset/reset-hsdk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/reset-hsdk.c b/drivers/reset/reset-hsdk.c
index 8bce391c6943..4c7b8647b49c 100644
--- a/drivers/reset/reset-hsdk.c
+++ b/drivers/reset/reset-hsdk.c
@@ -86,6 +86,7 @@ static int hsdk_reset_reset(struct reset_controller_dev *rcdev,
 
 static const struct reset_control_ops hsdk_reset_ops = {
 	.reset	= hsdk_reset_reset,
+	.deassert = hsdk_reset_reset,
 };
 
 static int hsdk_reset_probe(struct platform_device *pdev)
-- 
2.14.4

