Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F481C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEA22146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EcqEKCLc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y8Y5m6ZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEA22146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbeKUVQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:16:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46798 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbeKUVQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:16:58 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 94D0E602D7; Wed, 21 Nov 2018 10:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542796983;
        bh=MFGfn1YqQ+11f76bcdXQvOko2Z5OI0ImcCxJfnkg3EE=;
        h=From:To:Cc:Subject:Date:From;
        b=EcqEKCLcLBeWt651lDimD2PEHU5FlJOJSW4nu/YkZBFxfVO0yi+gfcrQ/MWEqB50g
         wlJVplAKbnepfUjZgaRkWmVhztb4QbVqRSYLRo4S25o6fVuE6jfLG1Lw0jNr1evVu0
         SdUr8r65UmQvTJZuCmqlY+ZyN2q9OJnPO3SGPfwM=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 600DA602D7;
        Wed, 21 Nov 2018 10:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542796982;
        bh=MFGfn1YqQ+11f76bcdXQvOko2Z5OI0ImcCxJfnkg3EE=;
        h=From:To:Cc:Subject:Date:From;
        b=Y8Y5m6ZG/Tu8E9KYctIN5xZwsg1hmmuL0N4RmFHMlHZLrrt7bNmitRLLD7xpP3dW7
         geB/Emd/nwvM40a5pPaK1tlgc/nDGEuK8onTKH50/DZaEQWtcsxJ4t1VOYglfe5b4l
         So8fGpgnANp7euHn/83QX0a1FjKfTdhDMaYZp208=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 600DA602D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        evgreen@google.com, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v10 0/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date:   Wed, 21 Nov 2018 16:12:45 +0530
Message-Id: <1542796967-5949-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

 .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 172 ++++++++++
 drivers/cpufreq/Kconfig.arm                        |  11 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/qcom-cpufreq-hw.c                  | 346 +++++++++++++++++++++
 4 files changed, 530 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
 create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

