Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB953C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BF721848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfBZIvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:51:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:40543 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfBZIve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:51:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2019 00:51:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,414,1544515200"; 
   d="scan'208";a="277917876"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 26 Feb 2019 00:51:30 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gyYSX-0005fZ-3R; Tue, 26 Feb 2019 10:51:29 +0200
Date:   Tue, 26 Feb 2019 10:51:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Life is hard, and then you die" <ronald@innovation.ch>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Input: add Apple SPI keyboard and trackpad driver.
Message-ID: <20190226085129.GU9224@smile.fi.intel.com>
References: <20190221105609.5710-1-ronald@innovation.ch>
 <20190221105609.5710-3-ronald@innovation.ch>
 <20190225080529.GA26142@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190225080529.GA26142@innovation.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 12:05:29AM -0800, Life is hard, and then you die wrote:
> 
> On Thu, Feb 21, 2019 at 02:56:09AM -0800, Ronald Tschalär wrote:
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

> > +/**
> > + * This is a reduced version of print_hex_dump() that uses dev_printk().
> > + */

...and this should follow kernel doc as stated by comment style.

> > +static void dev_print_hex_dump(const char *level, const struct device *dev,
> > +			       const char *prefix_str,
> > +			       int rowsize, int groupsize,
> > +			       const void *buf, size_t len, bool ascii)
> > +{
> > +	const u8 *ptr = buf;
> > +	int i, linelen, remaining = len;
> > +	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
> > +
> > +	if (rowsize != 16 && rowsize != 32)
> > +		rowsize = 16;
> > +
> > +	for (i = 0; i < len; i += rowsize) {
> > +		linelen = min(remaining, rowsize);
> > +		remaining -= rowsize;
> > +
> > +		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
> > +				   linebuf, sizeof(linebuf), ascii);
> > +
> > +		dev_printk(level, dev, "%s%s\n", prefix_str, linebuf);
> > +	}
> > +}
> 
> Apologies, I should've have fixed this before posting v2: I'll
> introduce an additional patch to add this function to the core to
> avoid duplication and because I presume this may be useful for others
> too.

Yes, makes sense.

-- 
With Best Regards,
Andy Shevchenko


