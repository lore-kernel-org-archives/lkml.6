Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A778EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7957721850
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfAWPZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:25:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34050 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfAWPZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:25:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id f7so2976855wrp.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 07:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=2u/KJGw0qjQYXUZfbIjyo6vsnnU92PqF6CURT4uPz20=;
        b=EsPl8211b2DIre+Wtzrq797iqfH3r8jlbuNMTXK6cdXNWJKDjHoCQ8ISKb50lPJuor
         9XF8gCosljonJfI6aQowb3MskS+LjFXX+GQj4n7QLdre4WVnCY02N0KRl4GUHLe0remr
         KA/amQYE7uR6hq9ZSxpXBmUnqdU/Mq7nmItMBa8B8VlUlBvz2Ob4zKpzIpFDqeqER1vm
         DffFZtNw16V6mlvaFDoIFIHVdW3Ka73kQ5zA/kTv/hhAiiPu/5be0ji1cqYpZKCAdGc9
         kdPxA7FF/ZLTTXTflB+OGoxDnfbXq2QzwokzxYQaKPH5y4ZW2uLheATjcfm6dCaAyRb1
         Ecmg==
X-Gm-Message-State: AJcUukd8UHh4jr+4VY4li3tt2lLrRCmi3beYuHP0L1qoIHBzFY6tGVVv
        BzpdDDGl+tqMR5C2q8DjarPJ+aFmugM=
X-Google-Smtp-Source: ALg8bN4e7b74FJWzctRevHNqw1ppquaNS8VH1GSsbH5/P1PzSAUUvePtmUMNHIt2O/6ExZ0UqBuHZQ==
X-Received: by 2002:adf:f4c2:: with SMTP id h2mr3195022wrp.21.1548257137446;
        Wed, 23 Jan 2019 07:25:37 -0800 (PST)
Received: from [10.200.139.106] (ovpn-brq.redhat.com. [213.175.37.11])
        by smtp.gmail.com with ESMTPSA id a8sm29266222wme.23.2019.01.23.07.25.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 07:25:36 -0800 (PST)
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Laura Abbott <labbott@redhat.com>
Subject: New warnings with gcc9
Cc:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <90cb9f5e-c0b5-dfa5-c6bd-4808dc47c799@redhat.com>
Date:   Wed, 23 Jan 2019 16:25:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As an FYI for anyone who is interested, gcc9 landed in Fedora rawhide
and I built the kernel as usual.

There's a very large number of warnings from -Waddress-of-packed-member e.g.

BUILDSTDERR: drivers/scsi/ipr.c: In function 'ipr_handle_config_change':
BUILDSTDERR: drivers/scsi/ipr.c:1453:22: warning: taking address of packed member of 'struct ipr_hostrcb_cfg_ch_not' may result in an unaligned pointer value [-Waddress-of-packed-member]
BUILDSTDERR:  1453 |   cfgtew.u.cfgte64 = &hostrcb->hcam.u.ccn.u.cfgte64;
BUILDSTDERR:       |

There's also some missing attribute warnings. The majority are caused by a
missing attribute in module_init/module_exit

