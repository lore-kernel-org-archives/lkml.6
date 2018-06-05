Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbeFETzT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:55:19 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:32843 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752298AbeFETzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:55:17 -0400
X-Google-Smtp-Source: ADUXVKLvnED3PtDJskZFVC/t+7ZfxsFmims2T4lC+s+LsLRuGflJkTMxsIihV0IFpONfrWWdwM+lkjvSkVL8wrGHudQ=
MIME-Version: 1.0
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F3B812DFC@ORSMSX114.amr.corp.intel.com>
References: <1527560464-19466-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1527560464-19466-4-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAKv+Gu_K3HsVoH0M7kFx12d8eGzdmAe-C06TnKek1xwsSFyStA@mail.gmail.com> <FFF73D592F13FD46B8700F0A279B802F3B812DFC@ORSMSX114.amr.corp.intel.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 5 Jun 2018 21:55:16 +0200
Message-ID: <CAKv+Gu_Y3Lt1FpymS00AMD4ZJ3AFSV1m7ggxuRFCa4PROeX8XA@mail.gmail.com>
Subject: Re: [PATCH V5 3/3] efi: Use efi_rts_wq to invoke EFI Runtime Services
To: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Cc: linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        "Luck, Tony" <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Naresh Bhat <naresh.bhat@linaro.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 June 2018 at 21:29, Prakhya, Sai Praneeth
<sai.praneeth.prakhya@intel.com> wrote:
>> > +       case RESET_SYSTEM:
>> > +               __efi_call_virt(reset_system, *(int *)arg1,
>> > +                               *(efi_status_t *)arg2,
>> > +                               *(unsigned long *)arg3,
>> > +                               (efi_char16_t *)arg4);
>> > +               break;
>>
>> I noticed that -unsurprisingly- reboot no longer works with these changes.
>>
>> I will fix up the patch, and revert the efi_reset_system() change, both here and
>> below.
>
> Could you please let me know what the bug is here? I am unable to see it right away :(
> I have tested reboot on qemu x86_64 by passing "reboot=efi" as command line arg and
> saw that reboot is working fine.
>

My arm64 hangs at reboot or power off, unless i revert the ResetSystem() part.

But given that it is both risky (relying on a kthread running a
workqueue in the shutdown path) and unnecessary (ResetSystem() is not
supposed to return, and is only called by the kernel when the whole
system has already been torn down), I think the main reason is simply
that there is no reason to add it.


>> > @@ -340,7 +441,8 @@ static void virt_efi_reset_system(int reset_type,
>> >                         "could not get exclusive access to the firmware\n");
>> >                 return;
>> >         }
>> > -       __efi_call_virt(reset_system, reset_type, status, data_size, data);
>> > +       efi_queue_work(RESET_SYSTEM, &reset_type, &status, &data_size, data,
>> > +                      NULL);
>> >         up(&efi_runtime_lock);
>> >  }
>
> Regards,
> Sai
