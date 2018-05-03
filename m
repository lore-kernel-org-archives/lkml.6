Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbeECCdT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 22:33:19 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39943 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752070AbeECCc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 22:32:58 -0400
X-Google-Smtp-Source: AB8JxZqzluMkPuOuEcnoeD8t7FPqbSEpKi1XbNUaVpCEsBCiKwMrlz8Cepcj5BS+8KwDKgm6hoOHooTVuQ8nlSHMJlI=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <CAGXu5jLnD=g=LxR5KTrvcwr1qaYiYXbH-ersvhs5NPRR6JA91w@mail.gmail.com>
References: <1525276400-7161-1-git-send-email-tyhicks@canonical.com>
 <1525276400-7161-5-git-send-email-tyhicks@canonical.com> <CAGXu5jLnD=g=LxR5KTrvcwr1qaYiYXbH-ersvhs5NPRR6JA91w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 2 May 2018 22:32:55 -0400
Message-ID: <CAHC9VhQNaYrZeA487DyhuKGc-2GcydFC2Fr7vUrpoDPhbi4v4A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] seccomp: Don't special case audited processes when logging
To: Kees Cook <keescook@chromium.org>
Cc: Tyler Hicks <tyhicks@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, Linux Audit <linux-audit@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 2, 2018 at 12:57 PM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, May 2, 2018 at 8:53 AM, Tyler Hicks <tyhicks@canonical.com> wrote:
>> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
>> index da78835..9029d9d 100644
>> --- a/kernel/seccomp.c
>> +++ b/kernel/seccomp.c
>> @@ -584,18 +584,13 @@ static inline void seccomp_log(unsigned long syscall, long signr, u32 action,
>>         }
>>
>>         /*
>> -        * Force an audit message to be emitted when the action is RET_KILL_*,
>> -        * RET_LOG, or the FILTER_FLAG_LOG bit was set and the action is
>> -        * allowed to be logged by the admin.
>> +        * Emit an audit message when the action is RET_KILL_*, RET_LOG, or the
>> +        * FILTER_FLAG_LOG bit was set. The admin has the ability to silence
>> +        * any action from being logged by removing the action name from the
>> +        * seccomp_actions_logged sysctl.
>>          */
>>         if (log)
>> -               return __audit_seccomp(syscall, signr, action);
>> -
>> -       /*
>> -        * Let the audit subsystem decide if the action should be audited based
>> -        * on whether the current task itself is being audited.
>> -        */
>> -       return audit_seccomp(syscall, signr, action);
>> +               audit_seccomp(syscall, signr, action);
>>  }
>
> This whole series looks great to me. If I can get an Ack from Paul for
> the audit bits, I can take it via the seccomp tree.

I got stuck doing some day job things today and didn't get a chance to
look at v2 today, but I'll do that tomorrow.

I'm not sure if you've already got anything queued up in your seccomp
tree Kees, but if not I'm happy to take these patches via the audit
tree; that was my original plan, assuming I got a positive nod from
you.  Either way, as long as it hits Linus' tree eventually I'll be
happy (assuming everything looks good post-review of course).

> ... One minor nit on
> seccomp_log() above, I'd probably change this to show the "exception"
> case as "out of line" of normal code flow. i.e. instead of "if (log)
> audit_seccomp", invert it to return early:
>
> ...
>     if (!log)
>         return;
>
>     audit_seccomp(syscall, signr, action);
> }
>
> But if there isn't some other need for a v3, I can just make this
> change when I commit.
>
> Thanks for fixing this up!
>
> -Kees
>
> --
> Kees Cook
> Pixel Security



-- 
paul moore
www.paul-moore.com
