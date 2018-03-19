Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755118AbeCSFFb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 01:05:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53510 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751084AbeCSFF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 01:05:29 -0400
X-Google-Smtp-Source: AG47ELuusLDzmsTh3mFYYm8MZf1Y3FKA7ag1sQqzm+uo89kZgLV0R1KV8C9mgn7e1mUcYOK0Tw1hVNzhC8/4jrGLz4g=
MIME-Version: 1.0
References: <20180317170953.111610-1-edumazet@google.com> <201803190119.XsZZ8VZX%fengguang.wu@intel.com>
In-Reply-To: <201803190119.XsZZ8VZX%fengguang.wu@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Mar 2018 05:05:16 +0000
Message-ID: <CANn89iJ7HWBQm4deBzjFEJezHegfvmUc0HV-GcX=01T71=LNKg@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86, msr: add rdmsr_safe_on_cpu_resched() and use it
 in msr_read()
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 18, 2018 at 10:14 AM kbuild test robot <lkp@intel.com> wrote:

> Hi Eric,

> Thank you for the patch! Yet something to improve:

> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.16-rc5 next-20180316]
> [if your patch is applied to the wrong git tree, please drop us a note to
help improve the system]

> url:
https://github.com/0day-ci/linux/commits/Eric-Dumazet/x86-msr-add-rdmsr_safe_on_cpu_resched-and-use-it-in-msr_read/20180319-001007
> config: i386-randconfig-s1-201811 (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=i386

> All errors (new ones prefixed by >>):

>     arch/x86/kernel/msr.c: In function 'msr_read':
> >> arch/x86/kernel/msr.c:63:9: error: implicit declaration of function
'rdmsr_safe_on_cpu_resched' [-Werror=implicit-function-declaration]
>        err = rdmsr_safe_on_cpu_resched(cpu, reg, &data[0], &data[1]);
>              ^~~~~~~~~~~~~~~~~~~~~~~~~
>     cc1: some warnings being treated as errors

I guess I will have to add in V2 this missing part :

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index
117a286660c61cf9c10e68f0b48d27e2de17deab..15e220243a4d5e9da524fb7733e23e2766b6eb12
100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -363,6 +363,11 @@ static inline int rdmsr_safe_on_cpu(unsigned int cpu,
u32 msr_no,
  {
         return rdmsr_safe(msr_no, l, h);
  }
+static inline int rdmsr_safe_on_cpu_resched(unsigned int cpu, u32 msr_no,
+                                           u32 *l, u32 *h)
+{
+       return rdmsr_safe(msr_no, l, h);
+}
  static inline int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 l,
u32 h)
  {
         return wrmsr_safe(msr_no, l, h);
