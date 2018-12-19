Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D7BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FCB217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="asbWlXmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbeLSNSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:18:30 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40772 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeLSNSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:18:30 -0500
Received: by mail-ed1-f66.google.com with SMTP id g22so10885258edr.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 05:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LXu+PPdPvje1+2xEvpGspYuIRgFLM02dw1h3WAzD7pU=;
        b=asbWlXmTAtR6YUwbl5VyNUVJxnxn3JHUVCIttFX2XEnactiKDv1ktyVo+SmtT08v+h
         5fRn0V6OLfL9sv9QemZi8+mlYHMa91Kagt9xZtDnnO4XcGvdWvVHLBCaYBEJy65g2O9L
         VQIqM4d2oeUBPoi4TxUZbJWv1OvGFhcyq29Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=LXu+PPdPvje1+2xEvpGspYuIRgFLM02dw1h3WAzD7pU=;
        b=COeOcZsKUOJVds084g1Lh6P/KL1QudFdxzuBevPvR7EUeZhmHHxZSc6dq1V2Ya6r40
         Mjz/ljK8AW8VQQKdqkqJPTnqHxFAlMPGRApkhKOViqFl31HxAl6gjJ7Ioto93Segj9E3
         4iUEzw1EN61BNaWupnc82fG6586O2hejO2CjT7hICUTzZQxuRahcq0UauyRDiJTx1CeV
         Yldy9wuVt/sGObwd9uPIjctzMHWC2+UJJ6C8WbDH0Hj5dKS7oOPMciASkUY8yqkCM8ym
         J8kH9FflI+aGxrCHoohTPTq7tPCUmxlPf/eV2ctaBRixT7Fpj5g3MH/Vf/1Hxmb7juMM
         aHiw==
X-Gm-Message-State: AA+aEWaaCk0MOgEtud1egjdo5rce0qfB/ABKWnICFNrgxSFZlq8rqU2i
        9F79WmBWLLxzjIRMjIivFjApaw==
X-Google-Smtp-Source: AFSGD/WH9Hmka+iss+plxsjiNbUjZQ6S5uE3DojyJRx4R3A0FraJh7Kij5V+lmcvOl1LNL9c+twk3A==
X-Received: by 2002:a17:906:288d:: with SMTP id o13-v6mr16099315ejd.53.1545225508475;
        Wed, 19 Dec 2018 05:18:28 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id gp22-v6sm2715992ejb.4.2018.12.19.05.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 05:18:27 -0800 (PST)
Date:   Wed, 19 Dec 2018 14:18:25 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
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
Message-ID: <20181219131825.GV21184@phenom.ffwll.local>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
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
References: <20181218201443.4950-1-daniel.vetter@ffwll.ch>
 <20181219123909.28754-1-daniel.vetter@ffwll.ch>
 <20181219124930.GA22496@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219124930.GA22496@kroah.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 01:49:30PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Dec 19, 2018 at 01:39:09PM +0100, Daniel Vetter wrote:
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -327,6 +327,7 @@ struct driver_attribute {
> >  #define DRIVER_ATTR_WO(_name) \
> >  	struct driver_attribute driver_attr_##_name = __ATTR_WO(_name)
> >  
> > +
> >  extern int __must_check driver_create_file(struct device_driver *driver,
> >  					const struct driver_attribute *attr);
> >  extern void driver_remove_file(struct device_driver *driver,
> > -- 
> 
> I'll edit away this last chunk when I apply the patch :)

Oops sry. I also forgot to do the s/Locking/Looking/ in the commit message
:-/
> 
> thanks for making the changes.
> 
> greg k-h

Thanks, Daniel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
