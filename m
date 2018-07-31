Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E019C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1493020894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7cuC7ss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1493020894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbeGaCwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:52:15 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:41351 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729210AbeGaCwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:52:14 -0400
Received: by mail-vk0-f66.google.com with SMTP id o82-v6so6695655vko.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 18:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=yBq+9AlXnY7ZePI2fK/8f5hJNh0LvAB6Wj3PIq+NHrc=;
        b=b7cuC7sswIIouIq/DAqCfdqaOEl+Frw8Gl2h4gvGNgHm9ptPVQjHMAbFvYxjKwzqRN
         iBifxeQnX6r1YJOTImMbgwC+PYmL5dvySoFqUAeaSbVRgyq/mHXGfV1eOFnwWpT6ZTVc
         V8CuRKOes8iwCZ9NaS/t2ssHCBJMcAqZgYCuKJrd5HH1urOpJUSoNeCExdOBHR2v22nk
         q9XmRRvwjIHjXke7COJmp18bC3P0nGlnPHbIlatunkI/vCQ7ZcdMpe4hrltd+005z3IS
         Bs6ZCqNRs9CLelETm8opuqb/8lW2DOoyfppluFd/NSuaZj0G4oGRpMPQH86MtUFBpajH
         WMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yBq+9AlXnY7ZePI2fK/8f5hJNh0LvAB6Wj3PIq+NHrc=;
        b=TUNlQIVDHBbfenun5Qa00xSlJE040bHUuNGymmIRl+FUx99aeYmAo4hWjhLH912Gka
         ejNkLJyj71YrduH0ldWUUnWiTJYGgEecdflVmieBseFLuYvx2oUFgs+JjUgLZCb7qxox
         UI3kFLF5Rbolf7kii+EbuyYNOs8YJyZVVrmUz2KZYYohPtweNAa3dx87HQgtly/u+z3a
         APU/zdwK3lQOUcA4a4B52yyxxmCix55hdVlcfWTO9x+QAwrz+ktbFhfAMbkvCL+U/Jxy
         QGuR/MAtKmipj4lVi/ksrJiGiIQb/ZcUmk4gsIEFCCNornMkKg83G+DnWT7oPbHD+FZ3
         /1Ow==
X-Gm-Message-State: AOUpUlFqkRCdYk9lvFDHyumZAaMENIL56hh5QZ75LGqbAQZf5aXMIpGS
        vuK/CBObE5FI2wEOmVi9a62Qf0i0R+iptSqYyPuihofV
X-Google-Smtp-Source: AAOMgpdE+lC9m1vbRgVj4kQ6YSFK+OvluXOXWndHF4W1a9ZkGEoPCveYg4FMBMuhd5i+TYGZrLKYc/Og8kU70L8d4Wo=
X-Received: by 2002:a1f:ccc5:: with SMTP id c188-v6mr11931902vkg.151.1532999672749;
 Mon, 30 Jul 2018 18:14:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:7187:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 18:14:12
 -0700 (PDT)
From:   Adam Novak <interfect@gmail.com>
Date:   Mon, 30 Jul 2018 18:14:12 -0700
Message-ID: <CADPp2fB3Oj3Jm08rVqeHxX855EnO8+22-H552Q6AFfJL-dWmtQ@mail.gmail.com>
Subject: Problems with Zen under Xen and recent Linux kernel improvements
To:     linux-kernel@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I was advised to take this here, and to Boris Ostrovsky and Juergen
Gross, by Thomas Gleixner.

I am having some trouble with the new speculation control code that
has been added to the Linux kernel, for AMD Zen CPUs. I am running an
AMD Ryzen 7 1700, and I am running Linux as a Xen dom0 (which is part
of the problem; the code seems to work fine running outside of Xen).

I started having trouble on Ubuntu's commit
3f6a3b035f91a22c0d3bd27630bf61eac9c8cf6c, "x86/speculation: Handle HT
correctly on AMD", which appears to be cherry-picked from
1f50ddb4f4189243c05926b842dc1a0332195f31. Since that commit, my system
hangs during the boot process; it starts starting stuff up and trying
to mount things and printing "[OK]" messages, but then fairly early in
the boot process the kernel complains that it is "unable to handle
kernel NULL pointer deference at 000...0008"

On my Ubuntu bug:

https://bugs.launchpad.net/bugs/1777338

I have a "Screenshot of the null pointer dereference message". It is
running into trouble during a spin lock in the new
speculative_store_bypass_update().

Has anyone else seen this behavior on these CPUs under Xen (I am using 4.9)?

Since the commit that started the problem has to do with sibling CPU
cores, I suspect that the problem may have something to do with how
Xen handles hyperthreading. Namely, Xen seems to hide hyperthreading
from the VMs running under it (including from dom0). Instead of having
8 CPUs with 2 threads each, my Linux running under Xen on my 8-core
Ryzen chip sees 16 virtual CPU cores, all of which still report
themselves as being the Ryzen 7 1700 processor.

For reference, my /proc/cpuinfo looks like this at the tail end:

processor    : 14
vendor_id    : AuthenticAMD
cpu family    : 23
model        : 1
model name    : AMD Ryzen 7 1700 Eight-Core Processor
stepping    : 1
microcode    : 0x8001137
cpu MHz        : 2994.027
cache size    : 512 KB
physical id    : 0
siblings    : 16
core id        : 0
cpu cores    : 16
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu de tsc msr pae mce cx8 apic mca cmov pat clflush
mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm constant_tsc
rep_good nopl nonstop_tsc cpuid extd_apicid pni pclmulqdq ssse3 fma
cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand hypervisor
lahf_lm cmp_legacy abm sse4a misalignsse 3dnowprefetch bpext cpb
vmmcall fsgsbase bmi1 avx2 bmi2 rdseed adx clflushopt sha_ni xsaveopt
xsavec xgetbv1 clzero ibpb arat ssbd
bugs        : fxsave_leak null_seg spectre_v1 spectre_v2 spec_store_bypass
bogomips    : 5989.03
TLB size    : 2560 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 48 bits physical, 48 bits virtual
power management:

processor    : 15
vendor_id    : AuthenticAMD
cpu family    : 23
model        : 1
model name    : AMD Ryzen 7 1700 Eight-Core Processor
stepping    : 1
microcode    : 0x8001137
cpu MHz        : 2994.027
cache size    : 512 KB
physical id    : 0
siblings    : 16
core id        : 0
cpu cores    : 16
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu de tsc msr pae mce cx8 apic mca cmov pat clflush
mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm constant_tsc
rep_good nopl nonstop_tsc cpuid extd_apicid pni pclmulqdq ssse3 fma
cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand hypervisor
lahf_lm cmp_legacy abm sse4a misalignsse 3dnowprefetch bpext cpb
vmmcall fsgsbase bmi1 avx2 bmi2 rdseed adx clflushopt sha_ni xsaveopt
xsavec xgetbv1 clzero ibpb arat ssbd
bugs        : fxsave_leak null_seg spectre_v1 spectre_v2 spec_store_bypass
bogomips    : 5989.03
TLB size    : 2560 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 48 bits physical, 48 bits virtual
power management:

All the cores have core ID 0, and the CPU says it has 16 cores. When
booted outside of Xen, I still have processors 0-15 in /proc/cpuinfo,
but they come in pairs with core IDs 0-7, and "CPU cores" is 8.

If it looks like this during the boot process, and the new
sibling-thread-aware code is looking for hyperthreading that Xen
doesn't expose, maybe that is causing the problem?

Thanks,
-Adam
