Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7B5C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803B621918
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803B621918
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403862AbeHGSBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:01:22 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:41305 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389066AbeHGSBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:01:22 -0400
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id A83AF405;
        Tue,  7 Aug 2018 15:46:27 +0000 (UTC)
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id F1A6870;
        Tue,  7 Aug 2018 15:46:26 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (anatevka.americas.hpqcorp.net [10.34.81.6])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 89FAB4F;
        Tue,  7 Aug 2018 15:46:26 +0000 (UTC)
Date:   Tue, 7 Aug 2018 09:46:26 -0600
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] watchdog: hpwdt: Initialize pretimeout from module
 parameter.
Message-ID: <20180807154626.GA21979@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
 <1533244541-42310-2-git-send-email-jerry.hoemann@hpe.com>
 <1635a9b2-6b2a-fd57-13ea-d99494dbfdec@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635a9b2-6b2a-fd57-13ea-d99494dbfdec@roeck-us.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 06:08:17PM -0700, Guenter Roeck wrote:
> On 08/02/2018 02:15 PM, Jerry Hoemann wrote:
> > When the pretimeout is specified as a module parameter, the
> > value should be reflected in hpwdt_dev.pretimeout.  The default
> > (on) case is correct.  But, when disabling pretimeout, the value
> > should be set to zero in hpwdt_dev.
> > 
> > Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> > ---
> >   drivers/watchdog/hpwdt.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> > index 9dc62a4..369022d 100644
> > --- a/drivers/watchdog/hpwdt.c
> > +++ b/drivers/watchdog/hpwdt.c
> > @@ -313,6 +313,11 @@ static int hpwdt_init_one(struct pci_dev *dev,
> >   	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL))
> >   		dev_warn(&dev->dev, "Invalid soft_margin: %d.\n", soft_margin);
> > +#ifdef CONFIG_HPWDT_NMI_DECODING
> > +	if (!pretimeout)
> > +		hpwdt_dev.pretimeout = 0;
> > +#endif
> > +
> 
> Seems to me that
> 	hpwdt_dev.pretimeout = pretimeout ? PRETIMEOUT_SEC : 0;
> would accomplish the same without ifdef. Also, that would make
> the conditional initialization in hpwdt_dev unnecessary,
> saving us some more ifdefs.
> 
> Guenter

Will do.

Thanks.

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
