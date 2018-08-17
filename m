Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DD5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43883218A7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43883218A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeHQMAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:00:11 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38762 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbeHQMAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:00:11 -0400
Received: by mail-oi0-f68.google.com with SMTP id v8-v6so12828637oie.5;
        Fri, 17 Aug 2018 01:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qN7LXQBlLNpyqGffdPWbl3TeOZdOe0gwIS3nQf9dr40=;
        b=SM3TQOqKbNwNU+z00gFi++fa4BACJkcvSFA5Jo+anKKFLxKVLkurko3qAAS5Bb9a8a
         k680PhRr1LFydV/PAECfHdqrwCVIgaLEXFodpjEIezzcBMZ01w3VUgNh3/a3mr521pFf
         tpEbBspVw51yEcvnQyjeoGhwISZh34FccP8KGNXspY3tZdoDkNp286ftEjM+j2NRz8cr
         B1Yy1JZMf1h7wfF67axEs743+fku/09VJM79yTkHUQXws40QGwns58bWp7qXDpatVNu6
         vA8jaiA/lp3XVigI/PhFaAlrdz+GkQ1A5A41zaopUTRAfX9SKH69U/Zu1aNo/d8EMoYS
         jp+g==
X-Gm-Message-State: AOUpUlGN3M1PfaapqkoaDwAjBIObSe6+o6qnf6WEOxA/SB8riebn/ccv
        VrPXdonWc1xpcQJGqxN3SJ6tfHASSxU1sm9a+Dg=
X-Google-Smtp-Source: AA+uWPwf84lPpuUVuPoHTP0inzPPE37dA1EdzhWmysIWT5KgV5z0rNV2e76u32GidexLDrITVEjAJawO03j5Y5y1ICo=
X-Received: by 2002:aca:b885:: with SMTP id i127-v6mr1634635oif.180.1534496256599;
 Fri, 17 Aug 2018 01:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180817075901.4608-1-david@redhat.com> <20180817075901.4608-2-david@redhat.com>
 <20180817084146.GB14725@kroah.com>
In-Reply-To: <20180817084146.GB14725@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Aug 2018 10:57:25 +0200
Message-ID: <CAJZ5v0ja2wrwQ_X=8WW0Lvio+jE7nyqM_WSy1C+tzuKj6RsMdA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] drivers/base: export lock_device_hotplug/unlock_device_hotplug
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devel@linuxdriverproject.org, linux-s390@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>, osalvador@suse.de,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 10:41 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 17, 2018 at 09:59:00AM +0200, David Hildenbrand wrote:
> > From: Vitaly Kuznetsov <vkuznets@redhat.com>
> >
> > Well require to call add_memory()/add_memory_resource() with
> > device_hotplug_lock held, to avoid a lock inversion. Allow external modules
> > (e.g. hv_balloon) that make use of add_memory()/add_memory_resource() to
> > lock device hotplug.
> >
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > [modify patch description]
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  drivers/base/core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 04bbcd779e11..9010b9e942b5 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -700,11 +700,13 @@ void lock_device_hotplug(void)
> >  {
> >       mutex_lock(&device_hotplug_lock);
> >  }
> > +EXPORT_SYMBOL_GPL(lock_device_hotplug);
> >
> >  void unlock_device_hotplug(void)
> >  {
> >       mutex_unlock(&device_hotplug_lock);
> >  }
> > +EXPORT_SYMBOL_GPL(unlock_device_hotplug);
>
> If these are going to be "global" symbols, let's properly name them.
> device_hotplug_lock/unlock would be better.

Well, device_hotplug_lock is the name of the lock itself. :-)

> But I am _really_ nervous about letting stuff outside of the driver core mess
> with this, as people better know what they are doing.
>
> Can't we just "lock" the memory stuff instead?  Why does the entirety of
> the driver core need to be messed with here?

Because, in general, memory hotplug and hotplug of devices are not
independent.  CPUs and memory may only be possible to take away
together and that may be the case for other devices too (say, it
wouldn't be a good idea to access a memory block that has just gone
away from a device, for DMA and the like).  That's why
device_hotplug_lock was introduced in the first place.

That said I agree that exporting this to drivers doesn't feel particularly safe.
