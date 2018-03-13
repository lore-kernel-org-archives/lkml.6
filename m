Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933406AbeCMQoS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:44:18 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:40440 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932729AbeCMQoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:44:14 -0400
X-Google-Smtp-Source: AG47ELta3mC1gIhMe5hjpxXGV9uCvLXlL7iZIy24H6BK2VD/IgABxIYm5twipcadHUtcP5+F0PLt5cCTYnafnC2ianw=
MIME-Version: 1.0
In-Reply-To: <CAKwvOdnPSMSOenPiPqBpDf=hf5q5uQ5MF0pOLAea5T5_VPhmaA@mail.gmail.com>
References: <20180313061109.72629-1-dianders@chromium.org> <20180313061109.72629-3-dianders@chromium.org>
 <20180313061603.jsgiumet23uqi6hl@gmail.com> <CAD=FV=UEuWww=H=TY=E8JvEmrobDNi5+rbTXvTAmZ2brpK+sdg@mail.gmail.com>
 <CAKwvOdnPSMSOenPiPqBpDf=hf5q5uQ5MF0pOLAea5T5_VPhmaA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 13 Mar 2018 09:44:11 -0700
X-Google-Sender-Auth: IxDpJmpvS9F2IV4q_eSv-X_so8I
Message-ID: <CAD=FV=UvT-BrpZcz4RV=cRW4Nf9rBkYvc2JgcQr465NMYjAvJw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kbuild: Don't mess with the .cache.mk when root
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mathieu Malaterre <malat@debian.org>,
        Dave Hansen <dave.hansen@intel.com>, Yang Shi <yang.s@alibaba-inc.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>, Arnd Bergmann <arnd@arndb.de>,
        Mark Charlebois <charlebm@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 13, 2018 at 9:33 AM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
> On Mon, Mar 12, 2018 at 11:23 PM Doug Anderson <dianders@chromium.org>
> wrote:
>
>> Hi,
>
>> On Mon, Mar 12, 2018 at 11:16 PM, Ingo Molnar <mingo@kernel.org> wrote:
>> >
>> > * Douglas Anderson <dianders@chromium.org> wrote:
>> >
>> >> +# Don't create Makefile caches if running as root since they can't be
> deleted
>> >> +# easily; in the real world we might be root when doing "sudo make
> install"
>> >> +ifeq ($(shell id -u),0)
>> >> +export KBUILD_NOCACHE := 1
>> >> +endif
>> >
>> > Please don't do this - many prominent kernel developers build their
> kernels as
>> > root - this makes the build slower for them, and also bifurcates
> testing.
>
>> Ah, interesting.  I hadn't realized that!
>
>> I'm OK with dropping this patch myself.  It was mostly addressing a
>> potential problem pointed out by Masahiro Yamada when we were talking
>> about .cache.mk, but I don't think anyone has actually experienced the
>> problems listed in the CL description.
>
>>    /bin/sh: ./.cache.mk: Permission denied
>
> I feel like I've definitely seen that permission error before.

Hopefully the error message was obvious enough that it didn't take you
too long to think to type "sudo make clean"?  I know it's better for
people not to have to figure this out, but my hope is at least it's
not too arcane of an errror message.


> Is there any issue if I:
>
> $ make clean
> $ make
> $ sudo make install
> <hack around>
> $ make

I don't personally know of any problems with the above flow.


> Or it's only a problem if:
>
> $ make clean
> $ sudo make install
> <hack around>
> $ make

Yeah, just that one.

NOTE: as Masahiro noted in response to the cover letter [1], he's come
up with a better solution to the problem that was solved by the
.cache.mk and he's planning to remove it shortly.


[1] https://lkml.org/lkml/2018/3/13/100
