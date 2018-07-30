Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71649FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E75F20873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E75F20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbeG3HDp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 03:03:45 -0400
Received: from mx.socionext.com ([202.248.49.38]:57521 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbeG3HDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 03:03:45 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 30 Jul 2018 14:30:29 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id AFFF318011F;
        Mon, 30 Jul 2018 14:30:29 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 30 Jul 2018 14:30:29 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 71DDE40385;
        Mon, 30 Jul 2018 14:30:29 +0900 (JST)
Received: from DESKTOP0FARE34 (unknown [10.213.134.218])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 35486120448;
        Mon, 30 Jul 2018 14:30:29 +0900 (JST)
From:   "Keiji Hayashibara" <hayashibara.keiji@socionext.com>
To:     "'Trent Piepho'" <tpiepho@impinj.com>, <andy.shevchenko@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <masami.hiramatsu@linaro.org>,
        =?utf-8?Q?Hayashi=2C_Kunihiko/=E6=9E=97_=E9=82=A6=E5=BD=A6?= 
        <hayashi.kunihiko@socionext.com>, <broonie@kernel.org>,
        <mark.rutland@arm.com>, <linux-spi@vger.kernel.org>,
        =?utf-8?B?WWFtYWRhLCBNYXNhaGlyby/lsbHnlLAg55yf5byY?= 
        <yamada.masahiro@socionext.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <jaswinder.singh@linaro.org>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com>  <1532588943-19481-3-git-send-email-hayashibara.keiji@socionext.com>     <CAHp75VcEdxDEo0T5_9BzOPaeaqjbmbrWmaE9+ZuUDYhjh6jpVw@mail.gmail.com> <1532624495.2283.197.camel@impinj.com>
In-Reply-To: <1532624495.2283.197.camel@impinj.com>
Subject: RE: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
Date:   Mon, 30 Jul 2018 14:30:25 +0900
Message-ID: <002901d427c6$6b9a4ff0$42ceefd0$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHUJK+Lb4PtBS+ckEWxak8O5zFtw6SgmfYAgACKagCABh0EkA==
Content-Language: ja
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY180220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Trent and Andy,

> From: Trent Piepho [mailto:tpiepho@impinj.com]
> Sent: Friday, July 27, 2018 2:02 AM
> To: andy.shevchenko@gmail.com; Hayashibara, Keiji/林原 啓二 <hayashibara.keiji@socionext.com>
> Subject: Re: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
> 
> On Thu, 2018-07-26 at 11:46 +0300, Andy Shevchenko wrote:
> > > +
> > > +       /*
> > > +        * the supported rates are even numbers from 4 to 254. (4,6,8...254)
> > > +        * round up as we look for equal or less speed
> > > +        */
> > > +       ckrat = DIV_ROUND_UP(clk_get_rate(priv->clk), speed);
> > > +       ckrat = roundup(ckrat, 2);
> >
> > ckrat += ckrat & 1;
> 
> Either way, the compiler produces the same code:
> 
>  add r0, r0, #1 
>  bic r0, r0, #1
> 
> I.e., ckrat = (ckrat + 1) & ~1, one "add" and one "and".
> 
> Might as well use the macro so it's clear. There is also round_up(x,y), which I believe is intended to be used
> only with power of 2 values of y.

I confirmed round_up() macro.
This macro is optimized to power of 2 argument,
and it matches to this case and clear.

I will replace to round_up() macro.

Thank you.

-----------------
Best Regards,
Keiji Hayashibara


