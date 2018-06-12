Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0841DC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE753208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JMq+QgyF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E+n/TlzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE753208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933282AbeFLLCs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:02:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42374 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752705AbeFLLCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:02:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 65310602BD; Tue, 12 Jun 2018 11:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528801365;
        bh=nEZw8m/0UP8gnnVkQvxOSDw7QXB/XcTcAW3siEkn2JA=;
        h=From:To:Cc:Subject:Date:From;
        b=JMq+QgyFc4iwmJEHOZ5ftviwPE+oPrf90mqHEBR8w4ebnAIt1RFQEPyOedsUNoZuN
         iEHpUtuCVm6XER/7Aczw5Cln49IIvXQqF8+D0B9H8IksqL8hWFLR/5bhvgJKjAnh4l
         5THd7o8RDR+vDqPZjMBvpgJvRg3cv5z6ygd+iIkY=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C2A2C602BD;
        Tue, 12 Jun 2018 11:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528801364;
        bh=nEZw8m/0UP8gnnVkQvxOSDw7QXB/XcTcAW3siEkn2JA=;
        h=From:To:Cc:Subject:Date:From;
        b=E+n/TlzBui/px8MZAy+E1ou0cRfXg5cKHw8Doj2yoYfqEbONIY+TUksKA00qDXo4r
         IlyhndazuFvF987BeYEmC58tjzH0XdF6G5Aex98333zoXQp3hP2DEm8+pLnytbcUl7
         HOMDPKRsp3jZvGNFY4xV63XXZptdHyMzIVB4H06I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2A2C602BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v4 0/2] cpufreq: qcom-fw: Add support for QCOM cpufreq FW driver
Date:   Tue, 12 Jun 2018 16:32:33 +0530
Message-Id: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
  dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW bindings
  cpufreq: qcom-fw: Add support for QCOM cpufreq FW driver

 .../bindings/cpufreq/cpufreq-qcom-fw.txt           | 173 +++++++++++
 drivers/cpufreq/Kconfig.arm                        |   9 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/qcom-cpufreq-fw.c                  | 336 +++++++++++++++++++++
 4 files changed, 519 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
 create mode 100644 drivers/cpufreq/qcom-cpufreq-fw.c

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

