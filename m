Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BDCECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0895D2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Z1Ljtu0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0895D2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeJQTYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:24:47 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45042 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeJQTYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wb7hS7VTR8IKb91xP9AUV/YiywTtzX4ymRCjWQVtEsw=; b=Z1Ljtu0pGpVomkPEapqzijA8I
        znolUa/vr8cINmHdHQUc5r7w9Elcb3COmiXio6V+S2DtwyCkdq7Qz+WlhWGvsKGgXPYZ4dBW5Jt7/
        Lfh02Ro7R7Fwgkghx2lSL58rqOW0cIUEeM4CGUBQyV3OGny9J/p//e/6o+gCHMlDyUjfA=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:47216)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gCk0x-0003kd-5Y; Wed, 17 Oct 2018 12:29:23 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gCk0r-0004UJ-C8; Wed, 17 Oct 2018 12:29:17 +0100
Date:   Wed, 17 Oct 2018 12:29:14 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/3] driver core: add probe_err log helper
Message-ID: <20181017112914.GH30658@n2100.armlinux.org.uk>
References: <CGME20181016072249eucas1p2303b8c06a9f7c839a971fe065b0c752e@eucas1p2.samsung.com>
 <20181016072244.1216-1-a.hajda@samsung.com>
 <20181016072244.1216-2-a.hajda@samsung.com>
 <CAHp75VfVxEkTzc=1hBrvc4K7r=L28vXipb=j9jSRJbTJE4GtLQ@mail.gmail.com>
 <605bd00e-ed0d-4259-bdc3-1784b2b3b16a@samsung.com>
 <20181016125543eucas1p1f23b3482179a9cd465f509e0abf782c1~eGAecmAv93038330383eucas1p1j@eucas1p1.samsung.com>
 <CAHp75VecquoNrzOuRvWcZ-Qa1b-5P0V0MWq=sNj-SnVcd2EhRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VecquoNrzOuRvWcZ-Qa1b-5P0V0MWq=sNj-SnVcd2EhRw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 04:55:00PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 16, 2018 at 3:55 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> > On 16.10.2018 13:29, Andrzej Hajda wrote:
> > > On 16.10.2018 13:01, Andy Shevchenko wrote:
> > >> On Tue, Oct 16, 2018 at 10:22 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
> > >>> During probe every time driver gets resource it should usually check for error
> > >>> printk some message if it is not -EPROBE_DEFER and return the error. This
> > >>> pattern is simple but requires adding few lines after any resource acquisition
> > >>> code, as a result it is often omited or implemented only partially.
> > >>> probe_err helps to replace such code seqences with simple call, so code:
> > >>>         if (err != -EPROBE_DEFER)
> > >>>                 dev_err(dev, ...);
> > >>>         return err;
> > >>> becomes:
> > >>>         return probe_err(dev, err, ...);
> 
> > >>> +               va_start(args, fmt);
> > >>> +
> > >>> +               vaf.fmt = fmt;
> > >>> +               vaf.va = &args;
> > >>> +
> > >>> +               __dev_printk(KERN_ERR, dev, &vaf);
> 
> > >> It would be nice to print an error code as well, wouldn't it?
> > > Hmm, on probe fail error is printed anyway (with exception of
> > > EPROBE_DEFER, ENODEV and ENXIO):
> > >     "probe of %s failed with error %d\n"
> > > On the other side currently some drivers prints the error code anyway
> > > via dev_err or similar, so I guess during conversion to probe_err it
> > > should be removed then.
> > >
> > > If we add error code to probe_err is it OK to report it this way?
> > >     dev_err(dev, "%V, %d\n", &vaf, err);
> >
> > Ups, I forgot that message passed to probe_err will contain already
> > newline character.
> 
> You may consider not to pass it.

It's normal to pass the '\n', so by doing this, we create the situation
where this function becomes the exception to the norm.  That's not a
good idea - we will see people forget that appending '\n' should not
be done for this particular function.

While we could add a checkpatch rule, that's hassle (extra rework).  In
any case, I think the message would be much better formatted if we did:

	dev_err(dev, "error %d: %V", err, &vaf);

which means we end up with (eg):

	error -5: request_irq failed for irq 9

rather than:

	request_irq failed for irq 9, -5

which is more confusing.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
