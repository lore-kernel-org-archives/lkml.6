Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD7AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248E221773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfBSCqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:46:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48238 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfBSCqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 21:46:19 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB8392D7E9;
        Tue, 19 Feb 2019 02:46:18 +0000 (UTC)
Received: from sky.random (ovpn-120-13.rdu2.redhat.com [10.10.120.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5E0E60C66;
        Tue, 19 Feb 2019 02:46:12 +0000 (UTC)
Date:   Mon, 18 Feb 2019 21:46:11 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
Message-ID: <20190219024611.GC24502@redhat.com>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
 <20190218114601-mutt-send-email-mst@kernel.org>
 <44740a29-bb14-e6e6-2992-98d0ae58e994@redhat.com>
 <CAKgT0UcHv0S1-ZUpAZ9w=GTLRtG8=-cuoT3fa4Ej2A==aky5dg@mail.gmail.com>
 <a3b64b60-a745-0ac1-574d-e5904c1bf161@redhat.com>
 <CAKgT0Ue=A16PhUzqziBBzMXdZ_C1H74-qCttwb8iD6tGCxfp6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Ue=A16PhUzqziBBzMXdZ_C1H74-qCttwb8iD6tGCxfp6g@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 19 Feb 2019 02:46:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Feb 18, 2019 at 03:47:22PM -0800, Alexander Duyck wrote:
> essentially fragmented them. I guess hugepaged went through and
> started trying to reassemble the huge pages and as a result there have
> been apps that ended up consuming more memory than they would have
> otherwise since they were using fragments of THP pages after doing an
> MADV_DONTNEED on sections of the page.

With relatively recent kernels MADV_DONTNEED doesn't necessarily free
anything when it's applied to a THP subpage, it only splits the
pagetables and queues the THP for deferred splitting. If there's
memory pressure a shrinker will be invoked and the queue is scanned
and the THPs are physically splitted, but to be reassembled/collapsed
after a physical split it requires at least one young pte.

If this is particularly problematic for page hinting, this behavior
where the MADV_DONTNEED can be undoed by khugepaged (if some subpage is
being frequently accessed), can be turned off by setting
/sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none to
0. Then the THP will only be collapsed if all 512 subpages are mapped
(i.e. they've all be re-allocated by the guest).

Regardless of the max_ptes_none default, keeping the smaller guest
buddy orders as the last target for page hinting should be good for
performance.

> Yeah, no problem. The only thing I don't like about MADV_FREE is that
> you have to have memory pressure before the pages really start getting
> scrubbed with is both a benefit and a drawback. Basically it defers
> the freeing until you are under actual memory pressure so when you hit
> that case things start feeling much slower, that and it limits your
> allocations since the kernel doesn't recognize the pages as free until
> it would have to start trying to push memory to swap.

The guest allocation behavior should not be influenced by MADV_FREE vs
MADV_DONTNEED, the guest can't see the difference anyway, so why
should it limit the allocations?

The benefit of MADV_FREE should be that when the same guest frees and
reallocates an huge amount of RAM (i.e. guest app allocating and
freeing lots of RAM in a loop, not so uncommon), there will be no KVM
page fault during guest re-allocations. So in absence of memory
pressure in the host it should be a major win. Overall it sounds like
a good tradeoff compared to MADV_DONTNEED that forcefully invokes MMU
notifiers and forces host allocations and KVM page faults in order to
reallocate the same RAM in the same guest.

When there's memory pressure it's up to the host Linux VM to notice
there's plenty of MADV_FREE material to free at zero I/O cost before
starting swapping.

Thanks,
Andrea
