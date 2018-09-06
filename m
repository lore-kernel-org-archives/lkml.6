Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8F9C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BB720659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BB720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbeIFTqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:46:45 -0400
Received: from foss.arm.com ([217.140.101.70]:47116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730093AbeIFTqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:46:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 564A77A9;
        Thu,  6 Sep 2018 08:10:47 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.Emea.Arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AB2163F557;
        Thu,  6 Sep 2018 08:10:45 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     arm@kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Kevin Hilman <khilman@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] firmware: arm_scmi: fix divide by zero when sustained_perf_level is zero
Date:   Thu,  6 Sep 2018 16:10:39 +0100
Message-Id: <1536246639-7420-1-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536165491-27813-1-git-send-email-sudeep.holla@arm.com>
References: <1536165491-27813-1-git-send-email-sudeep.holla@arm.com>
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
 drivers/firmware/arm_scmi/perf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Hi ARM SoC team,

Can you pick this patch directly ?

Regards,
Sudeep

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 721e6c57beae..64342944d917 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -166,7 +166,13 @@ scmi_perf_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 					le32_to_cpu(attr->sustained_freq_khz);
 		dom_info->sustained_perf_level =
 					le32_to_cpu(attr->sustained_perf_level);
-		dom_info->mult_factor =	(dom_info->sustained_freq_khz * 1000) /
+		if (!dom_info->sustained_freq_khz ||
+		    !dom_info->sustained_perf_level)
+			/* CPUFreq converts to kHz, hence default 1000 */
+			dom_info->mult_factor =	1000;
+		else
+			dom_info->mult_factor =
+					(dom_info->sustained_freq_khz * 1000) /
 					dom_info->sustained_perf_level;
 		memcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
 	}
--
2.7.4

