Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87015C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D3420821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a5g4oNTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D3420821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbeLJTcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:32:17 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35108 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeLJTcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:32:16 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so5435818pgs.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 11:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=p4wMSd+clrTT1ldPmCIKnrVlB4dOOm6F0olIdaXplr4=;
        b=a5g4oNTKgj/TZC20b4joKzTzocaFQXT5Y02dzBfOoWSQ00HLp/8ZiYBI0V1GuNqzoT
         7+fpEQJPA8ogfH6PucSzFYtSv0pouy+Ak+GG+0bNcOKzWUZjUKkqiZ/NHO8G4G80dX4l
         k5Qk3GhH29UafgvWIB7fF0YWFnsx7EgR9PsbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p4wMSd+clrTT1ldPmCIKnrVlB4dOOm6F0olIdaXplr4=;
        b=Dqzk9Kjfb+HBeh8akaebzUsQ/Y+lVeq9IRGrR1LQvhse0QsT4NbKW5PFJ3Oo0Ddlmb
         D7RuiiNQL1D4sfdeArVw1LtAzSBgtJX5XDGHKMGygejUkdAuuqs8ylEbpxKaefhiGC91
         TRUS8Te9jjHV+BQ0NaNooXqcUo6yV/9MT0LTAl92OFd1/cPoSYqeCeprKRJm3+UO7t18
         aKcs+TOYnZW712/6p/v4PCUQOO+lzwvP3gEszO50q8KjFBaunBCxU9JREVj8hYs7fOfI
         nr/tFKA/53MbSVKzxOiQxnVtB7NCVNLLPJPWaJM3Ggr8ncVNq/oGq+i+pGGMTa6X6yDt
         8jqg==
X-Gm-Message-State: AA+aEWZ2oS7jsoW+NLmsaIa1Ygj0o9ssIrDk4SfUIQHKmh+v5sUh3Ane
        M+LUUgqOSMA8XqjS3LBVbxCmvQ==
X-Google-Smtp-Source: AFSGD/UxF+OzP8CKLbcJDpMiM9+1X0a/CnTdimjL+mxi6YM312nl98Xe2qqPYKS7OVECZG50a04J0Q==
X-Received: by 2002:a63:1f4e:: with SMTP id q14mr11463516pgm.88.1544470336053;
        Mon, 10 Dec 2018 11:32:16 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id v5sm23737875pgn.5.2018.12.10.11.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 11:32:15 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Gross <andy.gross@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-arm-msm@vger.kernel.org, Can Guo <cang@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH v2 0/4] phy: qcom-qmp: Fix clock-cells binding and provider
Date:   Mon, 10 Dec 2018 11:32:03 -0800
Message-Id: <20181210193207.242080-1-evgreen@chromium.org>
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

Thanks to Vivek for testing msm8996.

This patch sits atop the UFS device nodes series [1].

[1] https://lore.kernel.org/lkml/20181210192826.241350-1-evgreen@chromium.org/


Changes in v2:
 - Rebased onto phy/next

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

