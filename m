Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6452C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173AD20663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SMdJkgfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173AD20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbeJWFM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:12:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40093 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbeJWFM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:12:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id o14-v6so3858021pgv.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 13:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RPT/WTxyUGreQcDbdg1cHDx9XCdq0A5fb8bWQwqAeBo=;
        b=SMdJkgfDWFnC7ibzKHBaWUUGrz8qnX/KAEt4NwGQUiw2zpWxZev4gtnbVreywPZyii
         CnoT0RaZaoIrq8+Y147CmhreSHJ8SfeIlpbL1uExgj+9qJELlVCNzBE9VPj7u0TynECa
         DuSTahW4yazos4OSCZ48fwbgjQc6aSrZFa2wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RPT/WTxyUGreQcDbdg1cHDx9XCdq0A5fb8bWQwqAeBo=;
        b=Gl30jYTnpJJrF6H9xa018yRyUXwDmlDgXxThG1//1hAj7dkUFXjVg3S2J/ulCa2lBU
         sr+AGI7r8HCVKycgy6G3mqDvyRpftKq1VDYjdMRs+VjvcAA1b9oKl8WrL8p8/qWadcKT
         PePwHs/JpaxVlTLuy6SCchP4FWDqMEkq3enY33nxdQi6tP5IB0kDSN+7Q4a0Ltp3EpfZ
         3dKi01NhZ++JzVYvyRdRjnbNtt2XJ6x1oPoB0HbB4zBFG5A2vo0G/JfKFQO+V29G41ET
         4AO0kcFsZgTS9oXM3htQNKQXu6pYHedOom+Fm92kk6MtGE8PGnCjhgeH/I80w7R/QtXc
         U3nQ==
X-Gm-Message-State: ABuFfojY3+ac2qw40eH6ZmL54LUqr8hmD0RwtJnDekASUcVILONbJ8Hl
        vBkkCouBUVfFuykYK2SORmTXmQ==
X-Google-Smtp-Source: ACcGV608bPOu4etozebDXXTQS7tMyYnVcCjK1YsIQtHS4T0S6XqjUcO5d1/2xGuUpt62Kz6covxPRg==
X-Received: by 2002:a62:8910:: with SMTP id v16-v6mr46873789pfd.106.1540241539236;
        Mon, 22 Oct 2018 13:52:19 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id a11-v6sm37216041pfn.66.2018.10.22.13.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Oct 2018 13:52:18 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH v3 5/5] arm64: dts: qcom: sdm845: Add USB PHY lane two
Date:   Mon, 22 Oct 2018 13:51:02 -0700
Message-Id: <20181022205102.74825-6-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181022205102.74825-1-evgreen@chromium.org>
References: <20181022205102.74825-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the second lane registers for the USB PHY, now that the
QMP phy bindings have been updated. This way the driver can stop
reaching beyond its register region to get at the second lane.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v3:
 - Removed erroneous fixup for USB UniPro PHY, which is not dual lane (Doug)

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 9c72edb678ec..ff2db36ec4fa 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1188,10 +1188,12 @@
 				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
 			reset-names = "phy", "common";
 
-			usb_1_ssphy: lane@88e9200 {
+			usb_1_ssphy: lanes@88e9200 {
 				reg = <0x88e9200 0x128>,
 				      <0x88e9400 0x200>,
 				      <0x88e9c00 0x218>,
+				      <0x88e9600 0x128>,
+				      <0x88e9800 0x200>,
 				      <0x88e9a00 0x100>;
 				#phy-cells = <0>;
 				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
-- 
2.16.4

