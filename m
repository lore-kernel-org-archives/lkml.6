Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE07ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C3D21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C3D21525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbeITO1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 10:27:02 -0400
Received: from fudo.makrotopia.org ([185.142.180.71]:50353 "EHLO
        fudo.makrotopia.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeITO1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 10:27:02 -0400
X-Greylist: delayed 1180 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Sep 2018 10:27:00 EDT
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
         (Exim 4.90_1)
        (envelope-from <daniel@makrotopia.org>)
        id 1g2uGW-0003pp-Vq; Thu, 20 Sep 2018 10:24:51 +0200
Date:   Thu, 20 Sep 2018 10:24:29 +0200
From:   Daniel Golle <daniel@makrotopia.org>
To:     Pavel Machek <pavel@ucw.cz>
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
Message-ID: <20180920082425.GB20006@makrotopia.org>
References: <1537328730-9156-1-git-send-email-aditya@kobol.io>
 <1537328730-9156-2-git-send-email-aditya@kobol.io>
 <20180920072354.GA20392@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920072354.GA20392@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Sep 20, 2018 at 09:23:54AM +0200, Pavel Machek wrote:
> Hi!
> 
> > +#ifdef CONFIG_ATA_LEDS
> > +	/* register LED triggers for all ports */
> > +	for (i = 0; i < host->n_ports; i++) {
> > +		if (unlikely(!host->ports[i]->ledtrig))
> > +			continue;
> > +
> > +		snprintf(host->ports[i]->ledtrig_name,
> > +			sizeof(host->ports[i]->ledtrig_name), "ata%u",
> > +			host->ports[i]->print_id);
> 
> > +		host->ports[i]->ledtrig->name = host->ports[i]->ledtrig_name;
> > +
> > +		if (led_trigger_register(host->ports[i]->ledtrig)) {
> > +			kfree(host->ports[i]->ledtrig);
> > +			host->ports[i]->ledtrig = NULL;
> > +		}
> > +	}
> > +#endif
> 
> No, we don't want you to register multiple triggers. We want one
> trigger, than has parameter "which port to watch". (Number of triggers
> is limited as by sysfs limitations).

Back then I implemented it that way to be able to define the
default trigger for each LED in device tree and "trigger-sources"
didn't exist yet (it was introduced for USB ports and isn't yet used
for anything other than that)
However, the problem till today is also that ATA ports are often not
individual device-tree objects we can refer to, see for example
marvell,armada-370-sata which appears as one opaque controller. Ie.
all SATA drivers have to be converted to expose individual ports on
device-tree before the trigger-sources approach can be applied...


> 
> Otherwise yes, ata trigger makes sense.
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


