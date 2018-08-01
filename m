Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCB2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085BF20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085BF20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404230AbeHATDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:03:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46076 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404155AbeHATDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:34 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6193EF98;
        Wed,  1 Aug 2018 16:57:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 094/336] drivers/bus: arm-cci: fix build warnings
Date:   Wed,  1 Aug 2018 18:47:09 +0200
Message-Id: <20180801165032.770021815@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 984e9cf1b9eaab08e4f1f082ce49ed2670e99d90 ]

When the arm-cci driver is enabled, but both CONFIG_ARM_CCI5xx_PMU and
CONFIG_ARM_CCI400_PMU are not, we get a warning about how parts of
the driver are never used:

drivers/perf/arm-cci.c:1454:29: error: 'cci_pmu_models' defined but not used [-Werror=unused-variable]
drivers/perf/arm-cci.c:693:16: error: 'cci_pmu_event_show' defined but not used [-Werror=unused-function]
drivers/perf/arm-cci.c:685:16: error: 'cci_pmu_format_show' defined but not used [-Werror=unused-function]

Marking all three functions as __maybe_unused avoids the warnings in
randconfig builds. I'm doing this lacking any ideas for a better fix.

Fixes: 3de6be7a3dd8 ("drivers/bus: Split Arm CCI driver")
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/perf/arm-cci.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -120,9 +120,9 @@ enum cci_models {
 
 static void pmu_write_counters(struct cci_pmu *cci_pmu,
 				 unsigned long *mask);
-static ssize_t cci_pmu_format_show(struct device *dev,
+static ssize_t __maybe_unused cci_pmu_format_show(struct device *dev,
 			struct device_attribute *attr, char *buf);
-static ssize_t cci_pmu_event_show(struct device *dev,
+static ssize_t __maybe_unused cci_pmu_event_show(struct device *dev,
 			struct device_attribute *attr, char *buf);
 
 #define CCI_EXT_ATTR_ENTRY(_name, _func, _config) 				\
@@ -1466,7 +1466,7 @@ static int cci_pmu_offline_cpu(unsigned
 	return 0;
 }
 
-static struct cci_pmu_model cci_pmu_models[] = {
+static __maybe_unused struct cci_pmu_model cci_pmu_models[] = {
 #ifdef CONFIG_ARM_CCI400_PMU
 	[CCI400_R0] = {
 		.name = "CCI_400",


