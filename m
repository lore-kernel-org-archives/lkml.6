Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C95ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0600320693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0600320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbeGRJBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 05:01:53 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:46481 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeGRJBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 05:01:53 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 45D1A280043B9;
        Wed, 18 Jul 2018 10:25:06 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id DC4C071E27; Wed, 18 Jul 2018 10:25:05 +0200 (CEST)
Date:   Wed, 18 Jul 2018 10:25:05 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [Nouveau] [PATCH 1/5] drm/nouveau: Prevent RPM callback
 recursion in suspend/resume paths
Message-ID: <20180718082505.GB16072@wunner.de>
References: <20180716235936.11268-1-lyude@redhat.com>
 <20180716235936.11268-2-lyude@redhat.com>
 <20180717071641.GA5411@wunner.de>
 <d7c25a7f41df70685c0c4726315592d1d9b561ff.camel@redhat.com>
 <20180717182041.GA18363@wunner.de>
 <CAJZ5v0g8O8J0U8V-gLMe+NnTd3xgZ5_pjr9p2oci7yAfW54B-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g8O8J0U8V-gLMe+NnTd3xgZ5_pjr9p2oci7yAfW54B-A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 09:38:41AM +0200, Rafael J. Wysocki wrote:
> On Tue, Jul 17, 2018 at 8:20 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > Okay, the PCI device is suspending and the nvkm_i2c_aux_acquire()
> > wants it in resumed state, so is waiting forever for the device to
> > runtime suspend in order to resume it again immediately afterwards.
> >
> > The deadlock in the stack trace you've posted could be resolved using
> > the technique I used in d61a5c106351 by adding the following to
> > include/linux/pm_runtime.h:
> >
> > static inline bool pm_runtime_status_suspending(struct device *dev)
> > {
> >         return dev->power.runtime_status == RPM_SUSPENDING;
> > }
> >
> > static inline bool is_pm_work(struct device *dev)
> > {
> >         struct work_struct *work = current_work();
> >
> >         return work && work->func == dev->power.work;
> > }
> >
> > Then adding this to nvkm_i2c_aux_acquire():
> >
> >         struct device *dev = pad->i2c->subdev.device->dev;
> >
> >         if (!(is_pm_work(dev) && pm_runtime_status_suspending(dev))) {
> >                 ret = pm_runtime_get_sync(dev);
> >                 if (ret < 0 && ret != -EACCES)
> >                         return ret;
> >         }
[snip]
> 
> For the record, I don't quite like this approach as it seems to be
> working around a broken dependency graph.
> 
> If you need to resume device A from within the runtime resume callback
> of device B, then clearly B depends on A and there should be a link
> between them.
> 
> That said, I do realize that it may be the path of least resistance,
> but then I wonder if we can do better than this.

The GPU contains an i2c subdevice for each connector with DDC lines.
I believe those are modelled as children of the GPU's PCI device as
they're accessed via mmio of the PCI device.

The problem here is that when the GPU's PCI device runtime suspends,
its i2c child device needs to be runtime active to suspend the MST
topology.  Catch-22.

I don't know whether or not it's necessary to suspend the MST topology.
I'm not an expert on DisplayPort MultiStream transport.

BTW Lyude, in patch 4 and 5 of this series, you're runtime resuming
pad->i2c->subdev.device->dev.  Is this the PCI device or is it the i2c
device?  I'm always confused by nouveau's structs.  In nvkm_i2c_bus_ctor()
I can see that the device you're runtime resuming is the parent of the
i2c_adapter:

	struct nvkm_device *device = pad->i2c->subdev.device;
	[...]
	bus->i2c.dev.parent = device->dev;

If the i2c_adapter is a child of the PCI device, it's sufficient
to runtime resume the i2c_adapter, i.e. bus->i2c.dev, and this will
implicitly runtime resume its parent.

Thanks,

Lukas
