Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966092AbeBMXOg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:14:36 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:51653 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966003AbeBMXOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:14:35 -0500
X-Google-Smtp-Source: AH8x224bPFu27JNTWndciD9eAYJHuYQlLXkxVoHZJEBSgoUI7nyESa07699HlEShCp3f+qqRI2UvUQOfEauH67U15+0=
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
In-Reply-To: <CAGXu5jLz+6ky3i4ShE2b+31UDi0cakQqa8YVdJo4F3NK2i2eTA@mail.gmail.com>
References: <CAP8WD_bdbmAp=bYAXp--36SME5Cgn42ovz+YpjEt94fzaVt4Ew@mail.gmail.com>
 <20180213165159.GR695913@devbig577.frc2.facebook.com> <CAP8WD_Z+yYXiRUZt4eMo2+zOSPFhsw=XiqJQUqVZFGGnGoWdPg@mail.gmail.com>
 <CAGXu5jLz+6ky3i4ShE2b+31UDi0cakQqa8YVdJo4F3NK2i2eTA@mail.gmail.com>
From: tedheadster <tedheadster@gmail.com>
Date: Tue, 13 Feb 2018 18:14:13 -0500
Message-ID: <CAP8WD_bZFWx=MadMfSb_nXYgNocxHjG1+WaJ38GqeBF559SDVw@mail.gmail.com>
Subject: Re: x86/stack protector: X86_32_LAZY_GS=n hangs kernel on old processors
To: Kees Cook <keescook@chromium.org>
Cc: Tejun Heo <tj@kernel.org>, jeremy@xensource.com,
        Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 4:37 PM, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Feb 13, 2018 at 8:57 AM, tedheadster <tedheadster@gmail.com> wrote:
>> Changing X86_32_LAZY_GS to 'y' does not cause the kernel to hang.
>>
>>> On Tue, Feb 13, 2018 at 11:40:17AM -0500, tedheadster wrote:
>>>>   in your patch "x86: make lazy %gs optional on x86_32" were you able
>>>> to test it on really old processors? In 4.16.0-rc1, X86_32_LAZY_GS got
>>>> toggled from 'y' to 'n' in my default config because of changes to the
>>>> stack protector code. It hangs my ancient i486 test machine right
>>>> after 'Booting the kernel'.
>>>
>>> I didn't have access to an i486 at the time or ever since, so it
>>> wasn't tested there.  If this is specific to i486, flagging it so in
>>> the config probably isn't the end of the world at this point.
>>
>> Tejun,
>>   I will be able to test this on other 32bit hardware at the end of
>> the week. Hopefully I'll be able to identify which processors it does
>> not work on (i486/i586/i686).
>
> So, this is the exact opposite of my tests: if I had X86_32_LAZY_GS=y
> and stack protector enabled (via _AUTO), the boot would hang. This
> change solved that for me:
>
>  config X86_32_LAZY_GS
>         def_bool y
> -       depends on X86_32 && !CC_STACKPROTECTOR
> +       depends on X86_32 && CC_STACKPROTECTOR_NONE
>
> since stack-protector in _AUTO mode had to reorganize that logic. It
> seemed LAZY_GS isn't compatible with stack-protector, so I made sure
> to retain that. What are your other configs?
>

Kees,
  I am running the 4.16-rc1 release. My arch/x86/Kconfig has this logic:

config X86_32_LAZY_GS
        def_bool y
        depends on X86_32 && CC_STACKPROTECTOR_NONE

I get a hang on i486 when I choose any of these configuration options:

CONFIG_CC_STACKPROTECTOR_AUTO=y
CONFIG_CC_STACKPROTECTOR_REGULAR=y
CONFIG_CC_STACKPROTECTOR_STRONG=y

Also, CONFIG_X86_32_LAZY_GS does not appear in any of these config
files, not even as "# CONFIG_X86_32_LAZY_GS is not set", which I
thought was strange.

The only configuration that works on i486 is:

CONFIG_CC_STACKPROTECTOR_NONE=y
CONFIG_X86_32_LAZY_GS=y

Now it gets interesting. All four of these configurations boots
successfully when compiled for, and run on, a Pentium 4 M
(CONFIG_PENTIUM4). So it certainly is related to what version of the
processor you use.

I will continue to try other configuration combinations and report back.

- Matthew
