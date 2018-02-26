Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeBZHhZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 02:37:25 -0500
Received: from mga04.intel.com ([192.55.52.120]:40792 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751796AbeBZHhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 02:37:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,396,1515484800";
   d="scan'208";a="20303722"
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>, "Borislav Petkov" <bp@alien8.de>,
        "Luck, Tony" <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Zijlstra, Peter" <peter.zijlstra@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH V1 2/3] efi: Introduce efi_rts_workqueue and necessary
 infrastructure to invoke all efi_runtime_services()
Thread-Topic: [PATCH V1 2/3] efi: Introduce efi_rts_workqueue and necessary
 infrastructure to invoke all efi_runtime_services()
Thread-Index: AQHTrb1EiaVsaODlpEikgPmPA75WlKO1c5OAgADX9eA=
Date: Mon, 26 Feb 2018 07:37:21 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F2E57EF8B@ORSMSX114.amr.corp.intel.com>
References: <1519510249-31447-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1519510249-31447-3-git-send-email-sai.praneeth.prakhya@intel.com>
 <CANiq72=Y_unJt-RMjOL=EWaTXstGNKmNnPBJQMJ9Y74G=9TxJw@mail.gmail.com>
In-Reply-To: <CANiq72=Y_unJt-RMjOL=EWaTXstGNKmNnPBJQMJ9Y74G=9TxJw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjc5MDFkMzUtZGZjYi00MmEzLTliYzYtMzRlNGRiNjc4YTk1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJjaXVTelcwdG1HbGxLMzZ4aDVtbU9zaDIwVHVPdlJJMHNiK0dEd0UwTGZlNkJoNXNmRmZsTVFPeTh0RVNHb2Q1In0=
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1Q7d7VD007008

> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index ac5db5f8dbbf..4714b305ca90 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -76,6 +76,8 @@ static unsigned long *efi_tables[] = {
> >         &efi.mem_attr_table,
> >  };
> >
> > +struct workqueue_struct *efi_rts_wq;
> > +
> >  static bool disable_runtime;
> >  static int __init setup_noefi(char *arg)  { @@ -329,6 +331,15 @@
> > static int __init efisubsys_init(void)
> >         if (!efi_enabled(EFI_BOOT))
> >                 return 0;
> >
> > +       /* Create a work queue to run EFI Runtime Services */
> > +       efi_rts_wq = create_workqueue("efi_rts_workqueue");
> 
> Please consider alloc_workqueue() instead with the appropriate flags, since
> create_workqueue() and friends are deprecated.

Sure! Will change in V2.

> 
> > +       if (!efi_rts_wq) {
> > +               pr_err("Failed to create efi_rts_workqueue, EFI runtime services "
> > +                      "disabled.\n");
> > +               clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
> > +               return 0;
> > +       }
> > +
> >         /*
> >          * Clean DUMMY object calls EFI Runtime Service, set_variable(), so
> >          * it should be invoked only after efi_rts_workqueue is ready.
> > diff --git a/drivers/firmware/efi/runtime-wrappers.c
> > b/drivers/firmware/efi/runtime-wrappers.c
> > index ae54870b2788..5cdb787da5d3 100644
> > --- a/drivers/firmware/efi/runtime-wrappers.c
> > +++ b/drivers/firmware/efi/runtime-wrappers.c
> > @@ -1,6 +1,14 @@
> >  /*
> >   * runtime-wrappers.c - Runtime Services function call wrappers
> >   *
> > + * Implementation summary:
> > + * -----------------------
> > + * 1. When user/kernel thread requests to execute
> > + efi_runtime_service(),
> > + * enqueue work to efi_rts_workqueue.
> > + * 2. Caller thread waits until the work is finished because it's
> > + * dependent on the return status and execution of efi_runtime_service().
> > + * For instance, get_variable() and get_next_variable().
> > + *
> >   * Copyright (C) 2014 Linaro Ltd. <ard.biesheuvel@linaro.org>
> >   *
> >   * Split off from arch/x86/platform/efi/efi.c @@ -22,6 +30,8 @@
> > #include <linux/mutex.h>  #include <linux/semaphore.h>  #include
> > <linux/stringify.h>
> > +#include <linux/workqueue.h>
> > +
> >  #include <asm/efi.h>
> >
> >  /*
> > @@ -33,6 +43,50 @@
> >  #define __efi_call_virt(f, args...) \
> >         __efi_call_virt_pointer(efi.systab->runtime, f, args)
> >
> > +/* Each EFI Runtime Service is represented with a unique number */
> > +#define GET_TIME                                       0
> > +#define SET_TIME                                       1
> > +#define GET_WAKEUP_TIME                                        2
> > +#define SET_WAKEUP_TIME                                        3
> > +#define GET_VARIABLE                                   4
> > +#define GET_NEXT_VARIABLE                              5
> > +#define SET_VARIABLE                                   6
> > +#define SET_VARIABLE_NONBLOCKING                       7
> > +#define QUERY_VARIABLE_INFO                            8
> > +#define QUERY_VARIABLE_INFO_NONBLOCKING                        9
> > +#define GET_NEXT_HIGH_MONO_COUNT                       10
> > +#define RESET_SYSTEM                                   11
> > +#define UPDATE_CAPSULE                                 12
> > +#define QUERY_CAPSULE_CAPS                             13
> 
> An enum would be better, given these are just internal, contiguous IDs.
> 

Makes sense.

> > +
> > +/*
> > + * efi_queue_work:     Queue efi_runtime_service() and wait until it's done
> > + * @rts:               efi_runtime_service() function identifier
> > + * @rts_arg<1-5>:      efi_runtime_service() function arguments
> > + *
> > + * Accesses to efi_runtime_services() are serialized by a binary
> > + * semaphore (efi_runtime_lock) and caller waits until the work is
> > + * finished, hence _only_ one work is queued at a time. So,
> > +queue_work()
> > + * should never fail.
> > + */
> > +#define efi_queue_work(_rts, _arg1, _arg2, _arg3, _arg4, _arg5)                \
> > +({                                                                     \
> > +       struct efi_runtime_work efi_rts_work;                           \
> > +       efi_rts_work.status = EFI_ABORTED;                              \
> > +                                                                       \
> > +       INIT_WORK_ONSTACK(&efi_rts_work.work, efi_call_rts);            \
> > +       efi_rts_work.func = _rts;                                       \
> > +       efi_rts_work.arg1 = _arg1;                                      \
> > +       efi_rts_work.arg2 = _arg2;                                      \
> > +       efi_rts_work.arg3 = _arg3;                                      \
> > +       efi_rts_work.arg4 = _arg4;                                      \
> > +       efi_rts_work.arg5 = _arg5;                                      \
> > +       if (queue_work(efi_rts_wq, &efi_rts_work.work))                 \
> > +               flush_work(&efi_rts_work.work);                         \
> 
> If "So, queue_work() should never fail.", shouldn't this be a BUG() or similar?
> 

BUG() sounds appropriate. Will roll it in V2.

> > +                                                                       \
> > +       efi_rts_work.status;                                            \
> > +})
> > +
> >  void efi_call_virt_check_flags(unsigned long flags, const char *call)
> > {
> >         unsigned long cur_flags, mismatch; @@ -312,3 +366,92 @@ void
> > efi_native_runtime_setup(void)
> >         efi.update_capsule = virt_efi_update_capsule;
> >         efi.query_capsule_caps = virt_efi_query_capsule_caps;  }
> > +
> > +/*
> > + * Calls the appropriate efi_runtime_service() with the appropriate
> > + * arguments.
> > + *
> > + * Semantics followed by efi_call_rts() to understand efi_runtime_work:
> > + * 1. If argument was a pointer, recast it from void pointer to
> > +original
> > + * pointer type.
> > + * 2. If argument was a value, recast it from void pointer to
> > +original
> > + * pointer type and dereference it.
> > + */
> > +void efi_call_rts(struct work_struct *work) {
> > +       struct efi_runtime_work *efi_rts_work;
> > +       void *arg1, *arg2, *arg3, *arg4, *arg5;
> > +       efi_status_t status = EFI_NOT_FOUND;
> > +
> > +       efi_rts_work = container_of(work, struct efi_runtime_work, work);
> > +       arg1 = efi_rts_work->arg1;
> > +       arg2 = efi_rts_work->arg2;
> > +       arg3 = efi_rts_work->arg3;
> > +       arg4 = efi_rts_work->arg4;
> > +       arg5 = efi_rts_work->arg5;
> > +
> > +       switch (efi_rts_work->func) {
> > +       case GET_TIME:
> > +               status = efi_call_virt(get_time, (efi_time_t *)arg1,
> > +                                      (efi_time_cap_t *)arg2);
> > +               break;
> > +       case SET_TIME:
> > +               status = efi_call_virt(set_time, (efi_time_t *)arg1);
> > +               break;
> > +       case GET_WAKEUP_TIME:
> > +               status = efi_call_virt(get_wakeup_time, (efi_bool_t *)arg1,
> > +                                      (efi_bool_t *)arg2, (efi_time_t *)arg3);
> > +               break;
> > +       case SET_WAKEUP_TIME:
> > +               status = efi_call_virt(set_wakeup_time, *(efi_bool_t *)arg1,
> > +                                      (efi_time_t *)arg2);
> > +               break;
> > +       case GET_VARIABLE:
> > +               status = efi_call_virt(get_variable, (efi_char16_t *)arg1,
> > +                                      (efi_guid_t *)arg2, (u32 *)arg3,
> > +                                      (unsigned long *)arg4, (void *)arg5);
> > +               break;
> > +       case GET_NEXT_VARIABLE:
> > +               status = efi_call_virt(get_next_variable, (unsigned long *)arg1,
> > +                                      (efi_char16_t *)arg2,
> > +                                      (efi_guid_t *)arg3);
> > +               break;
> > +       case SET_VARIABLE:
> > +       case SET_VARIABLE_NONBLOCKING:
> > +               status = efi_call_virt(set_variable, (efi_char16_t *)arg1,
> > +                                      (efi_guid_t *)arg2, *(u32 *)arg3,
> > +                                      *(unsigned long *)arg4, (void *)arg5);
> > +               break;
> > +       case QUERY_VARIABLE_INFO:
> > +       case QUERY_VARIABLE_INFO_NONBLOCKING:
> > +               status = efi_call_virt(query_variable_info, *(u32 *)arg1,
> > +                                      (u64 *)arg2, (u64 *)arg3, (u64 *)arg4);
> > +               break;
> > +       case GET_NEXT_HIGH_MONO_COUNT:
> > +               status = efi_call_virt(get_next_high_mono_count, (u32 *)arg1);
> > +               break;
> > +       case RESET_SYSTEM:
> > +               __efi_call_virt(reset_system, *(int *)arg1,
> > +                               *(efi_status_t *)arg2,
> > +                               *(unsigned long *)arg3,
> > +                               (efi_char16_t *)arg4);
> > +               break;
> > +       case UPDATE_CAPSULE:
> > +               status = efi_call_virt(update_capsule,
> > +                                      (efi_capsule_header_t **)arg1,
> > +                                      *(unsigned long *)arg2,
> > +                                      *(unsigned long *)arg3);
> > +               break;
> > +       case QUERY_CAPSULE_CAPS:
> > +               status = efi_call_virt(query_capsule_caps,
> > +                                      (efi_capsule_header_t **)arg1,
> > +                                      *(unsigned long *)arg2, (u64 *)arg3,
> > +                                      (int *)arg4);
> > +               break;
> > +       default:
> > +               pr_err("Not a valid EFI_RT_SERVICE?");
> > +               status = EFI_NOT_FOUND;
> > +               break;
> 
> Given that efi_call_rts() is only called from the virt_efi_*() funtions in the same
> file and that the IDs are internal as well, shouldn't this be a hard error? i.e. no
> one should be calling this with an unknown ID at all. But please see below.

That's true! No one should be calling with unknown ID.
Will make it a BUG().

> 
> > +       }
> > +       efi_rts_work->status = status; }
> > diff --git a/include/linux/efi.h b/include/linux/efi.h index
> > c4efb3ef0dfa..4abb401d40f5 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -1652,4 +1652,27 @@ struct linux_efi_tpm_eventlog {
> >
> >  extern int efi_tpm_eventlog_init(void);
> >
> > +/*
> > + * efi_runtime_work:   Details of EFI Runtime Service work
> > + * @func:              EFI Runtime Service function identifier
> > + * @arg<1-5>:          EFI Runtime Service function arguments
> > + * @status:            Status of executing EFI Runtime Service
> > + */
> > +struct efi_runtime_work {
> > +       u8 func;
> > +       void *arg1;
> > +       void *arg2;
> > +       void *arg3;
> > +       void *arg4;
> > +       void *arg5;
> > +       efi_status_t status;
> > +       struct work_struct work;
> > +};
> > +
> > +/* Workqueue to queue EFI Runtime Services */ extern struct
> > +workqueue_struct *efi_rts_wq;
> > +
> > +/* Call back function that calls EFI Runtime Services */ extern void
> > +efi_call_rts(struct work_struct *work);
> 
> So this seems to indicate there will be external users calling
> efi_call_rts() (even outside EFI itself, given it is in include/linux)
> -- but then, how they will know what to put in "u8 func"?
> 

My bad! efi_call_rts() should be static. There will not be any external users.

> Note that I have no clue on EFI, so I am just commenting on how the patch
> looks. :)
>

Thanks a lot! for the review. They are helpful :)
Will make changes in V2.

Regards,
Sai
