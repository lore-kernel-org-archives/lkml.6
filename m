Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeBWATw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 19:19:52 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33835 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeBWATv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 19:19:51 -0500
X-Google-Smtp-Source: AH8x224YGlblU0v85o/oq4Fq9WZwo+l5w0DDdr8DDdx1n7rPR3ib/jPKlksA37EGw6fhOip/olgQjS4mph+jCEzNZWw=
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKx+ReiTOVnxANL=NsOTWuxzuATUYqtfi91GvFKVgR6Yg@mail.gmail.com>
References: <20180222002854.GA29269@beast> <201802230613.8bqOOUnw%fengguang.wu@intel.com>
 <CAGXu5jKx+ReiTOVnxANL=NsOTWuxzuATUYqtfi91GvFKVgR6Yg@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 22 Feb 2018 16:19:49 -0800
X-Google-Sender-Auth: 9_TvPFBrtlY4LugISzpmzUBweeM
Message-ID: <CAGXu5jKcrxSwUaFdr4YGwtt1Lm0DtBZvD-gVkaLYRkgMua+JyQ@mail.gmail.com>
Subject: Re: [PATCH v2] kconfig.h: Include compiler types to avoid missed
 struct attributes
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc: kbuild-all@01.org, kbuild test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 4:03 PM, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Feb 22, 2018 at 2:26 PM, kbuild test robot <lkp@intel.com> wrote:
>> Hi Kees,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on linus/master]
>> [also build test ERROR on v4.16-rc2 next-20180222]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Kees-Cook/kconfig-h-Include-compiler-types-to-avoid-missed-struct-attributes/20180223-040717
>> config: mips-jz4740 (attached as .config)
>> compiler: mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=mips
>>
>> All errors (new ones prefixed by >>):
>>
>>>> Error: arch/mips/boot/vmlinux.gz.its:201.1-2 syntax error
>>    FATAL ERROR: Unable to parse input tree
>>    /usr/bin/mkimage: Can't read arch/mips/boot/vmlinux.gz.itb.tmp: Invalid argument
>>    /usr/bin/mkimage Can't add hashes to FIT blob
>
> Ugh, the compiler_types.h commit breaks MIPS. I've reproduced this
> failure; debugging now....

For the MIPS folks, this is about 28128c61e08e ("kconfig.h: Include
compiler types to avoid missed struct attributes").

This hack fixes it ("struct" definitions were appearing in the
resulting its output files, which broke parsing):

diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index 1bd5c4f00d19..c22da16d67b8 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -126,6 +126,7 @@ $(obj)/vmlinux.its.S: $(addprefix
$(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS

 quiet_cmd_cpp_its_S = ITS     $@
       cmd_cpp_its_S = $(CPP) $(cpp_flags) -P -C -o $@ $< \
+                       -D__ASSEMBLY__ \
                        -DKERNEL_NAME="\"Linux $(KERNELRELEASE)\"" \
                        -DVMLINUX_BINARY="\"$(3)\"" \
                        -DVMLINUX_COMPRESSION="\"$(2)\"" \

I assume since this is overloading a .S build rule, the __ASSEMBLY__
define went missing from cpp_flags?

I'm trying to figure out if there is a better solution; ideas welcome!

-Kees

-- 
Kees Cook
Pixel Security
