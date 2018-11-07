Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7810C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727F02086A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GFePTUyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727F02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388779AbeKGKA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:00:59 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52837 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388662AbeKGKA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:00:59 -0500
Received: by mail-it1-f195.google.com with SMTP id t190-v6so14906338itb.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 16:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IEvQGaTEyTQoVgI42OBCj+DpBFTSscNNlEYbOyUpznE=;
        b=GFePTUyfzSNSkfg919edcXJxTSGdeI34Uo/U5L3524jLl1o+GG/9CRELIW5IYAmsqO
         qxq9vkrAHCGg2mUPEZ/j0KhLxxyp0X2oCVdZF6d4I9sJdLrTxuEXnfJ9/TpF3bDBADsd
         Ki1dZIH97vNAEy7xP881FqCIwL3YEQB/t4Mrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IEvQGaTEyTQoVgI42OBCj+DpBFTSscNNlEYbOyUpznE=;
        b=LHT+eQVR5FX3ycQ2J2nGTw2Zn5ptcYIPSTUp4ukcwYdodH4wfBxN2Ud+g+5p+yev8E
         RhWXLm4fqVJ7P3IFjcF7sAY3QMf9loieCD1xKNAMkn8Lg3MK3bap7i3TnFU6WnRNuJoV
         /DkTezA9mNrcoEtAr3y02pnjKqvcfoW+YXkNnsI7MDJnihedvEqv4EvwWXMIEln+9TVE
         AnVGY4HJW5DprP8Gcod87RYZPKMx/Y4D7Mc4Q5D9y8A0JHijZI+V0a1iiXLjFqu96Woz
         MSfKRPIzCArCjyTMRkhIhBgyXSbk3qrHDg56Kd72kJ/1mGImPi3ltTmapqMfde2OEQoF
         I5Fg==
X-Gm-Message-State: AGRZ1gJcGb5vF9J8ST6fvXf+SLYbS1tuFm8HUXgF/gnD2x8xuXWsRdd5
        G/zDY2qDmZk4gATnbE2kKZUuyA==
X-Google-Smtp-Source: AJdET5cNNhjs8TiKSkjggEfBwgLhwdg3qzRPtWLSudUIoryK3U2cdvV1jFkLFxHilw4NVDV8sJOSvg==
X-Received: by 2002:a24:9717:: with SMTP id k23-v6mr131730ite.94.1541550783558;
        Tue, 06 Nov 2018 16:33:03 -0800 (PST)
Received: from shibby.gateway.innflux.com ([66.228.239.218])
        by smtp.gmail.com with ESMTPSA id e184-v6sm1061128ite.9.2018.11.06.16.32.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 16:33:02 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        syadagir@codeaurora.org, mjavid@codeaurora.org
Subject: [RFC PATCH 00/12] net: introduce Qualcomm IPA driver
Date:   Tue,  6 Nov 2018 18:32:38 -0600
Message-Id: <20181107003250.5832-1-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series presents the driver for the Qualcomm IP Accelerator (IPA).
The IPA is a hardware component present in some Qualcomm SoCs that
allows network functions--such as routing, filtering, network address
translation and aggregation--to be performed without active involvement
of the main application processor (AP).

Initially, these advanced features are not supported; the IPA driver
simply provides a network interface that makes the modem's LTE
network available to the AP.  In addition, support is only provided
for the IPA found in the Qualcomm SDM845 SoC.

This code is derived from a driver developed internally by Qualcomm.
A version of the original source can be seen here:
    https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree
in the "drivers/platform/msm/ipa" directory.  Many were involved in
developing this, but the following individuals deserve explicit
acknowledgement for their substantial contributions:

    Abhishek Choubey
    Ady Abraham
    Chaitanya Pratapa
    David Arinzon
    Ghanim Fodi
    Gidon Studinski
    Ravi Gummadidala
    Shihuan Liu
    Skylar Chang

The code has undergone considerable rework to prepare it for
incorporation into upstream Linux.  Parts of it bear little
resemblance to the original driver.  Still, some work remains
to be done.  The current code and its design had a preliminary
review, and some changes to the data path implementation were
recommended.   These have not yet been addressed:
- Use NAPI for all interfaces, not just RX (and WAN data) endpoints.
- Do more work in the NAPI poll function, including collecting
  completed TX requests and posting buffers for RX.
- Do not use periodic NOP requests as a way to avoid TX interrupts.
- The NAPI context should be associated with the hardware interrupt
  (it is now associated with something abstracted from the hardware).
- Use threaded interrupts, to avoid the need for using spinlocks and
  atomic variables for synchronizing between workqueue and interrupt
  context.
- Have runtime power management enable and disable IPA clock and
  interconnects.
Many thanks to Arnd Bergmann, Ilias Apalodimas, and Bjorn Andersson
for their early feedback.

While there clearly remains work to do on this, we felt that things
are far enough along that it would be helpful to solicit broader
input on the code.  Major issues are best addressed as soon as
possible, and even minor issues when identified help in setting
priorities.

