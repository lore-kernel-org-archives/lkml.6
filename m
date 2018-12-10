Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E590C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE44220880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544436399;
	bh=faVDNK86VYlzOIfJDdA59imcMuuyQeR01dMI+p2GZyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g6NQNK0O+9N9skPiTmJx+m5yv5enlH7i6vGWs5Stx/mmCkz4skEnqpO5wMUm+Tf1D
	 MedKfyaoNmKEVincfvhnxwLbeBbvjsbOGcYUzhbVpnRI8y4RHQ9q0gGJj2CbjSMZ4b
	 mpIMOa86tF4Oeok75GGMhGMPRmSissI9UsjF5m40=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE44220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbeLJKGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:06:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:58386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbeLJKGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:06:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F88820821;
        Mon, 10 Dec 2018 10:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544436396;
        bh=faVDNK86VYlzOIfJDdA59imcMuuyQeR01dMI+p2GZyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GC6bqOvASFge7pRIew0gTH82twietfN7xfUrKphtulpUpXNE4aSMMx/3HfQmSJNtB
         7XYJ7irVkzu2QHlAuSn/dAIu7HJKaLJvCmBh5hwT6nMzQ/YB8EHoQonDPFEGTyiVjq
         Yzi4g3z2fmq528gne+0Uwm8DbKx8KYK8jsGLtYbc=
Date:   Mon, 10 Dec 2018 11:06:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Ramalingam C <ramalingam.c@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] drivers/base: use a worker for sysfs unbind
Message-ID: <20181210100634.GA8836@kroah.com>
References: <20181210084653.7268-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210084653.7268-1-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 09:46:53AM +0100, Daniel Vetter wrote:
> Drivers might want to remove some sysfs files, which needs the same
> locks and ends up angering lockdep. Relevant snippet of the stack
> trace:
> 
>   kernfs_remove_by_name_ns+0x3b/0x80
>   bus_remove_driver+0x92/0xa0
>   acpi_video_unregister+0x24/0x40
>   i915_driver_unload+0x42/0x130 [i915]
>   i915_pci_remove+0x19/0x30 [i915]
>   pci_device_remove+0x36/0xb0
>   device_release_driver_internal+0x185/0x250
>   unbind_store+0xaf/0x180
>   kernfs_fop_write+0x104/0x190
> 
> I've stumbled over this because some new patches by Ram connect the
> snd-hda-intel unload (where we do use sysfs unbind) with the locking
> chains in the i915 unload code (but without creating a new loop),
> which upset our CI. But the bug is already there and can be easily
> reproduced by unbind i915 directly.

This is odd, why wouldn't any driver hit this issue?  And why now since
you say this is triggerable today?

I know scsi was doing some strange things like trying to remove the
device itself from a sysfs callback on the device, which requires it to
just call a different kobject function created just for that type of
thing.  Would that also make sense to do here instead of your workqueue?

thanks,

greg k-h
