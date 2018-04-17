Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbeDQVds (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 17:33:48 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:37828 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752939AbeDQVdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 17:33:46 -0400
X-Google-Smtp-Source: AIpwx4+3F7tmEV1xyC5kpEKoh9NdtfoRauYPO+c1vvA3BTIfNIibcyOhkWfm4fGj/aX6N5DoVY4F15ECNykOl7ZmyYQ=
MIME-Version: 1.0
From: Gregory Panic <airman.price@gmail.com>
Date: Tue, 17 Apr 2018 17:33:25 -0400
Message-ID: <CAMB+E4gS=F8kXMNTtKdLr9y-C_+NaSPQm3M1m9xC0Sbhn+hjYw@mail.gmail.com>
Subject: RW GDT replaced by Read-Only GDT and a GPL Interface
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been working on a VMX driver for a custom hypervisor which
depends on features that KVM is not built for.  Up until recently
(4.12.x), our module has been working just fine.  When we started to
build support for Ubuntu 18.04 (4.15.x+), we ran into an issue.

Unfortunately the following commits broke functionality, causing
kernel segfaults, due to a placing the GDT in the FIXMAP area, and
setting that mapping to Read-Only.
#69218e47994da614e7af600bf06887750ab6657a
and
#45fc8757d1d2128e342b4e7ef39adedf7752faac

Up until now, the GDT has been Read-Write, which allowed for resetting
the TSS to available, and then Reloading it after a VMExit.  The KVM
and Xen work-arounds for this were implemented by creating a GPL'd
interface to remap the GDT to the original Read/Write mapping and then
back.

Up to this point we've been able to maintain independence from GPL,
but with this change the only alternative to using this interface
would be to basically subvert the intent of the security patch in my
module.  Unfortunately this leaves me with the choice of letting this
one interface force GPL upon years of work, or implementing
unsafe/unadvised code.

I was wondering if it would be possible to change the gdt_page,
load_direct_gdt, and load_fixmap_gdt functions to EXPORT_SYMBOL
instead of EXPORT_SYMBOL_GPL as listed below.  This would restore the
lost functionality which we had relied on while using the recommended
interface to the kernel for this purpose.

Thank you for your consideration

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8a5b185..82fbd67 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -152,7 +152,7 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct gdt_page,
gdt_page) = { .gdt = {
        GDT_STACK_CANARY_INIT
 #endif
 } };
-EXPORT_PER_CPU_SYMBOL_GPL(gdt_page);
+EXPORT_PER_CPU_SYMBOL(gdt_page);

 static int __init x86_mpx_setup(char *s)
 {
@@ -519,7 +519,7 @@ void load_direct_gdt(int cpu)
        gdt_descr.size = GDT_SIZE - 1;
        load_gdt(&gdt_descr);
 }
-EXPORT_SYMBOL_GPL(load_direct_gdt);
+EXPORT_SYMBOL(load_direct_gdt);

 /* Load a fixmap remapping of the per-cpu GDT */
 void load_fixmap_gdt(int cpu)
@@ -530,7 +530,7 @@ void load_fixmap_gdt(int cpu)
        gdt_descr.size = GDT_SIZE - 1;
        load_gdt(&gdt_descr);
 }
-EXPORT_SYMBOL_GPL(load_fixmap_gdt);
+EXPORT_SYMBOL(load_fixmap_gdt);
