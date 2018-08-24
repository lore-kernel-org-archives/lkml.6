Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06C0C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A0C2150F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nl+wVFH3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N+cZMNPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A0C2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeHXXnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:43:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52004 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeHXXnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:43:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5681460540; Fri, 24 Aug 2018 20:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535141220;
        bh=asRBXtmVv2KzOVPpqFPD58AFGxknQheu/+umNB4bwLA=;
        h=From:To:Cc:Subject:Date:From;
        b=nl+wVFH3FM9P748xYz2h0cbujmsHmTwpvrRNWYxccdgn2w4dvq1hcE7WXOn+kaQtA
         yZDLFyewwxxgyRpQ3VDAGk1TY1iKHr84c8hB4VsRPGt/1Cu2CjK9H2rROfbzv63crR
         Hdu+9MBl/Ql7IGA77v+Vg0VXZH06rf29dohoJUKM=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2D9DE601D1;
        Fri, 24 Aug 2018 20:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535141219;
        bh=asRBXtmVv2KzOVPpqFPD58AFGxknQheu/+umNB4bwLA=;
        h=From:To:Cc:Subject:Date:From;
        b=N+cZMNPnSvoA1U0RuFolBqIfmDXIjBMFZ7OOa4pGf/c1GjEqNfeDtuac5hOv1WWxy
         hCVDQmn+rPx4rkDQuy6zOxF1HlFlRpD4vO4Mr2B6f2AfsRatKSYh+wa7ADVKuP2QQd
         v98dq23pPWyT/CE3SSq8LqHn7MEifCIY/+aRBWU0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D9DE601D1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com,
        rafael@kernel.org, drake@endlessm.com, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC 0/6] drivers: qcom: enable system low power modes for SDM845
Date:   Sat, 25 Aug 2018 01:36:22 +0530
Message-Id: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is an attempt at a solution to perform activities necessary while entering
deeper low power modes supported by firmware for QCOM SoCs which have hardened
IP (Resource Power Manager Hardened - RPMH) for shared resource management.

The shared resources that are no longer used, when processor enters deep idle
states, can be turned off or put to lower state via sleep requests. Clients vote
for lower resource state when application processor is asleep. These votes need
to be flushed only during entry to low power modes.

In addition to this, an always-on power domain wake-up timer present in PDC
(Power Domain Controller)  needs to be programmed so that RSC is up and running
by the time CPU has to wake-up. 

The kernel does not notify that the CPU powering down is the last CPU.
Therefore, in this series, we are doing a reference count to determine the last
CPU in the system to enter idle and use that to perform the last-man activities.
It would be optimal to do this than to flush whenever a core enters idle. The
current approach can be revisited in future if OS-initiated support becomes
available that enables certain actions to be taken when last core enters deepest
low power mode.

Apart from idle sleep, the deeper low modes can be exercised in system suspend.
As it is expected that all other cores except the core entering system suspend
will be disabled during suspend operations, the device suspend calls are
utilized to perform the required tasks.

Please review these patches. Your inputs would be greatly appreciated.

Thanks,
Raju

Dependencies:

The current series depends on patches[1][2], which add RPMH communication
support, to send shared resource request votes by clients. The patches[1][2]
also provide functions that are expected to be called by sleep manager client
during low power mode entry. The other patches[3][4][5] which fix couple of
issues are also needed. Apart from RPMH related patches, the current series
depends on knowing the next wake up timer of a CPU[6] for programing the
always-on timer present in PDC.

[1]. https://lkml.org/lkml/2018/6/20/519
[2]. https://lkml.org/lkml/2018/7/27/326
[3]. https://lkml.org/lkml/2018/7/13/358 
[4]. https://lkml.org/lkml/2018/7/19/84
[5]. https://lkml.org/lkml/2018/8/24/641
[6]. https://lkml.org/lkml/2018/6/20/800

Raju P.L.S.S.S.N (6):
  drivers: qcom: system_pm: add system PM client for RPMH based SoCs
  dt-bindings: introduce System PM bindings for Qualcomm SoCs
  drivers: qcom: system_pm: Add power management ops
  drivers: qcom: system_pm: program next wakeup to PDC timer
  drivers: qcom: rpmh: force flush new sleep/wake requests during
    suspend
  drivers: soc: system_pm: Add suspend notifier

 .../devicetree/bindings/soc/qcom/system_pm.txt     |  28 ++++
 drivers/soc/qcom/Kconfig                           |  11 ++
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/rpmh-internal.h                   |   1 +
 drivers/soc/qcom/rpmh.c                            |  17 +++
 drivers/soc/qcom/system_pm.c                       | 168 +++++++++++++++++++++
 include/soc/qcom/rpmh.h                            |   5 +
 7 files changed, 231 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/system_pm.txt
 create mode 100644 drivers/soc/qcom/system_pm.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.

