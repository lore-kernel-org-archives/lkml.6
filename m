Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34C0C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8072F20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8072F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbeIHBF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:05:28 -0400
Received: from baldur.buserror.net ([165.227.176.147]:48592 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeIHBF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:05:28 -0400
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1fyNHF-0007Sf-So; Fri, 07 Sep 2018 15:22:50 -0500
Message-ID: <c19f11e200258297dbe5a61392a4bbc1e937d7c3.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Ran Wang <ran.wang_1@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Fri, 07 Sep 2018 15:22:48 -0500
In-Reply-To: <20180831035219.31619-2-ran.wang_1@nxp.com>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
         <20180831035219.31619-2-ran.wang_1@nxp.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: ran.wang_1@nxp.com, leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH 2/3] Documentation: dt: binding: fsl: update property
 description for RCPM
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-31 at 11:52 +0800, Ran Wang wrote:
> +Optional properties:
> + - big-endian : Indicate RCPM registers is big-endian. A RCPM node
> +   that doesn't have this property will be regarded as little-endian.

You've just broken all the existing powerpc device trees that are big-endian
and have no big-endian property.

> + - <property 'compatible' string of consumer device> : This string
> +   is referred by RCPM driver to judge if the consumer (such as flex timer)
> +   is able to be regards as wakeup source or not, such as 'fsl,ls1012a-
> ftm'.
> +   Further, this property will carry the bit mask info to control
> +   coresponding wake up source.

What will you do if there are multiple instances of a device with the same
compatible, and different wakeup bits?  Plus, it's an awkward design in
general, and you don't describe what the value actually means (bits in which
register?).  What was wrong with the existing binding?  Alternatively, use the
clock bindings.

> -
> -Example:
> -	lpuart0: serial@2950000 {
> -		compatible = "fsl,ls1021a-lpuart";
> -		reg = <0x0 0x2950000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&sysclk>;
> -		clock-names = "ipg";
> -		fsl,rcpm-wakeup = <&rcpm 0x0 0x40000000>;
> +		big-endian;
> +		fsl,ls1012a-ftm = <0x20000>;
> +		fsl,pfe = <0xf0000020>;

fsl,pfe is not documented.

-Scott

