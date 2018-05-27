Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032640AbeE0M23 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 08:28:29 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33036 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030283AbeE0M22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 08:28:28 -0400
X-Google-Smtp-Source: AB8JxZpoCkFNUZ/Ol5rlDMbp2ov5JWx+DWnpw8sPKWfyVlVIOAJlEyt4GiOoFDfEHTQkVCdUuH8Mh1R1THxi3RikYkg=
MIME-Version: 1.0
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F39539372@ORSMSX114.amr.corp.intel.com>
References: <1527285903-31799-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAKv+Gu_oNUmOwTgM9sAsfMn4WgY+grC2f12vRC4HH9CgxxkfXQ@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F39481456@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu_eShqmjkDSXnFs-_Hcay67+JTMdb6TatNZpV2v5_MoaQ@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F3952F0CF@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu96gURHioy7hRLW2reyUwYMQDSLHhGE=m_TOz9CYF_Tjw@mail.gmail.com> <FFF73D592F13FD46B8700F0A279B802F39539372@ORSMSX114.amr.corp.intel.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sun, 27 May 2018 14:28:26 +0200
Message-ID: <CAKv+Gu9U5Ap37J-56=oDOuUfbcMyGaMnTZh1+JKHDTPU5pteZQ@mail.gmail.com>
Subject: Re: [PATCH V4 0/3] Use efi_rts_wq to invoke EFI Runtime Services
To: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
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
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4RCSigR029564

On 27 May 2018 at 10:37, Prakhya, Sai Praneeth
<sai.praneeth.prakhya@intel.com> wrote:
>> > One more question again, if we are sure that non-blocking variants
>> > will _always_ be called in atomic context, then, we got it covered.
>> > Because, in
>> > set_variable() and query_variable_info() (both blocking and
>> > non-blocking) we check for in_atomic() and if so, we don't use efi_rts_wq
>> (please refer to patch 3).
>> >
>> > If you think, there might be a probability of calling non-blocking
>> > efi_rts out of atomic context, then, sure! Let's make them never use
>> efi_rts_wq.
>> >
>>
>> This is not about what happens to be the current situation. It is about the API.
>>
>> The non-blocking functions should never block, period. They either fail gracefully
>> or perform their duties without sleeping.
>
> Yes, that makes sense.
>
>>
>> In this particular case, I think it is useful to have a guaranteed non-blocking
>> version, not only to delete the dummy EFI variable, but potentially in other
>> future cases as well, given that they can be called much earlier in the boot (when
>> the perf/%cr3 issue is not a concern to begin with)
>
> Thanks for making it more clear :)
> I will change the non-blocking variants _not_ to use efi_rts_wq and as you suggested
> make efi_delete_dummy_variable() use non-blocking variants (that should also make it
> local to arch/x86).
>

Yes, please.

> Another follow on question is, does every firmware support both blocking and
> non-blocking variants (specially legacy EFI firmware)? I am worried about
> this because, presently efi_delete_dummy_variable() uses set_variable() and
> query_variable_info() but if I change efi_delete_dummy_variable() to use non-blocking
> variants and if they aren’t supported, then, I guess, efi_delete_dummy_variable() might
> fail :(
>
> So, could you please clarify on that?
>

I don't follow. Why should it make any difference to the firmware
whether the OS routines blocks or gives up? We always honor the mutual
exclusion between different invocations of runtime services, and the
firmware itself has no awareness of the kind of scheduling the OS
needs to do to ensure this.
