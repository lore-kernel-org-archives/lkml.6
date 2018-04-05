Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751419AbeDEKbZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 06:31:25 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:53241 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeDEKbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 06:31:23 -0400
X-Google-Smtp-Source: AIpwx4/1dAj1FHJjoLFPJIGcCz1wfP5f6XhHEwe6K7yNSEHnKuBLbi5TFHrMLjjgTLHlGlYJIW5syg67MOcL5HUwg8Y=
MIME-Version: 1.0
In-Reply-To: <911d9855-cd45-26f0-90eb-563db899d5ee@huawei.com>
References: <cover.1522560550.git.sargun@sargun.me> <911d9855-cd45-26f0-90eb-563db899d5ee@huawei.com>
From: Peter Dolding <oiaohm@gmail.com>
Date: Thu, 5 Apr 2018 20:31:21 +1000
Message-ID: <CANA3KFX_sVhqvV7C0kR1nkLijiwWc286KcPBfY94LOe=YKGBwg@mail.gmail.com>
Subject: Re: [PATCH v4 0/1] Safe LSM (un)loading, and immutable hooks
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Sargun Dhillon <sargun@sargun.me>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        paul@paul-moore.com, plautrba@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 5, 2018 at 7:55 PM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
> On 01/04/18 08:41, Sargun Dhillon wrote:
>> The biggest security benefit of this patchset is the introduction of
>> read-only hooks, even if some security modules have mutable hooks.
>> Currently, if you have any LSMs with mutable hooks it will render all heads, and
>> list nodes mutable. These are a prime place to attack, because being able to
>> manipulate those hooks is a way to bypass all LSMs easily, and to create a
>> persistent, covert channel to intercept nearly all calls.
>>
>>
>> If LSMs have a model to be unloaded, or are compled as modules, they should mark
>> themselves mutable at compile time, and use the LSM_HOOK_INIT_MUTABLE macro
>> instead of the LSM_HOOK_INIT macro, so their hooks are on the mutable
>> chain.
>
>
> I'd rather consider these types of hooks:
>
> A) hooks that are either const or marked as RO after init
>
> B) hooks that are writable for a short time, long enough to load
> additional, non built-in modules, but then get locked down
> I provided an example some time ago [1]
>
> C) hooks that are unloadable (and therefore always attackable?)
>
> Maybe type-A could be dropped and used only as type-B, if it's
> acceptable that type-A hooks are vulnerable before lock-down of type-B
> hooks.
>
> I have some doubts about the usefulness of type-C, though.
> The benefit I see htat it brings is that it avoids having to reboot when
> a mutable LSM is changed, at the price of leaving it attackable.
>
> Do you have any specific case in mind where this trade-off would be
> acceptable?
>

A useful case for loadable/unloadable LSM is development automate QA.

So you have built a new program and you you want to test it against a
list of different LSM configurations without having to reboot the
system.  So a run testsuite with LSM off  then enabled LSM1 run
testsuite again disable LSM1 enable LSM2. run testsuite disable
LSM2... Basically repeating process.

I would say normal production machines being able to swap LSM like
this does not have much use.

Sometimes for productivity it makes sense to be able to breach
security.   The fact you need to test with LSM disabled to know if any
of the defects you are seeing is LSM configuration related that
instance is already in the camp of non secure anyhow..

There is a shade of grey between something being a security hazard and
something being a useful feature.

If development people are not testing that LSM configuration are clean
because they don't really have enough machined to boot up individual
instances with each LSM and this results in broken LSM configuration
being shipped resulting in end users turning LSM off completely.
Then a little security risk from providing unload-able LSM hooks when
particularly requested is not that high really.

With all the different LSM options how do application/distribution
makers validate all the different LSM configurations effectively is a
question that does need to be answered.  In answering this question
allowing this form of compromised security as a option might be quite
a valid move.

Peter Dolding
