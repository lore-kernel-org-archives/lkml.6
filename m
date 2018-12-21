Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C67C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D69E218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CGYLXLob";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EwK+tVci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390143AbeLUMAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 07:00:03 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38488 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729924AbeLUMAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 07:00:03 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4F37F608CB; Fri, 21 Dec 2018 12:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545393602;
        bh=33Mnkxhecqx+8rMpAkCZB8x26uUmOruIOB/e4RGZuLQ=;
        h=From:To:Cc:Subject:Date:From;
        b=CGYLXLobjSfxcJaAZ32GOEIzYC8Ja1l60RqbsoGtVHlQCo3YrZMExVeUbedN7iDRn
         ZZqiBnVyYb5PzNeJnkIk/aRnR3ZCMGXeBshw9DGx15DJWgaOUdAQED5u3AzMBomNLk
         vI1nCWppU8cFK3+49stnj785g7w15xdsgCR7/Dy0=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 59182607F1;
        Fri, 21 Dec 2018 11:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545393601;
        bh=33Mnkxhecqx+8rMpAkCZB8x26uUmOruIOB/e4RGZuLQ=;
        h=From:To:Cc:Subject:Date:From;
        b=EwK+tVcijZI8SNAJw7eO12YGIw/5BonXsrDgx4vfZErdbKSopa8q1yB/w5aTbAkjC
         Cbg18XJpo5aypJLDiDAXrIXElG7c+WpLo1DNHpRtd+pUu1A7aPRYiOz8reFQ4P4ZQw
         HvV3lg0ZX1+waLqrC6A2p+sFyzMOn1Eu5c8hcAJg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59182607F1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org,
        mka@chromium.org, ilina@codeaurora.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC 0/5] Add support for PDC timer for wake-ups 
Date:   Fri, 21 Dec 2018 17:29:41 +0530
Message-Id: <20181221115946.10095-1-rplsssn@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPMH based targets require that the next wake-up timer value needs
to be programmed to PDC (Power Domain Controller) which has its
own timer and is in an always on power domain. PDC wakes-up
the RSC and sets up the resources back in active state before the
processor is woken up by a timer interrupt. In order to query next
timer wake-up, the patch-set depends on patch - Export next wakeup
time of a CPU[1].

The kernel does not notify that the CPU powering down is the last
CPU. So in this version, next wake-up is programmed to PDC each time
when a CPU goes to power collapse. The current approach can be
revisited in future if OS-initiated support becomes available that
enables certain actions to be taken when last core enters deepest low
power mode.

Please review these patches. Your inputs would be greatly appreciated.

Thanks,
Raju.

Dependencies:
 [1].https://lore.kernel.org/patchwork/patch/1019432/

Raju P.L.S.S.S.N (5):
  drivers: qcom: rpmh-rsc: Add regmap for RSC controller
  drivers: qcom: rpmh-pdc-timer: add PDC timer support for RPMH based
    SoCs
  dt-bindings: Add PDC timer bindings for Qualcomm SoCs
  drivers: qcom: rpmh-pdc-timer: Add power management ops
  arm64: dts: msm: add PDC timer for apps_rsc for SDM845

 .../devicetree/bindings/soc/qcom/rpmh-rsc.txt |  29 +++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   9 +
 drivers/soc/qcom/Kconfig                      |   9 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/rpmh-pdc-timer.c             | 205 ++++++++++++++++++
 drivers/soc/qcom/rpmh-rsc.c                   |  14 ++
 6 files changed, 267 insertions(+)
 create mode 100644 drivers/soc/qcom/rpmh-pdc-timer.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

