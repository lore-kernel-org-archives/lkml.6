Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6ED6EC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D312086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V5kYrjVe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FfVqkHsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D312086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932481AbeFLElH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:41:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35366 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932334AbeFLElF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:41:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 27477607A4; Tue, 12 Jun 2018 04:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528778465;
        bh=mFxFBNiIJmgk0QtOvmQR41E9/aJ0Eh9DKlO7KtAbzs4=;
        h=From:To:Cc:Subject:Date:From;
        b=V5kYrjVewFCmsczqRUtBgO3/7YWCQQwarcZXzcOFw5z8KwiTonrE82wsPg0nIuNze
         HTlEl/eiSO/pIbJTjwq85j8UFd43PF6+LbzayuQhSiqGO2jMrvytQc8Bw3ZfnyNzQv
         tXM6sWYxwvOn3rTiptqkbn+WhPKCtuln4lt5S7L8=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C1751602BD;
        Tue, 12 Jun 2018 04:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528778464;
        bh=mFxFBNiIJmgk0QtOvmQR41E9/aJ0Eh9DKlO7KtAbzs4=;
        h=From:To:Cc:Subject:Date:From;
        b=FfVqkHsPCNBBJ/3MsNCtlmq2f2SVG5/R6dO5E9hVvowJYGUPG9BQtitYgMTWRjp/V
         GEAl2HIGF7RwexH1yqeCqdi3CYeFfTuLZhkIl1owcuw2yDhrHsw1qh98yuMTPB5mkP
         egN+U+bAVmbQX+5VAtyogHlpXSOl/1tfrqp+vrR0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C1751602BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v3 0/7] Add powerdomain driver for corners on msm8996/sdm845
Date:   Tue, 12 Jun 2018 10:10:45 +0530
Message-Id: <20180612044052.4402-1-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
* Bindings split into seperate patches
* Bindings updated to remove duplicate OPP table phandles
* DT headers defining macros for Power domain indexes and OPP levels
* Optimisations to use rpmh_write_async() whereever applicable
* Fixed up handling of ACTIVE_ONLY/WAKE_ONLY/SLEEP voting for RPMh
* Fixed the vlvl to hlvl conversions in set_performance
* Other minor fixes based on review of v2
* TODO: This series does not handle the case where all VDD_MX votes
should be higher than VDD_CX from APPs, as pointed out
by David Collins in v2. This needs support at genpd to propogate performance
state up the parents, if we model these as Parent/Child to handle the
interdependency.

Changes in v2:
* added a powerdomain driver for sdm845 which supports communicating to RPMh
* dropped the changes to sdhc driver to move over to using OPP
as there is active discussion on using OPP as the interface vs
handling all of it in clock drivers
* Other minor binding updates based on review of v1

With performance state support for genpd/OPP merged, this is an effort
to model a powerdomain driver to communicate corner/level
values for qualcomm platforms to RPM (Remote Power Manager) and RPMh.

Rajendra Nayak (7):
  dt-bindings: power: Add qcom rpm power domain driver bindings
  soc: qcom: rpmpd: Add a Power domain driver to model corners
  soc: qcom: rpmpd: Add support for get/set performance state
  arm64: dts: msm8996: Add rpmpd device node
  dt-bindings: power: Add qcom rpmh power domain driver bindings
  soc: qcom: Add RPMh Power domain driver
  soc: qcom: rpmpd/rpmhpd: Add a max vote on all corners at init

 .../devicetree/bindings/power/qcom,rpmhpd.txt |  65 +++
 .../devicetree/bindings/power/qcom,rpmpd.txt  |  49 ++
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  34 ++
 drivers/soc/qcom/Kconfig                      |  18 +
 drivers/soc/qcom/Makefile                     |   2 +
 drivers/soc/qcom/rpmhpd.c                     | 437 ++++++++++++++++++
 drivers/soc/qcom/rpmpd.c                      | 356 ++++++++++++++
 include/dt-bindings/power/qcom-rpmhpd.h       |  31 ++
 include/dt-bindings/power/qcom-rpmpd.h        |  16 +
 9 files changed, 1008 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmhpd.txt
 create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
 create mode 100644 drivers/soc/qcom/rpmhpd.c
 create mode 100644 drivers/soc/qcom/rpmpd.c
 create mode 100644 include/dt-bindings/power/qcom-rpmhpd.h
 create mode 100644 include/dt-bindings/power/qcom-rpmpd.h

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

