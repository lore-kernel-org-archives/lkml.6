Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2B3C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DEF279F2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DEF279F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936779AbeF2PxQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:53:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:53660 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935979AbeF2PxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:53:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 08:53:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="241735377"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jun 2018 08:52:42 -0700
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 29 Jun 2018 08:52:42 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 29 Jun 2018 08:52:42 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.223]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.51]) with mapi id 14.03.0319.002;
 Fri, 29 Jun 2018 23:52:40 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>
CC:     "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "quan.xu0@gmail.com" <quan.xu0@gmail.com>,
        "nilal@redhat.com" <nilal@redhat.com>,
        "riel@redhat.com" <riel@redhat.com>,
        "peterx@redhat.com" <peterx@redhat.com>
Subject: RE: [PATCH v34 0/4] Virtio-balloon: support free page reporting
Thread-Topic: [PATCH v34 0/4] Virtio-balloon: support free page reporting
Thread-Index: AQHUDIBXCAcukqzfc0qkpOxZ4k7fNaRzbrIAgANh7QCAAIzrsA==
Date:   Fri, 29 Jun 2018 15:52:40 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7396C251E@shsmsx102.ccr.corp.intel.com>
References: <1529928312-30500-1-git-send-email-wei.w.wang@intel.com>
 <c4dd0a13-91fb-c0f5-b41f-54421fdacca9@redhat.com>
 <20180629172216-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180629172216-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2RhYzA5MDItZGM0Zi00NWMwLTk3MWMtMTA2NjE1ZDg4ODkyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUzRrbEw3cklzeXZlUWFVclwvVUJtUjNVOGFGUWpLSXZCTEV4UkppVUhycXZ1ZzlHVG1XeFpEZzh1TjhYVlIwdjIifQ==
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

On Friday, June 29, 2018 10:46 PM, Michael S. Tsirkin wrote:
> To: David Hildenbrand <david@redhat.com>
> Cc: Wang, Wei W <wei.w.wang@intel.com>; virtio-dev@lists.oasis-open.org;
> linux-kernel@vger.kernel.org; virtualization@lists.linux-foundation.org;
> kvm@vger.kernel.org; linux-mm@kvack.org; mhocko@kernel.org;
> akpm@linux-foundation.org; torvalds@linux-foundation.org;
> pbonzini@redhat.com; liliang.opensource@gmail.com;
> yang.zhang.wz@gmail.com; quan.xu0@gmail.com; nilal@redhat.com;
> riel@redhat.com; peterx@redhat.com
> Subject: Re: [PATCH v34 0/4] Virtio-balloon: support free page reporting
> 
> On Wed, Jun 27, 2018 at 01:06:32PM +0200, David Hildenbrand wrote:
> > On 25.06.2018 14:05, Wei Wang wrote:
> > > This patch series is separated from the previous "Virtio-balloon
> > > Enhancement" series. The new feature,
> > > VIRTIO_BALLOON_F_FREE_PAGE_HINT, implemented by this series
> enables
> > > the virtio-balloon driver to report hints of guest free pages to the
> > > host. It can be used to accelerate live migration of VMs. Here is an
> introduction of this usage:
> > >
> > > Live migration needs to transfer the VM's memory from the source
> > > machine to the destination round by round. For the 1st round, all
> > > the VM's memory is transferred. From the 2nd round, only the pieces
> > > of memory that were written by the guest (after the 1st round) are
> > > transferred. One method that is popularly used by the hypervisor to
> > > track which part of memory is written is to write-protect all the guest
> memory.
> > >
> > > This feature enables the optimization by skipping the transfer of
> > > guest free pages during VM live migration. It is not concerned that
> > > the memory pages are used after they are given to the hypervisor as
> > > a hint of the free pages, because they will be tracked by the
> > > hypervisor and transferred in the subsequent round if they are used and
> written.
> > >
> > > * Tests
> > > - Test Environment
> > >     Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
> > >     Guest: 8G RAM, 4 vCPU
> > >     Migration setup: migrate_set_speed 100G, migrate_set_downtime 2
> > > second
> > >
> > > - Test Results
> > >     - Idle Guest Live Migration Time (results are averaged over 10 runs):
> > >         - Optimization v.s. Legacy = 284ms vs 1757ms --> ~84% reduction
> > >     - Guest with Linux Compilation Workload (make bzImage -j4):
> > >         - Live Migration Time (average)
> > >           Optimization v.s. Legacy = 1402ms v.s. 2528ms --> ~44% reduction
> > >         - Linux Compilation Time
> > >           Optimization v.s. Legacy = 5min6s v.s. 5min12s
> > >           --> no obvious difference
> > >
> >
> > Being in version 34 already, this whole thing still looks and feels
> > like a big hack to me. It might just be me, but especially if I read
> > about assumptions like "QEMU will not hotplug memory during
> > migration". This does not feel like a clean solution.
> >
> > I am still not sure if we really need this interface, especially as
> > real free page hinting might be on its way.
> >
> > a) we perform free page hinting by setting all free pages
> > (arch_free_page()) to zero. Migration will detect zero pages and
> > minimize #pages to migrate. I don't think this is a good idea but
> > Michel suggested to do a performance evaluation and Nitesh is looking
> > into that right now.
> 
> Yes this test is needed I think. If we can get most of the benefit without PV
> interfaces, that's nice.
> 
> Wei, I think you need this as part of your performance comparison
> too: set page poisoning value to 0 and enable KSM, compare with your
> patches.

Do you mean live migration with zero pages?
I can first share the amount of memory transferred during live migration I saw,
Legacy is around 380MB,
Optimization is around 340MB.
This proves that most pages have already been 0 and skipped during the legacy live migration. But the legacy time is still much larger because zero page checking is costly. 
(It's late night here, I can get you that with my server probably tomorrow)

Best,
Wei





