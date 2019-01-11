Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A6EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BDB2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nUferpBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfAKXBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:01:49 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46170 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfAKXBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:01:48 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so7599644pfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 15:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=R5yTAeJQYNL/ZoLYqXqyjHYfxCCGTwzPkTH92NkbMkQ=;
        b=nUferpBj+Lu8m/GTPNySjdACU5FxR7B6br0AkoXBOLl/70BCDaM37BDpZrqw14CNrL
         8+jPra0k/jOjycd8him3hcJChDCy8EQ5vTUDnttgXKQQ5Dd6w6eKuQZZsCU6cIpV0Qii
         iSu6runjANOpaHb8Ju/1tA6ZDoYF+lhXWrcOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R5yTAeJQYNL/ZoLYqXqyjHYfxCCGTwzPkTH92NkbMkQ=;
        b=RDWB7PEry+cO1sSKwdaOhejm7mI3Me/zGcv4Sla6y5N3caEZy3hZ5uItSvUIDPmA2U
         k+XMfD/SUx5V8nUczQc2sf9XzMcFajah5Nw6WTleFZimx98Ew0ntiHK8aUJ8u8WzuqFG
         gaDW4YxMAN5h3MfkPV700A5n/tfysh2QG+QJpmACSuiFD+Df3Mxe656wiazPykZfx/y1
         hZ1ff8TFRoh1aHcojpucQIdns/hIc4kxUw5qeCBWK8ubhxuTDFKJxRBWq76f08u6c/fF
         rSbWW4l4ObIYSPsDBewzvGR7zt5WVmEuduuMjaeH7w+epbaPT9SLnABqQtl48onNtYwQ
         H3Bw==
X-Gm-Message-State: AJcUukeeu7ytt/2G0kcuYcBmOT0xCWNvUhYjCBSCKixNXqSNAtp6bZiU
        ZKuYYgnOTOcSkY89HRLb52L2Xw==
X-Google-Smtp-Source: ALg8bN7Ce7vYfoOXLtFy/hePAESBUMLZfZ36zAwWD/ECRLkAspTeehWzppm/fcEBOUcK27SjKoHjww==
X-Received: by 2002:a63:4b60:: with SMTP id k32mr14907600pgl.186.1547247707259;
        Fri, 11 Jan 2019 15:01:47 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id 15sm116045186pfr.55.2019.01.11.15.01.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 15:01:46 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-scsi@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v1 0/8] phy: qcom-ufs: Enable regulators to be off in suspend
Date:   Fri, 11 Jan 2019 15:01:21 -0800
Message-Id: <20190111230129.127037-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal with this series is to enable shutting off regulators that power
UFS during system suspend.

In "the good life" version of this, we'd just disable the regulators
in phy_poweroff and be done with it. Unfortunately, that's not symmetric,
as regulators are not enabled during phy_poweron. Ok, so you might think
we could just move the regulator enable and anything else that needs to
come along into phy_poweron, so that we can then undo it all in
phy_poweroff. That's where things get tricky.

The qcom-qmp-phy overloaded the phy_init and phy_poweron callbacks,
basically to mean "init phase 1" and "init phase 2". There are two phases
because they have this phy_reset bit outside of the phy (in the UFS
controller registers), and they need to make sure this bit is toggled at
specific points in the phy init sequence. So there's this implicit
sequence in the init dance between ufs-qcom.c and phy-qcom-qmp.c:
1) ufs-qcom asserts the PHY reset bit.
2) phy-qcom-qmp phy_init does most of its initialization, but exits early.
3) ufs-qcom deasserts the PHY reset bit.
4) phy-qcom-qmp phy_poweron finishes its initialization.

This init dance is very difficult to follow in the code (since it's split
between two drivers and not spelled out well), and arguably represents a
deficiency in the hardware description of these devices.

In this series I'm proposing tweaking the bindings for the Qualcomm
UFS controller and PHY. In it we expose a reset controller from the
UFS controller, that is then picked up and used from the PHY code.
With this, the phy code can be reorganized to complete its initialization
in a single function, removing the implicit two-phase overloading.

Then I can move most of the phy initialization, including enabling
the regulators, into phy_poweron. Now, when phy_poweroff is called,
the phy actually powers off. This finally disables the regulators
and allows me to save power in system suspend.

Because the UFS PHY reset bit is now toggled in the PHY, rather
than in ufs-qcom, this also percolated to all other PHYs using
ufs-qcom, which from what I can see is just 8996.

There are a couple of tradeoffs in this series that I'd welcome feedback
on. First, it breaks compatibility with device trees that don't expose
this new reset controller. Making this work with older device trees
would be pretty ugly in the code, and given that the SDM845 UFS DT nodes
aren't accepted upstream yet, the breakage seemed worth it. I'm not as
sure about 8996.

Second, I removed the calls to phy_poweroff during clock gating. This
was originally dialing down a clock or two, while leaving the phy powered.
I've now changed the semantics of phy_poweroff to, well, actually power off.
This works great for userlands that have set UFS's spm_lvl to 5 (off) like
I have, but maybe changes power consumption for devices that have spm_lvl
set to 3. I could try to use phy_init and phy_poweron as the two different
possible transitions (fully off, and clocks off respectively), but I'm not
sure if it actually matters, and I like the idea that phy_poweroff really
does power the thing off.

Also, I don't have an 8996 device to test. If someone is able to test this
out and perhaps point out any (hopefully obvious) bugs in the 8996 portion,
I'd be grateful.

This patch is based atop phy-next, plus the UFS DT nodes, which are now
patch 3, 4, 5 of [1].

[1] https://lore.kernel.org/lkml/20181210192826.241350-1-evgreen@chromium.org/


Evan Green (8):
  dt-bindings: phy-qcom-qmp: Add UFS PHY reset
  dt-bindings: phy: qcom-ufs: Add resets property
  arm64: dts: sdm845: Add UFS PHY reset
  arm64: dts: msm8996: Add UFS PHY reset controller
  scsi: ufs: qcom: Expose the reset controller for PHY
  phy: qcom-qmp: Utilize UFS reset controller
  phy: qcom-qmp: Move UFS phy to phy_poweron/off
  phy: qcom-ufs: Refactor all init steps into phy_poweron

 .../devicetree/bindings/phy/qcom-qmp-phy.txt  |   6 +-
 .../devicetree/bindings/ufs/ufs-qcom.txt      |   1 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |   4 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   3 +
 drivers/phy/qualcomm/phy-qcom-qmp.c           | 123 ++++++++++--------
 drivers/phy/qualcomm/phy-qcom-ufs-i.h         |   5 +-
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c  |  25 +---
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c  |  25 +---
 drivers/phy/qualcomm/phy-qcom-ufs.c           |  57 ++++++--
 drivers/scsi/ufs/Kconfig                      |   1 +
 drivers/scsi/ufs/ufs-qcom.c                   | 110 +++++++++-------
 drivers/scsi/ufs/ufs-qcom.h                   |   4 +
 12 files changed, 197 insertions(+), 167 deletions(-)

-- 
2.18.1

