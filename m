Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C33C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74964218A8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74964218A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeHQMF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:05:57 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42339 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeHQMF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:05:57 -0400
Received: by mail-oi0-f65.google.com with SMTP id b16-v6so12844681oic.9;
        Fri, 17 Aug 2018 02:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtDX5JxVZ6bf4rTy9IoKQmn4dHYklQcfEiYjvV/oYFk=;
        b=T17qwFa/Acs3B7YhaquHi88FUzClsiG6KkA4BAN91jtrfqtYWxvPiH07YibXDUja0F
         7nwIM3ZDPHfxIQmwBkW5tgyN0oTtQ0hAXfirEI5IpIVetq0txfIU0mBwPZVAkPj3gsXA
         vVdM30vlzHmgBUfYlZt/EvvhlxUy6JobaqKxVszamP3MsRJs8qkcBSOKLVHK8CBDhWXg
         rPuok3U5OQAXLHDtdzCU/nJO4i/dO29ltOmKsBnxUoCGB8pdLpk/738s5roKFvG1fykr
         +1CtEv3+70hnmjj553OzfDTjoK7ZU9eR1eX7kyJFMWVGLM2h7mahyaZYX+hSW9wyc1Sy
         HYfg==
X-Gm-Message-State: AOUpUlGl+THlkkw80OPWUXpGiXR4bbFLsXiuGMXuMID2RJdBbwnh4eK5
        P4VpAehH4Hi5O9kKF4JqsTVrZXr/BMaXUrMfuw8=
X-Google-Smtp-Source: AA+uWPxfBz8WfJAKMM8BqisMw65xNYnYNjqKHzbp1xCOEqe2FN+CXDp637jxLiqcnmWDaVY0pRjTpjtAAHakS7rJ7Oc=
X-Received: by 2002:aca:b885:: with SMTP id i127-v6mr1653792oif.180.1534496601283;
 Fri, 17 Aug 2018 02:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180817075901.4608-1-david@redhat.com> <20180817075901.4608-2-david@redhat.com>
 <20180817084146.GB14725@kroah.com> <5a5d73e9-e4aa-ffed-a2e3-8aef64e61923@redhat.com>
In-Reply-To: <5a5d73e9-e4aa-ffed-a2e3-8aef64e61923@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Aug 2018 11:03:09 +0200
Message-ID: <CAJZ5v0gkYV8o2Eq+EcGT=OP1tQGPGVVe3n9VGD6z7KAVVqhv9w@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] drivers/base: export lock_device_hotplug/unlock_device_hotplug
To:     David Hildenbrand <david@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Fri, Aug 17, 2018 at 10:56 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 17.08.2018 10:41, Greg Kroah-Hartman wrote:
> > On Fri, Aug 17, 2018 at 09:59:00AM +0200, David Hildenbrand wrote:
> >> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> >>
> >> Well require to call add_memory()/add_memory_resource() with
> >> device_hotplug_lock held, to avoid a lock inversion. Allow external modules
> >> (e.g. hv_balloon) that make use of add_memory()/add_memory_resource() to
> >> lock device hotplug.
> >>
> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> [modify patch description]
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  drivers/base/core.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/base/core.c b/drivers/base/core.c
> >> index 04bbcd779e11..9010b9e942b5 100644
> >> --- a/drivers/base/core.c
> >> +++ b/drivers/base/core.c
> >> @@ -700,11 +700,13 @@ void lock_device_hotplug(void)
> >>  {
> >>      mutex_lock(&device_hotplug_lock);
> >>  }
> >> +EXPORT_SYMBOL_GPL(lock_device_hotplug);
> >>
> >>  void unlock_device_hotplug(void)
> >>  {
> >>      mutex_unlock(&device_hotplug_lock);
> >>  }
> >> +EXPORT_SYMBOL_GPL(unlock_device_hotplug);
> >
> > If these are going to be "global" symbols, let's properly name them.
> > device_hotplug_lock/unlock would be better.  But I am _really_ nervous
> > about letting stuff outside of the driver core mess with this, as people
> > better know what they are doing.
>
> The only "problem" is that we have kernel modules (for paravirtualized
> devices) that call add_memory(). This is Hyper-V right now, but we might
> have other ones in the future. Without them we would not have to export
> it. We might also get kernel modules that want to call remove_memory() -
> which will require the device_hotplug_lock as of now.
>
> What we could do is
>
> a) add_memory() -> _add_memory() and don't export it
> b) add_memory() takes the device_hotplug_lock and calls _add_memory() .
> We export that one.
> c) Use add_memory() in external modules only
>
> Similar wrapper would be needed e.g. for remove_memory() later on.

That would be safer IMO, as it would prevent developers from using
add_memory() without the lock, say.

If the lock is always going to be required for add_memory(), make it
hard (or event impossible) to use the latter without it.
