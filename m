Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45322C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C5B20869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzvtCez9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C5B20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeIGKNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 06:13:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34397 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbeIGKNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 06:13:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so6457862pfi.1;
        Thu, 06 Sep 2018 22:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=80TAZC7MEvhEcNz72Fo6KNw7tGsFVG91aIbRpc+jC/Q=;
        b=kzvtCez9D6eihJub/Q5Ty1q5xgeIcDcL70nXBjT2nCNuhscTVqLDxZv3mFmdCpJFhF
         LtMWRYr6snUXWhmzo1bYO07YOPDkqzdxaggIEckyX0vMcz8oEpzOTZ8AaRQtiELEivdh
         xarb8PL2+kT/GlHD97gliiodjRjlK5lCi9Pvam7s3dBuu8r76+8x67327X8rAr2YPBiu
         ImXO25LUiVjgo6++pwuQz6IVQKGQHPzKE/Ni1PTQLPJ0pJYt7CAvB/Gqu9kE7fkD0aVN
         b39Nfn8sqk603af5ycySk+VOcYm951qvRq0KeayA/xFUliDaKWzA/QY/XStUkY1oR+T9
         teQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=80TAZC7MEvhEcNz72Fo6KNw7tGsFVG91aIbRpc+jC/Q=;
        b=Z51Iwxar7AyaL/ZrSFwyzhP8Rpoumk3DQEjB5azs/4NYSeAw3n/X54hm0Epb2dyGnB
         08CUkEOIZp3A3/F/QVsSpv+38wwCgdGrL9AyH5/pnafYHRORqRBqAO9fuCUWb7LkUwmc
         mkfcnVl3RSkG/vUrLW0zTAL7zsiIoeJAD2XHJfe7g34+YOOk+Jn8Dz5T0i666FuK8C0S
         EG44kxWErJaNEsz+tap1QMhWFaaKMyunW8NU74wzl/3y7EDyLcZGP5eW5QP3qcs6bziV
         I1OJhrGV48zOpERYz+gX53XY4raOMRVOr08XBWVQ2t8ss2Ne+GTEplvTnBrUKdQPAQRr
         mTQQ==
X-Gm-Message-State: APzg51Ak69rhfBoNebCLpWnRE+DWQT+f9TmvB2z4st6aUb0GX54t1L9Z
        TUaSXCWL4z97J2XluljkM9X/jmtK
X-Google-Smtp-Source: ANB0VdYqltehVNtyHPDtAliz/8TwemwpQg4VG/mDNVDhbD334QefTsG5MvWjpFQQKj991iB+WXW/WQ==
X-Received: by 2002:a63:2906:: with SMTP id p6-v6mr6346156pgp.204.1536298466624;
        Thu, 06 Sep 2018 22:34:26 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id b203-v6sm9291581pfb.174.2018.09.06.22.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Sep 2018 22:34:26 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 3/6] ARM: dts: qcom-msm8974: use named constant for interrupt flag EDGE RISING
Date:   Thu,  6 Sep 2018 22:33:11 -0700
Message-Id: <1536298394-5548-4-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536298394-5548-1-git-send-email-frowand.list@gmail.com>
References: <1536298394-5548-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Cosmetic change of integer value "1" in the third field of the
"interrupts" property to the correct named constant.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index c09cc1232a6f..6273b6120be0 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1056,7 +1056,7 @@
 		};
 
 		rpm {
-			interrupts = <GIC_SPI 168 1>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
 
-- 
Frank Rowand <frank.rowand@sony.com>

