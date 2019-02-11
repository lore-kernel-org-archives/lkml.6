Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB12C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A542184E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfBKWkM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:40:12 -0500
Received: from mga17.intel.com ([192.55.52.151]:38976 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbfBKWkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:40:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 14:40:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,360,1544515200"; 
   d="scan'208";a="123707844"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga008.fm.intel.com with ESMTP; 11 Feb 2019 14:40:08 -0800
Received: from fmsmsx116.amr.corp.intel.com (10.18.116.20) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 11 Feb 2019 14:40:08 -0800
Received: from crsmsx151.amr.corp.intel.com (172.18.7.86) by
 fmsmsx116.amr.corp.intel.com (10.18.116.20) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 11 Feb 2019 14:40:06 -0800
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.57]) by
 CRSMSX151.amr.corp.intel.com ([169.254.3.79]) with mapi id 14.03.0415.000;
 Mon, 11 Feb 2019 16:40:03 -0600
From:   "Weiny, Ira" <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH 0/3] Add gup fast + longterm and use it in HFI1
Thread-Topic: [PATCH 0/3] Add gup fast + longterm and use it in HFI1
Thread-Index: AQHUwkbGJiw3VF3kpESe1yhfT7MilqXbcliAgAADmgD//4l5gIAAkQ8A//+b9cA=
Date:   Mon, 11 Feb 2019 22:40:02 +0000
Message-ID: <2807E5FD2F6FDA4886F6618EAC48510E79BCF37B@CRSMSX101.amr.corp.intel.com>
References: <20190211201643.7599-1-ira.weiny@intel.com>
 <20190211203417.a2c2kbmjai43flyz@linux-r8p5>
 <20190211204710.GE24692@ziepe.ca>
 <20190211214257.GA7891@iweiny-DESK2.sc.intel.com>
 <20190211222208.GJ24692@ziepe.ca>
In-Reply-To: <20190211222208.GJ24692@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGMyMmNiMGEtNzUwMC00NDMxLWE1ZmMtNWMwYjg2ZmU5ZDRlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiT2hFSXpPU0p0Mlg2VVJBcFR2RStXWkpkNTRTck9rOXAzR3pXUUF0MytVcXQ2c2VMa28wc2huVkI0ODJEN3lBNiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Feb 11, 2019 at 01:42:57PM -0800, Ira Weiny wrote:
> > On Mon, Feb 11, 2019 at 01:47:10PM -0700, Jason Gunthorpe wrote:
> > > On Mon, Feb 11, 2019 at 12:34:17PM -0800, Davidlohr Bueso wrote:
> > > > On Mon, 11 Feb 2019, ira.weiny@intel.com wrote:
> > > > > Ira Weiny (3):
> > > > >  mm/gup: Change "write" parameter to flags
> > > > >  mm/gup: Introduce get_user_pages_fast_longterm()
> > > > >  IB/HFI1: Use new get_user_pages_fast_longterm()
> > > >
> > > > Out of curiosity, are you planning on having all rdma drivers use
> > > > get_user_pages_fast_longterm()? Ie:
> > > >
> > > > hw/mthca/mthca_memfree.c:       ret = get_user_pages_fast(uaddr &
> PAGE_MASK, 1, FOLL_WRITE, pages);
> > >
> > > This one is certainly a mistake - this should be done with a umem.
> >
> > It looks like this is mapping a page allocated by user space for a
> > doorbell?!?!
> 
> Many drivers do this, the 'doorbell' is a PCI -> CPU thing of some sort

My surprise is why does _userspace_ allocate this memory?

> 
> > This does not seem to be allocating memory regions.  Jason, do you
> > want a patch to just convert these calls and consider it legacy code?
> 
> It needs to use umem like all the other drivers on this path.
> Otherwise it doesn't get the page pinning logic right

Not sure what you mean regarding the pinning logic?

> 
> There is also something else rotten with these longterm callsites, they seem
> to have very different ideas how to handle RLIMIT_MEMLOCK.
> 
> ie vfio doesn't even touch pinned_vm.. and rdma is applying
> RLIMIT_MEMLOCK to mm->pinned_vm, while vfio is using locked_vm.. No
> idea which is right, but they should be the same, and this pattern should
> probably be in core code someplace.

Neither do I.  But AFAIK pinned_vm is a subset of locked_vm.

So should we be accounting both of the counters?

Ira

