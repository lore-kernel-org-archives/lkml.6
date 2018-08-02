Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C438C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A592156F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A592156F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbeHBVws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:52:48 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33900 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbeHBVws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:52:48 -0400
Received: by mail-qk0-f196.google.com with SMTP id b66-v6so2494767qkj.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 13:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=91l2h2t3/xKYaNP7soprXxqavel+FILehFZBfd4Z6ZI=;
        b=lRLmMKYWMWN+NGbd7l03evaepQz1wISV5/vrGwVOYKA1lq6GDAWnh2K+FO6Td70DNb
         lRAcfD0gbZVHKbkbRwLA2/SEqSWI5Sx3L8Qz6WRXcN+GjD2zE4Egsl2dmEWHdte9Rv+y
         qJt6opnwTCiGvL4pPB10CpDpwxTe/+VeYr9jK6gj1vjp/svugDgsVxqCAxohrH640VET
         Tn/VRH/jDfKMR6Ytq12IZRA3eswTFr2e9k0Wr+XFr812oo2EaCnnTdFW5I5wtmU9z6NF
         ErvI7/Hdr6T3IBeoDgaOlS7nGea2qB0HclUVIyKTOA1uM3Y4PJGl3PId8ZX+sU7URKlO
         7Plw==
X-Gm-Message-State: AOUpUlGcXLzm4Od5dKrd45s0jeCY8ovchsKMC7+ROGP8epCWaJFySz9y
        A05dCghgvA5fi6kfRPCshS1FQoXnBt0=
X-Google-Smtp-Source: AAOMgpcy6qH3YARgWjtv/BpQLQ7mjoEU3+fd6g4MAsZlXVz5ecRu7Jv7ge/P26DUztMFmh0WtV7ilg==
X-Received: by 2002:a37:8643:: with SMTP id i64-v6mr978149qkd.194.1533240009490;
        Thu, 02 Aug 2018 13:00:09 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id v192-v6sm2824675qkb.0.2018.08.02.13.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 13:00:08 -0700 (PDT)
Message-ID: <b55fe368eaf99dee03e88288ec6e8fa53bb466e7.camel@redhat.com>
Subject: Re: [PATCH v4 8/8] drm/nouveau: Call pm_runtime_get_noresume() from
 hpd handlers
From:   Lyude Paul <lyude@redhat.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     nouveau@lists.freedesktop.org,
        Karol Herbst <karolherbst@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Thu, 02 Aug 2018 16:00:08 -0400
In-Reply-To: <20180802194041.GC6180@wunner.de>
References: <20180801211459.7731-1-lyude@redhat.com>
         <20180801211459.7731-9-lyude@redhat.com> <20180802194041.GC6180@wunner.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-02 at 21:40 +0200, Lukas Wunner wrote:
> On Wed, Aug 01, 2018 at 05:14:58PM -0400, Lyude Paul wrote:
> > We can't and don't need to try resuming the device from our hotplug
> > handlers, but hotplug events are generally something we'd like to keep
> > the device awake for whenever possible. So, grab a PM ref safely in our
> > hotplug handlers using pm_runtime_get_noresume() and mark the device as
> > busy once we're finished.
> 
> Patch looks fine in principle, but doesn't seem to be sufficient to fix
> the following race:
> 
> 1. runtime_suspend commences
> 2. user plugs in a display before the runtime_suspend worker disables
>    hotplug interrupts in nouveau_display_fini()
> 3. hotplug is handled, display is lit up
> 4. runtime_suspend worker waits for hotplug handler to finish
> 5. GPU is runtime suspended and the newly plugged in display goes black
> 
> The call to pm_runtime_mark_last_busy() has no effect in this situation
> because rpm_suspend() doesn't look at the last_busy variable after the
> call to rpm_callback().  What's necessary here is that runtime_suspend is
> aborted and -EBUSY returned.

So: that wasn't actually what this patch was meant to fix, this is just meant
to make it a little more likely that the GPU won't fall asleep while doing
connector probing, since there's no risk handling it here.

That being said; I think there's some parts you're missing on this. Mainly
that regardless of whether or not the GPU ends up getting runtime suspended
here, a hotplug event has still been propogated to userspace. If fbcon isn't
the one in charge in that scenario (e.g. we have gnome-shell, X, etc. running)
then whoever is can still respond to the hotplug as usual, and the probing
from userspace will result in waking the GPU back up again since
nouveau_connector_detect() will grab a runtime PM ref since it's not being
called from the hpd context. I don't think this is the case yet for MST
connectors since they don't use nouveau_connector_detect(), and I'll see if I
fix that as well in the next patch series.

Now; what you pointed out made me realize I'm not sure that would apply when
fbcon does happen to be the one in control, since fb_helper will have it's
hotplug handling suspended at this point, which will mean that it won't
respond to the connector change until the GPU is runtime resumed by something
else. That definitely should get fixed.

Also: let me know if any of this doesn't sound correct, there's so much to
this I wouldn't be surprised if I missed something else
> 
> Thanks,
> 
> Lukas
> 
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: stable@vger.kernel.org
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Karol Herbst <karolherbst@gmail.com>
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_connector.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c
> > b/drivers/gpu/drm/nouveau/nouveau_connector.c
> > index 8409c3f2c3a1..5a8e8c1ad647 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> > @@ -1152,6 +1152,11 @@ nouveau_connector_hotplug(struct nvif_notify
> > *notify)
> >  	const char *name = connector->name;
> >  	struct nouveau_encoder *nv_encoder;
> >  
> > +	/* Resuming the device here isn't possible; but the suspend PM ops
> > +	 * will wait for us to finish our work before disabling us so this
> > +	 * should be enough
> > +	 */
> > +	pm_runtime_get_noresume(drm->dev->dev);
> >  	nv_connector->hpd_task = current;
> >  
> >  	if (rep->mask & NVIF_NOTIFY_CONN_V0_IRQ) {
> > @@ -1171,6 +1176,9 @@ nouveau_connector_hotplug(struct nvif_notify
> > *notify)
> >  	}
> >  
> >  	nv_connector->hpd_task = NULL;
> > +
> > +	pm_runtime_mark_last_busy(drm->dev->dev);
> > +	pm_runtime_put_autosuspend(drm->dev->dev);
> >  	return NVIF_NOTIFY_KEEP;
> >  }
> >  
> > -- 
> > 2.17.1
> > 
-- 
Cheers,
	Lyude Paul

