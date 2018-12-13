Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46417C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B98208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gghMC4j3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B98208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbeLMJ6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:58:19 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40303 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbeLMJ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:58:19 -0500
Received: by mail-ed1-f67.google.com with SMTP id d3so1492899edx.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 01:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DyFnPGwFai6jF7+vAFApibSkmEDc58F14dUuetMugDs=;
        b=gghMC4j3C8I6NnpLypL3hnig0jjZnNyWWpdK5+P+gv42CrQ7qZztqebPbkF5N7fIAE
         9Ba5Ow5ZZE0Er6lCxPhDOm0gMtkaUPI5IOCR1hsOUOKxZsQqHc19d2fe6beyfn6xHGw6
         4sQohqr8d7ouhmmNA+V7Cqhh5uP3bbQPFY19k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=DyFnPGwFai6jF7+vAFApibSkmEDc58F14dUuetMugDs=;
        b=Y4+DiNvxVFL9fgxcXpKOoriA8ysf5fldVkrY8jYjAH6e2ev3KcJ5J4pjrOM86AtQWV
         JvHgLVJNT7PuRK+6z4bvxQaRcYpev2gbEGto7GThEkBsWCbmu4T48rjZIrw2UF8rOsQt
         p4Qc9aUptIAlawJeSGOum+b3P7C+RXBEkA6VI06icGRpayFv27nwOCHqRaAbKRaFodPn
         Rd05M/Rh0nVqCoWAC19pYJ3LapMiRFURb/GU+4K/pl23vp697gyDW0zF6P7rESQ++OUM
         M6BtkNufEATWTS14o5nbpPZMTwIqRx9livAL2mQYqjFxkGNmOl6ijfI5zp+AVGDEfGXJ
         qCYw==
X-Gm-Message-State: AA+aEWaZ3UyWalx01pln2vTkHarM+HyPc3IYHI3Qq8QtDLrIot5tT5rL
        EGuUfKM4AYu0tvjyS4awx5qMqg==
X-Google-Smtp-Source: AFSGD/W6g7AfWSX6jhwaRv95oKuwHlHP5BbLmBdTuQ3DWoAWOSu990Bgn0rp+iEBxaC8YlJU4v3elw==
X-Received: by 2002:a17:906:38e:: with SMTP id b14-v6mr17236866eja.209.1544695097640;
        Thu, 13 Dec 2018 01:58:17 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id r1sm499200eds.1.2018.12.13.01.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 01:58:16 -0800 (PST)
Date:   Thu, 13 Dec 2018 10:58:14 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ramalingam.c@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] drivers/base: use a worker for sysfs unbind
Message-ID: <20181213095814.GC21184@phenom.ffwll.local>
Mail-Followup-To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, ramalingam.c@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20181210084653.7268-1-daniel.vetter@ffwll.ch>
 <CAJZ5v0jkE=Rt2ozwcTxRdUN++Sr4HXULksDeMx4jEWj1jVDcyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jkE=Rt2ozwcTxRdUN++Sr4HXULksDeMx4jEWj1jVDcyA@mail.gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 10:38:14AM +0100, Rafael J. Wysocki wrote:
> On Mon, Dec 10, 2018 at 9:47 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> >
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
> 
> Is the acpi_bus_unregister_driver() in acpi_video_unregister() the
> source of the lockdep unhappiness?

Yeah I guess I cut out too much of the lockdep splat. It complains about
kernfs_fop_write and kernfs_remove_by_name_ns acquiring the same lock
class. It's ofc not the same lock, so no real deadlock. Getting the
device_release_driver outside of the callchain under kernfs_fop_write,
which this patch does, "fixes" it. For "fixes" = shut up lockdep.

Other options:
- Anotate the recursion with the usual lockdep annotations. Potentially
  results in lockdep not catching real deadlocks (you can still have other
  loops closing the deadlock, maybe through some subsystem/bus lock).

- Rewrite kernfs_fop_write to drop the lock (optionally, for callbacks
  that know what they're doing), which should be fine if we refcount
  everything properly (bus, driver & device).

- Also note that probably the same bug exists on the bind sysfs interface,
  but we don't use that, so I don't care :-)

- Most of these issues are never visible in normal usage, since normally
  driver bind/unbind is done from a kthread or model_load/unload, neither
  of which is running in the context of that kernfs mutex kernfs_fop_write
  holds. That's why I think the task work is the best solution, since it
  changes the locking context of the unbind sysfs to match the locking
  context of module unload and hotunplug. Unfortunately that trick doesn't
  work for the bind sysfs file, since that way we can't thread the errno
  value back to userspace.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
