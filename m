Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5493EC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B7920813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fDQhMITC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B7920813
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbeJWWFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 18:05:38 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37000 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJWWFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 18:05:37 -0400
Received: by mail-ed1-f68.google.com with SMTP id c15-v6so1675155eds.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 06:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fP1++GP6Qvp0pjdsuFyG5LSW6guXoD+iihM0y8mWSZI=;
        b=fDQhMITCnwbcfTP52XID1evT3XSDSFV96EEVT+usROZfY3U9F8uaouDVouHMpXD8Ut
         9PoWPKwfR5+kUS8xv14wAzZV+5Kr150xlP9/Z5LJhKsEg56riRilwgHBW/wDb/VbI2C8
         2ag9SgHLWwBbIZtUGZnrjW9lTaJc9ZN+gv5eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=fP1++GP6Qvp0pjdsuFyG5LSW6guXoD+iihM0y8mWSZI=;
        b=pNDxYGlqTgqhydTSBx9qOUcUsZmCWWqZBYMDtd+3i6BWmnjpi2lZEYZAOEFfglFd0z
         5RGtf4cIbJm6sXnewuisW1shecmhElTyobNgXX4arbnVzV3nEsDjolWXjhx7Nh2hYQ7q
         PRgI9gHbsvMQTPH9PqIXbM1GzaiSRwNrKxH+T7gT2+v+2f031g2lbcSoVW8jWH6AqPB2
         CU3sKGiYNx5qP9ebuuTwnxfc0/596PRbVQ6B4OTwEHhgcc682VbL75kO5toCnz3Tb2RI
         MDwmdLxO9Fs7f0zeUGGJ6J0key9Vbd2YIJnq6SWojFvC/phMUlGUgN1wHUrlck0mo++l
         TFmA==
X-Gm-Message-State: ABuFfojUKJUeiDhYQTLCfHXxxjBgHrcCdfRp5z3TksMXKlay17fhdT5h
        k9BO+/eStl74D5JxMrKGjaQExQ==
X-Google-Smtp-Source: ACcGV61ByXP0ubcYJF0Ep302gB3gzko9og2FQuRtl3/yKBFmpfEOJAKBPpeRbiZS2fIicu+ovHl2AQ==
X-Received: by 2002:a17:906:d81:: with SMTP id m1-v6mr940808eji.16.1540302125528;
        Tue, 23 Oct 2018 06:42:05 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id br14-v6sm397509ejb.17.2018.10.23.06.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 06:42:04 -0700 (PDT)
Date:   Tue, 23 Oct 2018 15:42:02 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "marcheu@chromium.org" <marcheu@chromium.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "gustavo@padovan.org" <gustavo@padovan.org>,
        "sean@poorly.run" <sean@poorly.run>
Subject: Re: [PATCH] DRM: UDL: get rid of useless vblank initialization
Message-ID: <20181023134202.GP324@phenom.ffwll.local>
Mail-Followup-To: Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "marcheu@chromium.org" <marcheu@chromium.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        "gustavo@padovan.org" <gustavo@padovan.org>,
        "sean@poorly.run" <sean@poorly.run>
References: <20180928144126.21598-1-Eugeniy.Paltsev@synopsys.com>
 <1540292472.19916.13.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540292472.19916.13.camel@synopsys.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 11:01:14AM +0000, Eugeniy Paltsev wrote:
> Hi David,
> 
> Maybe you have any comments or remarks about this patch?
> And if you don't could you please apply it. Thanks!

Hm I hoped Sean would pick this up. I stuffed it into drm-misc-next now,
and Sean owes me one. Generally pinging Dave is a last resort in dri-devel
(and doesn't work too well).

Thanks for your patch.
-Daniel
> 
> On Fri, 2018-09-28 at 17:41 +0300, Eugeniy Paltsev wrote:
> > UDL doesn't support vblank functionality so we don't need to
> > initialize vblank here (we are able to send page flip
> > completion events even without vblank initialization)
> > 
> > Moreover current drm_vblank_init call with num_crtcs > 0 causes
> > sending DRM_EVENT_FLIP_COMPLETE event with zero timestamp every
> > time. This breaks userspace apps (for example weston) which
> > relies on timestamp value.
> > 
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> > ---
> >  drivers/gpu/drm/udl/udl_main.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
> > index f455f095a146..1b014d92855b 100644
> > --- a/drivers/gpu/drm/udl/udl_main.c
> > +++ b/drivers/gpu/drm/udl/udl_main.c
> > @@ -350,15 +350,10 @@ int udl_driver_load(struct drm_device *dev, unsigned long flags)
> >  	if (ret)
> >  		goto err;
> >  
> > -	ret = drm_vblank_init(dev, 1);
> > -	if (ret)
> > -		goto err_fb;
> > -
> >  	drm_kms_helper_poll_init(dev);
> >  
> >  	return 0;
> > -err_fb:
> > -	udl_fbdev_cleanup(dev);
> > +
> >  err:
> >  	if (udl->urbs.count)
> >  		udl_free_urb_list(dev);
> -- 
>  Eugeniy Paltsev

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
