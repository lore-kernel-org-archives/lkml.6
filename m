Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6B4C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1169F20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XcJWbDnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1169F20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932963AbeFUINR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:13:17 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:22846 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932431AbeFUINO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:13:14 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelnx193.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5L8DCEe004175;
        Thu, 21 Jun 2018 03:13:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529568792;
        bh=6dTVnSyxfZ0CsM4ZCWg/d1zvLmJUPnL//QWVcL0bJa4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XcJWbDnFaIxf/HVWtljLNirslurBPoKy6E2NiR5N+wMNpcMXJRSvdg0BcrP/AlFtY
         hHsJbSzj7DPDwv6wlgYkMqQu1tsMQI8kc86OMoR6nVhlKiPKuls1ZdT1aIxQ6QFCHj
         PI7sw42t09xJACmFhkESJs6fhOtw8CexMHm5EEoM=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5L8DCoF024035;
        Thu, 21 Jun 2018 03:13:12 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 21
 Jun 2018 03:13:12 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 21 Jun 2018 03:13:11 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5L8D9r0010781;
        Thu, 21 Jun 2018 03:13:10 -0500
Subject: Re: [PATCH v2 0/4] clk: clk: Add functions to save/restore clock
 context en-masse
To:     <t-kristo@ti.com>, <sboyd@kernel.org>, <tony@atomide.com>
CC:     <linux-clk@vger.kernel.org>, <d-gerlach@ti.com>,
        <linux-omap@vger.kernel.org.org>, <linux-kernel@vger.kernel.org>
References: <1529568620-19765-1-git-send-email-j-keerthy@ti.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <8d58003e-25b4-b8b1-a1ef-1cf84a3fc79f@ti.com>
Date:   Thu, 21 Jun 2018 13:43:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1529568620-19765-1-git-send-email-j-keerthy@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 21 June 2018 01:40 PM, Keerthy wrote:
> Deep enough power saving mode can result into losing context of the clock
> registers also, and they need to be restored once coming back from the power
> saving mode. Hence add functions to save/restore clock context.
> 

Seems like there is an issue with one of the e-mail addresses. Sorry
about the noise will send v3 in a bit.

> Tested for DS0 on am437x-gp-evm
> 
> Based on top of linux-next
> 
> Changes in v2:
> 
>         * Renamed clk_dflt_restore to clk_gate_restore_context
> 
> Keerthy (2):
>   clk: clk: Add clk_gate_restore_context function
>   soc: ti: pm33xx: Save/restore clk context based on enable_off_mode
>     setting
> 
> Russ Dill (2):
>   clk: clk: Add functions to save/restore clock context en-masse
>   clk: ti: Add functions to save/restore clk context
> 
>  arch/arm/mach-omap2/pm33xx-core.c    |  15 +++++
>  drivers/clk/clk.c                    |  93 ++++++++++++++++++++++++++
>  drivers/clk/ti/clock.h               |   2 +
>  drivers/clk/ti/divider.c             |  36 ++++++++++
>  drivers/clk/ti/dpll.c                |   6 ++
>  drivers/clk/ti/dpll3xxx.c            | 124 +++++++++++++++++++++++++++++++++++
>  drivers/clk/ti/gate.c                |   3 +
>  drivers/clk/ti/mux.c                 |  29 ++++++++
>  drivers/soc/ti/pm33xx.c              |  13 ++++
>  include/linux/clk-provider.h         |   9 +++
>  include/linux/clk.h                  |  25 +++++++
>  include/linux/clk/ti.h               |   6 ++
>  include/linux/platform_data/pm33xx.h |   1 +
>  13 files changed, 362 insertions(+)
> 
