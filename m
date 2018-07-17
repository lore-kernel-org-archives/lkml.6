Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5538ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835BD206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835BD206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbeGQTGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 15:06:05 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:58853 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbeGQTGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 15:06:05 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 94B462800B48A;
        Tue, 17 Jul 2018 20:32:11 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 3E0E1226859; Tue, 17 Jul 2018 20:32:11 +0200 (CEST)
Date:   Tue, 17 Jul 2018 20:32:11 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>, linux-pm@vger.kernel.org
Subject: Re: [Nouveau] [PATCH 1/5] drm/nouveau: Prevent RPM callback
 recursion in suspend/resume paths
Message-ID: <20180717183211.GB18363@wunner.de>
References: <20180716235936.11268-1-lyude@redhat.com>
 <20180716235936.11268-2-lyude@redhat.com>
 <20180717071641.GA5411@wunner.de>
 <d7c25a7f41df70685c0c4726315592d1d9b561ff.camel@redhat.com>
 <20180717182041.GA18363@wunner.de>
 <cb5af1611622a080fdcbcf3bb794d8ebc39cae2a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb5af1611622a080fdcbcf3bb794d8ebc39cae2a.camel@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 02:24:31PM -0400, Lyude Paul wrote:
> On Tue, 2018-07-17 at 20:20 +0200, Lukas Wunner wrote:
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
> > 	return dev->power.runtime_status == RPM_SUSPENDING;
> > }
> > 
> > static inline bool is_pm_work(struct device *dev)
> > {
> > 	struct work_struct *work = current_work();
> > 
> > 	return work && work->func == dev->power.work;
> > }
> > 
> > Then adding this to nvkm_i2c_aux_acquire():
> > 
> > 	struct device *dev = pad->i2c->subdev.device->dev;
> > 
> > 	if (!(is_pm_work(dev) && pm_runtime_status_suspending(dev))) {
> > 		ret = pm_runtime_get_sync(dev);
> > 		if (ret < 0 && ret != -EACCES)
> > 			return ret;
> > 	}
> > 
> > But here's the catch:  This only works for an *async* runtime suspend.
> > It doesn't work for pm_runtime_put_sync(), pm_runtime_suspend() etc,
> > because then the runtime suspend is executed in the context of the caller,
> > not in the context of dev->power.work.
> > 
> > So it's not a full solution, but hopefully something that gets you
> > going.  I'm not really familiar with the code paths leading to
> > nvkm_i2c_aux_acquire() to come up with a full solution off the top
> > of my head I'm afraid.
> 
> OK-I was considering doing something similar to that commit beforehand but I
> wasn't sure if I was going to just be hacking around an actual issue. That
> doesn't seem to be the case. This is very helpful and hopefully I should be able
> to figure something out from this, thanks!

In some cases, the function acquiring the runtime PM ref is only called
from a couple of places and then it would be feasible and appropriate
to add a bool parameter to the function telling it to acquire the ref
or not.  So the function is told using a parameter which context it's
running in:  In the runtime_suspend code path or some other code path.

The technique to use current_work() is an alternative approach to figure
out the context if passing in an additional parameter is not feasible
for some reason.  That was the case with d61a5c106351.  That approach
only works for work items though.

Lukas
