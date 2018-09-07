Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3892C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BFA2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BFA2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeIGXF7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:05:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:2156 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeIGXF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:05:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 11:23:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,343,1531810800"; 
   d="scan'208";a="255396437"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga005.jf.intel.com with ESMTP; 07 Sep 2018 11:23:49 -0700
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 7 Sep 2018 11:23:49 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.8]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.207]) with mapi id 14.03.0319.002;
 Fri, 7 Sep 2018 11:23:49 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        Al Stone <astone@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: RE: [PATCH V4 3/3] x86/efi: Introduce EFI_PAGE_FAULT_HANDLER
Thread-Topic: [PATCH V4 3/3] x86/efi: Introduce EFI_PAGE_FAULT_HANDLER
Thread-Index: AQHURjlkrx/qzR68D063Dk4PQNG656TlIuuA///95NA=
Date:   Fri, 7 Sep 2018 18:23:48 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485BA5C1@ORSMSX114.amr.corp.intel.com>
References: <1536276468-28499-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1536276468-28499-4-git-send-email-sai.praneeth.prakhya@intel.com>
 <20180907112207.GS24106@hirez.programming.kicks-ass.net>
In-Reply-To: <20180907112207.GS24106@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDIwNzY3ZDYtZjk4OS00NzAyLWE4NWMtMDg4N2E4NDU1M2Y4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYWRYMGtvOGJubk1pNW9XZXQ0MEZLUjhxdThKOUhOQ3o1K1JnNjF6aUhPeHpPcVA1Z2JrSkZCOVYrMTVkQWhwUyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > There may exist some buggy UEFI firmware implementations that might
> > access efi regions other than EFI_RUNTIME_SERVICES_<CODE/DATA> even
> > after the kernel has assumed control of the platform. This violates
> > UEFI specification.
> >
> > If selected, this debug option will print a warning message if the
> > UEFI firmware tries to access any memory region which it shouldn't.
> > Along with the warning, the efi page fault handler will also try to
> > recover from the page fault triggered by the firmware so that the
> > machine doesn't hang.
> 
> Why make this optional?

I made it as a config option in RFC because the page fault handler was 
complicated and touching many parts (it had lots of code change and I didn't want 
to break any existing functionality). Now that it's simple, I don't think we need 
the config option.

Without efi page fault handler, any page fault caused by firmware should panic 
kernel but with this patch I think we are just improving existing condition (ideally).

So, if Thomas, Ingo, Andy, Ard and Boris are ok.. I will make it as default (i.e. without
config).

Regards,
Sai
