Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB5BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3C72086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3C72086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbeICVoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:44:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45404 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbeICVoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:44:18 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A6152D0A;
        Mon,  3 Sep 2018 17:23:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vivek Gautam <vivek.gautam@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Subject: [PATCH 4.14 093/165] iommu/arm-smmu: Error out only if not enough context interrupts
Date:   Mon,  3 Sep 2018 18:56:19 +0200
Message-Id: <20180903165700.192628841@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vivek Gautam <vivek.gautam@codeaurora.org>

commit d1e20222d5372e951bbb2fd3f6489ec4a6ea9b11 upstream.

Currently we check if the number of context banks is not equal to
num_context_interrupts. However, there are booloaders such as, one
on sdm845 that reserves few context banks and thus kernel views
less than the total available context banks.
So, although the hardware definition in device tree would mention
the correct number of context interrupts, this number can be
greater than the number of context banks visible to smmu in kernel.
We should therefore error out only when the number of context banks
is greater than the available number of context interrupts.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Suggested-by: Tomasz Figa <tfiga@chromium.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
[will: drop useless printk]
Signed-off-by: Will Deacon <will.deacon@arm.com>
Cc: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/arm-smmu.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2100,12 +2100,16 @@ static int arm_smmu_device_probe(struct
 	if (err)
 		return err;
 
-	if (smmu->version == ARM_SMMU_V2 &&
-	    smmu->num_context_banks != smmu->num_context_irqs) {
-		dev_err(dev,
-			"found only %d context interrupt(s) but %d required\n",
-			smmu->num_context_irqs, smmu->num_context_banks);
-		return -ENODEV;
+	if (smmu->version == ARM_SMMU_V2) {
+		if (smmu->num_context_banks > smmu->num_context_irqs) {
+			dev_err(dev,
+			      "found only %d context irq(s) but %d required\n",
+			      smmu->num_context_irqs, smmu->num_context_banks);
+			return -ENODEV;
+		}
+
+		/* Ignore superfluous interrupts */
+		smmu->num_context_irqs = smmu->num_context_banks;
 	}
 
 	for (i = 0; i < smmu->num_global_irqs; ++i) {


