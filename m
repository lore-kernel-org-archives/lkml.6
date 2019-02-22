Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D63C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 06:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6081E20823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 06:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550818213;
	bh=HrvpjxFAAc3p55NaHBg4/woNZPf9C0qNVi9dsGK+Ap4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vdf3QNGFt136U8zX/aoZukNseGcQaK0jVk3uxpF8N369va/FWeKNKBKJRaKsyO6yq
	 VDwd/DFvrLpqC8Ia/CltJZtdnEY9xwRntFhsQcOw5aGi2F+mFRwHs+6DKg39Y+mE1a
	 58tmx+U6uUr3xRQwHwFkxAdKZ4hhfJ4pMdXCXvaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfBVGuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 01:50:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:44248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfBVGuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 01:50:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 237CD20823;
        Fri, 22 Feb 2019 06:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550818210;
        bh=HrvpjxFAAc3p55NaHBg4/woNZPf9C0qNVi9dsGK+Ap4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VTTF/Iss9Ze4Fxzc4CY2tMJPo+jUHLps/RdiR6jWG/EUCSVmDp3SWMhgtW7SKSSRW
         aUMrUjkQwdnjLUw0HkogIjKHNUfJXK6rsr6+472Y/QxKoyOvm51BP4oebluoaePHJf
         rSzyl9bH3UYHjlLb1HaI9jb1zVlaECjLIDXIe6Fs=
Date:   Fri, 22 Feb 2019 07:50:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jerry Hoemann <jerry.hoemann@hpe.com>
Cc:     Matt Hsiao <matt.hsiao@hpe.com>, linux-kernel@vger.kernel.org,
        arnd@arndb.de, david.altobelli@hpe.com, mark.rusk@hpe.com
Subject: Re: [PATCH 2/4] misc: hpilo: Exclude unsupported device via blacklist
Message-ID: <20190222065008.GB15860@kroah.com>
References: <1550736282-25416-1-git-send-email-matt.hsiao@hpe.com>
 <1550736282-25416-3-git-send-email-matt.hsiao@hpe.com>
 <20190221083355.GB6397@kroah.com>
 <20190222043506.GC31132@anatevka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222043506.GC31132@anatevka>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 09:35:07PM -0700, Jerry Hoemann wrote:
> On Thu, Feb 21, 2019 at 09:33:55AM +0100, Greg KH wrote:
> > On Thu, Feb 21, 2019 at 04:04:40PM +0800, Matt Hsiao wrote:
> 
> > > +static const struct pci_device_id ilo_blacklist[] = {
> > > +	/* auxiliary iLO */
> > > +	{PCI_DEVICE_SUB(PCI_VENDOR_ID_HP, 0x3307, PCI_VENDOR_ID_HP, 0x1979)},
> > > +	{}
> > > +};
> > >  
> 
> ...
> 
> > 
> > And why do some devices need to be blacklisted, shouldn't there only be
> > a whitelist in the first place?  Do you need to tighten up your original
> > device ids?
> 
> Hi Greg,
> 
> I related the underlying reason for the black listing on another message
> of this thread.  I can fill you in on why we've taken this approach to
> white/black listing.
> 
> HPE hardware/firmware teams will put out minor updates to the iLO using
> the same device info except for the subsystem device id.
> 
> The approach we've taken in both the hpilo and hpwdt drivers is
> to claim based upon {Vendor, PC DevID, SubVendor}.
> 
> This allows old software to work on new hardware without patching.
> 
> As our primary way to support our customers is via distros, this patching
> when it does happen requires us to not just submit a patch upstream, but
> to then to have the patches back ported to multiple releases of multiple
> distros.  This process takes many many months.
> 
> So far, the approach we've taken has worked fairly well as this is only
> the second time in 10+ years that we've needed to blacklist an instance.

Ok, that's fine, but you should put that information in the changelog
text so that we understand what is going on here.

thanks,

greg k-h
