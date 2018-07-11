Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96C7C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86888208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86888208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388299AbeGKOA3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:00:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:41672 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387708AbeGKOA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:00:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 06:56:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,338,1526367600"; 
   d="scan'208";a="215154780"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga004.jf.intel.com with ESMTP; 11 Jul 2018 06:55:18 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 11 Jul 2018 06:55:17 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.57]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.173]) with mapi id 14.03.0319.002;
 Wed, 11 Jul 2018 21:55:15 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "quan.xu0@gmail.com" <quan.xu0@gmail.com>,
        "nilal@redhat.com" <nilal@redhat.com>,
        Rik van Riel <riel@redhat.com>,
        "peterx@redhat.com" <peterx@redhat.com>
Subject: RE: [PATCH v35 1/5] mm: support to get hints of free page blocks
Thread-Topic: [PATCH v35 1/5] mm: support to get hints of free page blocks
Thread-Index: AQHUGDRRNGdK3F5na0yhzVOAicw6EaSIMZwAgAELAwD//35MAIAAf8QAgACfgYD//36ogIAApDlw
Date:   Wed, 11 Jul 2018 13:55:15 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7396EEFD8@SHSMSX101.ccr.corp.intel.com>
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com>
 <1531215067-35472-2-git-send-email-wei.w.wang@intel.com>
 <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
 <5B455D50.90902@intel.com>
 <CA+55aFzqj8wxXnHAdUTiOomipgFONVbqKMjL_tfk7e5ar1FziQ@mail.gmail.com>
 <20180711092152.GE20050@dhcp22.suse.cz> <5B45E17D.2090205@intel.com>
 <20180711110949.GJ20050@dhcp22.suse.cz>
In-Reply-To: <20180711110949.GJ20050@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDQ1YzUyZmQtMTIzYy00N2IyLTlhYzUtM2VlZjJkNWZjMWE2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicytjMm5ZZ1BjRmc2b1k2MUtveHhYNURMc3J6QjhqRjM5SXAxT2Vnc3N3U3hNRVNLYkNJWlhMMG1MMlVGNWRuTSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 11, 2018 7:10 PM, Michal Hocko wrote:
> On Wed 11-07-18 18:52:45, Wei Wang wrote:
> > On 07/11/2018 05:21 PM, Michal Hocko wrote:
> > > On Tue 10-07-18 18:44:34, Linus Torvalds wrote:
> > > [...]
> > > > That was what I tried to encourage with actually removing the
> > > > pages form the page list. That would be an _incremental_
> > > > interface. You can remove MAX_ORDER-1 pages one by one (or a
> > > > hundred at a time), and mark them free for ballooning that way.
> > > > And if you still feel you have tons of free memory, just continue
> removing more pages from the free list.
> > > We already have an interface for that. alloc_pages(GFP_NOWAIT,
> MAX_ORDER -1).
> > > So why do we need any array based interface?
> >
> > Yes, I'm trying to get free pages directly via alloc_pages, so there
> > will be no new mm APIs.
> 
> OK. The above was just a rough example. In fact you would need a more
> complex gfp mask. I assume you only want to balloon only memory directly
> usable by the kernel so it will be
> 	(GFP_KERNEL | __GFP_NOWARN) & ~__GFP_RECLAIM

Sounds good to me, thanks.

> 
> > I plan to let free page allocation stop when the remaining system free
> > memory becomes close to min_free_kbytes (prevent swapping).
> 
> ~__GFP_RECLAIM will make sure you are allocate as long as there is any
> memory without reclaim. It will not even poke the kswapd to do the
> background work. So I do not think you would need much more than that.

"close to min_free_kbytes" - I meant when doing the allocations, we intentionally reserve some small amount of memory, e.g. 2 free page blocks of "MAX_ORDER - 1". So when other applications happen to do some allocation, they may easily get some from the reserved memory left on the free list. Without that reserved memory, other allocation may cause the system free memory below the WMARK[MIN], and kswapd would start to do swapping. This is actually just a small optimization to reduce the probability of causing swapping (nice to have, but not mandatary because we will allocate free page blocks one by one).

 > But let me note that I am not really convinced how this (or previous)
> approach will really work in most workloads. We tend to cache heavily so
> there is rarely any memory free.

With less free memory, the improvement becomes less, but should be nicer than no optimization. For example, the Linux build workload would cause 4~5 GB (out of 8GB) memory to be used as page cache at the final stage, there is still ~44% live migration time reduction.

Since we have many cloud customers interested in this feature, I think we can let them test the usefulness.

Best,
Wei
