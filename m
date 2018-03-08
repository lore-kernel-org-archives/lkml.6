Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966667AbeCHFiz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 00:38:55 -0500
Received: from mga12.intel.com ([192.55.52.136]:59093 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966074AbeCHFiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 00:38:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,439,1515484800";
   d="scan'208";a="35539852"
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>, "Luck, Tony" <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Zijlstra, Peter" <peter.zijlstra@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: RE: [PATCH V2 2/3] efi: Introduce efi_rts_workqueue and some
 infrastructure to invoke all efi_runtime_services()
Thread-Topic: [PATCH V2 2/3] efi: Introduce efi_rts_workqueue and some
 infrastructure to invoke all efi_runtime_services()
Thread-Index: AQHTtNngYFyf2e7B30yWdA6aWmV0oqPFNzYAgACKE+CAABOYAA==
Date: Thu, 8 Mar 2018 05:38:50 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F2E5818F1@ORSMSX114.amr.corp.intel.com>
References: <1520292190-5027-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1520292190-5027-3-git-send-email-sai.praneeth.prakhya@intel.com>
 <20180307121047.GG23662@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGU0MTg5ZTEtYTEwZC00MmFkLWJkYjctYmJhYmJiZTU3MDU0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJ5QUt1MUpIYlZHak1BK2g2ZnI3WVNrTEg2QTd1NzZwMDUxV1AwVVdnblpPcElZVnA2aXN0dU4ybHh0SXJVK2lOIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w285d7JR016090

+Cc Miguel Ojeda

> > > +({									\
> > > +	struct efi_runtime_work efi_rts_work;				\
> > > +									\
> > > +	INIT_WORK_ONSTACK(&efi_rts_work.work, efi_call_rts);		\
> > > +	efi_rts_work.func = _rts;					\
> > > +	efi_rts_work.arg1 = _arg1;					\
> > > +	efi_rts_work.arg2 = _arg2;					\
> > > +	efi_rts_work.arg3 = _arg3;					\
> > > +	efi_rts_work.arg4 = _arg4;					\
> > > +	efi_rts_work.arg5 = _arg5;					\
> > > +	/*								\
> > > +	 * queue_work() returns 0 if work was already on queue,		\
> > > +	 * _ideally_ this should never happen.				\
> > > +	 */								\
> > > +	if (queue_work(efi_rts_wq, &efi_rts_work.work))
> > 	\
> > > +		flush_work(&efi_rts_work.work);
> > 	\
> > > +	else								\
> > > +		BUG();							\
> >
> > So failure to queue that work is such a critical problem that we need
> > to BUG() and can't possibly continue and shoult not attempt recovery at all?
> >
> 
> I think it's not critical, we can just return error status.
> I think the problem in itself is not at all critical but when I initially thought about
> why the problem could have occurred, it sounded like one i.e. ideally (if the
> system is running fine) we should always be able to queue work. Failure to queue
> means that the previous work is already on queue and that shouldn't be the
> case.
> So, thought, maybe something bad had happened already (just doubtful).
> 
> But, I see your point. BUG() sounds more like an over kill. Instead of fixing an
> existing problem, this patch could completely take down the system.
> 
> > IOW, we should always strive to fail gracefully and not shit in pants
> > at the first sign of trouble.
> >
> 
> Yes, that makes sense. I will remove BUG() in V3 (in the two places that I
> introduced).
> 
> > Even checkpatch warns here:
> >
> > WARNING: Avoid crashing the kernel - try using WARN_ON & recovery code
> > rather than BUG() or BUG_ON()
> > #184: FILE: drivers/firmware/efi/runtime-wrappers.c:92:
> > +               BUG();                                                  \
> >
> 
> Sure! I will fix this
> 
> >
> > and by looking at the other output, you should run your patches
> > through checkpatch. Some of the things make sense like:
> >
> > WARNING: quoted string split across lines
> > #97: FILE: drivers/firmware/efi/efi.c:341:
> > +               pr_err("Failed to create efi_rts_workqueue, EFI runtime services "
> > +                      "disabled.\n");
> >
> > for example.
> >
> 
> I will fix this one too.
> 
> Another warning by checkpatch is "use of in_atomic() in drivers code"
> Do you think it's OK to check if were are "in_atomic()" in drivers code.
> I wasn't able to decide on other alternative, if possible, could you please suggest
> one?
> 
> Regards,
> Sai
