Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80237C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B0B206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="FAByLLsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfBENSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:18:13 -0500
Received: from chill.innovation.ch ([216.218.245.220]:56826 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfBENSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:18:13 -0500
Date:   Tue, 5 Feb 2019 05:18:12 -0800
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch C0B4E640109
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1549372692;
        bh=sSY0VZTX1YhXlCR4E3b+ux8QUzs1Tqz0U1wXI3u4wSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FAByLLsVB4gvzR/ypjndMAPNCU2p7xOPyaXG6KnLWsinbBKkZjFeSRSZlhu4jjZzn
         KTo0/KFvsN7f+JU7nrghQCL2YKw7xVN4SNgAui3u+B4D9wb2tspyn2oyndxDosC2lJ
         xcpXwbXveZx92CrVljf48rVNEwwmRraiE0WCxM1pLGEYdR9XlzYQnkVOlQ2xWteZQ2
         5vQKTkrM7QQFNLXwBvofqczzNr2lWqhDEFzEvqIQqyw5sPb990d00PqUFvsYhWCUQ8
         qVC2lPimjf9rlMMt3BuJdv0TWj9z/0uI/Fzv4jVSKJCbTQpkn7iUrmd6mp420FjOQA
         iFJltmXVLZTqw==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: add Apple SPI keyboard and trackpad driver.
Message-ID: <20190205131812.GC4225@innovation.ch>
References: <20190204081947.25152-1-ronald@innovation.ch>
 <20190204081947.25152-3-ronald@innovation.ch>
 <20190205114522.GV9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190205114522.GV9224@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi Andy,

On Tue, Feb 05, 2019 at 01:45:22PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 04, 2019 at 12:19:47AM -0800, Ronald Tschalär wrote:
> > The keyboard and trackpad on recent MacBook's (since 8,1) and
> > MacBookPro's (13,* and 14,*) are attached to an SPI controller instead
> > of USB, as previously. The higher level protocol is not publicly
> > documented and hence has been reverse engineered. As a consequence there
> > are still a number of unknown fields and commands. However, the known
> > parts have been working well and received extensive testing and use.
> > 
> > In order for this driver to work, the proper SPI drivers need to be
> > loaded too; for MB8,1 these are spi_pxa2xx_platform and spi_pxa2xx_pci;
> > for all others they are spi_pxa2xx_platform and intel_lpss_pci. For this
> > reason enabling this driver in the config implies enabling the above
> > drivers.
> 
> > +config KEYBOARD_APPLESPI
> > +	tristate "Apple SPI keyboard and trackpad"
> 
> > +	depends on (X86 && ACPI && SPI) || COMPILE_TEST
> 
> COMPILE_TEST more or less makes sense in conjunction with architecture selection.
> It means, your code always dependant to ACPI and SPI frameworks.
> That's why 0day complained.

Thanks. Yes, looking at this again I realized I somewhat misunderstood
the uses of COMPILE_TEST. I've changed this now to

        depends on ACPI && SPI && (X86 || COMPILE_TEST)


  Cheers,

  Ronald

