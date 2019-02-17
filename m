Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C98FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 03:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7709F21A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 03:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbfBQDzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 22:55:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3753 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727391AbfBQDzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 22:55:18 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8D1E3C8E6C783A931EC5;
        Sun, 17 Feb 2019 11:55:15 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Sun, 17 Feb 2019 11:55:06 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <gcherianv@gmail.com>, <pprakash@codeaurora.org>,
        <george.cherian@cavium.com>, <robert.moore@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <guohanjun@huawei.com>, <wangxiongfeng2@huawei.com>,
        <john.garry@huawei.com>
Subject: [PATCH v3 0/2] Work around for Hisilicon CPPC cpufreq
Date:   Sun, 17 Feb 2019 11:54:13 +0800
Message-ID: <1550375655-58007-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hisilicon chips do not support delivered performance counter register
and reference performance counter register. But the platform can
calculate the real performance using its own method. This patch provide
a workaround for this problem, and other platforms can also use this
workaround framework. We reuse the desired performance register to
store the real performance calculated by the platform. After the
platform finished the frequency adjust, it gets the real performance and
writes it into desired performance register. OS can use it to calculate
the real frequency.

Changlog:

v2 -> v3:
	Recontruct 'cppc_get_desired_perf'.
	Rename 'cppc_workaround_info' to 'cppc_workaround_oem_info'
	Drop 'get_rate' member from struct cppc_workaround_oem_info
	Change 'cppc_wa_get_rate' pointer to a flag to indicate whether
	we need to aplly the workaround.
	Move the new functions to the beginning of cppc-cpufreq.c


Xiongfeng Wang (2):
  ACPI / CPPC: Add a helper to get desired performance
  cpufreq / cppc: Work around for Hisilicon CPPC cpufreq

 drivers/acpi/cppc_acpi.c       | 39 +++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c | 66 ++++++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h       |  1 +
 3 files changed, 106 insertions(+)

-- 
1.7.12.4

