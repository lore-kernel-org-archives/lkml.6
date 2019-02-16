Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381A0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056C421A4C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733135AbfBPUSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 15:18:48 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54819 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfBPUSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 15:18:47 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gv6Q3-0004j3-I3; Sat, 16 Feb 2019 21:18:39 +0100
Date:   Sat, 16 Feb 2019 21:18:39 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jann Horn <jannh@google.com>
cc:     baloo@gandi.net, Andy Lutomirski <luto@amacapital.net>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Pascal Bouchareine <pascal@gandi.net>
Subject: Re: [PATCH] x86: uaccess: fix regression in unsafe_get_user
In-Reply-To: <CAG48ez2tYizTKncevLF=AMQ2nm3D=SqGHH5bM5f-U0fhQ1nL9Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1902161358160.1683@nanos.tec.linutronix.de>
References: <20190215235901.23541-1-baloo@gandi.net> <CAG48ez2tYizTKncevLF=AMQ2nm3D=SqGHH5bM5f-U0fhQ1nL9Q@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Feb 2019, Jann Horn wrote:
> On Sat, Feb 16, 2019 at 12:59 AM <baloo@gandi.net> wrote:
> > When extracting an initramfs, a filename may be near an allocation boundary.
> > Should that happen, strncopy_from_user will invoke unsafe_get_user which
> > may cross the allocation boundary. Should that happen, unsafe_get_user will
> > trigger a page fault, and strncopy_from_user would then bailout to
> > byte_at_a_time behavior.
> >
> > unsafe_get_user is unsafe by nature, and rely on pagefault to detect boundaries.
> > After 9da3f2b74054 ("x86/fault: BUG() when uaccess helpers fault on kernel addresses")
> > it may no longer rely on pagefault as the new page fault handler would
> > trigger a BUG().
> >
> > This commit allows unsafe_get_user to explicitly trigger pagefaults and
> > handle them directly with the error target label.
> 
> Oof. So basically the init code is full of things that just call
> syscalls instead of using VFS functions (which don't actually exist
> for everything), and the VFS syscalls use getname_flags(), which uses
> strncpy_from_user(), which can access out-of-bounds pages on
> architectures that set CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS, and
> that in summary means that all the init code is potentially prone to
> tripping over this?

Not all init code. It should be only the initramfs decompression.

> I don't particularly like this approach to fixing it, but I also don't
> have any better ideas, so I guess unless someone else has a bright
> idea, this patch might have to go in.

So we know that this happens in the context of decompress() which calls
flush_buffer() for every chunk. flush_buffer() gets the start_address and
the length. We also know that the fault can only happen within:

    start_address <= fault_address < start_address + length + 8;

So something like the untested workaround below should cover the initramfs
oddity and avoid to weaken the protection for all other cases.

Thanks,

	tglx

8<---------------
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -1,5 +1,6 @@
 #include <linux/extable.h>
 #include <linux/uaccess.h>
+#include <linux/initrd.h>
 #include <linux/sched/debug.h>
 #include <xen/xen.h>
 
@@ -161,6 +162,14 @@ static bool bogus_uaccess(struct pt_regs
 	if (current->kernel_uaccess_faults_ok)
 		return false;
 
+	/*
+	 * initramfs decompression can trigger a fault when
+	 * unsafe_get_user() goes over the boundary of the buffer. That's a
+	 * valid case for e.g. strncpy_from_user().
+	 */
+	if (initramfs_fault_in_decompress(fault_addr))
+		return false;
+
 	/* This is bad. Refuse the fixup so that we go into die(). */
 	if (trapnr == X86_TRAP_PF) {
 		pr_emerg("BUG: pagefault on kernel address 0x%lx in non-whitelisted uaccess\n",
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -1,5 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#ifndef LINUX_INITRD_H
+#define LINUX_INITRD_H
+
 #define INITRD_MINOR 250 /* shouldn't collide with /dev/ram* too soon ... */
 
 /* 1 = load ramdisk, 0 = don't load */
@@ -25,3 +28,14 @@ extern phys_addr_t phys_initrd_start;
 extern unsigned long phys_initrd_size;
 
 extern unsigned int real_root_dev;
+
+#ifdef CONFIG_BLK_DEV_INITRD
+bool initramfs_fault_in_decompress(unsigned long addr);
+#else
+static inline bool initramfs_fault_in_decompress(unsigned long addr)
+{
+	return false;
+}
+#endif
+
+#endif
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -403,13 +403,27 @@ static __initdata int (*actions[])(void)
 	[Reset]		= do_reset,
 };
 
+static unsigned long flush_start;
+static unsigned long flush_length;
+
+bool initramfs_fault_in_decompress(unsigned long addr)
+{
+	return addr >= flush_start && addr < flush_start + flush_length + 8;
+}
+
 static long __init write_buffer(char *buf, unsigned long len)
 {
+	/* Store address and length for uaccess fault handling */
+	flush_start = (unsigned long) buf;
+	flush_length = len;
+
 	byte_count = len;
 	victim = buf;
 
 	while (!actions[state]())
 		;
+	/* Clear the uaccess fault handling region */
+	flush_start = flush_length = 0;
 	return len - byte_count;
 }
 








