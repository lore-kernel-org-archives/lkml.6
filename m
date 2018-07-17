Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD6EECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E65206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E65206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbeGQS6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:58:25 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:41020 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbeGQS6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:58:25 -0400
Received: by mail-qk0-f194.google.com with SMTP id d22-v6so1029383qkc.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 11:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:mime-version
         :content-transfer-encoding;
        bh=X752vRPJtEdH6zgrcdB5Fhx7P6miQg+Oa7mIufajpUo=;
        b=JwnoAUQZhVYSt63UvyGPbm73+Ma+gIrgkWxQfSxNqW+3gPUeP+uLu1tDoRb+jREXhQ
         9D9TKla15u9I40T1E9DvqYA2zYddU/+e79l1NRXqxHsQNc0xCQnP2TQowebW2ReH0RvP
         3tvBEfagxnd0eo6BFcG/R5s1eUXexLx6Jx+jzHK6E6mhKqAZGm/LzJyh7AJlZa8tPbV5
         BlCQsxehEln+4gk4cQAYPBvJYDSy9CKtqfLJDG7MFRsAxl3XYOrz4WH2Ldn/gYkM+Lg8
         yjWEwnx6fb1OM6SOdPof3/mOSvo3GnNOKR3Bssx6FqAZ9UiIEqOU9xkkUNj7+bxBidIH
         2hGw==
X-Gm-Message-State: AOUpUlF0ijVcXcTMEBpB6sMxEfjKKRIbpfBPdH7AtYtptK1W4gcvoXIj
        sSaDfRHf9XVEeOuzLDDK/XuUzw==
X-Google-Smtp-Source: AAOMgpfS0oxGDajhbKOb1Z4+8DcjzbviLcA2l6BD2J6DX10tX92rmhe5VXA9KjYRYErH/IIpLVj0fg==
X-Received: by 2002:a37:d61b:: with SMTP id t27-v6mr2452186qki.244.1531851873447;
        Tue, 17 Jul 2018 11:24:33 -0700 (PDT)
Received: from whitewolf.lyude.net (pool-72-74-165-95.bstnma.fios.verizon.net. [72.74.165.95])
        by smtp.gmail.com with ESMTPSA id l44-v6sm1440296qtb.58.2018.07.17.11.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 11:24:32 -0700 (PDT)
Message-ID: <cb5af1611622a080fdcbcf3bb794d8ebc39cae2a.camel@redhat.com>
Subject: Re: [Nouveau] [PATCH 1/5] drm/nouveau: Prevent RPM callback
 recursion in suspend/resume paths
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Lukas Wunner <lukas@wunner.de>
Cc:     nouveau@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>, linux-pm@vger.kernel.org
Date:   Tue, 17 Jul 2018 14:24:31 -0400
In-Reply-To: <20180717182041.GA18363@wunner.de>
References: <20180716235936.11268-1-lyude@redhat.com>
         <20180716235936.11268-2-lyude@redhat.com> <20180717071641.GA5411@wunner.de>
         <d7c25a7f41df70685c0c4726315592d1d9b561ff.camel@redhat.com>
         <20180717182041.GA18363@wunner.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 20:20 +0200, Lukas Wunner wrote:
> On Tue, Jul 17, 2018 at 12:53:11PM -0400, Lyude Paul wrote:
> > On Tue, 2018-07-17 at 09:16 +0200, Lukas Wunner wrote:
> > > On Mon, Jul 16, 2018 at 07:59:25PM -0400, Lyude Paul wrote:
> > > > In order to fix all of the spots that need to have runtime PM get/puts()
> > > > added, we need to ensure that it's possible for us to call
> > > > pm_runtime_get/put() in any context, regardless of how deep, since
> > > > almost all of the spots that are currently missing refs can potentially
> > > > get called in the runtime suspend/resume path. Otherwise, we'll try to
> > > > resume the GPU as we're trying to resume the GPU (and vice-versa) and
> > > > cause the kernel to deadlock.
> > > > 
> > > > With this, it should be safe to call the pm runtime functions in any
> > > > context in nouveau with one condition: any point in the driver that
> > > > calls pm_runtime_get*() cannot hold any locks owned by nouveau that
> > > > would be acquired anywhere inside nouveau_pmops_runtime_resume().
> > > > This includes modesetting locks, i2c bus locks, etc.
> > > 
> > > [snip]
> > > > --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> > > > +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> > > > @@ -835,6 +835,8 @@ nouveau_pmops_runtime_suspend(struct device *dev)
> > > >  		return -EBUSY;
> > > >  	}
> > > >  
> > > > +	dev->power.disable_depth++;
> > > > +
> > > 
> > > Anyway, if I understand the commit message correctly, you're hitting a
> > > pm_runtime_get_sync() in a code path that itself is called during a
> > > pm_runtime_get_sync().  Could you include stack traces in the commit
> > > message?  My gut feeling is that this patch masks a deeper issue,
> > > e.g. if the runtime_resume code path does in fact directly poll outputs,
> > > that would seem wrong.  Runtime resume should merely make the card
> > > accessible, i.e. reinstate power if necessary, put into PCI_D0,
> > > restore registers, etc.  Output polling should be scheduled
> > > asynchronously.
> > 
> > So: the reason that patch was added was mainly for the patches later in the
> > series that add guards around the i2c bus and aux bus, since both of those
> > require that the device be awake for it to work. Currently, the spot where
> > it
> > would recurse is:
> 
> Okay, the PCI device is suspending and the nvkm_i2c_aux_acquire()
> wants it in resumed state, so is waiting forever for the device to
> runtime suspend in order to resume it again immediately afterwards.
> 
> The deadlock in the stack trace you've posted could be resolved using
> the technique I used in d61a5c106351 by adding the following to
> include/linux/pm_runtime.h:
> 
> static inline bool pm_runtime_status_suspending(struct device *dev)
> {
> 	return dev->power.runtime_status == RPM_SUSPENDING;
> }
> 
> static inline bool is_pm_work(struct device *dev)
> {
> 	struct work_struct *work = current_work();
> 
> 	return work && work->func == dev->power.work;
> }
> 
> Then adding this to nvkm_i2c_aux_acquire():
> 
> 	struct device *dev = pad->i2c->subdev.device->dev;
> 
> 	if (!(is_pm_work(dev) && pm_runtime_status_suspending(dev))) {
> 		ret = pm_runtime_get_sync(dev);
> 		if (ret < 0 && ret != -EACCES)
> 			return ret;
> 	}
> 
> But here's the catch:  This only works for an *async* runtime suspend.
> It doesn't work for pm_runtime_put_sync(), pm_runtime_suspend() etc,
> because then the runtime suspend is executed in the context of the caller,
> not in the context of dev->power.work.
> 
> So it's not a full solution, but hopefully something that gets you
> going.  I'm not really familiar with the code paths leading to
> nvkm_i2c_aux_acquire() to come up with a full solution off the top
> of my head I'm afraid.
OK-I was considering doing something similar to that commit beforehand but I
wasn't sure if I was going to just be hacking around an actual issue. That
doesn't seem to be the case. This is very helpful and hopefully I should be able
to figure something out from this, thanks!

> 
> Note, it's not sufficient to just check pm_runtime_status_suspending(dev)
> because if the runtime_suspend is carried out concurrently by something
> else, this will return true but it's not guaranteed that the device is
> actually kept awake until the i2c communication has been fully performed.
> 
> HTH,
> 
> Lukas
