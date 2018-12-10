Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD37C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21DC2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZbBb58wW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21DC2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeLJKXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:23:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35669 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbeLJKXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:23:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so9877505wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 02:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XZ8fgTNKEzlulFo0jglvRy93ay062mbv4LQ6PKEe/gQ=;
        b=ZbBb58wWhDv0MvwPZN9fA1XNugmo28nJATFNZ3SQPrwq7s88m8LANQ3JEoSlOuOpyw
         X3FR9ehnuEsgiJVknsxMyzK4p60EKVzrlbh+tXYTlGEqDKkvWs4eSih+mr8E2Jv+emdk
         dAUg2vdmhMtyEX2jigxj5+o8sYttCsDJOau7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZ8fgTNKEzlulFo0jglvRy93ay062mbv4LQ6PKEe/gQ=;
        b=prr04SGRw7KlyDuQ5uFhqbhOYXEauvAiBB7ixr/ayYY4mN/NlvOR7SaOflE4qbx/Cy
         Z6IkGE7vEZfX5xiBYdb/869c/62Kgg2vBGC5FeortU4i3U2iYygWr7/usVJHMju9UIYj
         4Bs9eHHCmcjlj9zdeuYaT8JqX3ImKdMVjRdE4WRjOm9lS3aQapABmVUfx4ecehaOe3zL
         9/JMe9LDopYf85Wx8KJ4eX2ptC7N/wQPMdBxmGFvRy5NkRGrEoiJnj/F1Dk23jJ9nYO5
         Fr1WQOxawpejdGbKNfri398XAj5pNafhnMBFMDYfHOhhHBIliHAv+T8vuCTP/5F1oLMO
         jfjg==
X-Gm-Message-State: AA+aEWZokPGvP4SbnSotVDDMl/TAiyLanVyGSrwJo3v4HptqaOgbawD0
        NJC8EoV+kIN0m7IAFACxeiMbhA==
X-Google-Smtp-Source: AFSGD/WUV60mKobL5BLE2bRhvSje/Gp7j0dRjZwA2MwbNnR/qvcGjJ5yuFEboaP5naRxrXnIVtm6sw==
X-Received: by 2002:adf:ef50:: with SMTP id c16mr9299102wrp.198.1544437396064;
        Mon, 10 Dec 2018 02:23:16 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id r64sm12266664wmg.5.2018.12.10.02.23.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 02:23:15 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     marc.zyngier@arm.com
Cc:     sudeep.holla@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, nicolas.dechesne@linaro.org,
        ctatlor97@gmail.com, vkoul@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 1/4] dt-bindings/gic-v3: Add msm8996 compatible string
Date:   Mon, 10 Dec 2018 10:23:06 +0000
Message-Id: <20181210102309.8207-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210102309.8207-1-srinivas.kandagatla@linaro.org>
References: <20181210102309.8207-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access to GICR_WAKER is restricted on msm8996 SoC in Hypervisor.
There are many devices out there with this restriction in place
and there has been no update to this firmware since last few years,
making those devices totally unusable for upstream development.

IIDR register value conflicts with other SoCs, using compatible seems
to be the only way to apply quirks required for msm8996 based SoCs.

Without this quirk many qcom SoCs (atleast 3 that I know) are
unable to boot mainline.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/interrupt-controller/arm,gic-v3.txt   | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
index 3ea78c4ef887..b83bb8249074 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
@@ -7,7 +7,9 @@ Interrupts (LPI).
 
 Main node required properties:
 
-- compatible : should at least contain  "arm,gic-v3".
+- compatible : should at least contain  "arm,gic-v3" or either
+		"qcom,msm8996-gic-v3", "arm,gic-v3" for msm8996 SoCs
+		to address SoC specific bugs/quirks
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
   interrupt source. Must be a single cell with a value of at least 3.
-- 
2.19.2

