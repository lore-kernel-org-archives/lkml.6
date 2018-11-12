Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6A4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867132087A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DrXvSaqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867132087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbeKLU3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:29:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43002 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbeKLU3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:29:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id u5-v6so3444059wrn.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 02:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uzcSAte6+/dvv5n+wrP2NMWEvoBdpsZkQM6zHSy+F1A=;
        b=DrXvSaqaje14WshJsMpXads4uj/7ZB2c546OuPHXtVRnYjGcUmV9DA9i9I0M78FKCZ
         cZDBfkA5DdTGDoQjt9lt9u/zjo9AOEs1JWeuhq/X8xz/Mx3iwsJywPFXr453phBnzGsk
         G4y9dU2rdefe+tgNX2VWTStqaAWFbH/5E5eYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uzcSAte6+/dvv5n+wrP2NMWEvoBdpsZkQM6zHSy+F1A=;
        b=WU8mnEzsuZJJSd0Oq4MfIDf1YeNrKf6v40z1nMu3HfmBKSoBR4VKS+ELjId5I4gCWs
         Kl6B1Mt00MlbIMijN5ZpMoMyeYMYTpZL0+QgMkz6vCgGhbJWrwN2e6ISP05IlM3rmWjx
         cqaSJ7Mqsz5PRpVmPQrdWF80+DiIcuCq1i0EAg4nHhq7L3QFCswYYQ6mprLSvmgkh6Nd
         H38jqeZnHUsGUR6h82NKKQGvjWvn7RbNxneo+FK9P8PC1ZUsi9Qf9NgXaYk+zF4dPHxQ
         WE4dGXOiZxFtEd4dUk9TamfNo4YX/z6t2kfw3TDooawXmzQFuRtm2SiuQHO22wK4M/cO
         n2CQ==
X-Gm-Message-State: AGRZ1gKlIZBFmcO4NX7kNUVQQo6SWa7XBrzbJwWAWTlVGZH5orW366Ej
        KDwW/guFsiVxySf6S3zLKbXjCg==
X-Google-Smtp-Source: AJdET5fDn59V/2KvQkK8E1FDIdipBn2C/qLv5GoM64xDqeZNDjX5AkMnXF4iBf86N3vCfYWEL+3pwA==
X-Received: by 2002:adf:d1c6:: with SMTP id m6-v6mr455014wri.138.1542019016733;
        Mon, 12 Nov 2018 02:36:56 -0800 (PST)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id z17-v6sm13747187wrm.65.2018.11.12.02.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 02:36:55 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     marc.zyngier@arm.com
Cc:     sudeep.holla@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org, srini@kernel.org,
        bjorn.andersson@linaro.org, nicolas.dechesne@linaro.org,
        ctatlor97@gmail.com, vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH v3 0/4] irqchip/gic-v3: Add support to DT based quirk for msm8996
Date:   Mon, 12 Nov 2018 10:33:36 +0000
Message-Id: <20181112103340.24702-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.1
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

My previous attempts to add quick based on IIDR register value seems to be
flawed by the fact that the value conflicted with other SoCs.
Last Suggestion by Marc Z using compatible seems to be the only way to apply
quirks required for msm8996 based SoCs.

Here is the patchset which add new compatible for msm8996 gicv3 and add
support gic_enable_of_quirks() followed by the actual quirk required for msm8996.

Without this quirk many qcom SoCs (atleast 3 that I know) are
unable to boot mainline.

Thanks,
Srini

Srinivas Kandagatla (4):
  dt-bindings/gic-v3: Add msm8996 compatible string
  irqchip/gic: common: add support to device tree based quirks
  irqchip: gic-v3: Add quirk for msm8996 secured registers
  arm64: dts: add msm8996 compatible to gicv3

 .../interrupt-controller/arm,gic-v3.txt       |  4 ++-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  2 +-
 drivers/irqchip/irq-gic-common.c              | 12 +++++++++
 drivers/irqchip/irq-gic-common.h              |  3 +++
 drivers/irqchip/irq-gic-v3.c                  | 26 +++++++++++++++++++
 5 files changed, 45 insertions(+), 2 deletions(-)

-- 
2.19.1

