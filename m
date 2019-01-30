Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5A6C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0232F218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548857375;
	bh=0Km+iSKyaMuzF9hZrxprPh3mJUVRfgED3Q3IXmmmmNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K1WXo0NiTkw/SHG6ieLXOXQHZk2EMgTeDCxvuOw7Fd0fhY61Z/Gu0NDUPw+jfovDe
	 PHyOVvf0KwVzPeAEGGGV35tCZFI64n5anG1Xde9BqRKv9WahFHwINWQS5f0yAXgAUj
	 Zs6CgpGtS515lMED7fSFnyBB0DTu86jJQWwEBG94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbfA3OJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:09:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbfA3OJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:09:32 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF0CE218A4;
        Wed, 30 Jan 2019 14:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548857372;
        bh=0Km+iSKyaMuzF9hZrxprPh3mJUVRfgED3Q3IXmmmmNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E4itVRdwP9Q0okhcv+1BDS+Xuy4KlQsSlP+XSQpv6tJK3e7p6ADTEaqw/vyWK5pd9
         bdKnW6x+MWBmcc5DwVwoxfHI6GjxIRfB3WX5iaOlMbFg1p2eNoeoZqoaten+S59ucR
         Wd9iw9RZQcAJlt752qv2/jDXaZKUfVf1NFKPeuU0=
Date:   Wed, 30 Jan 2019 08:09:29 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Aleksey Makarov <aleksey.makarov@cavium.com>
Cc:     netdev@vger.kernel.org, Robert Richter <rric@kernel.org>,
        "Goutham, Sunil" <Sunil.Goutham@cavium.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        linux-kernel@vger.kernel.org,
        David Daney <ddaney@caviumnetworks.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Joe Perches <joe@perches.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v6 1/2] net: add support for Cavium PTP
 coprocessor
Message-ID: <20190130140929.GA227269@google.com>
References: <20180115124500.14872-1-aleksey.makarov@cavium.com>
 <20180115124500.14872-2-aleksey.makarov@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180115124500.14872-2-aleksey.makarov@cavium.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2018 at 06:44:56PM +0600, Aleksey Makarov wrote:
> From: Radoslaw Biernacki <rad@semihalf.com>
> 
> This patch adds support for the Precision Time Protocol
> Clocks and Timestamping hardware found on Cavium ThunderX
> processors.
> 
> Signed-off-by: Radoslaw Biernacki <rad@semihalf.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@cavium.com>
> Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
> ---
>  drivers/net/ethernet/cavium/Kconfig             |  12 +
>  drivers/net/ethernet/cavium/Makefile            |   1 +
>  drivers/net/ethernet/cavium/common/Makefile     |   1 +
>  drivers/net/ethernet/cavium/common/cavium_ptp.c | 353 ++++++++++++++++++++++++
>  drivers/net/ethernet/cavium/common/cavium_ptp.h |  70 +++++
>  5 files changed, 437 insertions(+)
>  create mode 100644 drivers/net/ethernet/cavium/common/Makefile
>  create mode 100644 drivers/net/ethernet/cavium/common/cavium_ptp.c
>  create mode 100644 drivers/net/ethernet/cavium/common/cavium_ptp.h
> 
> diff --git a/drivers/net/ethernet/cavium/Kconfig b/drivers/net/ethernet/cavium/Kconfig
> index 63be75eb34d2..96586c0b4490 100644
> --- a/drivers/net/ethernet/cavium/Kconfig
> +++ b/drivers/net/ethernet/cavium/Kconfig
> @@ -50,6 +50,18 @@ config	THUNDER_NIC_RGX
>  	  This driver supports configuring XCV block of RGX interface
>  	  present on CN81XX chip.
>  
> +config CAVIUM_PTP
> +	tristate "Cavium PTP coprocessor as PTP clock"
> +	depends on 64BIT
> +	imply PTP_1588_CLOCK
> +	default y

Why is this "default y"?

It looks like this is a PCI driver and probably should be loaded only
when the PCI device is present.

> +	---help---
> +	  This driver adds support for the Precision Time Protocol Clocks and
> +	  Timestamping coprocessor (PTP) found on Cavium processors.
> +	  PTP provides timestamping mechanism that is suitable for use in IEEE 1588
> +	  Precision Time Protocol or other purposes.  Timestamps can be used in
> +	  BGX, TNS, GTI, and NIC blocks.
