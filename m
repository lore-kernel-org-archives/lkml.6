Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8FEC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975452070C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfAGJjn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:39:43 -0500
Received: from ozlabs.org ([203.11.71.1]:48689 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbfAGJjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:39:43 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Y9Mt2mPyz9sCX;
        Mon,  7 Jan 2019 20:39:38 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Laura Abbott <labbott@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Out-of-tree build works, in-tree build fails due to tracing (was Re: compilation failure with CONFIG_VFIO_PCI_NVLINK2)
In-Reply-To: <f14d4753-a527-01cb-d46f-6a185f5beaa6@ozlabs.ru>
References: <28d0ba1d-b116-178a-d6d0-8a8b569c7c02@redhat.com> <e74e0922-af2e-dac4-2260-8589afa2426b@ozlabs.ru> <2e4484ae-06b7-0de3-db8e-3a6989fac1f7@redhat.com> <91da4363-fed8-a09e-b657-6c10f2b6c33a@ozlabs.ru> <f14d4753-a527-01cb-d46f-6a185f5beaa6@ozlabs.ru>
Date:   Mon, 07 Jan 2019 20:39:35 +1100
Message-ID: <871s5obyco.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ + Masahiro & Steve ]

Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> On 07/01/2019 13:58, Alexey Kardashevskiy wrote:
>> On 04/01/2019 02:08, Laura Abbott wrote:
>>> On 1/3/19 5:49 AM, Alexey Kardashevskiy wrote:
>>>> On 03/01/2019 03:37, Laura Abbott wrote:
>>>>> Hi,
>>>>>
>>>>> I got a compilation failure when building with CONFIG_VFIO_PCI_NVLINK2
>>>>> enabled:
>>>>>
>>>>> + make -s 'HOSTCFLAGS=-O2 -g -pipe -Wall -Werror=format-security
>>>>> -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions
>>>>> -fstack-protector-strong -grecord-gcc-switches
>>>>> -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1
>>>>> -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mcpu=power8
>>>>> -mtune=power8 -fasynchronous-unwind-tables -fstack-clash-protection'
>>>>> 'HOSTLDFLAGS=-Wl,-z,relro -Wl,--as-needed  -Wl,-z,now
>>>>> -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -Wl,--build-id=uuid'
>>>>> ARCH=powerpc -j4 modules
>>>>> BUILDSTDERR: In file included from drivers/vfio/pci/trace.h:102,
>>>>> BUILDSTDERR:                  from
>>>>> drivers/vfio/pci/vfio_pci_nvlink2.c:29:
>>>>> BUILDSTDERR: ./include/trace/define_trace.h:89:42: fatal error:
>>>>> ./trace.h: No such file or directory
>>>>> BUILDSTDERR:  #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>>>>> BUILDSTDERR:                                           ^
>>>>> BUILDSTDERR: compilation terminated.
>>>>> BUILDSTDERR: make[3]: *** [scripts/Makefile.build:277:
>>>>> drivers/vfio/pci/vfio_pci_nvlink2.o] Error 1
>>>>> BUILDSTDERR: make[2]: *** [scripts/Makefile.build:492: drivers/vfio/pci]
>>>>> Error 2
>>>>> BUILDSTDERR: make[1]: *** [scripts/Makefile.build:492: drivers/vfio]
>>>>> Error 2
>>>>> BUILDSTDERR: make: *** [Makefile:1053: drivers] Error 2
>>>>> BUILDSTDERR: make: *** Waiting for unfinished jobs....
>>>>>
>>>>> I don't know enough about ftrace building to make a guess here.
>>>>> Config is attacked.
>>>>
>>>> What gcc is this and what is the exact sha1 of the tree? gcc8 prints
>>>> other error with your config in drivers/scsi/esas2r/esas2r_ioctl.c but
>>>> not this one so I am curious.
>>>>
>>>
>>> gcc (GCC) 8.2.1 20181215 (Red Hat 8.2.1-6)
>>>
>>> sha 8e143b90e4d45cca3dc53760d3cfab988bc74571
>> 
>> 
>> Your config and this sha1 still make "make oldconfig" ask few questions
>> and then it compiles just fine, are you sure about the config?
>> 
>> These are questions on "make oldconfig":
>> 
>> Kernel Live Patching (LIVEPATCH) [N/y/?] (NEW)
>> Stack Protector buffer overflow detection (STACKPROTECTOR) [Y/n/?] (NEW)
>>   Strong Stack Protector (STACKPROTECTOR_STRONG) [Y/n/?] (NEW)
>>     Do NOT protect notrace function from kprobe events
>> (KPROBE_EVENTS_ON_NOTRACE) [N/y/?] (NEW)
>
>
> Ok, I figured it out. This is because you compile in tree while I
> compile out of tree (with O=builddir) and the difference is that in my
> case gcc gets these additional -I$(src) statements and in your case you
> need to add them manually:
>
> yours V=1:
>
>   gcc
>  -Wp,-MD,drivers/vfio/pci/.vfio_pci_nvlink2.o.d
>  -nostdinc
>  -isystem /usr/lib/gcc/powerpc64le-linux-gnu/7/include
>  -I./arch/powerpc/include
>  -I./arch/powerpc/include/generated
>  -I./include
>  -I./arch/powerpc/include/uapi
>  -I./arch/powerpc/include/generated/uapi
>  -I./include/uapi
>  -I./include/generated/uapi
>  -include ./include/linux/kconfig.h
>  -include ./include/linux/compiler_types.h
>  -D__KERNEL__
> ...
>
>
> mine V=1 (has -I/home/aik/p/kernel/drivers/vfio/pci and
> -Idrivers/vfio/pci):
>
>   /opt/cross/gcc-powerpc64le-linux-8.2.1-nolibc/bin/powerpc64le-linux-gcc
>  -Wp,-MD,drivers/vfio/pci/.vfio_pci_nvlink2.o.d
>  -nostdinc
>  -isystem
> /opt/cross/gcc-powerpc64le-linux-8.2.1-nolibc/bin/../lib/gcc/powerpc64le-linux/8.2.1/include
>  -I/home/aik/p/kernel/arch/powerpc/include
>  -I./arch/powerpc/include/generated
>  -I/home/aik/p/kernel/include
>  -I./include
>  -I/home/aik/p/kernel/arch/powerpc/include/uapi
>  -I./arch/powerpc/include/generated/uapi
>  -I/home/aik/p/kernel/include/uapi
>  -I./include/generated/uapi
>  -include /home/aik/p/kernel/include/linux/kconfig.h
>  -include /home/aik/p/kernel/include/linux/compiler_types.h
>  -I/home/aik/p/kernel/drivers/vfio/pci
>  -Idrivers/vfio/pci
>  -D__KERNEL__
> ...
>
>
> This is where it happens:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/Makefile.lib#n143
>
>
> I'd rather prefer to fix this in scripts/Makefile.lib#n143 than doing
> -I$(src) but this is what everybody does already and therefore I guess
> "[PATCH] vfio_pci: Add local source directory as include" from
> https://patchwork.kernel.org/patch/10748803/ is correct.

Where the patch does:
+ccflags-y                               += -I$(src)


This seems like a bug in the build system?

ie. depending on whether you build in-tree or out-of-tree the build can
fail, or not.

Can we fix this once and for all in Makefile.lib as Alexey suggests, or
is there some reason that doesn't work?

(As an aside, why do we even support in-tree build any more?)

cheers
