Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D655C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1420120870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="COe6NzDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1420120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeLJKSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:18:37 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41551 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeLJKSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:18:37 -0500
Received: by mail-ed1-f65.google.com with SMTP id z28so8968525edi.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 02:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NAyoTtRLEgV/ZLu0j1afB7pOEypu3oJUgTQbmtuJru0=;
        b=COe6NzDrrA/t2I/UCH4hq/awqlSSzs/7g0b2lq/KwCoczu9lwnG+T3X9mEJ/7EsRph
         pRRX2BXh1ocjoY76TBEFQeYiE5HJJRyCKdgEzeJEz0XvUDpeQeqQPKXmbQRn7+2EEKBN
         9cG8u6IeD+lzVsp3WbZSijWOIt7WDf0Wp/f6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=NAyoTtRLEgV/ZLu0j1afB7pOEypu3oJUgTQbmtuJru0=;
        b=ect3aRn58k36QYAegvPTOgA0YqgA8m2AMJppgmzjIDpQ5sPRn7now5nBUum4qYxHoh
         f3ehWGVakhnIPlYzawt/h2wx25ChBf3IHHtnBDzomShiL0QuRzOdjghWTjxHYCq2dpyp
         34/D8pP+rdHHDxNWXDpKDn50Jxox2hgqaWea6MKPYsh9DoR5wnACaeqe4Ky0txYTcvJ/
         3P+JFK5uSWgWO7OlDVnZWaK76ipHkXOv8Fp8ONT7G/9jrAyK6RZyjV5eQqCwjpWI/+iw
         NWJOU0AUfZiOO2erNUPBlQwL/cobASZoCh0s/8zmv9Wgx9szcCHbqBKPmmzbpDYaDTnU
         uJhw==
X-Gm-Message-State: AA+aEWbkBTkYBWOC34rY2DG/wpQ5R3n51gLiVxcs2JTXXGYDHhvVVer6
        wRutGZsYu6WIbr+O792O0OWyWg==
X-Google-Smtp-Source: AFSGD/V9fF2TbVZ1jalCYbRCvHzMPjr9qO6Ad4XOIj4FTsBRF7KGerf/R9vlp1Mygh8H1j8uYe5XUA==
X-Received: by 2002:a17:906:37da:: with SMTP id o26-v6mr9251480ejc.179.1544437115071;
        Mon, 10 Dec 2018 02:18:35 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c11-v6sm1726157ejm.67.2018.12.10.02.18.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 02:18:34 -0800 (PST)
Date:   Mon, 10 Dec 2018 11:18:32 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Ramalingam C <ramalingam.c@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] drivers/base: use a worker for sysfs unbind
Message-ID: <20181210101832.GN21184@phenom.ffwll.local>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Ramalingam C <ramalingam.c@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20181210084653.7268-1-daniel.vetter@ffwll.ch>
 <20181210100634.GA8836@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210100634.GA8836@kroah.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 11:06:34AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Dec 10, 2018 at 09:46:53AM +0100, Daniel Vetter wrote:
> > Drivers might want to remove some sysfs files, which needs the same
> > locks and ends up angering lockdep. Relevant snippet of the stack
> > trace:
> > 
> >   kernfs_remove_by_name_ns+0x3b/0x80
> >   bus_remove_driver+0x92/0xa0
> >   acpi_video_unregister+0x24/0x40
> >   i915_driver_unload+0x42/0x130 [i915]
> >   i915_pci_remove+0x19/0x30 [i915]
> >   pci_device_remove+0x36/0xb0
> >   device_release_driver_internal+0x185/0x250
> >   unbind_store+0xaf/0x180
> >   kernfs_fop_write+0x104/0x190
> > 
> > I've stumbled over this because some new patches by Ram connect the
> > snd-hda-intel unload (where we do use sysfs unbind) with the locking
> > chains in the i915 unload code (but without creating a new loop),
> > which upset our CI. But the bug is already there and can be easily
> > reproduced by unbind i915 directly.
> 
> This is odd, why wouldn't any driver hit this issue?  And why now since
> you say this is triggerable today?

The above backtrace is triggered by unbinding i915 on current upstream
kernels. Note: Will crash later on rather badly in the
fbdev/fbcon/vtconsole hell, but that's separate issue (which can be worked
around by first unbinding fbcon manually through sysfs).

> I know scsi was doing some strange things like trying to remove the
> device itself from a sysfs callback on the device, which requires it to
> just call a different kobject function created just for that type of
> thing.  Would that also make sense to do here instead of your workqueue?

Note how we blow up on unregistering sw device instances supported by i915
in entirely different subsystems. I guess most drivers just have sysfs
files for their own stuff, where this is done as you describe. The problem
is that there's an awful lot of unrelated stuff hanging off i915.

Or maybe acpi_video is busted, and should be using a different function.
You haven't said which one, and I have no idea which one it is ...

And in case the context wasn't clear: This is unbinding the i915 pci
driver which triggers the above lockdep splat recursion.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
