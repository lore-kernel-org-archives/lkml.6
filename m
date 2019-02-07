Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD98CC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6E321908
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfBGQ4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:56:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:36635 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfBGQ4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:56:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 08:56:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,344,1544515200"; 
   d="scan'208";a="113169778"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga007.jf.intel.com with ESMTP; 07 Feb 2019 08:56:00 -0800
Message-ID: <d28e5bc95cfc18ca8c97e28459692fdd967d52d3.camel@linux.intel.com>
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
        David Hildenbrand <david@redhat.com>
Date:   Thu, 07 Feb 2019 08:56:00 -0800
In-Reply-To: <e0bf61d2-c315-ae4f-6ddb-93b7882fd13f@redhat.com>
References: <20190204181118.12095.38300.stgit@localhost.localdomain>
         <e0bf61d2-c315-ae4f-6ddb-93b7882fd13f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-07 at 09:48 -0500, Nitesh Narayan Lal wrote:
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
> 
> Hi Alexander,
> 
> Did you get a chance to look at my v8 posting of Guest Free Page Hinting
> [1]?
> Considering both the solutions are trying to solve the same problem. It
> will be great if we can collaborate and come up with a unified solution.
> 
> [1] https://lkml.org/lkml/2019/2/4/993

I haven't had a chance to review these yet.

I'll try to take a look later today and provide review notes based on
what I find.

Thanks.

- Alex

