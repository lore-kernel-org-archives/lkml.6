Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9278B13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4934220881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4934220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbeG3Mbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:31:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:35312 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbeG3Mbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:31:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 03:57:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,422,1526367600"; 
   d="scan'208";a="76698959"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jul 2018 03:57:08 -0700
Message-ID: <c82487a125591c14e66ba56dc3202aa0093f0aba.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/2] clk: Add of_clk_get_by_name_optional() function
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Simon Horman <horms@verge.net.au>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 30 Jul 2018 13:57:07 +0300
In-Reply-To: <CAMuHMdUWWb7uyiG6NdRaJxM0X4JfioWx=o9J7jD18rgiTz1m4w@mail.gmail.com>
References: <1532939768-7018-1-git-send-email-phil.edworthy@renesas.com>
         <1532939768-7018-2-git-send-email-phil.edworthy@renesas.com>
         <CAMuHMdUWWb7uyiG6NdRaJxM0X4JfioWx=o9J7jD18rgiTz1m4w@mail.gmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-30 at 10:55 +0200, Geert Uytterhoeven wrote:
> On Mon, Jul 30, 2018 at 10:36 AM Phil Edworthy
> <phil.edworthy@renesas.com> wrote:

> > +struct clk *of_clk_get_by_name_optional(struct device_node *np,
> > +                                       const char *name)
> > +{
> > +       if (!np)
> > +               return ERR_PTR(-ENOENT);
> 
> Shouldn't this return NULL?
> Or let __of_clk_get_by_name() handle that (cfr. above)?
> 
> Hmm, of_clk_get_by_name() has a similar check, while the current
> __of_clk_get_by_name() already handle np == NULL, too.

This check is needed to prevent NULL pointer dereference below.

And I agree that absence of device node should be considered as okay
case for optional clock (!CONFIG_OF case, for example).

> > +
> > +       return __of_clk_get_by_name(np, np->full_name, name, true);
> > +}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
