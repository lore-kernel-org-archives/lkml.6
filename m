Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF2BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642F620652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642F620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeIGXM1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:12:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:4687 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727654AbeIGXM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:12:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 11:30:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,343,1531810800"; 
   d="scan'208";a="231088867"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga004.jf.intel.com with ESMTP; 07 Sep 2018 11:29:08 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 7 Sep 2018 11:29:08 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.8]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.64]) with mapi id 14.03.0319.002;
 Fri, 7 Sep 2018 11:29:08 -0700
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
Subject: RE: [PATCH V4 2/3] x86/efi: Add efi page fault handler to recover
 from page faults caused by the firmware
Thread-Topic: [PATCH V4 2/3] x86/efi: Add efi page fault handler to recover
 from page faults caused by the firmware
Thread-Index: AQHURjliJ4DeigRDLEus4SenaID3kaTlItQAgAAAqWA=
Date:   Fri, 7 Sep 2018 18:29:07 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485BA5D7@ORSMSX114.amr.corp.intel.com>
References: <1536276468-28499-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1536276468-28499-3-git-send-email-sai.praneeth.prakhya@intel.com>
 <20180907112147.GR24106@hirez.programming.kicks-ass.net>
In-Reply-To: <20180907112147.GR24106@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWZlOTY1ZWYtYzdiYy00ODY5LWFiZDAtOGMwZmZkZWFlYTY2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQ1hrdTBtUFJqUmNJME1oNFcwZWZub1Q0Z2I4U2dVMG1IVGFaTlRoRk9NVFh5XC9oVHhsdFVGV1gxcDh5NTRxVjAifQ==
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

> > +	if (efi_rts_work.efi_rts_id == RESET_SYSTEM) {
> > +		pr_info("efi_reset_system() buggy! Reboot through BIOS\n");
> > +		machine_real_restart(MRR_BIOS);
> > +		return 0;
> > +	}
> > +
> > +	/* Firmware has caused page fault, hence, freeze efi_rts_wq. */
> > +	set_current_state(TASK_UNINTERRUPTIBLE);
> 
> This doesn't freeze it, as such, it just sets the state.

True! Thanks for pointing it out. I will update the comment.

> > +
> > +	/*
> > +	 * Before calling EFI Runtime Service, the kernel has switched the
> > +	 * calling process to efi_mm. Hence, switch back to task_mm.
> > +	 */
> > +	arch_efi_call_virt_teardown();
> > +
> > +	/* Signal error status to the efi caller process */
> > +	efi_rts_work.status = EFI_ABORTED;
> > +	complete(&efi_rts_work.efi_rts_comp);
> > +
> > +	clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
> > +	pr_info("Froze efi_rts_wq and disabled EFI Runtime Services\n");
> 
> > +	schedule();
> 
> So what happens when we get a spurious wakeup and return from this?
> 
> Quite possibly you want something like:
> 
> 	for (;;) {
> 		set_current_state(TASK_IDLE);
> 		schedule();
> 	}
> 
> here. The TASK_UNINTERRUPTIBLE thing will cause the load-avg to spike; is that
> what you want?

Yes, makes sense. TASK_IDLE seems more appropriate. I will change it.

Regards,
Sai
