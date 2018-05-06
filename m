Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbeEFHml (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 03:42:41 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:38886 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeEFHmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 03:42:20 -0400
X-Google-Smtp-Source: AB8JxZpyMGmGp6m4CGCX40FVenmHDVaUP24TE62FU5LXTRHSMv750KsmWHOKT4DObJNmdHtINx3K+GPYMG45ISqM5ns=
MIME-Version: 1.0
In-Reply-To: <CA+icZUUPmiCPVxDbaAoJyVXxwwU4v=iYDtK1tf3JdgFC2i8Wsg@mail.gmail.com>
References: <CA+icZUUPGQsRWpdmASzPQAdjmSFmhBwPKGh_CO65C9ot9+nOSQ@mail.gmail.com>
 <20180423174224.GA243180@google.com> <CA+icZUUPmiCPVxDbaAoJyVXxwwU4v=iYDtK1tf3JdgFC2i8Wsg@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sun, 6 May 2018 09:41:58 +0200
Message-ID: <CACT4Y+b4caLPQ7rD3390ep3eGV5j+04upKjLmC7Ky5e1NYrzXA@mail.gmail.com>
Subject: Re: Clang patch stacks for LTS kernels (v4.4 and v4.9) and status update
To: sedat.dilek@gmail.com
Cc: Matthias Kaehlcke <mka@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <nick.desaulniers@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 6, 2018 at 8:35 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On Mon, Apr 23, 2018 at 7:42 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> [...]
>>> [ ASM-GOTO ]
>>>
>>> Foremore, I have seen you have a "refs/sandbox/mka/llvm/v4.14" Git branch.
>>> Linux v4.14 is also an LTS release.
>>
>> Yes, there is also a follow up post:
>> https://lkml.org/lkml/2017/11/22/943
>>
>>> After Linux v4.9 "asm-goto" support was added which is GCC specific.
>>
>> asm-goto was optional until a few weeks ago, when x86 maintainers
>> decided to make it mandatory, and thus break clang builds for x86:
>>
>> https://lkml.org/lkml/2018/4/2/486
>>
>>> Is there a workaround to compile Linux-kernel with any CLANG
>>> version?
>>
>> You could revert the patch that makes asm-goto mandatory.
>>
>>> You happen to know the status in LLVM upstream?
>>
>> I know people are actively working on this, but don't know an ETA.
>>
>
> [ CC Dimitry ]
>
> Sorry for the late response.
> This weekend I had some time to play with clang-7 and Linux-4.17-rcN.
>
> I tried with Linux v4.17-rc3-261-gc1c07416cdd4 and reverted the
> mandatory patch [1].
>
> commit e501ce957a786ecd076ea0cfb10b114e6e4d0f40
> "x86: Force asm-goto"
>
> This needed a follow up [2]...
>
> commit d0266046ad54e0c964941364cd82a0d0478ce286
> "x86: Remove FAST_FEATURE_TESTS"
>
> ...but breaks my build.
>
> That seems to be a known issue [3] and Dimitry bisected this to [4].
> Is there a fix for this?
>
> I have attached my kernel-config and the broken build-log.
>
> Hope this helps.
>
> Regards,
> - Sedat -
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e501ce957a786ecd076ea0cfb10b114e6e4d0f40
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/x86/include/asm/cpufeature.h?id=d0266046ad54e0c964941364cd82a0d0478ce286
> [3] https://www.spinics.net/lists/linux-mm/msg147669.html
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8bf705d130396e69c04cd8e6e010244ad2ce71f4


Hi Sedat,

Sorry for the breakage.

This was reported and discussed here:
https://groups.google.com/forum/#!topic/kasan-dev/oMgCP37n1vw
The plan is to make clang behave the same way as gcc wrt asm
constraint checking. But I don't know what's the progress.
