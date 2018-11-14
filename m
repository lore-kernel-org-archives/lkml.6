Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC39C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E4822360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E4822360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732862AbeKOCxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:53:42 -0500
Received: from shell.v3.sk ([90.176.6.54]:45613 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbeKOCxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 21:53:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 92109441A6;
        Wed, 14 Nov 2018 17:49:39 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SLbkV32SZF6Q; Wed, 14 Nov 2018 17:49:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 87AE0441B1;
        Wed, 14 Nov 2018 17:49:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id usLa81gK-0Jj; Wed, 14 Nov 2018 17:49:35 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 4FE35441A6;
        Wed, 14 Nov 2018 17:49:35 +0100 (CET)
Message-ID: <85fa1566ba06f5e9ba87aad386a1400b8656904b.camel@v3.sk>
Subject: Re: [PATCH 11/15] x86, olpc: Use a correct version when making up a
 battery node
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quozl@laptop.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        devel@driverdev.osuosl.org, Linux PM <linux-pm@vger.kernel.org>
Date:   Wed, 14 Nov 2018 17:49:34 +0100
In-Reply-To: <CAHp75VdnrWUSONXwPfVD1HuON5DyGq3qF4JOJbhC-LKudhRdng@mail.gmail.com>
References: <20181010172300.317643-1-lkundrak@v3.sk>
         <20181010172300.317643-12-lkundrak@v3.sk>
         <CAHp75VdnrWUSONXwPfVD1HuON5DyGq3qF4JOJbhC-LKudhRdng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 2018-10-19 at 16:43 +0300, Andy Shevchenko wrote:
> On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk>
> wrote:
> > The XO-1 and XO-1.5 batteries apparently differ in an ability to
> > report
> > ambient temperature. Add a different compatible string to the 1.5
> > battery.
> > +int olpc_dt_compatible_match(phandle node, const char *compat)
> >  {
> >         char buf[64];
> > +       int plen;
> > +       char *p;
> > +       int len;
> > +
> > +       plen = olpc_dt_getproperty(node, "compatible", buf,
> > sizeof(buf));
> > +       if (plen <= 0)
> > +               return 0;
> > +
> > +       len = strlen(compat);
> > +       for (p = buf; p < buf + plen; p += strlen(p) + 1) {
> > +               if (strcmp(p, compat) == 0)
> > +                       return 1;
> > +       }
> > +
> > +       return 0;
> > +}
> 
> DT doesn't still have a helper for that?!
> I hardly believe in that.

There indeed is of_device_compatible_match() (and
of_find_node_by_phandle() for that matter).

However, these fixups are executed before the DT is built with
of_pdt_build_devicetree(), so I don't think any of_*() routines can be
used at that point.

> > +               olpc_dt_interpret("\" /battery@0\" find-device"
> > +                       " \" olpc,xo1.5-battery\" +compatible"
> > +                       " device-end");
> 
> Please, don't split string literals.
> 
> >                 olpc_dt_interpret("\" /pci/display@1\" find-device"
> >                         " new-device"
> >                         " \" dcon\" device-name \" olpc,xo1-dcon\"
> > +compatible"
> >                         " finish-device device-end");
> 
> Yeah, this and similar also needs to be fixed.

Okay.

Thank you
Lubo

