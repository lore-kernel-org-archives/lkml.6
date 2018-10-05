Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AE7C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59933206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZEc7OTPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59933206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbeJEVfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:35:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50250 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbeJEVfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:35:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id s12-v6so2106078wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OErbexhCnIBlMmtkfKS7qpgPsc0q+hgAkyXE0VUWm64=;
        b=ZEc7OTPzR0SzKyko5XB0hKTvLkM118l4PnO2xyf8vxKRyDN3ghbJTxpFTnN1zgh/Cy
         o+1F8MnZpEhwiIJ904fq7o4hFYXubUkp5rOmQQKCNIz/pDo92Puoo4T7VmNkly5stfSO
         d8WDKEB0uE7EKbT3gB3pkWjfHJ9gJs0/frTLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OErbexhCnIBlMmtkfKS7qpgPsc0q+hgAkyXE0VUWm64=;
        b=HXnWcNwVvjeaAqreaBzurhUkSWbf4MxgsDH1AOAenrOUcGdhfEgvK8UtlTEQ14E3Di
         RtB4q4kKVIeXGH/8zuabeIhA1kObbOJ4KgPhdX8Q+w+gI4sxbb5clnz5pA1IJiEmhI/k
         srNLTqj4tHBWv2YAPulrAlVZJTy+o/bavMhKvc6e7izODzPX+tDYfwI0kj1u85CGqRWP
         bNjjPBNGJDvabCl9dIvmMdaJV3M5E+Vbk/24veLuSPS3a7028k3Mjn6Q3M+Vidt7wARf
         ob3e4AwpRFKjxH6qnW9frY0IhKjNEb6nLETHle3X0iErrRDFDDelQfjJyVP+WIPEvzKM
         yTVA==
X-Gm-Message-State: ABuFfoheDeHi/8HGLAFtFtEK8peQIY78z/812VsTbMCd64aefnVfuc9D
        SaiYcmjZekSqxkRBnp8szB7ujg==
X-Google-Smtp-Source: ACcGV60pTs7q99w7Hn2m2M6K4VZX6S5PSqCZfiRGQB6h9dWg4LrvWGIUBZhnyKrSYy51BO/uUe9W1A==
X-Received: by 2002:a1c:2081:: with SMTP id g123-v6mr8026418wmg.144.1538750179576;
        Fri, 05 Oct 2018 07:36:19 -0700 (PDT)
Received: from localhost.localdomain (151.240.136.77.rev.sfr.net. [77.136.240.151])
        by smtp.gmail.com with ESMTPSA id t24-v6sm14080377wra.5.2018.10.05.07.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Oct 2018 07:36:18 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH 10/13] clocksource/drivers/sh_cmt: Add R-Car gen3 support
Date:   Fri,  5 Oct 2018 16:35:39 +0200
Message-Id: <1538750143-4282-10-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
References: <20181005143253.GE1881@mai>
 <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add support for the R-Car gen3 CMT types 0/1 -- they seem to be the same
CMT types 0/1 as in R-Car gen2 SoCs.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sh_cmt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 71624dc..55d3e03 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -935,6 +935,14 @@ static const struct of_device_id sh_cmt_of_table[] __maybe_unused = {
 		.compatible = "renesas,rcar-gen2-cmt1",
 		.data = &sh_cmt_info[SH_CMT1_RCAR_GEN2]
 	},
+	{
+		.compatible = "renesas,rcar-gen3-cmt0",
+		.data = &sh_cmt_info[SH_CMT0_RCAR_GEN2]
+	},
+	{
+		.compatible = "renesas,rcar-gen3-cmt1",
+		.data = &sh_cmt_info[SH_CMT1_RCAR_GEN2]
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sh_cmt_of_table);
-- 
2.7.4

