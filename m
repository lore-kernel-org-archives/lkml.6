Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30D6C6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 02:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D4D20895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 02:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D4D20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJMJ4k convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 05:56:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:19530 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbeJMJ4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 05:56:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 19:21:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,375,1534834800"; 
   d="scan'208";a="240965784"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga004.jf.intel.com with ESMTP; 12 Oct 2018 19:21:22 -0700
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 12 Oct 2018 19:21:22 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX155.amr.corp.intel.com (10.18.116.71) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 12 Oct 2018 19:21:21 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.217]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.245]) with mapi id 14.03.0319.002;
 Sat, 13 Oct 2018 10:21:20 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Xu, Like" <like.xu@intel.com>
Subject: RE: [PATCH v1] KVM/x86/vPMU: Guest PMI Optimization
Thread-Topic: [PATCH v1] KVM/x86/vPMU: Guest PMI Optimization
Thread-Index: AQHUYivyWC/BxHaJqkyOpiAgxus7L6UbR3QAgAElx5A=
Date:   Sat, 13 Oct 2018 02:21:19 +0000
Message-ID: <286AC319A985734F985F78AFA26841F739848A07@shsmsx102.ccr.corp.intel.com>
References: <1539346817-8638-1-git-send-email-wei.w.wang@intel.com>
 <20181012163058.GN32651@tassilo.jf.intel.com>
In-Reply-To: <20181012163058.GN32651@tassilo.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGQyYWFiMTMtYjkxNy00ZDkyLWIyZTItMTZiYWY3OTBiYzUxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZ0VOT1pcL0JnNVg5bFpCUEVFWlVKM3NEXC96Qm1PREFKYWJRaGFoSldwWW9pNExocE1EM1VLMHJ0ZGtlWXBhNnBmIn0=
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

On Saturday, October 13, 2018 12:31 AM, Andi Kleen wrote:
> > 4. Results
> >     - Without this optimization, the guest pmi handling time is
> >       ~4500000 ns, and the max sampling rate is reduced to 250.
> >     - With this optimization, the guest pmi handling time is ~9000 ns
> >       (i.e. 1 / 500 of the non-optimization case), and the max sampling
> >       rate remains at the original 100000.
> 
> Impressive performance improvement!
> 
> It's not clear to me why you're special casing PMIs here. The optimization
> should work generically, right?


Yes, seems doable. I plan to try some lazy approach for the perf event allocation. 

> Is that guaranteed to be always called on the right CPU that will run the vcpu?
> 
> AFAIK there's an ioctl to set MSRs in the guest from qemu, I'm pretty sure it
> won't handle that.
 

Thanks, will consider that case.

Best,
Wei
