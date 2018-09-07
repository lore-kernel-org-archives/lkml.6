Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CBFC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CF620645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1CF620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeIHBRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:17:50 -0400
Received: from baldur.buserror.net ([165.227.176.147]:48666 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeIHBRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:17:50 -0400
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1fyNTB-0007Uv-6y; Fri, 07 Sep 2018 15:35:09 -0500
Message-ID: <cad8c585fb415959e7ade8b500278c2c5e070873.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Ran Wang <ran.wang_1@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Fri, 07 Sep 2018 15:35:08 -0500
In-Reply-To: <20180831035219.31619-1-ran.wang_1@nxp.com>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: ran.wang_1@nxp.com, leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH 1/3] soc: fsl: add Platform PM driver QorIQ platforms
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-31 at 11:52 +0800, Ran Wang wrote:
> This driver is to provide a independent framework for PM service
> provider and consumer to configure system level wake up feature. For
> example, RCPM driver could register a callback function on this
> platform first, and Flex timer driver who want to enable timer wake
> up feature, will call generic API provided by this platform driver,
> and then it will trigger RCPM driver to do it. The benefit is to
> isolate the user and service, such as flex timer driver will not have
> to know the implement details of wakeup function it require. Besides,
> it is also easy for service side to upgrade its logic when design is
> changed and remain user side unchanged.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
>  drivers/soc/fsl/Kconfig   |   14 +++++
>  drivers/soc/fsl/Makefile  |    1 +
>  drivers/soc/fsl/plat_pm.c |  144
> +++++++++++++++++++++++++++++++++++++++++++++
>  include/soc/fsl/plat_pm.h |   22 +++++++
>  4 files changed, 181 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/soc/fsl/plat_pm.c
>  create mode 100644 include/soc/fsl/plat_pm.h
> 
> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
> index 7a9fb9b..6517412 100644
> --- a/drivers/soc/fsl/Kconfig
> +++ b/drivers/soc/fsl/Kconfig
> @@ -16,3 +16,17 @@ config FSL_GUTS
>  	  Initially only reading SVR and registering soc device are
> supported.
>  	  Other guts accesses, such as reading RCW, should eventually be
> moved
>  	  into this driver as well.
+
> +config FSL_PLAT_PM
> +	bool "Freescale platform PM framework"

This name seems to be simultaneously too generic (for something that is likely
intended only for use with certain Freescale/NXP chip families) and too
specific (for something that seems to be general infrastructure with no real
hardware dependencies).

What specific problems with Linux's generic wakeup infrastructure is this
trying to solve, and why would those problems not be better solved there?

Also, you should CC linux-pm on these patches.

-Scott

