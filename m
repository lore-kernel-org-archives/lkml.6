Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2671AECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA1C2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA1C2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbeGQSyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:54:36 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:53037 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729759AbeGQSyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:54:35 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 492CD2800B48A;
        Tue, 17 Jul 2018 20:20:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E984A227519; Tue, 17 Jul 2018 20:20:41 +0200 (CEST)
Date:   Tue, 17 Jul 2018 20:20:41 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>, linux-pm@vger.kernel.org
Subject: Re: [Nouveau] [PATCH 1/5] drm/nouveau: Prevent RPM callback
 recursion in suspend/resume paths
Message-ID: <20180717182041.GA18363@wunner.de>
References: <20180716235936.11268-1-lyude@redhat.com>
 <20180716235936.11268-2-lyude@redhat.com>
 <20180717071641.GA5411@wunner.de>
 <d7c25a7f41df70685c0c4726315592d1d9b561ff.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7c25a7f41df70685c0c4726315592d1d9b561ff.camel@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 12:53:11PM -0400, Lyude Paul wrote:
> On Tue, 2018-07-17 at 09:16 +0200, Lukas Wunner wrote:
> > On Mon, Jul 16, 2018 at 07:59:25PM -0400, Lyude Paul wrote:
> > > In order to fix all of the spots that need to have runtime PM get/puts()
> > > added, we need to ensure that it's possible for us to call
> > > pm_runtime_get/put() in any context, regardless of how deep, since
> > > almost all of the spots that are currently missing refs can potentially
> > > get called in the runtime suspend/resume path. Otherwise, we'll try to
> > > resume the GPU as we're trying to resume the GPU (and vice-versa) and
> > > cause the kernel to deadlock.
> > > 
> > > With this, it should be safe to call the pm runtime functions in any
> > > context in nouveau with one condition: any point in the driver that
> > > calls pm_runtime_get*() cannot hold any locks owned by nouveau that
> > > would be acquired anywhere inside nouveau_pmops_runtime_resume().
> > > This includes modesetting locks, i2c bus locks, etc.
> > 
> > [snip]
> > > --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> > > +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> > > @@ -835,6 +835,8 @@ nouveau_pmops_runtime_suspend(struct device *dev)
> > >  		return -EBUSY;
> > >  	}
> > >  
> > > +	dev->power.disable_depth++;
> > > +
> > 
> > Anyway, if I understand the commit message correctly, you're hitting a
> > pm_runtime_get_sync() in a code path that itself is called during a
> > pm_runtime_get_sync().  Could you include stack traces in the commit
> > message?  My gut feeling is that this patch masks a deeper issue,
> > e.g. if the runtime_resume code path does in fact directly poll outputs,
> > that would seem wrong.  Runtime resume should merely make the card
> > accessible, i.e. reinstate power if necessary, put into PCI_D0,
> > restore registers, etc.  Output polling should be scheduled
> > asynchronously.
> 
> So: the reason that patch was added was mainly for the patches later in the
> series that add guards around the i2c bus and aux bus, since both of those
> require that the device be awake for it to work. Currently, the spot where it
> would recurse is:

Okay, the PCI device is suspending and the nvkm_i2c_aux_acquire()
wants it in resumed state, so is waiting forever for the device to
runtime suspend in order to resume it again immediately afterwards.

The deadlock in the stack trace you've posted could be resolved using
the technique I used in d61a5c106351 by adding the following to
include/linux/pm_runtime.h:

static inline bool pm_runtime_status_suspending(struct device *dev)
{
	return dev->power.runtime_status == RPM_SUSPENDING;
}

static inline bool is_pm_work(struct device *dev)
{
	struct work_struct *work = current_work();

	return work && work->func == dev->power.work;
}

Then adding this to nvkm_i2c_aux_acquire():

	struct device *dev = pad->i2c->subdev.device->dev;

	if (!(is_pm_work(dev) && pm_runtime_status_suspending(dev))) {
		ret = pm_runtime_get_sync(dev);
		if (ret < 0 && ret != -EACCES)
			return ret;
	}

But here's the catch:  This only works for an *async* runtime suspend.
It doesn't work for pm_runtime_put_sync(), pm_runtime_suspend() etc,
because then the runtime suspend is executed in the context of the caller,
not in the context of dev->power.work.

So it's not a full solution, but hopefully something that gets you
going.  I'm not really familiar with the code paths leading to
nvkm_i2c_aux_acquire() to come up with a full solution off the top
of my head I'm afraid.

Note, it's not sufficient to just check pm_runtime_status_suspending(dev)
because if the runtime_suspend is carried out concurrently by something
else, this will return true but it's not guaranteed that the device is
actually kept awake until the i2c communication has been fully performed.

HTH,

Lukas
