Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3F6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0401521924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404290AbfBOJFP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:05:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:23918 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfBOJFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:05:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 01:05:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,372,1544515200"; 
   d="scan'208";a="116435412"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga006.jf.intel.com with ESMTP; 15 Feb 2019 01:05:12 -0800
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 15 Feb 2019 01:05:12 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.207]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.109]) with mapi id 14.03.0415.000;
 Fri, 15 Feb 2019 17:05:10 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     'David Hildenbrand' <david@redhat.com>,
        'Nitesh Narayan Lal' <nitesh@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "lcapitulino@redhat.com" <lcapitulino@redhat.com>,
        "pagupta@redhat.com" <pagupta@redhat.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "dodgen@google.com" <dodgen@google.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
Subject: RE: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
Thread-Topic: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
Thread-Index: AQHUvMb57IQCd72gCkOm4okDUKYrcaXdemAg//+vEwCAAWxXYP///cqAgAHz/UA=
Date:   Fri, 15 Feb 2019 09:05:10 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73DF71F38@shsmsx102.ccr.corp.intel.com>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <286AC319A985734F985F78AFA26841F73DF6B56A@shsmsx102.ccr.corp.intel.com>
 <f9516222-793a-a169-c18a-728ca0256cd3@redhat.com>
 <286AC319A985734F985F78AFA26841F73DF6F0E3@shsmsx102.ccr.corp.intel.com>
 <bdd4298d-b84b-1ffb-0d9c-3ff5798da325@redhat.com>
In-Reply-To: <bdd4298d-b84b-1ffb-0d9c-3ff5798da325@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTZkMjU1YWQtZGU2Ny00OGVjLTllNjYtMDRhNGY0MDdhZGYwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZ2FEVlllUHZYOHRRVnZmbExCZXVySU5KTmtwOHpQNHNmYzFtZjgrRFR0UG54cXhHUXNnZzRrQVwvZWhETHVSckMifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 14, 2019 5:43 PM, David Hildenbrand wrote:
> Yes indeed, that is the important bit. They must not be put pack to the
> buddy before they have been processed by the hypervisor. But as the pages
> are not in the buddy, no one allocating a page will stumble over such a page
> and try to allocate it. Threads trying to allocate memory will simply pick
> another buddy page instead of "busy waiting" for that page to be finished
> reporting.

What if a guest thread try to allocate some pages but the buddy cannot satisfy
because all the pages are isolated? Would it be the same case that the guest thread
gets blocked by waiting all the isolated pages to get madvised by the host and
returned to the guest buddy, or even worse, some guest threads get killed due to oom?

Best,
Wei
