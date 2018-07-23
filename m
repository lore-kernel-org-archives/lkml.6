Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFBDECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2EF20846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TVstDRnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2EF20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387919AbeGWHK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:10:59 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43180 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387904AbeGWHK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:10:59 -0400
Received: by mail-pl0-f65.google.com with SMTP id o7-v6so7798881plk.10
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 23:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LWxppdcTaKp3RkRdNBkHXwKcTm4kfWve60Wtgv2mUMI=;
        b=TVstDRnfD2iKsF/kQv1pOiQuoQ4ta7ArYXuSuhlVKlcvx82bzpkKOpUiisqEkvty79
         sSBtBc1rFOQyJ86PvNV+GyllJsdjI07TDjVp24VhuQqDfG+VqQ1AvABommKdnDq7yRYx
         QAK3xRSd1nT89TpbXcgA3+gH1bHQHRWhMOP+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=LWxppdcTaKp3RkRdNBkHXwKcTm4kfWve60Wtgv2mUMI=;
        b=ppEis1Eu6m+N9LltQhfpwgNyQJ3C6B7SbQN7JFIMFzat6b8Z7ESKucHUduUbe9H79C
         76ypLn/p3E1QzGF/8T6VppkEnLOueTQPELIwviEXiBo330F8Cv4ECaDu2TLuCPTx5B3g
         5kK0mRJqALTHQ6oHmLjG+5yrZU+Goy8gny8KEzitfkPp0oF0+eLKOQl85Gj4s/7h7hxm
         N/11dRUrpJbY51rGDl/MZWUIx5dxsX+a+NpBtGQnnV70sZblwvyFi3NpaoDwGIltexQz
         XOmvBik4/UnHxbRMeMQoVxSGNzXSCkeUxfrB5dsqgA8fVndxBOZw7ezZtayMBs0+i1Qx
         MJZA==
X-Gm-Message-State: AOUpUlHR8i4n+j+umxQa6D7JrlviDkw7HyeWn1kVW1m9ebqP0v1qTuuN
        foIBt6SEt6Yy1bzw+GKgqMQV6g==
X-Google-Smtp-Source: AAOMgpd0q4fqXlxdr4YJNVGYXLqDXg9eeFEqL2/2EsDIEqX8QNYJloDFwGXUouYrtNCgktQ/zy2yqQ==
X-Received: by 2002:a17:902:4381:: with SMTP id j1-v6mr11660175pld.104.1532326285498;
        Sun, 22 Jul 2018 23:11:25 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 8-v6sm11972303pfk.132.2018.07.22.23.11.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 23:11:25 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Cc:     devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH 3/5] arm64: dts: sprd: Add SC27XX eFuse device
Date:   Mon, 23 Jul 2018 14:10:18 +0800
Message-Id: <9cfac30ae483e1ee1d7e3519b542d50a583f0b8d.1531881619.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
References: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
In-Reply-To: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
References: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the eFuse device node for Spreadtrum SC27XX PMICs.
The SC27XX eFuse contains 32 blocks and each block's data width is
16 bits.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index 650bd68..fc68076 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -57,6 +57,14 @@
 			#interrupt-cells = <2>;
 		};
 
+		efuse@380 {
+			compatible = "sprd,sc27xx-efuse", "sprd,sc2731-efuse";
+			reg = <0x380>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			hwlocks = <&hwlock 12>;
+		};
+
 		vibrator@ec8 {
 			compatible = "sprd,sc27xx-vibrator", "sprd,sc2731-vibrator";
 			reg = <0xec8>;
-- 
1.7.9.5

