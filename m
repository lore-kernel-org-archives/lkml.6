Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31534C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4F320879
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="K9qZ2lFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4F320879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeLLLIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:08:46 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46496 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbeLLLIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:08:44 -0500
Received: by mail-ed1-f67.google.com with SMTP id o10so15159385edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 03:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NBYG3dt8oCcJhuzZ/ytmAIKIqhgaPKq+Vtgqx15x1NE=;
        b=K9qZ2lFDi55edB+wKp0bhgT1qGjYlHspyJOw1xaol6RZwjfl2VA4VoNy9pAnBG0yrN
         FwEEOjJOnVlW1HP5WIXddviOT3Tm2Cn26cPuJuQF0tmY593W4O7ZMVfL7Veg811PG4ep
         pDJ4/XSni2TEXj/KhT/xBwcw0vtk+fzIY6k78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=NBYG3dt8oCcJhuzZ/ytmAIKIqhgaPKq+Vtgqx15x1NE=;
        b=ANHCMkL0nr6rL1Y9zbVJh/m5vplTHa8KRQaDYzAEQahh1leE8A3VaBbb+uwYJYGXy7
         qngyt40iSQM0XBVE4a1X9waeDQNQrNe91ptP3Ngaf1IY/kf0hMy/tSvVacniwptogVjz
         OhpBD5K3CnUGmpRxEANyS95BG9UAkeHDWvdQlGmIEKOxfsHLfipmwYf+BEA8yQV5kyLp
         y8KDsyGixN6CapPMV65vZq2VTGCBRv2LlXywnI8eYz7ZnKDkW9ZSZ3JlxI9jTZ4T8VVB
         SO7oq6gKz1VSSLGmez7o906ydArb6RAagN17Br9ELLCkj+GyeakBzkNwDCNoWcN9lfbD
         4Tjw==
X-Gm-Message-State: AA+aEWZwXEuadkMCdRt76QJjg3R0RddlikIy6rJS4n4t9N9bN3RLG3+5
        mN2HQJke//i+5OQz4empQmhjPQ==
X-Google-Smtp-Source: AFSGD/U86Go3+3ybhFBMH05jAnslT80NIroiYFSXEaGgmTHmpsLbzoiaglbV2yKITD4g6992FWeFvg==
X-Received: by 2002:a17:906:2989:: with SMTP id x9-v6mr15372950eje.156.1544612923013;
        Wed, 12 Dec 2018 03:08:43 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id j23sm4670364edr.89.2018.12.12.03.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 03:08:41 -0800 (PST)
Date:   Wed, 12 Dec 2018 12:08:40 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Ramalingam C <ramalingam.c@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] drivers/base: use a worker for sysfs unbind
Message-ID: <20181212110840.GA21184@phenom.ffwll.local>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Ramalingam C <ramalingam.c@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20181210084653.7268-1-daniel.vetter@ffwll.ch>
 <20181210100634.GA8836@kroah.com>
 <20181210101832.GN21184@phenom.ffwll.local>
 <20181210102058.GO21184@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210102058.GO21184@phenom.ffwll.local>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 11:20:58AM +0100, Daniel Vetter wrote:
> On Mon, Dec 10, 2018 at 11:18:32AM +0100, Daniel Vetter wrote:
> > On Mon, Dec 10, 2018 at 11:06:34AM +0100, Greg Kroah-Hartman wrote:
> > > On Mon, Dec 10, 2018 at 09:46:53AM +0100, Daniel Vetter wrote:
> > > > Drivers might want to remove some sysfs files, which needs the same
> > > > locks and ends up angering lockdep. Relevant snippet of the stack
> > > > trace:
> > > > 
> > > >   kernfs_remove_by_name_ns+0x3b/0x80
> > > >   bus_remove_driver+0x92/0xa0
> > > >   acpi_video_unregister+0x24/0x40
> > > >   i915_driver_unload+0x42/0x130 [i915]
> > > >   i915_pci_remove+0x19/0x30 [i915]
> > > >   pci_device_remove+0x36/0xb0
> > > >   device_release_driver_internal+0x185/0x250
> > > >   unbind_store+0xaf/0x180
> > > >   kernfs_fop_write+0x104/0x190
> > > > 
> > > > I've stumbled over this because some new patches by Ram connect the
> > > > snd-hda-intel unload (where we do use sysfs unbind) with the locking
> > > > chains in the i915 unload code (but without creating a new loop),
> > > > which upset our CI. But the bug is already there and can be easily
> > > > reproduced by unbind i915 directly.
> > > 
> > > This is odd, why wouldn't any driver hit this issue?  And why now since
> > > you say this is triggerable today?
> > 
> > The above backtrace is triggered by unbinding i915 on current upstream
> > kernels. Note: Will crash later on rather badly in the
> > fbdev/fbcon/vtconsole hell, but that's separate issue (which can be worked
> > around by first unbinding fbcon manually through sysfs).
> > 
> > > I know scsi was doing some strange things like trying to remove the
> > > device itself from a sysfs callback on the device, which requires it to
> > > just call a different kobject function created just for that type of
> > > thing.  Would that also make sense to do here instead of your workqueue?
> > 
> > Note how we blow up on unregistering sw device instances supported by i915
> > in entirely different subsystems. I guess most drivers just have sysfs
> > files for their own stuff, where this is done as you describe. The problem
> > is that there's an awful lot of unrelated stuff hanging off i915.
> > 
> > Or maybe acpi_video is busted, and should be using a different function.
> > You haven't said which one, and I have no idea which one it is ...
> > 
> > And in case the context wasn't clear: This is unbinding the i915 pci
> > driver which triggers the above lockdep splat recursion.
> 
> btw another option for "fixing" this would be to annotate the mutex_lock
> in kernfs_remove_by_name_ns as recursive. Which just shuts up lockdep (and
> might hide some real bugs), but would get the job done since there's not
> actually a deadlock here. Just lockdep being annoyed.

So what's the pick? I can do the typing, but I don't understand all the
driver core interactions to know what we should be doing here best.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
