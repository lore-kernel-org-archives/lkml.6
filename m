Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAD1C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA972075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ATd0BlS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA972075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbeJ3Oea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 10:34:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38695 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbeJ3Oe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 10:34:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so5228468pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 22:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fSNG4Wf3QaLCMSJLJSn0A/ViIfSMoba8WJjS6lb9qEY=;
        b=ATd0BlS9zl5B0TuMkJA6KBR/cuoI+pEDCLJHjeR62BB41qYIuSJkWaOlUYIySNBpA9
         VuMACpBzsRB5yeKHMaiY7IsZrU2HcJSCJS8XPkZQ5nA2th8di27X1fWPnom96fp2NfRm
         HMMcM0ak1irXdDq0DsmuSSYM/MsZVox26Nv7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fSNG4Wf3QaLCMSJLJSn0A/ViIfSMoba8WJjS6lb9qEY=;
        b=OdCU8aMCAcSr4lyfqpYvlj5LWyestayxZS1f+k9tqTGceimjfA4VRCwM/vAdR2Tk3I
         IoYiEWtODYOP7w7D/Fj5wVjL3weho5wZdOqa0vYsR46FSl4ljrOgUcxy7ztZMaHiVHYQ
         /x7Z0B61D+pjsxiQsjpYKDzk5jPmhiYjvHaA6AN1ljLCdwFe1OURBsMdjCA+ADX95FeG
         EWjzhmVS+l4wjYhUKQvQQVAyQTusgeMSA7COn48RlDlPWYdknxUzR29dP7jNZHyC+a+i
         rTJeXzb3SFNuhdf/SfnFfxKg2OMQ/QdPQRcMqczn8aMbdDIiQzzS4lV+BRsuxzy7vOw4
         okXw==
X-Gm-Message-State: AGRZ1gJ91Wrrdrko3kDOPnp0dE+Kjy8HsybmwgctPyUa4rbrZ5RMn+2E
        bC2qSBbgM4zJU/KSCPUKmAW5IjbJKG8=
X-Google-Smtp-Source: AJdET5elFSAudEw2Hyh/EXGrZCS7LAFc2UU9C5M5iFOJeQ9LNABGRNQcoG1PJwHOkZBPuj8cZh75cA==
X-Received: by 2002:a63:1d10:: with SMTP id d16-v6mr16119386pgd.228.1540878147405;
        Mon, 29 Oct 2018 22:42:27 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g72-v6sm23577077pfd.181.2018.10.29.22.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 22:42:26 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: msm8998: Reserve gpio ranges on MTP
Date:   Mon, 29 Oct 2018 22:45:54 -0700
Message-Id: <20181030054554.1954-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIOs 0 through 3 and 81 through 84 are configured to not be accessible
from the application CPUs. Mark them as reserved to allow the MSM8998
MTP to boot after the introduction of 3edfb7bd76bd ("gpiolib: Show
correct direction from the beginning").

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
index b4276da1fb0d..11fd1fe8bdb5 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -241,3 +241,7 @@
 		};
 	};
 };
+
+&tlmm {
+	gpio-reserved-ranges = <0 4>, <81 4>;
+};
-- 
2.18.0

