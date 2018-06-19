Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0484DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF8620693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF8620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937251AbeFSEwG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:52:06 -0400
Received: from smtprelay0231.hostedemail.com ([216.40.44.231]:44971 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751602AbeFSEwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:52:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 1BC83837F252;
        Tue, 19 Jun 2018 04:52:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bat07_8641d2427883f
X-Filterd-Recvd-Size: 2722
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 Jun 2018 04:52:02 +0000 (UTC)
Message-ID: <800831730e3aeaf4da23f7f97cfa80103236c3cb.camel@perches.com>
Subject: Re: [PATCH v2 4/4] vt: coherence validation code for the unicode
 screen buffer
From:   Joe Perches <joe@perches.com>
To:     Nicolas Pitre <nicolas.pitre@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 18 Jun 2018 21:52:01 -0700
In-Reply-To: <nycvar.YSQ.7.76.1806182110450.16670@knanqh.ubzr>
References: <20180617190706.14614-1-nicolas.pitre@linaro.org>
         <20180617190706.14614-5-nicolas.pitre@linaro.org>
         <CAHp75VfG_4zw+NPuHTUyH-gzdktiCKVcnWcwo0D_fAgfPbdk+A@mail.gmail.com>
         <nycvar.YSQ.7.76.1806182110450.16670@knanqh.ubzr>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-18 at 21:50 -0400, Nicolas Pitre wrote:
> On Tue, 19 Jun 2018, Andy Shevchenko wrote:
[]
> > > +       /*
> > > +        * Make sure our unicode screen translates into the same glyphs
> > > +        * as the actual screen. This is brutal indeed.
> > > +        */
> > > +       p = (unsigned short *)vc->vc_origin;
> > > +       mask = vc->vc_hi_font_mask | 0xff;
> > > +       for (y = 0; y < vc->vc_rows; y++) {
> > > +               char32_t *line = uniscr->lines[y];
> > > +               for (x = 0; x < vc->vc_cols; x++) {
> > > +                       u16 glyph = scr_readw(p++) & mask;
> > > +                       char32_t uc = line[x];
> > > +                       int tc = conv_uni_to_pc(vc, uc);
> > > +                       if (tc == -4)
> > > +                               tc = conv_uni_to_pc(vc, 0xfffd);
> > > +                       if (tc == -4)
> > > +                               tc = conv_uni_to_pc(vc, '?');
> > > +                       if (tc != glyph)
> > > +                               pr_notice("%s: mismatch at %d,%d: "
> > > +                                         "glyph=%#x tc=%#x\n", __func__,
> > > +                                         x, y, glyph, tc);
> > 
> > Don't split format string in printk(). checkpatch will not warn on longer lines.
> 
> I didn't do it like that for checkpatch but to keep the code readable.
> I don't particularly care either ways though.

If one glyph is off, then perhaps others are off too.
Perhaps this message should be ratelimited.

