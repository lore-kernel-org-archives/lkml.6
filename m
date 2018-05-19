Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbeESOKK (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 10:10:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:41733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752317AbeESOKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 10:10:07 -0400
Message-ID: <1526738996.5365.1.camel@gmx.de>
Subject: Re: [PATCH] x86: UV: raw_spinlock conversion
From: Mike Galbraith <gleep@gmx.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Date: Sat, 19 May 2018 16:09:56 +0200
In-Reply-To: <20180507073928.shmtfpqyhgxya53b@linutronix.de>
References: <20180504111459.24825-1-bigeasy@linutronix.de>
         <20180504111459.24825-2-bigeasy@linutronix.de>
         <alpine.DEB.2.21.1805061225550.1685@nanos.tec.linutronix.de>
         <1525604359.28142.3.camel@gmx.de>
         <20180507073928.shmtfpqyhgxya53b@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:4iExFV1RY4vPjPkV23iNzmGwhJ4R5aTw4Z7722JhKqiJG+ncYlk
 feuu9Fa7frSKA6+rKg7O4gQA4E2xSkAftMhQx8wIPgVPPjYOcL5dGn+1P4LYhYWpOZdVfTj
 qbmQqJUS51vqiyzU0V6yusnKFL7tSlWe+3hFzBIvlGBv01GPWIPsqz0qc2+6+/h3Mvws4uP
 zVMlm5MSgZEpnqjtDdFsQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8pNJfSQQWY8=:anZUNizViUI6kM+YROB9iF
 moLWJMjsrHMPrl0Y06iU1AQqAWf9FmalpFFpaiNjwnE9X79JbNt99oHHYi3fmQs2FpdaEA6Sk
 +3M6qqZcHMYcSgksO4QonAwIvZ7VDUhT/gew9t9rc61fFU0PgczTdvQJpO2+mwk5YIW3NVEpY
 GUdfMEnjujFQyX0u0q0vurWTqaIH5CjBzdqV8GthE7y95J6Isg/+qtFkhYnG1TArhNuLdHwz7
 0MKHvcvvtxck4+NbZBEl6xPh3+OWlIJ/KhFRRMuchBEMDMGu9ZoxTl3SCALdHnMc9Ruf4snBd
 RVVgeLCsg/U9g57mfv6HNMEWrYXU7SsdYZ15XjSvNOncwEdyMTBXxuquu6m59e6tyeqAwwZpo
 TT494ur783+0f8SQbV5UQD1Luu/4SDEBLqxrdpTYb0TnlgUfUSM7ei9vEWxbmX6q7iDfWLgPT
 Yf6zhRO43RBaUcS4d9OwwMNQgfDJmXlP1i+qwx7C8C547ZOmjz3L0vRIkFoiB2W3UKbq9Ktqk
 5otYBUkWHGQcdwYvUcbf+91d3vh2ckvGJ1qJY2HZiEbQ9Ijb489m/Yr/Xl6yEVA8vDIGlb2lX
 my7S/2+C9bboi2DKW4e9zWGeFdLKaNYUI3cdJz7PVnXdDB+S9HHLrltqnd6UhEm9ggZYrKyY3
 evLTHgrhndPVdh2wits4FNSOSZuEGwk4hr90xNe4dRFtddutaI21dlgor3pB1Eq+nLqQXPLkd
 HnzDql6AURNI6Zf6BzcoPkAVQKI5p5dh7dtCLBr+FEc0Qd/Xry4yVlLoA0cVOsWYNKyayv7Iw
 weA2god
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-07 at 09:39 +0200, Sebastian Andrzej Siewior wrote:
> On 2018-05-06 12:59:19 [+0200], Mike Galbraith wrote:
> > On Sun, 2018-05-06 at 12:26 +0200, Thomas Gleixner wrote:
> > > On Fri, 4 May 2018, Sebastian Andrzej Siewior wrote:
> > > 
> > > > From: Mike Galbraith <umgwanakikbuti@gmail.com>
> > > > 
> > > > Shrug.  Lots of hobbyists have a beast in their basement, right?
> > > 
> > > This hardly qualifies as a proper changelog ...
> > 
> > Hm, that wasn't intended to be a changelog.
> > 
> > This patch may not be current either, I haven't tested RT on a UV box
> > in quite some time.
> 
> That last hunk looks like something that would be required even for !RT. 
> Would you mind to check that patch and write a changelog? If it doesn't
> work for RT there is no need to carry this in -RT.

None of that patch is needed for a UV3000, but the below is.  It's
likely still valid for now ancient UV boxen, but the UV100 the patch
was originally written for (2011/2.6.33-rt) has apparently wandered off
to become a beer keg or something meanwhile, so I can't test.

UV: Fix uv_bau_init() check_preemption_disabled() gripeage

[    2.851947] BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
[    2.851951] caller is uv_bau_init+0x28/0xb62
[    2.851954] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.17.0-rc5-0.g3e3e37b-rt_debug
[    2.851956] Hardware name: SGI UV3000/UV3000, BIOS SGI UV 3000 series BIOS 01/15/2015
[    2.851957] Call Trace:
[    2.851964]  dump_stack+0x85/0xcb
[    2.851969]  check_preemption_disabled+0x10c/0x120
[    2.851972]  ? init_per_cpu+0x88c/0x88c
[    2.851974]  uv_bau_init+0x28/0xb62
[    2.851979]  ? lapic_cal_handler+0xbb/0xbb
[    2.851982]  ? rt_mutex_unlock+0x35/0x50
[    2.851985]  ? init_per_cpu+0x88c/0x88c
[    2.851988]  ? set_debug_rodata+0x11/0x11
[    2.851991]  do_one_initcall+0x46/0x249
[    2.851995]  kernel_init_freeable+0x207/0x29c
[    2.851999]  ? rest_init+0xd0/0xd0
[    2.852000]  kernel_init+0xa/0x110
[    2.852000]  ret_from_fork+0x3a/0x50

(gdb) list *uv_bau_init+0x28
0xffffffff824a4d96 is in uv_bau_init (./arch/x86/include/asm/uv/uv_hub.h:212).
207             return (struct uv_hub_info_s *)__uv_hub_info_list[node];
208     }
209
210     static inline struct uv_hub_info_s *_uv_hub_info(void)
211     {
212             return (struct uv_hub_info_s *)uv_cpu_info->p_uv_hub_info;
213     }
214     #define uv_hub_info     _uv_hub_info()
215
216     static inline struct uv_hub_info_s *uv_cpu_hub_info(int cpu)
(gdb)

arch/x86/include/asm/uv/uv_hub.h:
197 #define uv_cpu_info             this_cpu_ptr(&__uv_cpu_info)

This and other substitutions make uv_bau_init() annoying for a PREEMPT
kernel, but PREEMPT_RT can silence the lot with one migrate_disable().

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 arch/x86/platform/uv/tlb_uv.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -2213,6 +2213,8 @@ static int __init uv_bau_init(void)
 	if (!is_uv_system())
 		return 0;
 
+	migrate_disable();
+
 	if (is_uv4_hub())
 		ops = uv4_bau_ops;
 	else if (is_uv3_hub())
@@ -2269,6 +2271,8 @@ static int __init uv_bau_init(void)
 		}
 	}
 
+	migrate_enable();
+
 	return 0;
 
 err_bau_disable:
@@ -2276,6 +2280,7 @@ static int __init uv_bau_init(void)
 	for_each_possible_cpu(cur_cpu)
 		free_cpumask_var(per_cpu(uv_flush_tlb_mask, cur_cpu));
 
+	migrate_enable();
 	set_bau_off();
 	nobau_perm = 1;
 
