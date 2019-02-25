Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680C7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF472087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="grrfjANy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfBYIFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:05:31 -0500
Received: from chill.innovation.ch ([216.218.245.220]:50470 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfBYIFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:05:31 -0500
Date:   Mon, 25 Feb 2019 00:05:29 -0800
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch E41E1640194
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1551081929;
        bh=Bhd7fGHDixOe6T2Ks9+BQBSDrDKpWJirsq996QZvXrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=grrfjANy2PT+e6VfWj9cVJUAuSJSVnKXErBHO5UPVTgHXXWzFL3lYNzpU22iVsQBA
         I0azUZIGbOfEzFCdiQ7IMY6MP8rgCCKWgt8GrPi/UpxiX17inPLnMFYTIjKougcHts
         wT3GRnG7IVhuU0nGM5QZnYf5MvH9H81gmIBe3xKIFU3fhcJnq1qwvobUO4UC6CPNV2
         07MbvONtq+jCZqmO4XW5r+epqVZiYrliq4cUARQAh19NZvT44fDQQHHJgVMXpnXrL+
         2ks2rer2WYmYTbGBudH961cUPiczq7XNkxFCnjx0rIx4S1Wo9VYGMOfKxZPeWYvgOL
         9MdzMNyYVEGpQ==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Input: add Apple SPI keyboard and trackpad driver.
Message-ID: <20190225080529.GA26142@innovation.ch>
References: <20190221105609.5710-1-ronald@innovation.ch>
 <20190221105609.5710-3-ronald@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190221105609.5710-3-ronald@innovation.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Feb 21, 2019 at 02:56:09AM -0800, Ronald Tschalär wrote:
> The keyboard and trackpad on recent MacBook's (since 8,1) and
> MacBookPro's (13,* and 14,*) are attached to an SPI controller instead
> of USB, as previously. The higher level protocol is not publicly
> documented and hence has been reverse engineered. As a consequence there
> are still a number of unknown fields and commands. However, the known
> parts have been working well and received extensive testing and use.
> 
> In order for this driver to work, the proper SPI drivers need to be
> loaded too; for MB8,1 these are spi_pxa2xx_platform and spi_pxa2xx_pci;
> for all others they are spi_pxa2xx_platform and intel_lpss_pci. For this
> reason enabling this driver in the config implies enabling the above
> drivers.
> 
> CC: Federico Lorenzi <federico@travelground.com>
> CC: Lukas Wunner <lukas@wunner.de>
> CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=99891
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=108331
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> ---
>  drivers/input/keyboard/Kconfig    |   14 +
>  drivers/input/keyboard/Makefile   |    1 +
>  drivers/input/keyboard/applespi.c | 2003 +++++++++++++++++++++++++++++
>  3 files changed, 2018 insertions(+)
>  create mode 100644 drivers/input/keyboard/applespi.c
[snip]
> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
> new file mode 100644
> index 000000000000..2a8d1786011d
> --- /dev/null
> +++ b/drivers/input/keyboard/applespi.c
[snip]
> +/**
> + * This is a reduced version of print_hex_dump() that uses dev_printk().
> + */
> +static void dev_print_hex_dump(const char *level, const struct device *dev,
> +			       const char *prefix_str,
> +			       int rowsize, int groupsize,
> +			       const void *buf, size_t len, bool ascii)
> +{
> +	const u8 *ptr = buf;
> +	int i, linelen, remaining = len;
> +	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
> +
> +	if (rowsize != 16 && rowsize != 32)
> +		rowsize = 16;
> +
> +	for (i = 0; i < len; i += rowsize) {
> +		linelen = min(remaining, rowsize);
> +		remaining -= rowsize;
> +
> +		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
> +				   linebuf, sizeof(linebuf), ascii);
> +
> +		dev_printk(level, dev, "%s%s\n", prefix_str, linebuf);
> +	}
> +}

Apologies, I should've have fixed this before posting v2: I'll
introduce an additional patch to add this function to the core to
avoid duplication and because I presume this may be useful for others
too.


  Cheers,

  Ronald

