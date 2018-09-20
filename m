Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD491ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8C021522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8C021522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388735AbeIUDu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:50:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55749 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeIUDu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:50:28 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id DE2558075A; Fri, 21 Sep 2018 00:04:49 +0200 (CEST)
Date:   Fri, 21 Sep 2018 00:04:49 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Aditya Prayoga <aditya@kobol.io>, linux-ide@vger.kernel.org,
        linux-leds@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH 1/2] libata: add ledtrig support
Message-ID: <20180920220449.GC27468@xo-6d-61-c0.localdomain>
References: <1537328730-9156-1-git-send-email-aditya@kobol.io>
 <1537328730-9156-2-git-send-email-aditya@kobol.io>
 <20180920072354.GA20392@amd>
 <20180920082425.GB20006@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920082425.GB20006@makrotopia.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +#ifdef CONFIG_ATA_LEDS
> > > +	/* register LED triggers for all ports */
> > > +	for (i = 0; i < host->n_ports; i++) {
> > > +		if (unlikely(!host->ports[i]->ledtrig))
> > > +			continue;
> > > +
> > > +		snprintf(host->ports[i]->ledtrig_name,
> > > +			sizeof(host->ports[i]->ledtrig_name), "ata%u",
> > > +			host->ports[i]->print_id);
> > 
> > > +		host->ports[i]->ledtrig->name = host->ports[i]->ledtrig_name;
> > > +
> > > +		if (led_trigger_register(host->ports[i]->ledtrig)) {
> > > +			kfree(host->ports[i]->ledtrig);
> > > +			host->ports[i]->ledtrig = NULL;
> > > +		}
> > > +	}
> > > +#endif
> > 
> > No, we don't want you to register multiple triggers. We want one
> > trigger, than has parameter "which port to watch". (Number of triggers
> > is limited as by sysfs limitations).
> 
> Back then I implemented it that way to be able to define the
> default trigger for each LED in device tree and "trigger-sources"
> didn't exist yet (it was introduced for USB ports and isn't yet used
> for anything other than that)

I see why you did it... BUt I believe we still want single trigger solution...

> However, the problem till today is also that ATA ports are often not
> individual device-tree objects we can refer to, see for example
> marvell,armada-370-sata which appears as one opaque controller. Ie.
> all SATA drivers have to be converted to expose individual ports on
> device-tree before the trigger-sources approach can be applied...

Yep, well... something to do in SATA then.

Perhaps this should also have an option for single LED for _any_ SATA activity,
and 90% devices will be happy with that?

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
