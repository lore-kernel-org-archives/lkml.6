Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754748AbeDTLze (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 07:55:34 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:36578 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754631AbeDTLzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 07:55:32 -0400
X-Google-Smtp-Source: AIpwx4/kjA+ndk8rxqSdMnzh6Z+LFN3Ouha29U+KSJZrFA5OLyvHvuikekT0QR6exOz4z8gBkEx7q1ujf90UO2dAOOU=
MIME-Version: 1.0
In-Reply-To: <20180419183840.GA500@roeck-us.net>
References: <21ef6561299cdbbe0f3571c5048a2eaf5eb43bc7.1524143428.git.greentime@andestech.com>
 <20180419183840.GA500@roeck-us.net>
From: Greentime Hu <green.hu@gmail.com>
Date: Fri, 20 Apr 2018 19:54:51 +0800
Message-ID: <CAEbi=3dpFsm-gSZbTngcdT9kMr1aPPoXgUmuqvDFWaKUFgXVfw@mail.gmail.com>
Subject: Re: [9/9] nds32: Fix the allmodconfig build. To make sure
 CONFIG_CPU_LITTLE_ENDIAN is default y
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Greentime <greentime@andestech.com>,
        Guenter Roeck <private@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-20 2:38 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
> On Thu, Apr 19, 2018 at 09:18:15PM +0800, Greentime Hu wrote:
>> This way we can build kernel with CONFIG_CPU_LITTLE_ENDIAN=y and allmodconfig
>> will be available.
>>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>
> As Arnd suspected, this causes allnoconfig to fail.
> The failure is due to endianness mismatches in vdso code.
>
> Not sure if that is really an improvement.
>

Thank you for reviewing.
The reason of this issue is because some objects are compiled with -EL
and some objects are compiled with -EB to cause endianness mismatch
issue.
It happened because AFLAGS and LDFLAGS is not passed correctly. I will
send the 2nd verson patch to fix this issue.

Yes, allnoconfig is fine after applying these fixes.

diff --git a/arch/nds32/Makefile b/arch/nds32/Makefile
index 20edf34e70ce..513bb2e9baf9 100644
--- a/arch/nds32/Makefile
+++ b/arch/nds32/Makefile
@@ -32,8 +32,12 @@ endif

 ifdef CONFIG_CPU_LITTLE_ENDIAN
 KBUILD_CFLAGS   += $(call cc-option, -EL)
+KBUILD_AFLAGS   += $(call cc-option, -EL)
+LDFLAGS         += $(call cc-option, -EL)
 else
 KBUILD_CFLAGS   += $(call cc-option, -EB)
+KBUILD_AFLAGS   += $(call cc-option, -EB)
+LDFLAGS         += $(call cc-option, -EB)
 endif

---
greentime@atcsqa02:/sqa2/greentime/contrib/travis/build_script/src_pkg/linux
<gt-master> $ nds32le-elf-readelf -h vmlinux
ELF Header:
  Magic:   7f 45 4c 46 01 02 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF32
  Data:                              2's complement, big endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           Andes Technology compact code
size embedded RISC processor family
  Version:                           0x1
  Entry point address:               0xc000
  Start of program headers:          52 (bytes into file)
  Start of section headers:          905772 (bytes into file)
  Flags:                             0x30000242, AABI, Andes ELF V1.4,
Andes Star v3.0, PERF1
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         4
  Size of section headers:           40 (bytes)
  Number of section headers:         18
  Section header string table index: 15
