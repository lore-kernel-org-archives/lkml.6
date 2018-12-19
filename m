Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97317C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54760218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545231614;
	bh=tdh2A/GTV3f7/GFzZXsVK6MK2fVx8TC9mLlHR7Jvpvo=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=uoNB8Iepi1g/eMSs3dwkLAa1yyG3kbd5vGfbLCCTFCKIEo1MHPUXsZWug/9MT30EZ
	 KkXG7x2bq5cD0v7LwOYXah6A+10QvtRTHdbIcWWtOwhhkc5Raewc/IahIO1Tc0aWl6
	 fM/UVcsn4jgiveMIhDcwbKZ9Cl/7a62YBeOFNU94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbeLSPAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:00:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:60478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729799AbeLSPAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:00:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79CB3218AE;
        Wed, 19 Dec 2018 15:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545231612;
        bh=tdh2A/GTV3f7/GFzZXsVK6MK2fVx8TC9mLlHR7Jvpvo=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=tUWlz3mkjWh4mGbelRZPyBeTcUO6UvF00OdApDHd9IgzYBdrkO61cEg+a7FHDf4fZ
         ctVbuzpg7nKO3JNJxRNISwlnlP/29sjwOiqNXY4gPu1nyir3SNsmySQo46bKoAR2Jz
         ALVcr0ydg+10ziBvmGhxYJ1NIWMxWiPdqwY4YFlA=
Date:   Wed, 19 Dec 2018 16:00:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ramalingam C <ramalingam.c@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Joe Perches <joe@perches.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] sysfs: Disable lockdep for driver bind/unbind files
Message-ID: <20181219150009.GA22073@kroah.com>
References: <20181218201443.4950-1-daniel.vetter@ffwll.ch>
 <20181219123909.28754-1-daniel.vetter@ffwll.ch>
 <20181219124930.GA22496@kroah.com>
 <20181219131825.GV21184@phenom.ffwll.local>
 <20181219132622.GX21184@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219132622.GX21184@phenom.ffwll.local>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 02:26:22PM +0100, Daniel Vetter wrote:
> On Wed, Dec 19, 2018 at 02:18:25PM +0100, Daniel Vetter wrote:
> > On Wed, Dec 19, 2018 at 01:49:30PM +0100, Greg Kroah-Hartman wrote:
> > > On Wed, Dec 19, 2018 at 01:39:09PM +0100, Daniel Vetter wrote:
> > > > --- a/include/linux/device.h
> > > > +++ b/include/linux/device.h
> > > > @@ -327,6 +327,7 @@ struct driver_attribute {
> > > >  #define DRIVER_ATTR_WO(_name) \
> > > >  	struct driver_attribute driver_attr_##_name = __ATTR_WO(_name)
> > > >  
> > > > +
> > > >  extern int __must_check driver_create_file(struct device_driver *driver,
> > > >  					const struct driver_attribute *attr);
> > > >  extern void driver_remove_file(struct device_driver *driver,
> > > > -- 
> > > 
> > > I'll edit away this last chunk when I apply the patch :)
> > 
> > Oops sry. I also forgot to do the s/Locking/Looking/ in the commit message
> > :-/
> 
> And I also forgot Rafael's r-b :-(

Ok, rebuilt with both of these things now fixed up, thanks.

greg k-h
