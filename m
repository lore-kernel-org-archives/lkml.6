Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05C3C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C99620652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C99620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbeICTMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:12:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725949AbeICTMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:12:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B2DDC87A50;
        Mon,  3 Sep 2018 14:52:17 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DBA4A2026D6B;
        Mon,  3 Sep 2018 14:52:16 +0000 (UTC)
Date:   Mon, 3 Sep 2018 22:52:13 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        thgarnie@google.com, kirill.shutemov@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/mm/KASLR: Adjust the vmemmap size according to
 paging mode
Message-ID: <20180903145213.GG1740@192.168.1.3>
References: <20180829021754.21850-1-bhe@redhat.com>
 <20180829021754.21850-2-bhe@redhat.com>
 <20180829120530.6dhgsautjjrj4ztt@kshutemo-mobl1>
 <20180830152512.GE14702@192.168.1.2>
 <20180902205242.kcpt6wsatacahswp@kshutemo-mobl1>
 <20180903074718.GD1740@192.168.1.3>
 <20180903102642.rmzawwqsqjvh2mkb@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903102642.rmzawwqsqjvh2mkb@kshutemo-mobl1>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 03 Sep 2018 14:52:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 03 Sep 2018 14:52:17 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/18 at 01:26pm, Kirill A. Shutemov wrote:
> On Mon, Sep 03, 2018 at 03:47:18PM +0800, Baoquan He wrote:
> > On 09/02/18 at 11:52pm, Kirill A. Shutemov wrote:
> > > On Thu, Aug 30, 2018 at 11:25:12PM +0800, Baoquan He wrote:
> > > > Hi Kirill,
> > > > 
> > > > I made a new version according to your suggestion, just a little
> > > > different, I didn't make 1TB as default, just calculate with the actual
> > > > size, then align up to 1TB boundary.  Just found kcore is printing more
> > > > entries than before, I thought it's caused by my code, later got it was
> > > > touchde by other people.
> > > > 
> > > > Any comment about this? I can change accordingly.
> > > 
> > > Looks good to me.
> > > 
> > > But there's corner case when struct page is unreasonably large and
> > > vmemmap_size will be way to large. We probably have to report an error if
> > > we cannot fit vmemmap properly into virtual memory layout.
> > 
> > Hmm, sizeof(struct page) can't exceed one whole page surely, otherwise
> > system bootup can't go over vmemmap initlization. Except of this, we may
> > need think about the virtual memory layout which vmemmap can be allowed
> > to occupy.
> > 
> > If KASAN enabled, KASLR disabled,
> > 4-level 1TB + 1TB hole (2TB)
> > 5-level 512TB + 2034TB hole (2.5PB)
> > 
> > If KASAN disabled, KASLR enabled,
> > 4-level 1TB + 1TB hole + 16TB  (18TB)
> > 5-level 512TB + 2034TB hole + 8PB (10.5PB)
> > 
> > So, as you can see, if add check in memory KASLR code, we should only
> > consider KASLR enabled case. We possibly don't need to worry about
> > 5-level case since the size 10.5PB is even bigger than the maximum
> > physical RAM mapping size. For 4-level, 18TB align to multiples of 2, it
> > will be 32 times of the current 1TB, then we usually assume 64 as the
> > default value of sizeof(struct page), then 64*32 == 1024. So we can add
> > check like this, what do you think? Or any other idea?
> 
> Looks reasonable to me.
> 
> But I would have the BUILD_BUG_ON() in generic code. If you struct page is
> more than 1/4 of PAGE_SIZE something is horribly broken.

Just the 1/4 of PAGE_SIZE is based on analysis of KASLR case. If
non-KASLR case, it may not be that value. Not sure if it's OK to put it
in generic code, and haven't thought of a good place, maybe in
setup_arch(), just at the beginning?

> 
> > diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> > index 1db8e166455e..776ec759a87c 100644
> > --- a/arch/x86/mm/kaslr.c
> > +++ b/arch/x86/mm/kaslr.c
> > @@ -90,6 +90,7 @@ void __init kernel_randomize_memory(void)
> >         BUILD_BUG_ON(vaddr_start >= vaddr_end);
> >         BUILD_BUG_ON(vaddr_end != CPU_ENTRY_AREA_BASE);
> >         BUILD_BUG_ON(vaddr_end > __START_KERNEL_map);
> > +       BUILD_BUG_ON(sizeof(struct page ) > PAGE_SIZE/4);
> 
> Nitpick: redundant space before ')'.
> 
> >  
> >         if (!kaslr_memory_enabled())
> >                 return;
> > 
> > 
> > For 5-level paging mode, we
> > may not need to worry about that. Since KASAN 
> > 
> > ***4-level***
> > ffffea0000000000 - ffffeaffffffffff (=40 bits) virtual memory map (1TB)
> > ... unused hole ...
> > ffffec0000000000 - fffffbffffffffff (=44 bits) kasan shadow memory (16TB)
> > ... unused hole ...
> > 
> > 
> > 
> > ***5-level***
> > ffd4000000000000 - ffd5ffffffffffff (=49 bits) virtual memory map (512TB)
> > ... unused hole ...
> > ffdf000000000000 - fffffc0000000000 (=53 bits) kasan shadow memory (8PB) 
> > 
> > > 
> > > -- 
> > >  Kirill A. Shutemov
> 
> -- 
>  Kirill A. Shutemov
