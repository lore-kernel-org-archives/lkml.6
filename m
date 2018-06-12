Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6A6D6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210F5208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bHSx4GpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210F5208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933738AbeFLOuM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:50:12 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36639 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932750AbeFLOuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:50:11 -0400
Received: by mail-wr0-f193.google.com with SMTP id f16-v6so24418757wrm.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 07:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uqgmDH3OOOrKkH6AlElDwp8MalxGqk71Y0hDT1QZrnw=;
        b=bHSx4GpOxj+CAnJCXf0UIDoLmVJFXtNGsfpHVWSzRxOoJskKRM4DzdrnnrH0uKcAzQ
         CwP3pJilPFVL8bQ5xnT16oCmaa7JEqPx3QQpT0wzmY4aewopXijC70YnUsaTQktfbFKt
         1a0gK9hsww3+nI/anjNnvY6XX+lbZ1k1n1QXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uqgmDH3OOOrKkH6AlElDwp8MalxGqk71Y0hDT1QZrnw=;
        b=juCIdnCxWdC7At9WSOb2ECrN6iF81L6aqPrODW22bt2s1+aslhiTBt8NlXfxgy827O
         Ksqb7ob7QC8acUTAkL2ycZ7SVzNbkcRn8zUM2KfZ8z+fpIZ4LqllUnxscA6HQOIaqN3m
         UBQmllcwhnL1q5nJuy82sFIvr7i/Xw6YR0gqU0xdkkTLlDr+zK5ZtxJsBaeGCN15EWKN
         HRKVQ/2zoVFrDitBeIZHc/17CTh12wFmoSf9kZK1X3aUpMMMJt9BEJwlIb2O9hhQ/SoY
         1uCTSa+H0Cox68AiBVJM1rW2+HgjxlqQNHcf1ngLC7OHH64Wg+sd+LRiBn1gaw47cD3q
         dCuw==
X-Gm-Message-State: APt69E1SKBqTyFcmL2CKccG0UjcArk6JqMIwJCStVkaeOAZHJO0NKAuc
        npIeATuCO0iipjQsdYhyXgfeLQ==
X-Google-Smtp-Source: ADUXVKKBFkwKi1PT2Y3erX2zQ7a2Q6u1bciwh2eLyTXTbU2TNi0UOfp/ciM5M+g67VCS4h9sr/lcVw==
X-Received: by 2002:a5d:470b:: with SMTP id y11-v6mr559662wrq.107.1528815010047;
        Tue, 12 Jun 2018 07:50:10 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id w102-v6sm496182wrc.23.2018.06.12.07.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jun 2018 07:50:09 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     andy.gross@linaro.org
Cc:     mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] arm64: dts: apq8096-db820c: disable uart0 by default
Date:   Tue, 12 Jun 2018 15:48:06 +0100
Message-Id: <20180612144806.19201-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access to UART0 is disabled by bootloaders. By leaving it enabled by
default would reboot the board.
Disable this for now, this would alteast give a board which boots.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 0f829db33efe..4d5ef01f43a3 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -75,7 +75,7 @@
 
 		serial@75b1000 {
 			label = "LS-UART0";
-			status = "okay";
+			status = "disabled";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&blsp2_uart2_4pins_default>;
 			pinctrl-1 = <&blsp2_uart2_4pins_sleep>;
-- 
2.16.2

