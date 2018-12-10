Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08017C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAFB2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A4lsnW+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAFB2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbeLJN4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:56:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46892 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeLJN4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:56:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so10526035wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 05:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2dExJ0toU00K+yN1m9CdYu6ruq4gSdWk6SPmLbPLaKg=;
        b=A4lsnW+x9MB2mlZUV9mt+LAZGmTUx52LYx4YU8gQ/6B8p/So9sc4N/9tIjAzGVmYdo
         dn2mWm1auGvHAQre8ZF4Kpog4QwdgO15h210t4b/fxpdZEgJVvoTeLeGBrvGBdbcToEI
         ZexE1Atwb5+uLzvlIjfB/sPeyjSaHR/tbONXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2dExJ0toU00K+yN1m9CdYu6ruq4gSdWk6SPmLbPLaKg=;
        b=qHi0dYpX8oHFTkm1oy87abGrzkbQ2wzBx9s1Ks2EarM10GSw6q1LaoUT9oF3jEsUv3
         z7GX4miX5oKwBsPF+eEnNXi5hlGcDDrPlXCjJJwH9vCsA7A1RAdvHbFLZ/K7WYjqnZOS
         Pd/aLiBc58t+uMpeHz0KIQr29kcKFQ93z4kMu8oW52BnjCzWwqY5SUepyJ8ixynGeAh8
         i6XKdObuTYxyN13YPG9D+djorOA/Fm8utPPNcoLyXovyNwJK9mP/paTSmIDoLDhVvZsw
         4ZD51zluoUtf61/kfeC9JNYgVkJ3NalrUptFOdiskQ0oVa7P2sE+OPvfWtp/xKmK+eGB
         XigQ==
X-Gm-Message-State: AA+aEWYxpQNITYbTXptLGIPL3Fq1oI0GucQmjXTSsfRvS2fVjKdJ9C/I
        EyH/TmaeM5JZ5gH+iK8d145fZQ==
X-Google-Smtp-Source: AFSGD/Vij8vIRPwDFWvNSZTR7oMHqKnywiDfRCEdMJEe2nbDsKuhH1YREhHBE+fxxBG0HizoV99zHg==
X-Received: by 2002:a5d:53c3:: with SMTP id a3mr9530467wrw.71.1544450196687;
        Mon, 10 Dec 2018 05:56:36 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c14sm8612506wme.13.2018.12.10.05.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 05:56:35 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     marc.zyngier@arm.com
Cc:     sudeep.holla@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, nicolas.dechesne@linaro.org,
        ctatlor97@gmail.com, vkoul@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 0/4] irqchip/gic-v3: Add support to DT based quirk for msm8996
Date:   Mon, 10 Dec 2018 13:56:29 +0000
Message-Id: <20181210135633.30283-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
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

My previous attempts to add quirk based on IIDR register value seems to be
flawed by the fact that the value conflicted with other SoCs.
Last Suggestion by Marc Z using compatible seems to be the only way to apply
quirks required for msm8996 based SoCs.

Here is the patchset which add new compatible for msm8996 gicv3 and add
support gic_enable_of_quirks() followed by the actual quirk required for msm8996.

Without this quirk many qcom SoCs (atleast 3 that I know) are
unable to boot mainline.


Changes since v4:
- Added missing empty entry into quirk table.

Srinivas Kandagatla (4):
  dt-bindings/gic-v3: Add msm8996 compatible string
  irqchip/gic: common: add support to device tree based quirks
  irqchip: gic-v3: Add quirk for msm8996 secured registers
  arm64: dts: add msm8996 compatible to gicv3

 .../interrupt-controller/arm,gic-v3.txt       |  4 ++-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  2 +-
 drivers/irqchip/irq-gic-common.c              | 12 +++++++++
 drivers/irqchip/irq-gic-common.h              |  3 +++
 drivers/irqchip/irq-gic-v3.c                  | 27 +++++++++++++++++++
 5 files changed, 46 insertions(+), 2 deletions(-)

-- 
2.19.2

