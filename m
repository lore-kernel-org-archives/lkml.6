Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2045C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E1D20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DgCCOpV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E1D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeLJN4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:56:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39855 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbeLJN4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:56:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id f81so11292648wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 05:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G2KRU/g/GisxnlaqWW4HcsfIO+AdwGpDB+M+SNsZ+gc=;
        b=DgCCOpV1jjqexVZrzVy5+Gm6pzIHO/uvplxk09R+5QQCC1YF8Szo5o39EDrQ53PvpZ
         7O8EZ+zKW707HF86QTKia0ZuocvPLTm+4CeQJeGQ2QuNNfHzsGttiq3b3BLJNtlY2YW9
         Dkx0MFPsiEkppVdkE1XbHm/Eqc4ePHjlhrNc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G2KRU/g/GisxnlaqWW4HcsfIO+AdwGpDB+M+SNsZ+gc=;
        b=lIxGkB/rcJkeiK7W1YFYvqM+AmlZBgSLYj7IbcAYwM29a9or/iXGai5p70qswjPL/s
         po6UKLnu11iBVVa4xLaGki2cLYN9Buy1Ot/KmVmwHdFAbepIelhexpHqaNvqHsCnJGWB
         VcnixlMwPbZUC/kijurDTVGn/wKZtd7bmcwUJZL5WCQtoTLfOUYkBVN77ojdNy10mUBc
         jerWQmIHb8T3EJtf2XGyEUB8EAcBAuj07/8eP222F+ZA5lwasTW2Vh1K9sxbl3YG0gSR
         vFJbXX3yVRv4yd0gcbcvBkZ9wsJ3oUhvP1uhGPGj5+FB+6fk7FUKw6nSQT/i/iguxIWc
         cW0g==
X-Gm-Message-State: AA+aEWaEkB8bymMKCbE2luwmb2b15oBeHE8rJUsbAHLsz9V7RlEk+1EJ
        ROzzQjz97PkPN3XP54k/eRdy2g==
X-Google-Smtp-Source: AFSGD/W2WwDPHKKlo3VBdUyi3rLn0TU5/UAfjIUC84ZwSp+v6svxqoKaW1CDKkVjGH/qLifqbtW1KQ==
X-Received: by 2002:a1c:5585:: with SMTP id j127-v6mr9954369wmb.127.1544450202086;
        Mon, 10 Dec 2018 05:56:42 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c14sm8612506wme.13.2018.12.10.05.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 05:56:41 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     marc.zyngier@arm.com
Cc:     sudeep.holla@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, nicolas.dechesne@linaro.org,
        ctatlor97@gmail.com, vkoul@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 4/4] arm64: dts: add msm8996 compatible to gicv3
Date:   Mon, 10 Dec 2018 13:56:33 +0000
Message-Id: <20181210135633.30283-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210135633.30283-1-srinivas.kandagatla@linaro.org>
References: <20181210135633.30283-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible to gicv3 node to enable quirk required to restrict writing
to GICR_WAKER register which is restricted on msm8996 SoC in Hypervisor.

With this quirk MSM8996 can at least boot out of mainline, which can help
community to work with boards based on MSM8996.

Without this patch Qualcomm DB820c board reboots on mainline.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 8585c61e32ef..cd9650cea05d 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -404,7 +404,7 @@
 		};
 
 		intc: interrupt-controller@9bc0000 {
-			compatible = "arm,gic-v3";
+			compatible = "qcom,msm8996-gic-v3", "arm,gic-v3";
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			#redistributor-regions = <1>;
-- 
2.19.2

