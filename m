Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDF0C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11A320874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kgrOK7f5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E17g8H1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11A320874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbeGXLsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:48:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56160 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeGXLsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:48:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 132EC60B11; Tue, 24 Jul 2018 10:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532428982;
        bh=epwQqw6molEAeHu1soEVopzCiZbs08uSpQg2zgjomIY=;
        h=From:To:Cc:Subject:Date:From;
        b=kgrOK7f5oyZTrUcrKrBJkUO7+HekE5aBObEHJ0vYV2Z8DmfCzotm+Ee6W2gCUDFEa
         a2Kobv0IK63Q8zahVWYAMmrZK+zF7vFYmXUJ5HzR/ST0pVaKugs80Om9hEcYjQY2mG
         98eP+UvDw6QYk55evFn/CffEJDJ6sIPBbfekwDWE=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 648A7602BC;
        Tue, 24 Jul 2018 10:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532428980;
        bh=epwQqw6molEAeHu1soEVopzCiZbs08uSpQg2zgjomIY=;
        h=From:To:Cc:Subject:Date:From;
        b=E17g8H1MXt+WqzTIJLx8poOUMiURxW96znGocCsyxFR9d1ksFdiixz6d1PG0/9Tcp
         rA31GWZ2axttzbD9Pd/u/s+RKAp/+ZzeMZpfFzz/Ckt/AYwN0s+3p9wW/v5JDcdkIC
         oeFpHwpShJceF7fTM4weoBppAZFGgJXwdlbbZaDk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 648A7602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, amit.kucheria@linaro.org,
        evgreen@google.com, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v7 0/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date:   Tue, 24 Jul 2018 16:12:48 +0530
Message-Id: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 [v7]
   * Updated the logic to check for related CPUs.

 [v6]
   * Renamed match table 'qcom_cpufreq_hw_match'.
   * Renamed 'qcom_read_lut' to 'qcom_cpufreq_hw_read_lut'.
   * Updated the logic to check for related CPUs at the beginning of the
     'qcom_cpu_resources_init'.
   * Use devm_ioremap_resource instead of devm_ioremap.
   * Update the use of of_node_put to handle error conditions.
   * Use policy->cached_resolved_idx in fast switch callback.
   * Keep precalculated offsets 'reg_bases'.
   * XO clock is taken from Device tree.
   * Update documentation binding for clocks/clock-names.
   * Minor comments in Kconfig.arm.
   * Comments to move dev_info to dev_dbg.

 [v5]
   * Remove mapping different register regions of perf/lut/enable,
     instead map the entire HW region.
   * Add reg_offset/cpufreq_qcom_std_offsets to be supplied as device data.
   * Check of src == 0 during lut read.
   * Add of_node_put(cpu_np) in qcom_get_related_cpus
   * Update the qcom_cpu_resources_init for register offset data,
     and cleanup the related cpus to keep a single copy of CPUfreq.
   * Replace FW with HW, update Kconfig, rename filename qcom-cpufreq-hw.c
   * Update the documentation binding to reflect the changes of mapping the
   * entire HW region.

 [v4]
   * Fixed console messages as per comments.
   * Return error from qcom_resources_init()
     in the cases where failed to get frequency domain.
   * Rename cpu_dev to cpu_np in qcom_resources_init,
     qcom_get_related_cpus(). Also use temp variable freq_np in
     qcom_get_related_cpus().
   * Update qcom_cpufreq_fw_get() to use the policy data to incoporate
     the hotplug use case.
   * Update code to use of fast_switching.
   * Check for !c->max_cores instead of cpumask_empty in
     qcom_get_related_cpus().
   * Update the logic of assigning 'c' to qcom_freq_domain_map[cpu].

 [v3]
   * Remove index check from 'qcom_cpufreq_fw_target_index'.
   * Update the Documentation binding to add the platform specific properties in
     the CPU nodes, node name "qcom,freq-domain".
   * Update return value to '0' from -ENODEV from 'qcom_cpufreq_fw_get'.
   * Update the logic for boost frequency to use local variables instead of
     cpufreq driver data in 'qcom_read_lut'.
   * Update the logic in 'qcom_get_related_cpus' to find the related cpus.
   * Update the reg-names to remove "_base" and also update the binding with the
     description of these registers.
   * Update the logic in 'qcom_resources_init' to address the new device tree
     notation of handling the frequency domain phandles.

 [v2]
   * Fixed the alignment issues in "qcom_cpufreq_fw_target_index" for dev_err and
     also for "qcom_cpu_resources_init".
   * Removed ret = 0 from qcom_get_related_cpus and added to check for
     cpu_mask_empty to return -ENOENT.
   * Fixes qcom_cpu_resources_init function
   * Remove initialization of 'index'
   * Check for valid 'c'
   * Removed initialization of 'prev_cc' from 'qcom_read_lut'.

Taniya Das (2):
  dt-bindings: cpufreq: Introduce QCOM CPUFREQ Firmware bindings
  cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver

 .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 172 ++++++++++
 drivers/cpufreq/Kconfig.arm                        |  11 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/qcom-cpufreq-hw.c                  | 348 +++++++++++++++++++++
 4 files changed, 532 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
 create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

