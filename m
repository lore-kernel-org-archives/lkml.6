Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4665C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A9020892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bUFIzjCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A9020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbeLFSpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:45:36 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45640 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbeLFSpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:45:35 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so556252plm.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Epun9c8q/ahOAgKAIMefQh9iFCZvdlNc3VcFQulde3A=;
        b=bUFIzjCH/zfeMqMKiZesusfqXA0gtaQ0FqwT75tezT9FI1uYSbq6c8wu2+Ds2kPr+I
         mnk757WznBYuQ3RH1wtc73RdZVc+Io4b88RVX00j1VJgBfENSq76rrz7EBaILghp4/mi
         AknLKbnZKRKMWxQsCwFOyLvMQVspkmBNuX3Fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Epun9c8q/ahOAgKAIMefQh9iFCZvdlNc3VcFQulde3A=;
        b=FKxolp4Ak5VkPKkwnqGIqEGYCxiSVTfAHvlx/SyiHsS+u4gqUk3RVFUHudEV2ATd4e
         ak1Nlsx+hcPj0xeFGjKH5dbJbCDI+9Mrz5XHibh/tNBvvgzZzo9uyRkNTE3hP9uoZnbS
         SsWK4+uI8SsU3fyICrOeO0j9ttwk84pMgS8MpfA3mnz3ifD9omMlQAgsivNtjO71G1ka
         JSLHXVlvVR1G2wRixkjuwJK1b4vpWfJ6EMzRltq4Lh5EAWighYcQD6crr1EmVbdbBSgT
         N7thv48o7Kf4D3kJkoMbwG9I/DB2NxXxJZOY468yjJuPDmj5wuj+t6/R4OrefctmCBp6
         mCOA==
X-Gm-Message-State: AA+aEWZSigiMk+cEqj6ZgVdGg7VX13kpj/gswnJnzPVt4CzeOyEz8Xo1
        IiTrrGqbPR6xIPNctZnpqo2LQg==
X-Google-Smtp-Source: AFSGD/VUbGFf5vHDQ2RoklBdn8mJ0RQVJzbLV5ouJr2WyYDF4RQ9I5nbeNhtUOaxW1OEUVelIrCphw==
X-Received: by 2002:a17:902:6502:: with SMTP id b2mr28811506plk.44.1544121934719;
        Thu, 06 Dec 2018 10:45:34 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id v89sm1458476pfk.12.2018.12.06.10.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 10:45:33 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 0/3] arm64: dts: qcom: sdm845: Add SD nodes
Date:   Thu,  6 Dec 2018 10:45:19 -0800
Message-Id: <20181206184522.118062-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the nodes for one of the two SD host controllers on SDM845,
and wires it up on the MTP.

Though I tested similar changes on another board, I was unable to actually run
this on an MTP. If someone felt like trying this out on an MTP I would be
grateful.

The original downstream nodes had sleep pinctrl states. It's not obvious to
me that all this messing with drive-strength saves non-negligible amounts of
power, so I didn't add them and figured we could add them later if needed.

Changes in v2:
 - Reworded commit message to note that there are multiple SD
 controllers.
 - Fixed alphabetization of node placement in sdm845-mtp.dtsi (Doug)
 - Fixed card detect name to match schematics (Doug).
 - Moved comment about drive strength next to the drive-strength entry
 (Doug)
 - Removed drive-strength from card detect input pin (Doug).
 - Consolidated tlmm nodes in MTP.

Evan Green (3):
  dt-bindings: mmc: sdhci-msm: Clarify register requirements
  arm64: dts: qcom: sdm845: Add SD node
  arm64: dts: qcom: sdm845: Add SD nodes for sdm845-mtp

 .../devicetree/bindings/mmc/sdhci-msm.txt     |  2 +-
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts       | 58 ++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 15 +++++
 3 files changed, 72 insertions(+), 3 deletions(-)

-- 
2.18.1