This code is dependent on the following two sets of code, which have
been posted for review but are not yet accepted upstream:
- Interconnect framework:  https://lkml.org/lkml/2018/8/31/444
- SDM845 interconnect provider driver:  https://lkml.org/lkml/2018/8/24/25

In addition, it depends on four more bits of code that have not yet
been posted for upstream review, but are expected to be available soon:
- clk-rpmh support for IPA from David Dai <daidavid1@codeaurora.org>
- SDM845 reserved memory from Bjorn Andersson <bjorn.andersson@linaro.org>
- list_cut_end() from Alex Elder <elder@linaro.org>
- FIELD_MAX() in "bitfield.h" from Alex Elder <elder@linaro.org>

This code (including its dependencies) is available in buildable
form here, based on kernel v4.19:
    remote: ssh://git@git.linaro.org/people/alex.elder/linux.git
    branch: qualcomm_ipa-v1
	    59562facd61a arm64: dts: sdm845: add IPA information

					-Alex

Alex Elder (12):
  dt-bindings: soc: qcom: add IPA bindings
  soc: qcom: ipa: DMA helpers
  soc: qcom: ipa: generic software interface
  soc: qcom: ipa: immediate commands
  soc: qcom: ipa: IPA interrupts and the microcontroller
  soc: qcom: ipa: QMI modem communication
  soc: qcom: ipa: IPA register abstraction
  soc: qcom: ipa: utility functions
  soc: qcom: ipa: main IPA source file
  soc: qcom: ipa: data path
  soc: qcom: ipa: IPA rmnet interface
  soc: qcom: ipa: build and "ipa_i.h"

 .../devicetree/bindings/soc/qcom/qcom,ipa.txt |  136 ++
 .../bindings/soc/qcom/qcom,rmnet-ipa.txt      |   15 +
 drivers/net/ipa/Kconfig                       |   30 +
 drivers/net/ipa/Makefile                      |    7 +
 drivers/net/ipa/gsi.c                         | 1685 ++++++++++++++
 drivers/net/ipa/gsi.h                         |  195 ++
 drivers/net/ipa/gsi_reg.h                     |  563 +++++
 drivers/net/ipa/ipa_dma.c                     |   61 +
 drivers/net/ipa/ipa_dma.h                     |   61 +
 drivers/net/ipa/ipa_dp.c                      | 1994 +++++++++++++++++
 drivers/net/ipa/ipa_i.h                       |  573 +++++
 drivers/net/ipa/ipa_interrupts.c              |  307 +++
 drivers/net/ipa/ipa_main.c                    | 1400 ++++++++++++
 drivers/net/ipa/ipa_qmi.c                     |  406 ++++
 drivers/net/ipa/ipa_qmi.h                     |   12 +
 drivers/net/ipa/ipa_qmi_msg.c                 |  587 +++++
 drivers/net/ipa/ipa_qmi_msg.h                 |  233 ++
 drivers/net/ipa/ipa_reg.c                     |  972 ++++++++
 drivers/net/ipa/ipa_reg.h                     |  614 +++++
 drivers/net/ipa/ipa_uc.c                      |  336 +++
 drivers/net/ipa/ipa_utils.c                   | 1035 +++++++++
 drivers/net/ipa/ipahal.c                      |  541 +++++
 drivers/net/ipa/ipahal.h                      |  253 +++
 drivers/net/ipa/msm_rmnet.h                   |  120 +
 drivers/net/ipa/rmnet_config.h                |   31 +
 drivers/net/ipa/rmnet_ipa.c                   |  805 +++++++
 26 files changed, 12972 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,rmnet-ipa.txt
 create mode 100644 drivers/net/ipa/Kconfig
 create mode 100644 drivers/net/ipa/Makefile
 create mode 100644 drivers/net/ipa/gsi.c
 create mode 100644 drivers/net/ipa/gsi.h
 create mode 100644 drivers/net/ipa/gsi_reg.h
 create mode 100644 drivers/net/ipa/ipa_dma.c
 create mode 100644 drivers/net/ipa/ipa_dma.h
 create mode 100644 drivers/net/ipa/ipa_dp.c
 create mode 100644 drivers/net/ipa/ipa_i.h
 create mode 100644 drivers/net/ipa/ipa_interrupts.c
 create mode 100644 drivers/net/ipa/ipa_main.c
 create mode 100644 drivers/net/ipa/ipa_qmi.c
 create mode 100644 drivers/net/ipa/ipa_qmi.h
 create mode 100644 drivers/net/ipa/ipa_qmi_msg.c
 create mode 100644 drivers/net/ipa/ipa_qmi_msg.h
 create mode 100644 drivers/net/ipa/ipa_reg.c
 create mode 100644 drivers/net/ipa/ipa_reg.h
 create mode 100644 drivers/net/ipa/ipa_uc.c
 create mode 100644 drivers/net/ipa/ipa_utils.c
 create mode 100644 drivers/net/ipa/ipahal.c
 create mode 100644 drivers/net/ipa/ipahal.h
 create mode 100644 drivers/net/ipa/msm_rmnet.h
 create mode 100644 drivers/net/ipa/rmnet_config.h
 create mode 100644 drivers/net/ipa/rmnet_ipa.c

-- 
2.17.1

