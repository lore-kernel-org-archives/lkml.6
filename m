Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50093ECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E52821470
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E52821470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeJRJoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 05:44:13 -0400
Received: from smtprelay0054.hostedemail.com ([216.40.44.54]:59321 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727082AbeJRJoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 05:44:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id B09C718029586;
        Thu, 18 Oct 2018 01:45:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: laugh19_143359c92415c
X-Filterd-Recvd-Size: 4292
Received: from XPS-9350 (unknown [172.58.22.135])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu, 18 Oct 2018 01:45:38 +0000 (UTC)
Message-ID: <c2c8f5186beff6bdc04cfe79292cedad20f36475.camel@perches.com>
Subject: Re: [PATCH 1/3] driver core: add probe_err log helper
From:   Joe Perches <joe@perches.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Wed, 17 Oct 2018 18:45:36 -0700
In-Reply-To: <20181017112914.GH30658@n2100.armlinux.org.uk>
References: <CGME20181016072249eucas1p2303b8c06a9f7c839a971fe065b0c752e@eucas1p2.samsung.com>
         <20181016072244.1216-1-a.hajda@samsung.com>
         <20181016072244.1216-2-a.hajda@samsung.com>
         <CAHp75VfVxEkTzc=1hBrvc4K7r=L28vXipb=j9jSRJbTJE4GtLQ@mail.gmail.com>
         <605bd00e-ed0d-4259-bdc3-1784b2b3b16a@samsung.com>
         <20181016125543eucas1p1f23b3482179a9cd465f509e0abf782c1~eGAecmAv93038330383eucas1p1j@eucas1p1.samsung.com>
         <CAHp75VecquoNrzOuRvWcZ-Qa1b-5P0V0MWq=sNj-SnVcd2EhRw@mail.gmail.com>
         <20181017112914.GH30658@n2100.armlinux.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-17 at 12:29 +0100, Russell King - ARM Linux wrote:
> On Tue, Oct 16, 2018 at 04:55:00PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 16, 2018 at 3:55 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> > > On 16.10.2018 13:29, Andrzej Hajda wrote:
> > > > On 16.10.2018 13:01, Andy Shevchenko wrote:
> > > > > On Tue, Oct 16, 2018 at 10:22 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
> > > > > > During probe every time driver gets resource it should usually check for error
> > > > > > printk some message if it is not -EPROBE_DEFER and return the error. This
> > > > > > pattern is simple but requires adding few lines after any resource acquisition
> > > > > > code, as a result it is often omited or implemented only partially.
> > > > > > probe_err helps to replace such code seqences with simple call, so code:
> > > > > >         if (err != -EPROBE_DEFER)
> > > > > >                 dev_err(dev, ...);
> > > > > >         return err;
> > > > > > becomes:
> > > > > >         return probe_err(dev, err, ...);
> > > > > > +               va_start(args, fmt);
> > > > > > +
> > > > > > +               vaf.fmt = fmt;
> > > > > > +               vaf.va = &args;
> > > > > > +
> > > > > > +               __dev_printk(KERN_ERR, dev, &vaf);
> > > > > It would be nice to print an error code as well, wouldn't it?
> > > > Hmm, on probe fail error is printed anyway (with exception of
> > > > EPROBE_DEFER, ENODEV and ENXIO):
> > > >     "probe of %s failed with error %d\n"
> > > > On the other side currently some drivers prints the error code anyway
> > > > via dev_err or similar, so I guess during conversion to probe_err it
> > > > should be removed then.
> > > > 
> > > > If we add error code to probe_err is it OK to report it this way?
> > > >     dev_err(dev, "%V, %d\n", &vaf, err);
> > > 
> > > Ups, I forgot that message passed to probe_err will contain already
> > > newline character.
> > 
> > You may consider not to pass it.
> 
> It's normal to pass the '\n', so by doing this, we create the situation
> where this function becomes the exception to the norm.  That's not a
> good idea - we will see people forget that appending '\n' should not
> be done for this particular function.
> 
> While we could add a checkpatch rule, that's hassle (extra rework).

It would not be a simple checkpatch rule with high confidence
because of pr_cont uses that may not be in the patch context.

> In I think the message would be much better formatted if we did:
> 
> 	dev_err(dev, "error %d: %V", err, &vaf);

s/%V/%pV/


