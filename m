Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7D4C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 08:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886E02168D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 08:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="g9+djj6m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886E02168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbeHOLlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 07:41:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45699 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbeHOLlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 07:41:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id s16-v6so408645edq.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 01:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fBjen4HtcNg2qWsRYO9fQqhwgzve+1mKHa7LlKfnd4w=;
        b=g9+djj6m9dhXc5Vv2cVZ6EmYdLCfsfhg3LMibH5B63t/6pZb5/5m2Fw3dDcjFSYEPv
         Tq9EN1M5K/yMmuskKlO+zysfL3soNeDuD89R5xPZJkmZQ8qtcVwwVagZj4Ie+7KBXKaz
         wN5vbANOljkcYta52Jm2fMrCqR8tPXFZn5v2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=fBjen4HtcNg2qWsRYO9fQqhwgzve+1mKHa7LlKfnd4w=;
        b=EP/FvYxGXpAsV3jxHeRpRQ0+roW9wTxsBQySc647qhV1D9kwTDwvLPgWO5b5xDkU8L
         P49HaCsQBQbhOAhnkueDBW6jn+Bqc/uHmyLrpMPUg2SkehaFebWFSWoYzKX8iSkD+kKb
         S2sX6UWmeAs8QgaQVGaLeIZ8J0e0FU2BOTZSqysVz4yBA74kBT7dB7giFaQAne6Bmusi
         qi0vUEnrSz7csMqJ/UIA7TtqzDvAl3WAf/bVCZ7t51UM5UB8w14mGCgyq+jJ7z9rJxF6
         aCHnJeEqzoTk5XZktwK+mqeWhiULxJ4A3yFYQAYj8q4IZVP6QzTH6mIJ3z32lTyawHLz
         DeQA==
X-Gm-Message-State: AOUpUlG9lWrAA0t/hggHEjPT3KLY0PqN9crx2KP7k0fEvENVvPdyRBLx
        YrTv7ksgD8ueFIYuHfkePGus+A==
X-Google-Smtp-Source: AA+uWPxnY7WFKBAY28Czxb1JqUqGpinXWK0NWr3tEwG2U+LIx/A6J0jbXH1JLUu+fDaAk/wTD20+Mw==
X-Received: by 2002:a50:af45:: with SMTP id g63-v6mr32472026edd.30.1534322997350;
        Wed, 15 Aug 2018 01:49:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:56fc:0:d707:d7d8:b180:96e5])
        by smtp.gmail.com with ESMTPSA id g14-v6sm8594859edm.25.2018.08.15.01.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 01:49:56 -0700 (PDT)
Date:   Wed, 15 Aug 2018 10:49:54 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jyri Sarha <jsarha@ti.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Sean Paul <seanpaul@chromium.org>,
        Lukas Wunner <lukas@wunner.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RFC] driver core: Reprobe consumer if it was unbound by
 dropped device_link
Message-ID: <20180815084954.GQ21634@phenom.ffwll.local>
Mail-Followup-To: Jyri Sarha <jsarha@ti.com>,
        Sean Paul <seanpaul@chromium.org>, Lukas Wunner <lukas@wunner.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>
References: <cover.1519321145.git.jsarha@ti.com>
 <57c1d52a5a8f5985dc1dd53260d7d68795be8ea2.1519321145.git.jsarha@ti.com>
 <20180225092223.GB923@wunner.de>
 <36c24c0e-59a1-12de-cfff-01c942862349@ti.com>
 <CAKMK7uGiYbRCS=eGLPn3XW29VvX3yo5TZVObc5LJJvZf2eswAQ@mail.gmail.com>
 <8e3bbebb-80b6-1747-6a5b-ee63fa70af6c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e3bbebb-80b6-1747-6a5b-ee63fa70af6c@ti.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 09:49:58AM +0300, Jyri Sarha wrote:
