Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030673AbeBNOXK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:23:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:33119 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030363AbeBNOXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:23:09 -0500
Date: Wed, 14 Feb 2018 15:23:05 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa@the-dreams.de>,
        =?UTF-8?B?Wm9sdMOhbiBCw7ZzesO2cm0=?= =?UTF-8?B?w6lueWk=?=
        <zboszor@pr.hu>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: piix4: Use request_muxed_region
Message-ID: <20180214152305.57b76ea5@endymion>
In-Reply-To: <20180212185152.GA20877@roeck-us.net>
References: <1514652658-6228-1-git-send-email-linux@roeck-us.net>
        <20180212111041.027edd85@endymion>
        <20180212185152.GA20877@roeck-us.net>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2018 10:51:52 -0800, Guenter Roeck wrote:
> On Mon, Feb 12, 2018 at 11:10:41AM +0100, Jean Delvare wrote:
> > On Sat, 30 Dec 2017 08:50:57 -0800, Guenter Roeck wrote:  
> > > @@ -298,12 +295,15 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
> > >  	else
> > >  		smb_en = (aux) ? 0x28 : 0x2c;
> > >  
> > > -	mutex_lock(&piix4_mutex_sb800);
> > > +	if (!request_muxed_region(SB800_PIIX4_SMB_IDX, 2, "sb800_piix4_smb"))
> > > +		return -EBUSY;  
> > 
> > This would happen if and only if another driver has requested the
> > region already but without IORESOURCE_MUXED, right? Don't you want to  
> 
> Or if its call to alloc_resource() fails.

OK, two things which are not supposed to happen, so failing is the
right thing to do.

> > write an error message then? I don't think request_muxed_region() will
> > do, and probe failing with -EBUSY but no error message logged would be
> > hard to diagnose.
>
> NP, though the analysis is quite simple - /proc/iomem will show the culprit.

I'm confused. How would the user know what to look for in /proc/iomem
(or, I believe, /proc/ioports actually) if the driver does not print
which resource allocation failed?

If the information is already printed somewhere, then I agree there's no
point adding a message. But from the code I could not find it.

-- 
Jean Delvare
SUSE L3 Support
