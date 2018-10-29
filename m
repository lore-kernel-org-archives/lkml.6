Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B42C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679582080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679582080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbeJ3DW2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:22:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:49726 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbeJ3DW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:22:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 11:32:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,441,1534834800"; 
   d="scan'208";a="81863268"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga007.fm.intel.com with ESMTP; 29 Oct 2018 11:32:36 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.128]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.237]) with mapi id 14.03.0415.000;
 Mon, 29 Oct 2018 11:32:36 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Ingo Molnar" <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: RE: [PATCH V2 1/2] x86/efi: Unmap EFI boot services code/data
 regions from efi_pgd
Thread-Topic: [PATCH V2 1/2] x86/efi: Unmap EFI boot services code/data
 regions from efi_pgd
Thread-Index: AQHUbXSDlG5yxQFZuUKIGr9tlrL5CKU27+KAgAACRID//5GH4IAAfEuAgAACJgD//4v9QA==
Date:   Mon, 29 Oct 2018 18:32:36 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485E5588@ORSMSX114.amr.corp.intel.com>
References: <20181026213845.28166-1-sai.praneeth.prakhya@intel.com>
 <20181026213845.28166-2-sai.praneeth.prakhya@intel.com>
 <alpine.DEB.2.21.1810291809490.5984@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1810291820250.5984@nanos.tec.linutronix.de>
 <FFF73D592F13FD46B8700F0A279B802F485E5549@ORSMSX114.amr.corp.intel.com>
 <alpine.DEB.2.21.1810291907320.5984@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1810291911570.5984@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1810291911570.5984@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDdmYTEyNjUtMjExZi00YmI3LWFmNWYtMzJhMjM1NGVmOGFjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiV3JZVXozQ3ZvdXY3VzFMZGdEMWVsM0ljZnJDOHRaMHhxVFhIYXZnb0JRdlgyaXExVDlwV1wvUHg1OE9sM010YTMifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > In general it's good to do on list because others can learn from the
> > answers as well.
> 
> So you somehow managed to keep everyone and the lists in CC nevertheless.
> Did not pay attention to the CC list until I got my reply on the list :)

Sorry! my bad.. yes, the conversation did happen on the list and it's by accident.
> 
> > > > > > +	retval = __change_page_attr_set_clr(&cpa, 0);

[........]

> > > So some questions I have are,
> > > 1. What did Peter Z mean here? "How is that not a TLB invalidation bug ?"
> >
> > __flush_tlb_all() flushes only the mapping on the current CPU. So in a
> > SMP environment it's not sufficient.

Thanks for the explanation. The issue makes sense to me now.

[.........]

> > I'll have a second look at the whole thing and reply on list.
> 
> So actually for the problem at hand __flush_tlb_all() works, because that is
> called way before the secondary CPUs are up.
> 
> Ditto for kernel_map_pages_in_pgd().

Yes, you are right. Both the functions are *always* called before SMP initialization
and as you rightly pointed out they should be marked with __init.

> But both functions want to be marked
> __init and aside of that they both should contain a warning when they are called
> after the secondary CPUs have been brought up.

Makes sense too.. I will include these changes in V3.

Regards,
Sai
