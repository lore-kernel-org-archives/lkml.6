Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE42C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D620F20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="NuslozsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D620F20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeJWO6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 10:58:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41248 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbeJWO6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 10:58:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id a19-v6so174306pfo.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 23:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/I5cGrR9mN8LsHujIU97A4+05IB3e9WQX2po7+/U/L8=;
        b=NuslozsCtSK4VrjyQQStd8wNnQa3TIejods649nXa8QnUQ6dR6/3ETgRHM4Ld5M3gS
         pBu2NJDpkbPBw27UlEC+tt00SSnkqTu5y6U6iVIL0SiaV0cKt6Bz8I3prjYRkYMILYKT
         dBkCMHe480VKACzSvdZpbaVd2u1EuQjVqety8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/I5cGrR9mN8LsHujIU97A4+05IB3e9WQX2po7+/U/L8=;
        b=BwSRfr7zkbCWz/MIxjFLLxWVK7REmYCG0twZYcT9W7KmC0t9kLlXslzyr6GBIFp9n4
         wIfDNxSV2ziH/Cdj13+sDHyNcvbZdlrVraGZ70i+ph1/rZSfC5c+wJG4hhZ6b/An/rfD
         OzgkRUhbKCXpeu4vXTEd8w2xUeAWApPOpDrXMmDqtuBzKvRpcaS9HOV7mRmd5mt7VA9I
         XFBZ2R31tQI0CxnK7N/i7VCQ7aSaL02z6F3idxFC9vCHeXxNis1pilrg3cwWjmbb6JbP
         cueC4m0MNL5LRO0+mC36mb7nNQJkVhfg4RY1A/ZZQhzbKf6TbuKBFIOJLp8yXHlaaKvJ
         034Q==
X-Gm-Message-State: ABuFfojazl9JwkEYs5VddTC2F4HGZcVN4g16fFFUDAmWs5Z4M0XSFbUh
        yZHe6Upr15KofUrYgzqA2ugbhQ==
X-Google-Smtp-Source: ACcGV61qT85ehVOjGTvVe2SVsS/z2hWOtoz74me/j3pOa0MCU4bXossP2f4PK10761FOgEm7aXwu6A==
X-Received: by 2002:a63:ff46:: with SMTP id s6-v6mr45623644pgk.241.1540276610632;
        Mon, 22 Oct 2018 23:36:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id g123-v6sm1528542pfc.67.2018.10.22.23.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 23:36:49 -0700 (PDT)
Date:   Mon, 22 Oct 2018 23:36:48 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 0/2] improve vmalloc allocation
Message-ID: <20181023063648.GB22110@joelaf.mtv.corp.google.com>
References: <20181019173538.590-1-urezki@gmail.com>
 <20181020001145.GA243578@joelaf.mtv.corp.google.com>
 <20181022145006.ga2n3hjtkc2pqhub@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022145006.ga2n3hjtkc2pqhub@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 04:50:06PM +0200, Uladzislau Rezki wrote:
> On Fri, Oct 19, 2018 at 05:11:45PM -0700, Joel Fernandes wrote:
> > On Fri, Oct 19, 2018 at 07:35:36PM +0200, Uladzislau Rezki (Sony) wrote:
> > > Objective
> > > ---------
> > > Initiative of improving vmalloc allocator comes from getting many issues
> > > related to allocation time, i.e. sometimes it is terribly slow. As a result
> > > many workloads which are sensitive for long (more than 1 millisecond) preemption
> > > off scenario are affected by that slowness(test cases like UI or audio, etc.).
> > > 
> > > The problem is that, currently an allocation of the new VA area is done over
> > > busy list iteration until a suitable hole is found between two busy areas.
> > > Therefore each new allocation causes the list being grown. Due to long list
> > > and different permissive parameters an allocation can take a long time on
> > > embedded devices(milliseconds).
> > 
> > I am not super familiar with the vmap allocation code, it has been some
> > years. But I have 2 comments:
> > 
> > (1) It seems the issue you are reporting is the walking of the list in
> > alloc_vmap_area().
> > 
> > Can we not solve this by just simplifying the following code?
> > 
> > 	/* from the starting point, walk areas until a suitable hole is found
> > 	 */
> > 	while (addr + size > first->va_start && addr + size <= vend) {
> > 		if (addr + cached_hole_size < first->va_start)
> > 			cached_hole_size = first->va_start - addr;
> > 		addr = ALIGN(first->va_end, align);
> > 		if (addr + size < addr)
> > 			goto overflow;
> > 
> > 		if (list_is_last(&first->list, &vmap_area_list))
> > 			goto found;
> > 
> > 		first = list_next_entry(first, list);
> > 	}
> > 
> > Instead of going through the vmap_area_list, can we not just binary search
> > the existing address-sorted vmap_area_root rbtree to find a hole? If yes,
> > that would bring down the linear search overhead. If not, why not?
> >
> vmap_area_root rb-tree is used for fast access to vmap_area knowing
> the address(any va_start). That is why we use the tree. To use that tree
> in order to check holes will require to start from the left most node or
> specified "vstart" and move forward by rb_next(). What is much slower
> than regular(list_next_entry O(1)) access in this case. 

Ah, sorry. Don't know what I was thinking, you are right.  By the way the
binder driver does something similar too for buffer allocations, maintains an
rb tree of free areas:
https://github.com/torvalds/linux/blob/master/drivers/android/binder_alloc.c#L415

> > (2) I am curious, do you have any measurements of how much time
> > alloc_vmap_area() is taking? You mentioned it takes milliseconds but I was
> > wondering if you had more finer grained function profiling measurements. And
> > also any data on how big are the lists at the time you see this issue.
> > 
> Basically it depends on how much or heavily your system uses vmalloc
> allocations. I was using CONFIG_DEBUG_PREEMPT with an extra patch. See it
> here: ftp://vps418301.ovh.net/incoming/0001-tracing-track-preemption-disable-callers.patch
> 
> As for list size. It can be easily thousands.

Understood. I will go through your patches more in the coming days, thanks!

 - Joel

