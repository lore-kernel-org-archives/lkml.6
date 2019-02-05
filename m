Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36944C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028BA206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="REwqvZhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfBENOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:14:31 -0500
Received: from chill.innovation.ch ([216.218.245.220]:56734 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbfBENOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:14:31 -0500
Date:   Tue, 5 Feb 2019 05:14:30 -0800
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch A585F640109
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1549372470;
        bh=R2H3Yfr+2nP2DVWFw27ajBvORzwaiu1kaN1PAUY+Xes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=REwqvZhrY1pYfbmPcf3eWnFV3SfUipf7E9vRDegpYz6QdHvZqqWTsBzpwBEjKfw1n
         /3hZhHgCRBzMaRGx9XE6sddsWoVJ5EoKTnZmyOuIo6yrSZuald9yb530gNgofyz0mw
         Xoz2/36g/CJr5Rtku5qZO/uBBdD0DPBjQWV3EEjfRIQ8oDapt+49OBh/Z8S8eKMuYF
         v9KznXolLwts7ALsMkDNb/r2vCaUuYpAQW6eCkxELENY4grp/AjrWW6dodyRrpOegR
         OxXqrJSM9/i4uPSLFafiz9Mka4k5ol1G/ivMImi4dZoH+NKY+QBMue5YLxIpb26lWF
         14VF9DPj7kV+Q==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Henrik Rydberg <rydberg@bitmath.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add Apple SPI keyboard and trackpad driver
Message-ID: <20190205131430.GA4225@innovation.ch>
References: <20190204081947.25152-1-ronald@innovation.ch>
 <cdca5121-4f2b-2f74-8a1c-63fda385ee6f@bitmath.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <cdca5121-4f2b-2f74-8a1c-63fda385ee6f@bitmath.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi Henrik,

On Mon, Feb 04, 2019 at 09:47:55PM +0100, Henrik Rydberg wrote:
> Hi Ronald,
> 
> > This changeset adds a driver for the SPI keyboard and trackpad on recent
> > MacBook's and MacBook Pro's. The driver has seen a fair amount of use
> > over the last 2 years (basically anybody running linux on these
> > machines), with only relatively small changes in the last year or so.
> > For those interested, the driver development has been hosted at
> > https://github.com/cb22/macbook12-spi-driver/  (as well as my clone at
> > https://github.com/roadrunner2/macbook12-spi-driver/).
> > 
> > The first patch is just a placeholder for now and is provided in case
> > somebody wants to compile the driver while it's being reviewed here; the
> > real patch has been submitted to dri-devel and is being discussed there,
> > with the intent/hope that I can get an Ack and permission to merge it
> > through the input subsystem tree here as part of this patch series.
> 
> Great to see this upstream. The patch obviously has a lot in common with the
> previous keyboard and touchpad drivers; foremost this is a change of
> transport protocol and not functionality. That said, the code is compact and
> clear enough to make it hard to motivate any major effort to share more of
> existing code, at least initially.

Yes, some pieces have been copy-pasted from the existing drivers.
However, when I last reviewed those pieces they seemed a bit small and
I had a hard time seeing how to share them usefully at least for some
of it.

The pieces in question on the keyboard side (from the hid-apple
driver) are really the 'applespi_fn_codes' and 'apple_iso_keyboard'
tables, the corresponding 'applespi_find_translation()' function, and
some bits in the of the 'applespi_code_to_key()' function. Pulling out
the tables and maybe the applespi_find_translation() function into a
common include might be a simple change and take care of most of the
shared stuff.

A few lines were also lifted from the bcm5974 driver, basically the
'struct tp_finger' and the 'report_tp_state()' function. Though here
it's even harder to see how to share, as there are various small
differences scattered throughout the implemenation of that function.

> Barring detailed comments that are likely
> to produce new revisions, this looks like really good work.

Thank you for looking at this.


  Cheers,

  Ronald

