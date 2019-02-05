Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E1AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3404217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbfBESnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:43:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:33586 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfBESnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:43:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 10:43:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,336,1544515200"; 
   d="scan'208";a="136125414"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga001.jf.intel.com with ESMTP; 05 Feb 2019 10:43:20 -0800
Message-ID: <274c9e23cb0bf947d8dd033bd8a7c14252ba9b85.camel@linux.intel.com>
Subject: Re: [RFC PATCH 0/4] kvm: Report unused guest pages to host
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     rkrcmar@redhat.com, x86@kernel.org, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, pbonzini@redhat.com, tglx@linutronix.de,
        akpm@linux-foundation.org,
        Luiz Capitulino <lcapitulino@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Pankaj Gupta <pagupta@redhat.com>
Date:   Tue, 05 Feb 2019 10:43:20 -0800
In-Reply-To: <697d3769-9320-a632-749e-56de9474bdf0@redhat.com>
References: <20190204181118.12095.38300.stgit@localhost.localdomain>
         <697d3769-9320-a632-749e-56de9474bdf0@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-05 at 12:25 -0500, Nitesh Narayan Lal wrote:
> On 2/4/19 1:15 PM, Alexander Duyck wrote:
> > This patch set provides a mechanism by which guests can notify the host of
> > pages that are not currently in use. Using this data a KVM host can more
> > easily balance memory workloads between guests and improve overall system
> > performance by avoiding unnecessary writing of unused pages to swap.
> > 
> > In order to support this I have added a new hypercall to provided unused
> > page hints and made use of mechanisms currently used by PowerPC and s390
> > architectures to provide those hints. To reduce the overhead of this call
> > I am only using it per huge page instead of of doing a notification per 4K
> > page. By doing this we can avoid the expense of fragmenting higher order
> > pages, and reduce overall cost for the hypercall as it will only be
> > performed once per huge page.
> > 
> > Because we are limiting this to huge pages it was necessary to add a
> > secondary location where we make the call as the buddy allocator can merge
> > smaller pages into a higher order huge page.
> > 
> > This approach is not usable in all cases. Specifically, when KVM direct
> > device assignment is used, the memory for a guest is permanently assigned
> > to physical pages in order to support DMA from the assigned device. In
> > this case we cannot give the pages back, so the hypercall is disabled by
> > the host.
> > 
> > Another situation that can lead to issues is if the page were accessed
> > immediately after free. For example, if page poisoning is enabled the
> > guest will populate the page *after* freeing it. In this case it does not
> > make sense to provide a hint about the page being freed so we do not
> > perform the hypercalls from the guest if this functionality is enabled.
> > 
> > My testing up till now has consisted of setting up 4 8GB VMs on a system
> > with 32GB of memory and 4GB of swap. To stress the memory on the system I
> > would run "memhog 8G" sequentially on each of the guests and observe how
> > long it took to complete the run. The observed behavior is that on the
> > systems with these patches applied in both the guest and on the host I was
> > able to complete the test with a time of 5 to 7 seconds per guest. On a
> > system without these patches the time ranged from 7 to 49 seconds per
> > guest. I am assuming the variability is due to time being spent writing
> > pages out to disk in order to free up space for the guest.
> 
> Hi Alexander,
> 
> Can you share the host memory usage before and after your run. (In both
> the cases with your patch-set and without your patch-set)

Here are some snippets from the /proc/meminfo for the system both
before and after the test.

W/O patch
-- Before --
MemTotal:       32881396 kB
MemFree:        21363724 kB
MemAvailable:   25891228 kB
Buffers:            2276 kB
Cached:          4760280 kB
SwapCached:            0 kB
Active:          7166952 kB
Inactive:        1474980 kB
Active(anon):    3893308 kB
Inactive(anon):     8776 kB
Active(file):    3273644 kB
Inactive(file):  1466204 kB
Unevictable:       16756 kB
Mlocked:           16756 kB
SwapTotal:       4194300 kB
SwapFree:        4194300 kB
Dirty:             29812 kB
Writeback:             0 kB
AnonPages:       3896540 kB
Mapped:            75568 kB
Shmem:             10044 kB

-- After --
MemTotal:       32881396 kB
MemFree:          194668 kB
MemAvailable:      51356 kB
Buffers:              24 kB
Cached:           129036 kB
SwapCached:       224396 kB
Active:         27223304 kB
Inactive:        2589736 kB
Active(anon):   27220360 kB
Inactive(anon):  2481592 kB
Active(file):       2944 kB
Inactive(file):   108144 kB
Unevictable:       16756 kB
Mlocked:           16756 kB
SwapTotal:       4194300 kB
SwapFree:          35616 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:      29476628 kB
Mapped:            22820 kB
Shmem:              5516 kB

W/ patch
-- Before --
MemTotal:       32881396 kB
MemFree:        26618880 kB
MemAvailable:   27056004 kB
Buffers:            2276 kB
Cached:           781496 kB
SwapCached:            0 kB
Active:          3309056 kB
Inactive:         393796 kB
Active(anon):    2932728 kB
Inactive(anon):     8776 kB
Active(file):     376328 kB
Inactive(file):   385020 kB
Unevictable:       16756 kB
Mlocked:           16756 kB
SwapTotal:       4194300 kB
SwapFree:        4194300 kB
Dirty:                96 kB
Writeback:             0 kB
AnonPages:       2935964 kB
Mapped:            75428 kB
Shmem:             10048 kB

-- After --
MemTotal:       32881396 kB
MemFree:        22677904 kB
MemAvailable:   26543092 kB
Buffers:            2276 kB
Cached:          4205908 kB
SwapCached:            0 kB
Active:          3863016 kB
Inactive:        3768596 kB
Active(anon):    3437368 kB
Inactive(anon):     8772 kB
Active(file):     425648 kB
Inactive(file):  3759824 kB
Unevictable:       16756 kB
Mlocked:           16756 kB
SwapTotal:       4194300 kB
SwapFree:        4194300 kB
Dirty:           1336180 kB
Writeback:             0 kB
AnonPages:       3440528 kB
Mapped:            74992 kB
Shmem:             10044 kB

