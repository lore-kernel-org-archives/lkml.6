Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C149C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35798206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BhkOBUlL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35798206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbeK3W37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:29:59 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39417 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbeK3W37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:29:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so4920707wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 03:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7erg8T/suDyNnxBlOv6+Oc8Opzezhe58BHPmkVpN4aA=;
        b=BhkOBUlLAGclsf/5TsLcx6uomblvQS6WfUPdzwhA8z4BxHRt5LlX+Gda8DKBrT81bH
         rd+M6sJvPC+WIX2zKH0D6oPrCPtnyZPvB7HbasB+6U3ah5csVheP4oYGzfsYX01ljQjZ
         qBS/6RTRTn2mpzBtDlPbvGXL+r7jABJUwEhv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7erg8T/suDyNnxBlOv6+Oc8Opzezhe58BHPmkVpN4aA=;
        b=pOY5f3rob8J5zSMOJ6ahDJ9p5KRD4/WztQCoCekfXW10wE1jXM8PyvoZQ313b+y8f+
         gJGhREJDPdWDFXFJs4ru7lDWmZf0g7veWoa3VwvLoHSDx5AZFyfOOOO4yFpKq2EkSnd5
         c2W2+flewJIvD7PjBKzrcri8xX20/jAZWEqzMz79Pl0Kp4ro/zawfskOJzRnMHNYrt2z
         j5hyYbe4PJup6psM4xyVY/YPEaxMBGJTBn89qVty4/Wxg21eyiB9IOO4jA3OPRO/R6Ys
         AD4mYn50z24uwOs/06ElClM2UKvGhSaonf0r+yP2vgRmnIDr3wMe+x44GBvFs5gBWhw0
         Ki9A==
X-Gm-Message-State: AA+aEWamHn+n6uvqySOcyqTZazvcc7RWYkPNn04wQ54DiKjw6JhgOvom
        pYkZ+R9MIekLyNcamCiCFvgKTg==
X-Google-Smtp-Source: AFSGD/UJgxcfbN7ggT9v6OHafxHH4tMbl8JOT5chQKratmLN4N08wmgn9EtlNt7WrrnHdiWMV9wGJQ==
X-Received: by 2002:a5d:558a:: with SMTP id i10mr4429921wrv.287.1543576860758;
        Fri, 30 Nov 2018 03:21:00 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id o81sm6585217wmd.10.2018.11.30.03.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 03:21:00 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] rpmsg: core: make rpmsg bus DMA capable
Date:   Fri, 30 Nov 2018 11:20:49 +0000
Message-Id: <20181130112049.14444-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many of the rpmsg clients like audio, fastrpc drivers need to allocate
dma memory. Make this bus DMA capable so that the child devices can
use dma apis.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/rpmsg/rpmsg_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 8122807db380..33881e70f478 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -510,6 +510,7 @@ static struct bus_type rpmsg_bus = {
 	.uevent		= rpmsg_uevent,
 	.probe		= rpmsg_dev_probe,
 	.remove		= rpmsg_dev_remove,
+	.dma_configure	= platform_dma_configure,
 };
 
 int rpmsg_register_device(struct rpmsg_device *rpdev)
-- 
2.19.2

