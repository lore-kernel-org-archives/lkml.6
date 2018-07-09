Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA299C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F082089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7owGpW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F082089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933705AbeGITDO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:03:14 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34231 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932834AbeGITDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:03:12 -0400
Received: by mail-pf0-f193.google.com with SMTP id e10-v6so14308939pfn.1;
        Mon, 09 Jul 2018 12:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pNMEyy1fgDQpcW5mxh1QbOziJxL2z8TjW6/on3KVnMA=;
        b=p7owGpW+kSJYSOt2or83VoB4rI+yv49SkwVHU46a553l3F61QY3n5lALgnIJBuvhGM
         FvY+Mor8EtU9zdOadtiwQ9WxiHLXsJUklOt8BFcjWi/kz3kxX8QQ0hzSI2H+lKjIzYHq
         DzAQve5m8r6F0LvCzzqnoR1v9MCUL5uAtl3Za8v+R3dckb8J2Yo36eNGJk1JvidrZGCO
         +jbl9VJllNMvstyJ9tXoZBQWIGprz1zvm4xcr+8pmN7Dztq9M4D/6vAOUbcK+FdnGYQU
         BF0xvDOikhhhfID+PUzO3qyX0p0uMPyT7hVgKsR8tPYQqqZzIurEjU1u48y1znFW70dk
         K0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pNMEyy1fgDQpcW5mxh1QbOziJxL2z8TjW6/on3KVnMA=;
        b=XFtlqB52Qm7zJpQlJ5Laiy86yOgPUMtTURkHbZG++qHGDZqsXJ2BgIyXoeZEBnmfdu
         l3SP0wRQxeUONcmgEqjiPFfkSW/SPuJdpCd50UAhnKMe8eGHoe/r2sg1BqqCriY1W6nE
         NXMv/oXzNNAMuQNTzOjnRGNESHQw6vsLPrsXRCIt81lh1lOJrd1PlT+0Gdwk9Fn20yw1
         Rln8mTuDtLHwHBDb/+EiIqZX4YjjQZac1MXEbvd5o6EpI3R/a8N4fJ/hXu0CUS8uKazn
         HR22wCAdGGLXHfe+zbdid2cGLgLB0WLT2Frf59gMrLDXogddajr38+YYyF/hw3PdHu7O
         JvCQ==
X-Gm-Message-State: APt69E3hgmGZyqsjveLem7j7o+SXAV0ZzxtRf2IcE+g847N1qPrM9coy
        nSsSNFRGmqc9gCuqKIm0H/854A==
X-Google-Smtp-Source: AAOMgpfvuJSRPMKKhQDSSQ7OEcsrU2oCmC6JFNWCZSkV3PHxm45AlFQheUyZUMEuQlnZBurayf6abw==
X-Received: by 2002:a62:b20c:: with SMTP id x12-v6mr22882139pfe.64.1531162992106;
        Mon, 09 Jul 2018 12:03:12 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g11-v6sm22352404pfh.63.2018.07.09.12.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 12:03:11 -0700 (PDT)
Date:   Mon, 9 Jul 2018 12:03:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] usb: typec: mux: Get the mux identifier from
 function parameter
Message-ID: <20180709190310.GC1896@roeck-us.net>
References: <20180627151953.30942-1-heikki.krogerus@linux.intel.com>
 <20180627151953.30942-4-heikki.krogerus@linux.intel.com>
 <20180628105155.GB5191@kroah.com>
 <20180628113427.GB30974@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628113427.GB30974@kuha.fi.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 02:34:27PM +0300, Heikki Krogerus wrote:
> On Thu, Jun 28, 2018 at 07:51:55PM +0900, Greg Kroah-Hartman wrote:
> > On Wed, Jun 27, 2018 at 06:19:48PM +0300, Heikki Krogerus wrote:
> > > In order for the muxes to be usable with alternate modes,
> > > the alternate mode devices will need also to be able to get
> > > a handle to the muxes on top of the port devices. To make
> > > that possible, the muxes need to be possible to request with
> > > an identifier.
> > > 
> > > This will change the API so that the mux identifier is given
> > > as a function parameter to typec_mux_get(), and the hard-coded
> > > "typec-mux" is replaced with that value.
> > > 
> > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > ---
> > >  drivers/usb/typec/class.c     | 2 +-
> > >  drivers/usb/typec/mux.c       | 6 +++---
> > >  include/linux/usb/typec_mux.h | 2 +-
> > >  3 files changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > > index 2b3eaa969f3b..b860bd3a0acb 100644
> > > --- a/drivers/usb/typec/class.c
> > > +++ b/drivers/usb/typec/class.c
> > > @@ -1357,7 +1357,7 @@ struct typec_port *typec_register_port(struct device *parent,
> > >  		goto err_switch;
> > >  	}
> > >  
> > > -	port->mux = typec_mux_get(cap->fwnode ? &port->dev : parent);
> > > +	port->mux = typec_mux_get(parent, "typec-mux");
> > 
> > This changes the first parameter for this call, is that ok?  Doesn't
> > that change the functionality here?
> 
> No, I noticed that cap->fwnode is set after we call that function, so
> we always ended up using parent.
> 
> This needs to be fixed properly of course, but I choose not to propose
> anything in this series. We don't yet use the fwnode handle with the
> muxes in any case, as the device connection API does not support
> anything else except build-in connections descriptions for now.
> 

Seems to me that would be better handled in a separate patch or patch
series. With this patch, the code ends up always using parent here but
there is still
	port->sw = typec_switch_get(cap->fwnode ? &port->dev : parent);
a couple of lines above. This is at the very least confusing to the
reader.

Guenter
