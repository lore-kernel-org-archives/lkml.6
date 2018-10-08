Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF37CC677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9935A2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="VGZmEsem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9935A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeJIBdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:33:47 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:59398 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbeJIBdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:33:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 970891F984;
        Mon,  8 Oct 2018 20:20:01 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1539022800; x=
        1541614801; bh=bIA8961skFS3aGjLCRIVUiZowiuj4nBOB3flC/q58j8=; b=V
        GZmEsem+LvE3bXzzDAoHu1dtKSyMNDP8EXsG1p0ItkmZVbUqmezlAcfjmmgFpmtA
        pH9nyUH7fdqsteT/l471p4sTxmPE1/ezh4ujsweb86bIWaDqAlA6pOxXHEbmzb2x
        Q6wQdjqZ6SlLdoCzXzQK79C6TvypuNic7gnfL1e4xHOcx1zzNWpsNrIRLTytBOQg
        qKexRe0u0pLG/fXdvX5fn9lJ81tcbWB8vqSfUst3QXwBIqi8CWYRkKIBUfd0ZFFX
        /t7SLm0h9UyAGTiHrpVv4eERI2Rqh86wibrZvi67NFbg/UT45oUKWHc3cDNOQVOx
        30+P/KpDWj3JYtbojAXBmHoI+eFyLrvGKPOZy6Op8CxAD4V/rdf76EvuSyb+of9k
        Rx3JdoydXu2e6bDoDYm7usgqXN5C6ciIrP9GpwfSd1NnCkAQDHxwBHyfwkcICwvz
        cYDEWCsi8bnucSYKSrARgDYW4a8mgoXH6CkU2o9Qny6g6mVvspzkKRcm9l4Grpaf
        IwluSRsGSkNhinvvIsnCQGuG3TzI0Lsf71nb1JMsTSIfF+9A5lqzHjPy2mi03v52
        g/Vq3jncOZRT6mzbcACWJRgoMCzfbw85HmXD1L1uVvEGMRp+kByIuU6rSGw0l5aA
        /dunbExhGUXVXj5im0A+rSSD4OqhEuRSRWjTid7j7I=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id tcArbIAGhriw; Mon,  8 Oct 2018 20:20:00 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 426C220929;
        Mon,  8 Oct 2018 20:20:00 +0200 (CEST)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/7] ARM: dts: axp81x: add AC power supply subnode
Date:   Mon,  8 Oct 2018 21:19:03 +0300
Message-Id: <20181008181908.9456-3-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008181908.9456-1-oskari@lemmela.net>
References: <20181008181908.9456-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AC power supply subnode for AXP81X PMIC.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 arch/arm/boot/dts/axp81x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
index 043c717dcef1..bd83962d3627 100644
--- a/arch/arm/boot/dts/axp81x.dtsi
+++ b/arch/arm/boot/dts/axp81x.dtsi
@@ -48,6 +48,11 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	ac_power_supply: ac-power-supply {
+		compatible = "x-powers,axp813-ac-power-supply";
+		status = "disabled";
+	};
+
 	axp_adc: adc {
 		compatible = "x-powers,axp813-adc";
 		#io-channel-cells = <1>;
-- 
2.17.1

