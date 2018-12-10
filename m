Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057DCC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A652081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iKh6TQEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A652081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbeLJT2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:28:44 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40431 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbeLJT2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:28:44 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so5695828plq.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 11:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=l5AKnUQBXLPWGgnje1Oil3e8pmxzfoPRu57CIxFYBQc=;
        b=iKh6TQEZKyyzuVYhEKFXoYqoqrrW5po11MGD6tJezfDOaKCjx3v9VduoKFAPCu15Jm
         hXp9M4mxlqGPFNQGfZjTnwrV7WvZ0aNxh3BYlRGNljjgXgLkE57Vocf9nO4APF0VNxUJ
         zwPJcrL15NwsB6bJS1jXOaoEPmnmbsZiP+eO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l5AKnUQBXLPWGgnje1Oil3e8pmxzfoPRu57CIxFYBQc=;
        b=DoXwjGrDMv9a9AVMt74d4nNXarG/l1wzdPFTpSE5qKMdcKTvQGGodTc6WYv+s0O7Hn
         ZMlJa4mH00ifM079spAphL82VnlBuNOjE11J+XbInLvmaXiIl1zIlEhajR7jMetkaBeA
         8rSlOyzXcdH0wUBLW/mgDkQknP2viXv7D2U3JZf2M3+zP2MI9oely4K15EAGFCBnpzL4
         wBsZswxoVfUMgR3MQGOC0QunTteK0a2fTqfKiLgVn89CEvuMiAY4l07pIUZdS5tp50e/
         pJYILkEMcx2LqHf6fpGYbMZgQFZ3e9vxsEgNYnudEygRlq93zG9K2+1xWjgW95qdTjPD
         4L+Q==
X-Gm-Message-State: AA+aEWaDXZbuXpr2gZGC2Q7bhOWeJuelwQEoCLqm/VzxZYOtDz8SqYRo
        RV3mry9JEZqmFoaG/mx2Y2qPaeuEZkE=
X-Google-Smtp-Source: AFSGD/Xkt34EG5garvEmEt06te0ShUc1nNA8fB4WYH0KSRnaCwrFc6XJv1bz5bdQGPrnztOVIahVsQ==
X-Received: by 2002:a17:902:850c:: with SMTP id bj12mr12970386plb.46.1544470123628;
        Mon, 10 Dec 2018 11:28:43 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id v12sm18318674pgg.41.2018.12.10.11.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 11:28:42 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        Can Guo <cang@codeaurora.org>, linux-kernel@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH v7 0/5] arm64: dts: qcom: sdm845: Add UFS DT nodes
Date:   Mon, 10 Dec 2018 11:28:21 -0800
Message-Id: <20181210192826.241350-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the device tree bindings for the QMP PHY to properly
specify the registers for dual-lane PHYs. Update the driver to use
those new registers. Add the DT nodes for UFS on SDM845 and MTP.
Finally, fix up the USB3 PHY on SDM845, which also has a dual-lane phy

This series is now based on phy/next, and given that the changes stack,
I guess that means Kishon will take the whole thing?

Changes in v7:
 - Rebased on top of phy/next

Changes in v6:
- Removed resets and reset-names (Bjorn)
- Renamed nodes (Bjorn)
- Fix renamed nodes in MTP (Bjorn)

Changes in v5:
- Fix incorrect register value in example, copied from real life!

Changes in v4:
- Remove "status" from DT binding example (Rob)

Changes in v3:
 - Removed erroneous fixup for USB UniPro PHY, which is not dual lane (Doug)

Changes in v2:
- Added dt bindings change, corresponding driver fixup, and USB PHY fixup
- Renamed ufsphy to phy (Vivek)
- Removed #clock-cells (Vivek)

Can Guo (1):
  arm64: dts: qcom: sdm845: Add UFS nodes for sdm845-mtp

Evan Green (4):
  dt-bindings: phy-qcom-qmp: Fix register underspecification
  phy: qcom-qmp: Utilize fully-specified DT registers
  arm64: dts: qcom: sdm845: add UFS controller
  arm64: dts: qcom: sdm845: Add USB PHY lane two

 .../devicetree/bindings/phy/qcom-qmp-phy.txt  | 69 +++++++++++++++++--
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts       | 14 ++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 68 +++++++++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp.c           | 51 ++++++++++----
 4 files changed, 181 insertions(+), 21 deletions(-)

-- 
2.18.1

