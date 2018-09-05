Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA198C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758892075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758892075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeIEVJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:09:19 -0400
Received: from foss.arm.com ([217.140.101.70]:32910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbeIEVJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:09:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCD3F7A9;
        Wed,  5 Sep 2018 09:38:20 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D2F983F5BC;
        Wed,  5 Sep 2018 09:38:18 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     arm@kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Kevin Hilman <khilman@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] firmware: arm_scmi: fix divide by zero when sustained_perf_level is zero
Date:   Wed,  5 Sep 2018 17:38:11 +0100
Message-Id: <1536165491-27813-1-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firmware can provide zero as values for sustained performance level and
corresponding sustained frequency in kHz in order to hide the actual
frequencies and provide only abstract values. It may endup with divide
by zero scenario resulting in kernel panic.

Let's set the multiplication factor to one if either one or both of them
(sustained_perf_level and sustained_freq) are set to zero.

Fixes: a9e3fbfaa0ff ("firmware: arm_scmi: add initial support for performance protocol")
Reported-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/perf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Hi ARM SoC team,

Can you pick this patch directly ?

Regards,
Sudeep

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 721e6c57beae..51c08394026b 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -166,7 +166,12 @@ scmi_perf_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 					le32_to_cpu(attr->sustained_freq_khz);
 		dom_info->sustained_perf_level =
 					le32_to_cpu(attr->sustained_perf_level);
-		dom_info->mult_factor =	(dom_info->sustained_freq_khz * 1000) /
+		if (!dom_info->sustained_freq_khz ||
+		    !dom_info->sustained_perf_level)
+			dom_info->mult_factor =	1;
+		else
+			dom_info->mult_factor =
+					(dom_info->sustained_freq_khz * 1000) /
 					dom_info->sustained_perf_level;
 		memcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
 	}
--
2.7.4

