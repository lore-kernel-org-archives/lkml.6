Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FA9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832BB2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391623AbfBRRys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:54:48 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39077 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391599AbfBRRys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:54:48 -0500
Received: by mail-qt1-f195.google.com with SMTP id o6so20131845qtk.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 09:54:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aXGuH4bMRZCS3o6PuHhYNqDZBHiaUBi+BpYM0XYa+lE=;
        b=aBNJ3Do+aa3zrgixCF0dTHZ12MlOXyQn+pIzMKrJHkIyrh+bo46ycVOl63u6WIorW6
         9+SMIOdcJFXLoxUJ0rQhc7wDXBbT1uNsEW3TvSDj2fDUyDImCY2sVAoKzKAa323zr7T7
         gf3nqZqa413WDN148NcGUNTDRJ7C+Vc5pW4Ui/hEQPG/CPzf6QNX4huZLugTNJjSKFZe
         HpJYfNnjVlFIDuvdUzfG5/3svGCt1FwMQnEoAY+8ZbBAgU+gYjxBK8y9algndZDXVzSa
         Mp7lV36SHUrh6y0q2YhPzYSMyPzzQx9v6Stm+BYaYjfee/URiNDCzCA2RtimrWrv1Kjh
         DnJQ==
X-Gm-Message-State: AHQUAuY5vhwgAALdNg9IGowDegs8RYQWvyZtRVbT6WQZvPnWdm42N3RA
        0wZiUSxlonBkROJ2SJkIiOPRJg==
X-Google-Smtp-Source: AHgI3IYaDRQ41iWAe0Cly/dc1gR5TdqnC/rpBZccRLE1hLdarLIE5hOiry6885J1oIBIe0owcz+q+w==
X-Received: by 2002:a0c:ecc5:: with SMTP id o5mr18566052qvq.106.1550512486825;
        Mon, 18 Feb 2019 09:54:46 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id s48sm8874192qts.47.2019.02.18.09.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 09:54:45 -0800 (PST)
Date:   Mon, 18 Feb 2019 12:54:43 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com,
        yang.zhang.wz@gmail.com, riel@surriel.com, dodgen@google.com,
        konrad.wilk@oracle.com, dhildenb@redhat.com, aarcange@redhat.com,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
Message-ID: <20190218122636-mutt-send-email-mst@kernel.org>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
 <20190218114601-mutt-send-email-mst@kernel.org>
 <44740a29-bb14-e6e6-2992-98d0ae58e994@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44740a29-bb14-e6e6-2992-98d0ae58e994@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 05:59:06PM +0100, David Hildenbrand wrote:
> On 18.02.19 17:49, Michael S. Tsirkin wrote:
> > On Sat, Feb 16, 2019 at 10:40:15AM +0100, David Hildenbrand wrote:
> >> It would be worth a try. My feeling is that a synchronous report after
> >> e.g. 512 frees should be acceptable, as it seems to be acceptable on
> >> s390x. (basically always enabled, nobody complains).
> > 
> > What slips under the radar on an arch like s390 might
> > raise issues for a popular arch like x86. My fear would be
> > if it's only a problem e.g. for realtime. Then you get
> > a condition that's very hard to trigger and affects
> > worst case latencies.
> 
> Realtime should never use free page hinting.

OK maybe document this in commit log. RT project has
enough work as it is without need to untangle
complex dependencies with other features.

> Just like it should never
> use ballooning.

Well its an aside but why not ballooning? As long as hypervisor does not touch the balloon,
and you don't touch the (weird, not really documented properly)
deflate on oom, you are fine.
Real time is violated when you reconfigure balloon,
but  after you are done guest is real time again.
And management certainly knows it that it did something
with balloon at the exact same time there was a latency spike.


I think this might not work well right now, but generally
I think it should be fine. No?


> Just like it should pin all pages in the hypervisor.

BTW all this is absolutely interesting to fix.
But I agree wrt hinting being kind of like pinning.


> > 
> > But really what business has something that is supposedly
> > an optimization blocking a VCPU? We are just freeing up
> > lots of memory why is it a good idea to slow that
> > process down?
> 
> I first want to know that it is a problem before we declare it a
> problem. I provided an example (s390x) where it does not seem to be a
> problem. One hypercall ~every 512 frees. As simple as it can get.
> 
> No trying to deny that it could be a problem on x86, but then I assume
> it is only a problem in specific setups.

But which setups? How are we going to identify them?

> I would much rather prefer a simple solution that can eventually be
> disabled in selected setup than a complicated solution that tries to fit
> all possible setups.

Well I am not sure just disabling it is reasonable.  E.g. Alex shows
drastic boot time speedups.  You won't be able to come to people later
and say oh you need to disable this feature yes you will stop getting
packet loss once in a while but you also won't be able to boot your VMs
quickly enough.

So I'm fine with a simple implementation but the interface needs to
allow the hypervisor to process hints in parallel while guest is
running.  We can then fix any issues on hypervisor without breaking
guests.


> Realtime is one of the examples where such stuff is
> to be disabled either way.

OK so we have identified realtime. Nice even though it wasn't documented
anywhere. Are there other workloads? What are they?


> Optimization of space comes with a price (here: execution time).

I am not sure I agree. If hinting patches just slowed everyone down they
would be useless. Note how Alex show-cased this by demonstrating
faster boot times.

Unlike regular ballooning, this doesn't do much to optimize space. There
are no promises so host must still have enough swap to fit guest memory
anyway.

All free page hinting does is reduce IO on the hypervisor.

So it's a tradeoff.

> -- 
> 
> Thanks,
> 
> David / dhildenb