BUILDSTDERR: In file included from drivers/scsi/hptiop.c:18:
BUILDSTDERR: ./include/linux/module.h:132:6: warning: 'init_module' specifies less restrictive attribute than its target 'hptiop_module_init': 'cold' [-Wmissing-attributes]
BUILDSTDERR:   132 |  int init_module(void) __attribute__((alias(#initfn)));
BUILDSTDERR:       |      ^~~~~~~~~~~
BUILDSTDERR: drivers/scsi/hptiop.c:1704:1: note: in expansion of macro 'module_init'
BUILDSTDERR:  1704 | module_init(hptiop_module_init);
BUILDSTDERR:       | ^~~~~~~~~~~
BUILDSTDERR: drivers/scsi/hptiop.c:1692:19: note: 'init_module' target declared here
BUILDSTDERR:  1692 | static int __init hptiop_module_init(void)
BUILDSTDERR:       |

I also hit a build failure on s390, This looks to be an issue with the assembly,
I'm in discussion with the s390 people about the proper fix.

BUILDSTDERR: ./arch/s390/include/asm/jump_label.h: Assembler messages:
BUILDSTDERR: ./arch/s390/include/asm/jump_label.h:23: Error: bad expression
BUILDSTDERR: ./arch/s390/include/asm/jump_label.h:23: Error: junk at end of line, first unrecognized character is `r'
BUILDSTDERR: make[1]: *** [scripts/Makefile.build:277: init/main.o] Error 1


This looks like a new warning due to hvclock_page being declared
u8 and then cast to a struct

BUILDSTDERR: arch/x86/entry/vdso/vclock_gettime.c: In function 'do_hres':
BUILDSTDERR: ./include/linux/compiler.h:182:26: warning: array subscript 1 is outside array bounds of 'u8[1]' {aka 'unsigned char[1]'} [-Warray-bounds]
BUILDSTDERR:   182 |  case 8: *(__u64 *)res = *(volatile __u64 *)p; break;  \
BUILDSTDERR:       |                          ^~~~~~~~~~~~~~~~~~~~
BUILDSTDERR: ./include/linux/compiler.h:193:2: note: in expansion of macro '__READ_ONCE_SIZE'
BUILDSTDERR:   193 |  __READ_ONCE_SIZE;
BUILDSTDERR:       |  ^~~~~~~~~~~~~~~~
BUILDSTDERR: arch/x86/entry/vdso/vclock_gettime.c:37:11: note: while referencing 'hvclock_page'
BUILDSTDERR:    37 | extern u8 hvclock_page
BUILDSTDERR:       |           ^~~~~~~~~~~~

This looks like we just need to make the attributes match

BUILDSTDERR: lib/crc32.c:209:5: warning: 'crc32_le_base' specifies less restrictive attribute than its target 'crc32_le': 'pure' [-Wmissing-attributes]
BUILDSTDERR:   209 | u32 crc32_le_base(u32, unsigned char const *, size_t) __alias(crc32_le);
BUILDSTDERR:       |     ^~~~~~~~~~~~~
BUILDSTDERR: lib/crc32.c:195:19: note: 'crc32_le_base' target declared here
BUILDSTDERR:   195 | u32 __pure __weak crc32_le(u32 crc, unsigned char const *p, size_t len)
BUILDSTDERR:       |                   ^~~~~~~~
BUILDSTDERR: lib/crc32.c:210:5: warning: '__crc32c_le_base' specifies less restrictive attribute than its target '__crc32c_le': 'pure' [-Wmissing-attributes]
BUILDSTDERR:   210 | u32 __crc32c_le_base(u32, unsigned char const *, size_t) __alias(__crc32c_le);
BUILDSTDERR:       |     ^~~~~~~~~~~~~~~~
BUILDSTDERR: lib/crc32.c:200:19: note: '__crc32c_le_base' target declared here
BUILDSTDERR:   200 | u32 __pure __weak __crc32c_le(u32 crc, unsigned char const *p, size_t len)
BUILDSTDERR:       |

I think this is a corner case in the code flow so it should
be fixed up

BUILDSTDERR: drivers/i2c/i2c-core-base.c: In function 'i2c_generic_scl_recovery':
BUILDSTDERR: drivers/i2c/i2c-core-base.c:235:5: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
BUILDSTDERR:   235 |  if (ret == -EOPNOTSUPP)
BUILDSTDERR:       |     ^


There's also a bunch of warnings from -Wpragma that show up on powerpc and arm32

BUILDSTDERR: In file included from ././include/linux/compiler_types.h:68,
BUILDSTDERR:                  from <command-line>:
BUILDSTDERR: ./include/linux/compiler-gcc.h:166:20: warning: unknown option after '#pragma GCC diagnostic' kind [-Wpragmas]
BUILDSTDERR:   166 | #define __diag(s)  _Pragma(__diag_str(GCC diagnostic s))
BUILDSTDERR:       |                    ^~~~~~~
BUILDSTDERR: ./include/linux/compiler-gcc.h:169:26: note: in expansion of macro '__diag'
BUILDSTDERR:   169 | #define __diag_GCC_8(s)  __diag(s)
BUILDSTDERR:       |                          ^~~~~~
BUILDSTDERR: ./include/linux/compiler-gcc.h:157:2: note: in expansion of macro '__diag_GCC_8'
BUILDSTDERR:   157 |  __diag_GCC_ ## version(__diag_GCC_ ## severity s)
BUILDSTDERR:       |  ^~~~~~~~~~~
BUILDSTDERR: ././include/linux/compiler_types.h:212:2: note: in expansion of macro '__diag_GCC'
BUILDSTDERR:   212 |  __diag_ ## compiler(version, ignore, option)
BUILDSTDERR:       |  ^~~~~~~
BUILDSTDERR: ./include/linux/syscalls.h:237:2: note: in expansion of macro '__diag_ignore'
BUILDSTDERR:   237 |  __diag_ignore(GCC, 8, "-Wattribute-alias",   \
BUILDSTDERR:       |  ^~~~~~~~~~~~~
BUILDSTDERR: ./include/linux/syscalls.h:225:2: note: in expansion of macro '__SYSCALL_DEFINEx'
BUILDSTDERR:   225 |  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
BUILDSTDERR:       |  ^~~~~~~~~~~~~~~~~
BUILDSTDERR: ./include/linux/syscalls.h:216:36: note: in expansion of macro 'SYSCALL_DEFINEx'
BUILDSTDERR:   216 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
BUILDSTDERR:       |                                    ^~~~~~~~~~~~~~~
BUILDSTDERR: kernel/bpf/syscall.c:2580:1: note: in expansion of macro 'SYSCALL_DEFINE3'
BUILDSTDERR:  2580 | SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, size)
BUILDSTDERR:       | ^~~~~~~~~~~~~~~


I'll see about fixing these up if someone doesn't get to them first.

Thanks,
Laura
