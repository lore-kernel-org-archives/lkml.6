Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeCUSE5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 14:04:57 -0400
Received: from smtprelay0125.hostedemail.com ([216.40.44.125]:59045 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752512AbeCUSE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 14:04:56 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:152:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3872:4225:4250:4321:4605:5007:6119:7875:7903:10004:10400:10848:11026:11232:11473:11658:11914:12048:12296:12438:12681:12740:12895:13141:13161:13229:13230:13894:14093:14096:14097:14659:14721:21080:21324:21433:21451:21627:30012:30046:30054:30080:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: voice66_47dc40e384d16
X-Filterd-Recvd-Size: 3899
Message-ID: <1521655492.7999.13.camel@perches.com>
Subject: Re: [PATCH 2/2] fpga: lattice machxo2: Add Lattice MachXO2 support
From: Joe Perches <joe@perches.com>
To: Paolo Pisati <p.pisati@gmail.com>, Alan Tull <atull@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 21 Mar 2018 11:04:52 -0700
In-Reply-To: <1521653726-24625-3-git-send-email-p.pisati@gmail.com>
References: <1521653726-24625-1-git-send-email-p.pisati@gmail.com>
         <1521653726-24625-3-git-send-email-p.pisati@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-21 at 18:35 +0100, Paolo Pisati wrote:
> This patch adds support to the FPGA manager for programming
> MachXO2 device’s internal flash memory, via slave SPI.

style trivia:

> diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
[]
> +static int get_status(struct spi_device *spi, unsigned long *status)
> +{
> +	struct spi_message msg;
> +	struct spi_transfer rx, tx;
> +	u8 cmd[] = LSC_READ_STATUS;

static const u8 cmd[]
here and everywhere else as all the tx_buf assignments 
of cmd are to const void *

> +	int ret;
> +
> +	memset(&rx, 0, sizeof(rx));
> +	memset(&tx, 0, sizeof(tx));
> +	tx.tx_buf = cmd;

[]

> +#ifdef DEBUG
> +static void dump_status_reg(unsigned long *status)
> +{

Instead of multiple declarations of dump_status_reg
it's frequently nicer to use a style like

static void debug_func(args...)
{
#ifdef DEBUG
	[code...]
#endif
}

so if function arguments ever need to be changed
it's only required to be changed in one spot and
not multiply compilation tested with and without
the DEBUG definition

> +	char *ferr;
> +
> +	switch (get_err(status)) {
> +	case ENOERR:
> +		ferr = "No Error";
> +		break;
> +	case EID:
> +		ferr = "ID ERR";
> +		break;
> +	case ECMD:
> +		ferr = "CMD ERR";
> +		break;
> +	case ECRC:
> +		ferr = "CRC ERR";
> +		break;
> +	case EPREAM:
> +		ferr = "Preamble ERR";
> +		break;
> +	case EABRT:
> +		ferr = "Abort ERR";
> +		break;
> +	case EOVERFL:
> +		ferr = "Overflow ERR";
> +		break;
> +	case ESDMEOF:
> +		ferr = "SDM EOF";
> +		break;
> +	default:
> +		ferr = "Default switch case";
> +	}

It's frequently nicer to use a static function
for these enum -> string conversions like:

static const char *get_err_string(unsigned long err)
{
	switch (err) {
	case ENOERR:	return "No Error";
	case EID:	return "ID ERR";
	case ECMD:	return "CMD ERR";
	[...]
	}
	return "default switch case";
}

> +	pr_debug("machxo2 status: 0x%08lX - done=%d, cfgena=%d, busy=%d, fail=%d, devver=%d, err=%s\n",
> +	       *status, test_bit(DONE, status), test_bit(ENAB, status),
> +	       test_bit(BUSY, status), test_bit(FAIL, status),
> +		   test_bit(DVER, status), ferr);

So instead of ferr, this could use
	get_err_string(*status)

And please try to keep a consistent alignment for
indentation of multiple line statements

> +}
> +#else
> +static void dump_status_reg(unsigned long *status) {}
> +#endif
> +
> +static int wait_until_not_busy(struct spi_device *spi)
> +{
> +	unsigned long status;
> +	int ret, loop = 0;
> +
> +	do {
> +		ret = get_status(spi, &status);
> +		if (ret)
> +			break;
> +		if (++loop >= MACHXO2_MAX_BUSY_LOOP) {
> +			ret = -EBUSY;
> +			break;
> +		}
> +	} while (test_bit(BUSY, &status));
> +
> +	return ret;
> +}

Direct returns are OK and would shorten the function
line count.
