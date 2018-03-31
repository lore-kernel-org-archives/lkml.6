Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753010AbeCaOi7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 10:38:59 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:41851 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752859AbeCaOi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 10:38:57 -0400
X-Google-Smtp-Source: AIpwx48lv1GOodlISgVakuDmm9sfXhpe6wx2GKdmuuaEsmsZaWRoRyJl7XmJbDdqenNU6XqS7WV6fwcINai0ZJdfdwU=
MIME-Version: 1.0
In-Reply-To: <CAMp4zn96Maw8LrdOrdv-fCEZUdPi+kYQVROURcSxOQfiUUyCNA@mail.gmail.com>
References: <cover.1522357211.git.sargun@sargun.me> <5240a81494bbe5be5651379cd9828bda34d764e2.1522357211.git.sargun@sargun.me>
 <3292bbb3-7c9d-f18d-05f3-9b69b3cac922@schaufler-ca.com> <20180330023331.GA10833@ircssh-2.c.rugged-nimbus-611.internal>
 <8b015e9e-dccb-aefd-f5b2-c66eed3c6815@schaufler-ca.com> <CAMp4zn96Maw8LrdOrdv-fCEZUdPi+kYQVROURcSxOQfiUUyCNA@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 31 Mar 2018 07:38:54 -0700
X-Google-Sender-Auth: qyTTNQ1Po01PWiK29s4LI1nYTDs
Message-ID: <CAGXu5jLn6c=mr5VC=fUP4LUD18EuPAYyDkYTrv_rpxSuxAz--A@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] security: Add mechanism to safely (un)load LSMs
 after boot time
To: Sargun Dhillon <sargun@sargun.me>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Igor Stoppa <igor.stoppa@huawei.com>, James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>,
        plautrba@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 11:16 PM, Sargun Dhillon <sargun@sargun.me> wrote:
> On Fri, Mar 30, 2018 at 2:39 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>  static struct security_hook_list     null_hooks[SECURITY_HOOK_COUNT];
>>> -#define HAS_FUNC(SHL, FUNC)  (SHL->hook.FUNC)
>>> +DEFINE_STATIC_SRCU(security_hook_srcu);
>>> +
>>> +static inline bool is_null_hook(struct security_hook_list *shl)
>>> +{
>>> +     union {
>>> +             void *cb_ptr;
>>> +             union security_list_options slo;
>>> +     } hook_options;
>>> +
>>> +     hook_options.slo = shl->hook;
>>> +     return !hook_options.cb_ptr;
>>> +}
>>
>> I like the HAS_FUNC() approach better.
>
>  Just curious, why? I personally prefer small static inline functions
> over macros, if possible.

Generally speaking, small static inline functions are better since
they provide type-checking. In this case, though, it looks like you're
just doing a cast, but with a union. Why isn't this just:

return !!((uintptr_t)shl->hook)

?

Though the security_list_options union exists for callback type
checking, so really, having HAS_FUNC() with the explicit function
you're interested in creates a bit of self-documenting code (even if
it always resolves to the above test).

-Kees

-- 
Kees Cook
Pixel Security
