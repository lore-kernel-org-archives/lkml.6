Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6E0C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 00:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CE320844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 00:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CE320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbeIHFN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 01:13:56 -0400
Received: from smtprelay0153.hostedemail.com ([216.40.44.153]:48318 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725731AbeIHFN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 01:13:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 9165F182CED28;
        Sat,  8 Sep 2018 00:30:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crown99_5afa21c4fb04d
X-Filterd-Recvd-Size: 3866
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sat,  8 Sep 2018 00:30:25 +0000 (UTC)
Message-ID: <0999919005219fa94ccc69ff57659d47911d3abd.camel@perches.com>
Subject: Re: [PATCH 3/4] of: Convert to using %pOFn instead of
 device_node.name
From:   Joe Perches <joe@perches.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Date:   Fri, 07 Sep 2018 17:30:23 -0700
In-Reply-To: <20180907122928.GA5821@ulmo>
References: <20180828155254.10709-1-robh@kernel.org>
         <20180828155254.10709-4-robh@kernel.org> <20180907122928.GA5821@ulmo>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-09-07 at 14:29 +0200, Thierry Reding wrote:
> On Tue, Aug 28, 2018 at 10:52:53AM -0500, Rob Herring wrote:
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> > 
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Florian Fainelli <f.fainelli@gmail.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/of/device.c   |  4 ++--
> >  drivers/of/of_mdio.c  | 12 ++++++------
> >  drivers/of/of_numa.c  |  4 ++--
> >  drivers/of/overlay.c  |  4 ++--
> >  drivers/of/platform.c |  8 ++++----
> >  drivers/of/unittest.c | 12 ++++++------
> >  6 files changed, 22 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > index 5957cd4fa262..daa075d87317 100644
> > --- a/drivers/of/device.c
> > +++ b/drivers/of/device.c
> > @@ -219,7 +219,7 @@ static ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len
> >  		return -ENODEV;
> >  
> >  	/* Name & Type */
> > -	csize = snprintf(str, len, "of:N%sT%s", dev->of_node->name,
> > +	csize = snprintf(str, len, "of:N%pOFnT%s", dev->of_node,
> >  			 dev->of_node->type);
> >  	tsize = csize;
> >  	len -= csize;
> 
> This seems to cause the modalias to be improperly constructed. As a
> consequence, automatic module loading at boot time is now broken. I
> think the reason why this fails is because vsnprintf() will skip all
> alpha-numeric characters after a call to pointer(). Presumably this
> is meant to be a generic way of skipping whatever specifiers we throw
> at it.
> 
> Unfortunately for the case of OF modaliases, this means that the 'T'
> character gets eaten, so we end up with something like this:
> 
> 	# udevadm info /sys/bus/platform/devices/54200000.dc
> 	[...]
> 	E: MODALIAS=of:Ndc<NULL>Cnvidia,tegra124-dc
> 	[...]
> 
> instead of this:
> 
> 	# udevadm info /sys/bus/platform/devices/54200000.dc
> 	[...]
> 	E: MODALIAS=of:NdcT<NULL>Cnvidia,tegra124-dc
> 	[...]
> 
> Everything is back to normal if I revert this patch. However, since
> that's obviously not what we want, I think perhaps what we need is a
> way for pointer() (and its implementations) to report back how many
> characters in the format string it consumed so that we can support
> these kinds of back-to-back strings.
> 
> If nobody else has the time I can look into coding up a fix, but in the
> meantime it might be best to back this one out until we can handle the
> OF modalias format string.

Or just use 2 consecutive snprintf calls

	csize = snprintf(str, len, "of:N%pOFn", dev->of_node);
	csize += snprintf(str + csize, len - csize, "T%s",
			  dev->of_node->type);

