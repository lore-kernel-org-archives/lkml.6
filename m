Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13592C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD97321486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD97321486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388158AbeIXSeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:34:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58126 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbeIXSeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:34:15 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 503951018;
        Mon, 24 Sep 2018 12:32:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 091/235] iommu/ipmmu-vmsa: IMUCTRn.TTSEL needs a special usage on R-Car Gen3
Date:   Mon, 24 Sep 2018 13:51:17 +0200
Message-Id: <20180924113114.268291507@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit 2ae86955703e9e6a119af4bbe27f6b6dd7a43131 ]

The TTSEL bit of IMUCTRn register of R-Car Gen3 needs to be set
unused MMU context number even if uTLBs are disabled
(The MMUEN bit of IMUCTRn register = 0).
Since initial values of IMUCTRn.TTSEL on all IPMMU-domains are 0,
this patch adds a new feature "reserved_context" to reserve IPMMU
context number 0 as the unused MMU context.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/ipmmu-vmsa.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -47,6 +47,7 @@ struct ipmmu_features {
 	unsigned int number_of_contexts;
 	bool setup_imbuscr;
 	bool twobit_imttbcr_sl0;
+	bool reserved_context;
 };
 
 struct ipmmu_vmsa_device {
@@ -916,6 +917,7 @@ static const struct ipmmu_features ipmmu
 	.number_of_contexts = 1, /* software only tested with one context */
 	.setup_imbuscr = true,
 	.twobit_imttbcr_sl0 = false,
+	.reserved_context = false,
 };
 
 static const struct ipmmu_features ipmmu_features_r8a7795 = {
@@ -924,6 +926,7 @@ static const struct ipmmu_features ipmmu
 	.number_of_contexts = 8,
 	.setup_imbuscr = false,
 	.twobit_imttbcr_sl0 = true,
+	.reserved_context = true,
 };
 
 static const struct of_device_id ipmmu_of_ids[] = {
@@ -1017,6 +1020,11 @@ static int ipmmu_probe(struct platform_d
 		}
 
 		ipmmu_device_reset(mmu);
+
+		if (mmu->features->reserved_context) {
+			dev_info(&pdev->dev, "IPMMU context 0 is reserved\n");
+			set_bit(0, mmu->ctx);
+		}
 	}
 
 	/*


