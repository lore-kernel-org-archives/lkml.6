Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA85EAAD5A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47E8208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A8QVcHxr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AnMulebz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47E8208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeGLSQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:16:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57854 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeGLSQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:16:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3471660B72; Thu, 12 Jul 2018 18:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531418758;
        bh=c2UaUhd++qxvnHNttwGw5YWntlz99bmFbOJRTgKvs14=;
        h=From:To:Cc:Subject:Date:From;
        b=A8QVcHxrKTFUye/l5UtWxPxlBQKjc8k8D58SPZPo4XybeQILYwHBZODQYDRgdfVMc
         KdHZGUSfDxiKWw/0LP/m9OIYYlohr2J6/Zbq2m/TBheh/4VtojUyziFLVGPkKxrEiF
         1gRHXGwzkK6706Rk5zGfCfttcRTo9o8NM7r8W1Cw=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7A61660555;
        Thu, 12 Jul 2018 18:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531418757;
        bh=c2UaUhd++qxvnHNttwGw5YWntlz99bmFbOJRTgKvs14=;
        h=From:To:Cc:Subject:Date:From;
        b=AnMulebzg8HAoOjctw0oaRK8mxkA+Eok9GhsjuG0FhYLCvUL63iMbgsLLipOdJSGD
         wNRY1CKi2ejM91+X3ht6ev+AWQmzbm6/OETJpyWjEyXpYAy6Ipi5eEks/RfiT24eXV
         R+zE5c6kdVrH5eaPNHQ0WFl5CJTVZBRauYakm8qs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A61660555
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
Subject: [PATCH v5 0/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date:   Thu, 12 Jul 2018 23:35:43 +0530
Message-Id: <1531418745-19742-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 * Remove initialization of 'ret' from function qcom_resources_init and add
   return -ENODEV based on 'of_get_available_child_count'.
 * Removed initialization of 'rc' from qcom_cpufreq_fw_driver_probe
 * Removed module_exit as this driver would not be used as module, also updated
   the Kconfig to bool from tristate.
 * Updated the subsystem in device tree bindings.

 [v1]
   * Fixed compilation reported by Amit K.

Taniya Das (2):
  dt-bindings: cpufreq: Introduce QCOM CPUFREQ Firmware bindings
  cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver

 .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 158 ++++++++++
 drivers/cpufreq/Kconfig.arm                        |  10 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/qcom-cpufreq-hw.c                  | 344 +++++++++++++++++++++
 4 files changed, 513 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
 create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

