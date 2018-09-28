Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65781C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281A72064D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VTp8liM+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fgr4on1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281A72064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbeI1VVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:21:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49364 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1VVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:21:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8317160B1E; Fri, 28 Sep 2018 14:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538146632;
        bh=ODJUoLgkD36hTImx/WdWBiBCvtXqjKduwsBMT//CJjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VTp8liM+yUh1KD6rhV5klL52lr5z37tu0ZSbslIYWvAIxydBTtXESwdr47eBNERE6
         p9pgzc9QNwZH2OVNn+0gPUhTNnAyFm4vSYt+YpPuuhF5gYBPJefVso5mI6RwwAGUWt
         CHOwqRpbphr/MS/fgRW+NYJOjU66KrqPWsl6p6Oo=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A19216053C;
        Fri, 28 Sep 2018 14:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538146631;
        bh=ODJUoLgkD36hTImx/WdWBiBCvtXqjKduwsBMT//CJjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fgr4on1yVzqH1xeHbMDOWp9HHlSIo2n7JW5z/h+ib87o2Uc3MRBpbjPU8xZMjuFo5
         OxyX/aPaqXOsVWfZUAqYaNVYM0xhjdPnz9Eusfr09OJLg/QJmvsfHG3ZRBT/4stnX1
         2Wkwm2FsbGKQhT4dIhd+O0tmrknknwQHlLwor/x4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A19216053C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Fri, 28 Sep 2018 08:57:10 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     evgreen@chromium.org, bjorn.andersson@linaro.org,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        andy.gross@linaro.org, sboyd@kernel.org, dianders@chromium.org
Subject: Re: [PATCH] drivers: irqchip: pdc: setup all edge interrupts as
 rising edge at GIC
Message-ID: <20180928145710.GI11144@codeaurora.org>
References: <20180927171810.22968-1-ilina@codeaurora.org>
 <27d7df0d-4429-dcdd-f527-a33f9385b4e0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <27d7df0d-4429-dcdd-f527-a33f9385b4e0@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28 2018 at 04:40 -0600, Marc Zyngier wrote:
>On 27/09/18 18:18, Lina Iyer wrote:
>>The PDC irqchp can convert a falling edge or level low interrupt to a
>>rising edge or level high interrupt at the GIC. We just need to setup
>>the GIC correctly. Set up the interrupt type for the IRQ_TYPE_EDGE_BOTH
>>as IRQ_TYPE_EDGE_RISING at the GIC.
>>
>>Reported-by: Evan Green <evgreen@chromium.org>
>>Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>>---
>>  drivers/irqchip/qcom-pdc.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>>diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
>>index b1b47a40a278..faa7d61b9d6c 100644
>>--- a/drivers/irqchip/qcom-pdc.c
>>+++ b/drivers/irqchip/qcom-pdc.c
>>@@ -124,6 +124,7 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
>>  		break;
>>  	case IRQ_TYPE_EDGE_BOTH:
>>  		pdc_type = PDC_EDGE_DUAL;
>>+		type = IRQ_TYPE_EDGE_RISING;
>>  		break;
>>  	case IRQ_TYPE_LEVEL_HIGH:
>>  		pdc_type = PDC_LEVEL_HIGH;
>>
>
>Queued for 4.20, with
>
>Fixes: f55c73aef890 ("irqchip/pdc: Add PDC interrupt controller for
>QCOM SoCs")
>
>added. Please consider providing these tags in the future.

Thanks Marc. Will do.

-- Lina
