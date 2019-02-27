Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6869C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57AC20643
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551261270;
	bh=ac/tcYPKVdXcbs3iOGiBh+F8X3LbDoe9cIw46zSlc/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ax43mGeJd1gsy5n3RF3hWyKA0fLfNwqfma86c8ACBg8eJfvfA68YjPljPX+yD2+2X
	 fitFNx5jxsTiCPsWi4v15fGrXeDjzxuzk2wgzmc3iVAzxNYKt/bLEyrSyPeIrDN5BH
	 iNqIGNj7zKpAPmBpFJatSMTv6i9d5e1NbFA3KXR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbfB0Jy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:54:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbfB0Jy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:54:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 107282146F;
        Wed, 27 Feb 2019 09:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551261266;
        bh=ac/tcYPKVdXcbs3iOGiBh+F8X3LbDoe9cIw46zSlc/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xSn+LojX90IMbl/bisYBKUrN0mFWz42VKl6prjpXBGayWg5wzyvXJUhqgW6qSJ3ed
         JqPl91Vb92otpqfyG2Pg0846+fP78udn+6lcRLwjI2+Ll5wglaUw75x/UgFxsNCqH8
         eCjAjBVfJYxOArR2F5uE62VlP6/qcW1/CLVda2kA=
Date:   Wed, 27 Feb 2019 10:54:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/2] device.h: pack struct dev_links_info
Message-ID: <20190227095424.GA11387@kroah.com>
References: <20190226144108.25891-1-gregkh@linuxfoundation.org>
 <20190227092318.GK4747@localhost>
 <20190227093104.GA5354@kroah.com>
 <20190227094021.GL4747@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227094021.GL4747@localhost>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 10:40:21AM +0100, Johan Hovold wrote:
> On Wed, Feb 27, 2019 at 10:31:04AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Feb 27, 2019 at 10:23:18AM +0100, Johan Hovold wrote:
> > > On Tue, Feb 26, 2019 at 03:41:07PM +0100, Greg Kroah-Hartman wrote:
> > > > The dev_links_info structure has 4 bytes of padding at the end of it
> > > > when embedded in struct device (which is the only place it lives).  To
> > > > help reduce the size of struct device pack this structure so we can take
> > > > advantage of the hole with later structure reorganizations.
> > > > 
> > > > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > ---
> > > >  include/linux/device.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > > index 6cb4640b6160..b63165276a09 100644
> > > > --- a/include/linux/device.h
> > > > +++ b/include/linux/device.h
> > > > @@ -884,7 +884,7 @@ struct dev_links_info {
> > > >  	struct list_head suppliers;
> > > >  	struct list_head consumers;
> > > >  	enum dl_dev_state status;
> > > > -};
> > > > +} __packed;
> > > 
> > > This seems like a bad idea. You're changing the alignment of these
> > > fields to one byte, something which may cause the compiler to generate
> > > less efficient code to deal with unaligned accesses (even if they happen
> > > to currently be naturally aligned in struct device).
> > 
> > No, all this changes is the trailing "space" is gone.  The alignment of
> > the fields did not change at all as they are all naturally aligned
> > (list_head is just 2 pointers).
> 
> Yes, currently and in struct device, but given a pointer to a struct
> dev_links_info the compiler must assume it is unaligned and act
> accordingly for example.

Packing the structure doesn't mean that the addressing of it is not also
aligned, that should just depend on the location of the pointer in the
first place, right?

Surely compilers are not that foolish :)

And accessing this field should not be an issue of "slow", hopefully the
memory savings would offset any compiler mess.

> > So this allows us to save 4 bytes in struct device by putting something in that
> > trailing "hole" that can be aligned with it better (i.e. an integer or
> > something else).
> 
> I understand that, but I don't think it is worth to start using packed
> liked this for internal structures as it may have subtle and unintended
> consequences.

I'm not understanding what the consequences are here, sorry.  Does the
compiler output change given that the structure is still aligned
properly in the "parent" structure?  I can't see any output changed
here, but maybe I am not looking properly?

thanks,

greg k-h
