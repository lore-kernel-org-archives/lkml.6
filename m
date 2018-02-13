Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933508AbeBMHJa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 02:09:30 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:5279 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933366AbeBMHJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 02:09:28 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37022158"
Subject: Re: why scripts/link-vmlinux.sh has a final build of init/
To: Masahiro Yamada <yamada.masahiro@socionext.com>
CC: Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <fb60e245-86f2-53c6-79d8-bd395ef011dd@cn.fujitsu.com>
 <CAK7LNARjks+EWiKq4KkHrbQTOAYWzRku_fuj_-8dcThQB=h6PA@mail.gmail.com>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <6f19ae3f-249e-2d20-dcd6-e34c475a2638@cn.fujitsu.com>
Date: Tue, 13 Feb 2018 15:08:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNARjks+EWiKq4KkHrbQTOAYWzRku_fuj_-8dcThQB=h6PA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 8A9E848AE761.A88B1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/12/2018 10:48 PM, Masahiro Yamada wrote:
> 2018-02-12 13:22 GMT+09:00 Cao jin <caoj.fnst@cn.fujitsu.com>:
>> Hi Masahiro-san,
>>
>>   As I remember, init/ is already built during recursive make, and I did
>> a clean build(make mrproper, make localmodconfig) with all plugins
>> included on x86_64 with following patch, the kernel can boot without any
>> obvious problem. So, I don't figure out why we need this final build?
>>
>>
>> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
>> index e6818b8e7141..086b2efd4d53 100755
>> --- a/scripts/link-vmlinux.sh
>> +++ b/scripts/link-vmlinux.sh
>> @@ -247,9 +247,6 @@ else
>>         expr 0$(cat .old_version) + 1 >.version;
>>  fi;
>>
>> -# final build of init/
>> -${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init
>> GCC_PLUGINS_CFLAGS="${GCC_PLUGINS_CFLAGS}"
>> -
>>  archive_builtin
>>
>>  #link vmlinux.o
>>
> 
> 
> link-vmlinux.sh increments '.version'
> so it must descend into init/
> to update include/generated/compile.h
> and re-compile init/version.o
> 
> We do not increment '.version'
> at the first descend into init/
> because we never know whether the kernel
> is updated or not before the final link stage.
> 

Oh, I wasn't aware of this process, now understood. Thanks Masahiro-san.

BTW, I still have 2 questions.

1. In final build, why need

   GCC_PLUGINS_CFLAGS="${GCC_PLUGINS_CFLAGS}"

Doesn't GCC_PLUGINS_CFLAGS already exist in the environment?

I also tested the Randomizing Structure Layout plugin with this patch,
the plugin seems works in my test.

2. scripts/link-vmlinux.sh seems just handle only one argument: clean.
So why shouldn't it be:

diff --git a/Makefile b/Makefile
index ccd981892ef2..21d93b545381 100644
--- a/Makefile
+++ b/Makefile
@@ -998,7 +998,7 @@ ARCH_POSTLINK := $(wildcard
$(srctree)/arch/$(SRCARCH)/Makefile.postlink)

 # Final link of vmlinux with optional arch pass after final link
 cmd_link-vmlinux =                                                 \
-       $(CONFIG_SHELL) $< $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) ;    \
+       $(CONFIG_SHELL) $<;                                         \
        $(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)

 vmlinux: scripts/link-vmlinux.sh vmlinux_prereq $(vmlinux-deps) FORCE

-- 
Sincerely,
Cao jin