> On 14/08/18 17:17, Daniel Vetter wrote:
> > On Mon, Feb 26, 2018 at 8:52 AM, Jyri Sarha <jsarha@ti.com> wrote:
> >> On 25/02/18 11:22, Lukas Wunner wrote:
> >>> On Thu, Feb 22, 2018 at 07:42:46PM +0200, Jyri Sarha wrote:
> >>>> Put consumer device to deferred probe list if it is unbound due to a
> >>>> dropped link to a supplier.
> >>>>
> >>>> When a device link supplier is unbound (either manually or because one
> >>>> of its own suppliers was unbound), its consumers are unbound as
> >>>> well. Currently if the supplier binds again after this the consumer
> >>>> does not automatically probe again. With this patch it does.
> >>>
> >>> Yes I think this makes sense, based on the rationale that the consumer
> >>> was automatically unbound, so by symmetry it should also be automatically
> >>> rebound.
> >>>
> >>> The only thing I don't understand is you wrote in an earlier e-mail of a
> >>> difference in behavior depending on whether driver_deferred_probe_add()
> >>> is called before or after device_release_driver_internal().
> >>> That's really odd, it shouldn't make a difference.
> >>>
> >>
> >> In that version there was a couple of other bugs elsewhere in the
> >> system. I tried to reproduce that situation again multiple times, but I
> >> could not (even write those bugs back in there, and move the link
> >> creation back to panel bridge code). But even from reading the code that
> >> difference did not make any sense. I suspect a heisen-bug, after I have
> >> read the code and understood that the crash is not possible, it does not
> >> happen anymore :).
> >>
> >> With the current version I could not find any difference in behaviour
> >> depending on the order of device_release_driver_internal() and
> >> driver_deferred_probe_add() calls. I just thought having them in this
> >> order just lookes nicer.
> >>
> >> I stress tested the code by unloading and loading the panel driver in a
> >> tight loop, for several minutes, but it simply wont crash (not in this
> >> setup anyway). The probe of tilcdc eventually gracefully fails in a CMA
> >> failure.
> > 
> > Is this still moving or stuck? Pinging since Sean just brought up the
> > drm_bridge lifetime issues, and I think it'd be nice if we could solve
> > those by using device_link, like we've added already for drm_panel.
> > From my very layman understanding of the discussions, device_link not
> > quite working for deferred probing is the blocker for this plan.
> > 
> 
> I would say stuck. As there is has not been any traffic regarding this
> patch after Lukas' reply. And I've been busy with other things since
> then. Perhaps I did not know to cc the right people.
> 
> A reviewed-by or tested-by from someone would probably help to get this
> spinning again. I am happy to do changes or improvements etc., but for
> that I would need suggestions.
> 
> As far as I can tell the patch is good to apply as it is, but then again
> I am no device core expert.

I do think the cc list is good and has all the stakeholders on it
(Greg/Rafeal are the main ones I think).

Maybe this also didn't get much attention since it's not (yet) a big
problem in drm? Only drm_panel uses device_link, the discussion to add
that for drm_bridge also seems to have died down. But from my far-away
observer vantage point (we don't use device_link nor panel or bridge in
drm/i915) it does all sound like a good approach.

Interest from i915 side might go up, since we're using component already
and device_link will probably happen eventually too (for better handling
the suspend/resume ordering of i915 vs. snd-hda and other stuff), and then
I guess we'll need this? Otoh we're not big on EPROBE_DEFER in x86 :-)

Cheers, Daniel


> 
> Best regards,
> Jyri
> 
> > Also adding Sean.
> > -Daniel
> > 
> >>
> >> Best regards,
> >> Jyri
> >>
> >>> Thanks,
> >>>
> >>> Lukas
> >>>
> >>>>
> >>>> If this patch is not acceptable as such, how about adding this
> >>>> behavior behind a new device link flag?
> >>>>
> >>>> The idea to this patch was gotten from this post by Lucas Wunner:
> >>>> https://www.spinics.net/lists/dri-devel/msg166318.html
> >>>>
> >>>> Part of the code and the description is borrowed from him.
> >>>>
> >>>> cc: Lukas Wunner <lukas@wunner.de>
> >>>> cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>> cc: Thierry Reding <thierry.reding@gmail.com>
> >>>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> >>>> ---
> >>>>  drivers/base/base.h | 1 +
> >>>>  drivers/base/core.c | 2 ++
> >>>>  drivers/base/dd.c   | 2 +-
> >>>>  3 files changed, 4 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/base/base.h b/drivers/base/base.h
> >>>> index d800de6..39370eb 100644
> >>>> --- a/drivers/base/base.h
> >>>> +++ b/drivers/base/base.h
> >>>> @@ -114,6 +114,7 @@ extern void device_release_driver_internal(struct device *dev,
> >>>>
> >>>>  extern void driver_detach(struct device_driver *drv);
> >>>>  extern int driver_probe_device(struct device_driver *drv, struct device *dev);
> >>>> +extern void driver_deferred_probe_add(struct device *dev);
> >>>>  extern void driver_deferred_probe_del(struct device *dev);
> >>>>  static inline int driver_match_device(struct device_driver *drv,
> >>>>                                    struct device *dev)
> >>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
> >>>> index b2261f9..0964ed5 100644
> >>>> --- a/drivers/base/core.c
> >>>> +++ b/drivers/base/core.c
> >>>> @@ -570,6 +570,8 @@ void device_links_unbind_consumers(struct device *dev)
> >>>>
> >>>>                      device_release_driver_internal(consumer, NULL,
> >>>>                                                     consumer->parent);
> >>>> +                    driver_deferred_probe_add(consumer);
> >>>> +
> >>>>                      put_device(consumer);
> >>>>                      goto start;
> >>>>              }
> >>>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> >>>> index de6fd09..846ae78 100644
> >>>> --- a/drivers/base/dd.c
> >>>> +++ b/drivers/base/dd.c
> >>>> @@ -140,7 +140,7 @@ static void deferred_probe_work_func(struct work_struct *work)
> >>>>  }
> >>>>  static DECLARE_WORK(deferred_probe_work, deferred_probe_work_func);
> >>>>
> >>>> -static void driver_deferred_probe_add(struct device *dev)
> >>>> +void driver_deferred_probe_add(struct device *dev)
> >>>>  {
> >>>>      mutex_lock(&deferred_probe_mutex);
> >>>>      if (list_empty(&dev->p->deferred_probe)) {
> >>
> >>
> >> --
> >> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> >> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > 
> > 
> > 
> 
> 
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
