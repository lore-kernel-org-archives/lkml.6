Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907CFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4E820685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jzTvFyZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4E820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504473AbeKWX7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:59:33 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53238 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390867AbeKWX7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:59:33 -0500
Received: by mail-it1-f194.google.com with SMTP id i7so18362059iti.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 05:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TgmVmK8YOkbGetgLHjxUB252HP/issfa95UlGOT8KP4=;
        b=jzTvFyZLWhaTv3fPabKaGw/xq40CPu2WvN8sSnBauPJ3sbmXpOu9toWODABuHVG3nn
         e/QtbqaZjx6WvvkC86A1dIPmpEWjUxBxLf2bYQeEZ9jdZ87ELhmDyXw6p5/r6Xe/mGaf
         jZ3DgzUav6eLqMA2KRMBphZloo99vLORyr9YQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TgmVmK8YOkbGetgLHjxUB252HP/issfa95UlGOT8KP4=;
        b=EEATLsvOzBclad703iHH71PtZ6EsE5AKeYT70/aGxWNDSeE4DVohM64qa2G8vk8EY9
         nfJrnXorsXyA02Ff3u+HxtK+WeETNJAyS6TLoTQ0yS3WxAyMg3JcUxqL6nbOG5KsFrGI
         vmOSOhx/HF4f0U5bmVKQbfEP9djd7ZKBS2G1vLfPn5xSaPBzQ3JR/3xip+JxuyyOgJie
         sPwGu/JMN7jEFV6mrJTF7D3MTf3pZ0yJnC3T7MlUPCTLBFSRspWOuv08mNEG5RB+gQQL
         JiqQd6TzMLp4cMmC7gk+IQWJ7bFZcM5ym9xVqInQI9LPA8VkyNcM+gx2TgrrmjeAQtCb
         Tmqg==
X-Gm-Message-State: AA+aEWaCsbCBf50S/APh4vfBobD2pNV55ncSLrN1aZMhr+ccE/zJ4zH/
        jwB8UUCxeL2FHvhTnwb7jk7ZWiUAPWVs8UzHymNGSA==
X-Google-Smtp-Source: AFSGD/X0yvjSxT0V3nOYCe2A+fRqYqEEsRMs+rXehdeHbLbbNSl3yYce4HuTYzzMdE8mqYOF/6mZQSPjVAgSRfQPqeM=
X-Received: by 2002:a24:138b:: with SMTP id 133-v6mr4830676itz.117.1542978923307;
 Fri, 23 Nov 2018 05:15:23 -0800 (PST)
MIME-Version: 1.0
References: <20181122165106.18238-1-daniel.vetter@ffwll.ch>
 <20181122165106.18238-2-daniel.vetter@ffwll.ch> <20181123111557.GG8625@dhcp22.suse.cz>
 <20181123123057.GK4266@phenom.ffwll.local> <20181123124358.GJ8625@dhcp22.suse.cz>
In-Reply-To: <20181123124358.GJ8625@dhcp22.suse.cz>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 23 Nov 2018 14:15:11 +0100
Message-ID: <CAKMK7uGViQT5HPEQzFsAT85gdCr-gw94EB5fMT9eXRBAXambWg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: Check if mmu notifier callbacks are allowed to fail
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Rientjes <rientjes@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 1:43 PM Michal Hocko <mhocko@kernel.org> wrote:
> On Fri 23-11-18 13:30:57, Daniel Vetter wrote:
> > On Fri, Nov 23, 2018 at 12:15:57PM +0100, Michal Hocko wrote:
> > > On Thu 22-11-18 17:51:04, Daniel Vetter wrote:
> > > > Just a bit of paranoia, since if we start pushing this deep into
> > > > callchains it's hard to spot all places where an mmu notifier
> > > > implementation might fail when it's not allowed to.
> > >
> > > What does WARN give you more than the existing pr_info? Is really
> > > backtrace that interesting?
> >
> > Automated tools have to ignore everything at info level (there's too much
> > of that). I guess I could do something like
> >
> > if (blockable)
> >       pr_warn(...)
> > else
> >       pr_info(...)
> >
> > WARN() is simply my goto tool for getting something at warning level
> > dumped into dmesg. But I think the pr_warn with the callback function
> > should be enough indeed.
>
> I wouldn't mind s@pr_info@pr_warn@

Well that's too much, because then it would misfire in the oom
testcase, where failing is ok (desireble even, we want to avoid
blocking after all). So needs to be  a switch (or else we need to
filter it in results, and that's a bit a maintenance headache from a
CI pov).
-Danile

> > If you wonder where all the info level stuff happens that we have to
> > ignore: suspend/resume is a primary culprit (fairly important for
> > gfx/desktops), but there's a bunch of other places. Even if we ignore
> > everything at info and below we still need filters because some drivers
> > are a bit too trigger-happy (i915 definitely included I guess, so everyone
> > contributes to this problem).
>
> Thanks for the clarification.
> --
> Michal Hocko
> SUSE Labs



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
