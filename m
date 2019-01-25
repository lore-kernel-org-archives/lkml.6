Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3A1C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2E7218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GttiOvLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfAYX0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:26:43 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33074 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfAYX0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:26:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so5447886pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 15:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fUnzpkkKPd9BeYGxYL4u0M8CAGQFglMs7DV//KlK6OE=;
        b=GttiOvLIr7onsg9dwRLhZ7jAK9eHRevELHzImusdz/3ewHj1DFV8EAWMo7YYbd90+q
         hVr6muGPiZ6m2PkKo4ISbIe4hp0+Hm1Btg2BfzYhQZ/kKIp6MQCpPg8Q4o/iUkD3P0iV
         Rnd0E5PjJNQQuoo0VzEBXjRtyn/pffMOcD2M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fUnzpkkKPd9BeYGxYL4u0M8CAGQFglMs7DV//KlK6OE=;
        b=WGpdjnoiB5oxJ6JwYjQgQFCchisapLBbQB0Y1QAHJLRAVt29sM9rKrxmZidkOumBlL
         yvkF+MoetCkc3UK5tCiuAh8y2wO9gSLJjZ4kzX1jg9jIRHWqzwzRa3SxNURLLS7Hmrux
         bN2dhQbYaOfd6OqXAFtlmSalQGcEnPiaEhX4iSr+c94I0hk0fObx1jU1qnuVwr39ULsz
         ObjP0gxTr75RPwHhAzOOusuc4HUNIsL49E23rNl4k7ic2SyLVkunDF5z2NSrq8q6wfQe
         vYTAB2+aocTY2JDEsV1rFsbU1IU/DKp9V8WOPOvmQ3b0/rGEGxfn9oF0xt5Qy2XPijvt
         gKfg==
X-Gm-Message-State: AJcUukdpfbWfHaAM3tLR6LY9iB9hPY4vAf45PLnEGr8o4e83624SOh9E
        nH6nvGfmq+FD6GL3uN7uRitzwQ==
X-Google-Smtp-Source: ALg8bN7Et9xZ2t6Iy3our6g2gjp6kVwnPnBpmH+++z/iJUQ2AI/1+feB9/y95sn6nMCwg5eMkmFz9g==
X-Received: by 2002:a62:a1a:: with SMTP id s26mr13008527pfi.31.1548458802427;
        Fri, 25 Jan 2019 15:26:42 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l70sm52910375pgd.20.2019.01.25.15.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 15:26:41 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] PCI: qcom: Don't deassert reset GPIO during probe
Date:   Fri, 25 Jan 2019 15:26:16 -0800
Message-Id: <20190125232616.25714-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acquiring the reset GPIO low means that reset is being deasserted, this
is followed almost immediately with qcom_pcie_host_init() asserting it,
initializing it and then finally deasserting it again, for the link to
come up.

Some PCIe devices requires a minimum time between the initial deassert
and subsequent reset cycles. In a platform that boots with the reset
GPIO asserted this requirement is being violated by this deassert/assert
pulse.

Acquiring the reset GPIO high will prevent this by matching the state to
the subsequent asserted state.

Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d185ea5fe996..a7f703556790 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1228,7 +1228,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	pcie->ops = of_device_get_match_data(dev);
 
-	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_LOW);
+	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->reset)) {
 		ret = PTR_ERR(pcie->reset);
 		goto err_pm_runtime_put;
-- 
2.18.0

