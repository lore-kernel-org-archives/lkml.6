Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E266C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46E920863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eK9iSwYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46E920863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeK3JVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:21:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39343 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeK3JVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:21:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id c72so1715736pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 14:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rToTEUbJH/iXENfLh5TeV3laYOOSQBG/Wi0PxG4NA78=;
        b=eK9iSwYTmkn6KztqkuQBv4CL3UdxkA+wXlZY5O+uCFedw3AVHe1txgnIiML2XD2rGo
         LnBCg9tx7tJSu8a52pI5xfAwv56tgGFlKD/kB8rvZTxAecxAnUgH3eMWubpFkqWGlUcr
         evFGV1PG7ByEadALaceJFiI8tx8db/Pjauc6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rToTEUbJH/iXENfLh5TeV3laYOOSQBG/Wi0PxG4NA78=;
        b=GLF8yXiVonDWA7LSwirTnCbO1zY8HXinX1UWUqSJMqgwY4+Hy02zhqxlmvTH2vZ7rv
         HF8HdpsYpDSnOUH5l5Nui8WSScn3nkaqF+BUkRC6+rUwQfvkxVs5BcyMq1xiSstm6RTI
         rot1HPEjU9YcyRns7jkkhecum9CzBjKLKkWpPijki/ouIr3X/2aDc0MLP1wQ/00tazHd
         nLoTMVriYMLqRifYQpLHWVZEQTCy6ruYKR/3D2573Jnqnu/Iv5olzesx7lb0HDsubd14
         E+CRy2j8q0/cw+Kawkk1lh7NY5IXuNVJ/p8mTCj7/jHA7VVeEIo4b5ipktjeNufZ1h/F
         6OOQ==
X-Gm-Message-State: AA+aEWYJqbgXun9Gp9G0i4/3BMvEqgidhZcUd+AYLmv5TJ/DRdNoQ3nR
        gX7xUWByAUuxSMm8LpPTLS+BOA==
X-Google-Smtp-Source: AFSGD/WMwGf4pU+VGNB4AcZCJ/n0oDHA1oPTsL3+GJsnoc+kEq6IG24XUCMOkBnLp8n84KKMja15/Q==
X-Received: by 2002:a62:2cf:: with SMTP id 198mr3158558pfc.67.1543529661149;
        Thu, 29 Nov 2018 14:14:21 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id c67sm4697690pfg.170.2018.11.29.14.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 14:14:20 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        Can Guo <cang@codeaurora.org>, linux-kernel@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH v1 0/4] phy: qcom-qmp: Fix clock-cells binding and provider
Date:   Thu, 29 Nov 2018 14:13:53 -0800
Message-Id: <20181129221357.67417-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the QMP PHY bindings, which had specified #clock-cells
in the parent node, and had set it to 1. Putting it in the parent node is
wrong because the clock providers are the child nodes, so this change
moves it there. Having it set to 1 is also wrong, since nothing is ever
specified as to what should go in that cell. So this changes it to zero.
Finally, this change completes a little bit of code to actually allow these
exposed clocks to be pointed at in DT.

I had no idea how to fix up ipq8074.dtsi. It seems to be completely wrong in
that it doesn't specify #clock-cells at all, has no child nodes, and
specifies clock-output-names in the parent node. As far as I can tell this
doesn't work at all. But I can't add the child nodes myself because I don't know
1) how many there are, and 2) the registers in them. I also have no way to test it.

Speaking of testing, I was able to test this on sdm845, but haven't tested msm8996.

This patch sits atop the UFS device nodes series [1].

[1] https://lore.kernel.org/lkml/20181026173544.136037-1-evgreen@chromium.org/



Evan Green (4):
  dt-bindings: phy-qcom-qmp: Move #clock-cells to child
  arm64: dts: qcom: msm8996: Fix QMP PHY #clock-cells
  arm64: dts: qcom: sdm845: Fix QMP PHY #clock-cells
  phy: qcom-qmp: Expose provided clocks to DT

 .../devicetree/bindings/phy/qcom-qmp-phy.txt  | 11 ++++-----
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  6 +++--
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  4 ++--
 drivers/phy/qualcomm/phy-qcom-qmp.c           | 23 ++++++++++++++++++-
 4 files changed, 33 insertions(+), 11 deletions(-)

-- 
2.18.1

