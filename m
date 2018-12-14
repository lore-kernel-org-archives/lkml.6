Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2193AC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEBF2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l2Pv8Kww";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g8XDu9YI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEBF2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeLNEKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 23:10:37 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49902 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNEKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 23:10:37 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 979B4601D7; Fri, 14 Dec 2018 04:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544760635;
        bh=jqwc1E+oyox3f0RuRfsqahwQ0/SBSd+i3IsM/Iwah1U=;
        h=From:To:Cc:Subject:Date:From;
        b=l2Pv8Kwwa0Ehnb/w1TBs08C0S0lPOtFuXBs4k+zHY9RmusK7g4GV5w65ai7y5u3Oz
         MKjjfBcpz9Fikplwrdx/qomsAMIB0BZxjbEpj0B4SiCXe/eIjg3Rskxi2xyx2D5K1o
         HfmvR7ZsAN9ul0SChiSrdQHIqEXPAs/kMDHXA++4=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 21CF86081C;
        Fri, 14 Dec 2018 04:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544760634;
        bh=jqwc1E+oyox3f0RuRfsqahwQ0/SBSd+i3IsM/Iwah1U=;
        h=From:To:Cc:Subject:Date:From;
        b=g8XDu9YItoUasUOvBvopReOUlMMxCEfAGoJAPOjOog/2t0ydhwsWV49LT/t32xvOn
         B50zobYtJkAig3ftz3XzXNW4pkhsqTL8Yc1X+WTIxvjtbXitw9NSCwHl8j4Jprxva2
         9lS2W67AAzonAFzCoGG8D+rG2jXR+aqYonmghFD4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 21CF86081C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, evgreen@google.com,
        Matthias Kaehlcke <mka@chromium.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v13 0/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
Date:   Fri, 14 Dec 2018 09:40:22 +0530
Message-Id: <1544760624-12874-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 [v13]
   * Update Documentation binding to #freq-domain-cells in description.
   * Replace devm_ioremap_resource() to use devm_ioremap() API.

 [v12]
   * Remove per-cpu domain global structure.

 [v11]
   * Updated the code logic as per Stephen.
   * Default boost enabled is removed.
   * Update the clock name to use "alternate" for GPLL0 source in code and
     Documentation binding.
   * Module description updated.
   * perf_base updated to perf_state_reg.

 [v10]
  * Update Documentation binding for cpufreq node.
  * Make the driver 'tristate' instead of 'bool' and update code.
  * Update the clock name to reflect the hardware name.
  * Remove support for varying offset.

 [v9]
  * Update the Documentation binding for freq-domain-cells & cpufreq node.
  * Address comments in Kconfig.arm & Makefile.
  * Remove include file & MODULE_DESCRIPTION not required.
  * Fix the code for 'of_node_put(cpu_np)'.

 [v8]
   * Address comments to update code to take cpufreq_hw phandle and index from
     the CPU nodes.
   * Updated the Documentation for the above change in DT.
   * Updated logic for assigning 'qcom_freq_domain_map' for related CPUs.
   * Clock input to the HW block is taken from DT which has been updated in
     code and Device tree documentation.

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

 .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 172 ++++++++++++
 drivers/cpufreq/Kconfig.arm                        |  11 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/qcom-cpufreq-hw.c                  | 308 +++++++++++++++++++++
 4 files changed, 492 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
 create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

