Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4davKV9NGltkbwAAmS7hNA
	; Fri, 08 Jun 2018 09:33:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9DC5B607A4; Fri,  8 Jun 2018 09:33:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id ECE29602FC;
	Fri,  8 Jun 2018 09:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ECE29602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752428AbeFHJd3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:33:29 -0400
Received: from www62.your-server.de ([213.133.104.62]:37459 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbeFHJd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:33:27 -0400
Received: from [178.197.248.12] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fRDlk-0007H5-CL; Fri, 08 Jun 2018 11:33:16 +0200
Subject: Re: [PATCH] [net-next, wrong] make BPFILTER_UMH depend on X86
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexei Starovoitov <ast@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180528153222.2037158-1-arnd@arndb.de>
 <CAMuHMdXy0uHXaGkFBh9_tr2VzmJF+8KtraTuFHJwcmqhcHs4Dg@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8c0f8cc4-b919-9b69-4144-fd216253aa24@iogearbox.net>
Date: Fri, 8 Jun 2018 11:33:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXy0uHXaGkFBh9_tr2VzmJF+8KtraTuFHJwcmqhcHs4Dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.3/24643/Fri Jun  8 06:37:57 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 06/08/2018 10:57 AM, Geert Uytterhoeven wrote:
> On Mon, May 28, 2018 at 5:31 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> When build testing across architectures, I run into a build error on
>> all targets other than X86:
>>
>> gcc-8.1.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-objdump: net/bpfilter/bpfilter_umh: File format not recognized
>> gcc-8.1.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-objcopy:net/bpfilter/bpfilter_umh.o: Invalid bfd target
>>
>> The problem is that 'hostprogs' get built with 'gcc' rather than
>> '$(CROSS_COMPILE)gcc', and my default gcc (as most people's) targets x86.
>>
>> To work around it, adding an X86 dependency gets randconfigs building
>> again on my box.
>>
>> Clearly, this is not a good solution, since it should actually work fine
>> when building native kernels on other architectures but that is now
>> disabled, while cross building an x86 kernel on another host is still
>> broken after my patch.
>>
>> What we probably want here is to try out if the compiler is able to build
>> executables for the target architecture and not build the helper otherwise,
>> at least when compile-testing. No idea how to do that though.
> 
> So that was done in commit 819dd92b9c0bc7bc ("bpfilter: switch to CC
> from HOSTCC"), but it is not sufficient:
> 
>       GEN net/bpfilter/bpfilter_umh.o
>     Usage: m68k-linux-gnu-objcopy [option(s)] in-file [out-file]
>      Copies a binary file, possibly transforming it in the process
>      The options are:
>     [...]
> 
> net/bpfilter/Makefile:29: recipe for target 'net/bpfilter/bpfilter_umh.o' failed
> make[5]: *** [net/bpfilter/bpfilter_umh.o] Error 1
> 
>> --- a/net/bpfilter/Kconfig
>> +++ b/net/bpfilter/Kconfig
>> @@ -9,6 +9,7 @@ menuconfig BPFILTER
>>  if BPFILTER
>>  config BPFILTER_UMH
>>         tristate "bpfilter kernel module with user mode helper"
>> +       depends on X86 # actually depends on native builds
> 
> No, (currently) it does depend on X86, due to its use of:
> 
>     $(OBJCOPY) -I binary -O $(CONFIG_OUTPUT_FORMAT)
> 
> with CONFIG_OUTPUT_FORMAT being defined on X86 only...

That hard dependency should have been fixed with the following patch in -net tree:

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=8d97ca6b6755bf7ef57d323642ca9ee80d689782

Thanks,
Daniel
