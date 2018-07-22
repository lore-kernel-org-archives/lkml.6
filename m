Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EDAC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 11:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6662220875
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 11:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6662220875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeGVMIX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 08:08:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:38661 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbeGVMIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 08:08:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2018 04:12:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,389,1526367600"; 
   d="scan'208";a="56251370"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jul 2018 04:12:02 -0700
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 22 Jul 2018 04:12:02 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 22 Jul 2018 04:12:02 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.57]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.100]) with mapi id 14.03.0319.002;
 Sun, 22 Jul 2018 19:12:00 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
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
Subject: RE: [PATCH v36 0/5] Virtio-balloon: support free page reporting
Thread-Topic: [PATCH v36 0/5] Virtio-balloon: support free page reporting
Thread-Index: AQHUIAglrybJe3xqWk2ztdP0qZFBfKSXipcAgAOOGxA=
Date:   Sun, 22 Jul 2018 11:11:59 +0000
Message-ID: <286AC319A985734F985F78AFA26841F739702695@SHSMSX101.ccr.corp.intel.com>
References: <1532075585-39067-1-git-send-email-wei.w.wang@intel.com>
 <20180720154922-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180720154922-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2Y0ZjQ0OWUtMGE0OS00MjZlLWFjZjEtOTBkZWVhN2JhOGJmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVkNXSHlldVhIeHJ2K2VyZkpVU3d4QURWQkRDMUMyTm5XcE94ZXBpZXJ4ZGZhZGh3ZWJZSkZRY1FvZG91WFljUyJ9
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

On Friday, July 20, 2018 8:52 PM, Michael S. Tsirkin wrote:
> On Fri, Jul 20, 2018 at 04:33:00PM +0800, Wei Wang wrote:
> > This patch series is separated from the previous "Virtio-balloon
> > Enhancement" series. The new feature,
> VIRTIO_BALLOON_F_FREE_PAGE_HINT,
> > implemented by this series enables the virtio-balloon driver to report
> > hints of guest free pages to the host. It can be used to accelerate
> > live migration of VMs. Here is an introduction of this usage:
> >
> > Live migration needs to transfer the VM's memory from the source
> > machine to the destination round by round. For the 1st round, all the
> > VM's memory is transferred. From the 2nd round, only the pieces of
> > memory that were written by the guest (after the 1st round) are
> > transferred. One method that is popularly used by the hypervisor to
> > track which part of memory is written is to write-protect all the guest
> memory.
> >
> > This feature enables the optimization by skipping the transfer of
> > guest free pages during VM live migration. It is not concerned that
> > the memory pages are used after they are given to the hypervisor as a
> > hint of the free pages, because they will be tracked by the hypervisor
> > and transferred in the subsequent round if they are used and written.
> >
> > * Tests
> > - Test Environment
> >     Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
> >     Guest: 8G RAM, 4 vCPU
> >     Migration setup: migrate_set_speed 100G, migrate_set_downtime 2
> > second
> 
> Can we split out patches 1 and 2? They seem appropriate for this release ...

Sounds good to me. I'm not sure if there would be comments on the first 2 patches. If no, can you just take them here? Or you need me to repost them separately?

Best,
Wei
