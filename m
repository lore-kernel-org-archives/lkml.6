Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754872AbeCHEA1 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 23:00:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:6637 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750761AbeCHEAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 23:00:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,438,1515484800";
   d="scan'208";a="209743429"
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Mark Rutland <mark.rutland@arm.com>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lee@lakrids.cambridge.arm.com" <Lee@lakrids.cambridge.arm.com>,
        Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        "Luck, Tony" <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Zijlstra, Peter" <peter.zijlstra@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH V2 2/3] efi: Introduce efi_rts_workqueue and some
 infrastructure to invoke all efi_runtime_services()
Thread-Topic: [PATCH V2 2/3] efi: Introduce efi_rts_workqueue and some
 infrastructure to invoke all efi_runtime_services()
Thread-Index: AQHTtNngYFyf2e7B30yWdA6aWmV0oqPDlMWAgAIjjCA=
Date: Thu, 8 Mar 2018 04:00:22 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F2E5817B3@ORSMSX114.amr.corp.intel.com>
References: <1520292190-5027-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1520292190-5027-3-git-send-email-sai.praneeth.prakhya@intel.com>
 <20180306111339.xjrugce553f2egzh@lakrids.cambridge.arm.com>
In-Reply-To: <20180306111339.xjrugce553f2egzh@lakrids.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzEwMmY5OTItYzMzZi00MWVjLThhNTktZDMyZmU3M2I2MzNiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiIxWkQwdVBLd0VyYUNNWnhcL3F6SHQxUEYrVHlEaGY1Y3llZmtTZFVLNk1WWFV0a3RtWHc0Wm4zUHc2XC9ROHhqS24ifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-0800, Sai Praneeth Prakhya wrote:
> > @@ -329,6 +331,19 @@ static int __init efisubsys_init(void)
> >  		return 0;
> >
> >  	/*
> > +	 * Since we process only one efi_runtime_service() at a time, an
> > +	 * ordered workqueue (which creates only one execution context)
> > +	 * should suffice all our needs.
> > +	 */
> > +	efi_rts_wq = alloc_ordered_workqueue("efi_rts_workqueue", 0);
> > +	if (!efi_rts_wq) {
> > +		pr_err("Failed to create efi_rts_workqueue, EFI runtime services
> "
> > +		       "disabled.\n");
> > +		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
> > +		return 0;
> > +	}
> 
> I'm a little worried that something might sample this flag between it being set in
> an early_initcall (arm_enable_runtime_services), and cleared in a subsys_initcall
> here.
> 
> However, nothing seems to do that so far, so maybe that's ok...
> 

Thanks for raising this. I will take a look at initcalls.

> [...]
> 
> > +/* efi_runtime_service() function identifiers */ enum {
> > +	GET_TIME,
> > +	SET_TIME,
> > +	GET_WAKEUP_TIME,
> > +	SET_WAKEUP_TIME,
> > +	GET_VARIABLE,
> > +	GET_NEXT_VARIABLE,
> > +	SET_VARIABLE,
> > +	SET_VARIABLE_NONBLOCKING,
> > +	QUERY_VARIABLE_INFO,
> > +	QUERY_VARIABLE_INFO_NONBLOCKING,
> > +	GET_NEXT_HIGH_MONO_COUNT,
> > +	RESET_SYSTEM,
> > +	UPDATE_CAPSULE,
> > +	QUERY_CAPSULE_CAPS,
> > +};
> 
> Can we please give this enum a name....

Sure! Added in V3.

> 
> [...]
> 
> > +/*
> > + * efi_runtime_work:	Details of EFI Runtime Service work
> > + * @func:		EFI Runtime Service function identifier
> > + * @arg<1-5>:		EFI Runtime Service function arguments
> > + * @status:		Status of executing EFI Runtime Service
> > + */
> > +struct efi_runtime_work {
> > +	u8 func;
> 
> ... and use it here rather than an opaque u8? I realise that means placing the
> enum in <linux/efi.h>.
> 

Actually, with Miguel comments, I am considering making this struct static and moving
it to runtime-wrappers.c, since "struct efi_runtime_work" isn't really being used anywhere
except runtime-wrappers.c. Please see in V3.

> > +	void *arg1;
> > +	void *arg2;
> > +	void *arg3;
> > +	void *arg4;
> > +	void *arg5;
> > +	efi_status_t status;
> > +	struct work_struct work;
> > +};
> 
> Thanks,
> Mark.
