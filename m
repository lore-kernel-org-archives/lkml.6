Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7704C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C179320989
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C179320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbeKTVlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:41:32 -0500
Received: from mga12.intel.com ([192.55.52.136]:15322 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728222AbeKTVlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:41:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 03:12:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,256,1539673200"; 
   d="scan'208";a="275426798"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga005.jf.intel.com with ESMTP; 20 Nov 2018 03:12:50 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gP3xY-0001Gy-Nw; Tue, 20 Nov 2018 13:12:48 +0200
Date:   Tue, 20 Nov 2018 13:12:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>, Guan Xuetao <gxt@pku.edu.cn>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] clk: Add (devm_)clk_get_optional() functions
Message-ID: <20181120111248.GW10650@smile.fi.intel.com>
References: <20181119141259.11992-1-phil.edworthy@renesas.com>
 <20181120103832.GV10650@smile.fi.intel.com>
 <TY1PR01MB176982D5E11A665D0DCC9E31F5D90@TY1PR01MB1769.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY1PR01MB176982D5E11A665D0DCC9E31F5D90@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 10:53:33AM +0000, Phil Edworthy wrote:
> On 20 November 2018 10:39 Andy Shevchenko wrote:
> > On Mon, Nov 19, 2018 at 02:12:59PM +0000, Phil Edworthy wrote:
> > > This adds clk_get_optional() and devm_clk_get_optional() functions to
> > > get optional clocks.
> > > They behave the same as (devm_)clk_get except where there is no clock
> > > producer. In this case, instead of returning -ENOENT, the function
> > > returns NULL. This makes error checking simpler and allows
> > > clk_prepare_enable, etc to be called on the returned reference without
> > > additional checks.

> > >  - Instead of messing with the core functions, simply wrap them for the
> > >    _optional() versions. By putting clk_get_optional() inline in the header
> > >    file, we can get rid of the arch specific patches as well.

> > Fine if it would have no surprises with error handling.
> There shouldn't be any surprises. My earlier attempts at implementing this
> were hampered by the fact that of_clk_get_by_name() can return -EINVAL
> in some circumstances. By directly wrapping the (devm_)clk_get() functions
> that problem goes away.

Good!

After my comments being addressed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


> > > +	if (ERR_PTR(-ENOENT))
> Huh? That wasn't the code I sent...

Yup, it's my wrong editing flow. Anyway, you got the idea.

> > > +		return NULL;
> > > +	else
> > > +		return clk;

> > return clk == ERR_PTR(-ENOENT) ? NULL : clk;

-- 
With Best Regards,
Andy Shevchenko


