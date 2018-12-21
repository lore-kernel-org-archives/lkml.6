Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24617C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EEB21907
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXjLReqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388228AbeLUIne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:43:34 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34733 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733220AbeLUInd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:43:33 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so2291312pfg.1;
        Fri, 21 Dec 2018 00:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=60UGiVLaQW6OiQuT3/1ilh/3XKvPECs3Du2KsC9Ux8M=;
        b=fXjLReqkfdu4O82ytsH0aFHKFamZqdKSB1pClSLgCmU3y4IxWffNzluLToCCG/Oi4C
         joIOoTmExHLohNsYnjWD7I8cMeiqityGB1/oyL0Zh+g4vxYNBLxtjnAZIHHEd/3zwEbS
         W9prNASOoSuuC2UkN9PdJLj9SYlfmGFyh5VwNLrnm99FExmg3cRYT7fDg+iBVi5kJwHP
         Qt+Zzr1uswkNPnl0ltAOAcrWIyN50I7Bm0vGSqaOjLReHoFqtwhFXArdn6okUWEdlaYO
         ZTX3qbrBWfdtAFFB9M/QdBgDxOVQ2sqmBjN++inMiUwf359I19roM52YEXkhqzS0Pelh
         i6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=60UGiVLaQW6OiQuT3/1ilh/3XKvPECs3Du2KsC9Ux8M=;
        b=MPKARcp5s34axxhKJcC0tiNemuy6kb9vSfpOP/ChgYfERimks9wEg7C2GJdOkj4Lfd
         7Xmw56jwPSKhCX9RbaO1YglRF+DydEvsGioZDb/EM/6U67U8W/Nim3EPJCDrb7fehhLY
         TUMFSsAdmpiUcDXlEGKNs9ccRK5RJ9i49NrR1985vjwqlaKA/2FPkEnBiZeaR32D2MmR
         bXgXy94wsCAC+6JR1cDFsJqYruMKm12a9WBOQUX+z5S82HnrBi/BeWdVh5OQ3Qayy96j
         E+CEK/zxtVOdR8xqGTsXC9xIQ9YXZLV0vMeVhm2H9Ak3n3O1V1udTQoydQdm2OR+B4xO
         juKA==
X-Gm-Message-State: AJcUukcl34kNuMRrUUJna9Z6/7bhQESwBTYUfLNpR3TcXVtKaCD3QiqY
        IBFvyfV9v2FKcpOpbG68Jk0=
X-Google-Smtp-Source: ALg8bN4vo7gJRYsMSpcKQyO1E1ykSktIJSvjDvqgj8QI/3ZC+awhGAVvWBVB056Z1cE1ZVCXfhoDlg==
X-Received: by 2002:a63:d005:: with SMTP id z5mr1559834pgf.64.1545381812065;
        Fri, 21 Dec 2018 00:43:32 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id i73sm34610839pfi.66.2018.12.21.00.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 00:43:30 -0800 (PST)
Date:   Fri, 21 Dec 2018 00:43:28 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Peter Hutterer <peter.hutterer@who-t.net>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        kt.liao@emc.com.tw, Aaron Ma <aaron.ma@canonical.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] Input: elantech - Disable elan-i2c for P52 and P72
Message-ID: <20181221084328.GH211587@dtor-ws>
References: <20181212154205.24025-1-benjamin.tissoires@redhat.com>
 <20181218081343.GA4701@jelly>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218081343.GA4701@jelly>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 06:13:43PM +1000, Peter Hutterer wrote:
> On Wed, Dec 12, 2018 at 04:42:05PM +0100, Benjamin Tissoires wrote:
> > The current implementation of elan_i2c is known to not support those
> > 2 laptops.
> > 
> > A proper fix is to tweak both elantech and elan_i2c to transmit the
> > correct information from PS/2, which would make a bad candidate for
> > stable.
> > 
> > So to give us some time for fixing the root of the problem, disable
> > elan_i2c for the devices we know are not behaving properly.
> > 
> > Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1803600
> > Link: https://bugs.archlinux.org/task/59714
> > Fixes: df077237cf55 Input: elantech - detect new ICs and setup Host Notify for them
> > 
> > Cc: stable@vger.kernel.org  # v4.18+
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Acked-by: Peter Hutterer <peter.hutterer@who-t.net>

Applied, thank you.

> 
> Cheers,
>    Peter
> 
> > ---
> >  drivers/input/mouse/elantech.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> > index 2d95e8d93cc7..830ae9f07045 100644
> > --- a/drivers/input/mouse/elantech.c
> > +++ b/drivers/input/mouse/elantech.c
> > @@ -1767,6 +1767,18 @@ static int elantech_smbus = IS_ENABLED(CONFIG_MOUSE_ELAN_I2C_SMBUS) ?
> >  module_param_named(elantech_smbus, elantech_smbus, int, 0644);
> >  MODULE_PARM_DESC(elantech_smbus, "Use a secondary bus for the Elantech device.");
> >  
> > +static const char * const i2c_blacklist_pnp_ids[] = {
> > +	/*
> > +	 * these are known to not be working properly as bits are missing
> > +	 * in elan_i2c
> > +	 */
> > +	"LEN2131", /* ThinkPad P52 w/ NFC */
> > +	"LEN2132", /* ThinkPad P52 */
> > +	"LEN2133", /* ThinkPad P72 w/ NFC */
> > +	"LEN2134", /* ThinkPad P72 */
> > +	NULL
> > +};
> > +
> >  static int elantech_create_smbus(struct psmouse *psmouse,
> >  				 struct elantech_device_info *info,
> >  				 bool leave_breadcrumbs)
> > @@ -1802,10 +1814,12 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
> >  
> >  	if (elantech_smbus == ELANTECH_SMBUS_NOT_SET) {
> >  		/*
> > -		 * New ICs are enabled by default.
> > +		 * New ICs are enabled by default, unless mentioned in
> > +		 * i2c_blacklist_pnp_ids.
> >  		 * Old ICs are up to the user to decide.
> >  		 */
> > -		if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
> > +		if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version) ||
> > +		    psmouse_matches_pnp_id(psmouse, i2c_blacklist_pnp_ids))
> >  			return -ENXIO;
> >  	}
> >  
> > -- 
> > 2.19.2
> > 

-- 
Dmitry
