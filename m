Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751052AbeFDR1j (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 13:27:39 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:37728 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbeFDR1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 13:27:38 -0400
From: Michael Rodin <michael-git@rodin.online>
To: tglx@linutronix.de, mingo@redhat.com, x86@kernel.org
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org,
        Michael Rodin <michael-git@rodin.online>
Subject: [PATCH] arch/x86/entry/vsyscall/vsyscall_gtod.c: remove __read_mostly from vclocks_used
Date: Mon,  4 Jun 2018 19:27:11 +0200
Message-Id: <20180604172711.18962-1-michael-git@rodin.online>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable "vclocks_used" doesn't appear to be "read mostly".
Measurements of the access frequency with perf stat [1] and
perf report show, that approximately half of the accesses to
this variable are write accesses and happen in update_vsyscall()
in the file arch/x86/entry/vsyscall/vsyscall_gtod.c.
The measurements were done with the kernel 4.13.0-43-generic used by
ubuntu as well as with the stable kernel 4.16.7 with a custom config.
I've used "perf bench sched" and iperf3 as workloads.

This was discovered during my master thesis in the CADOS project [2].

[1] perf stat --all-cpus --group --event="{mem:addr/4:rw:k,mem:addr/4:w:k}"
[2] https://www.sra.uni-hannover.de/Research/CADOS/

Signed-off-by: Michael Rodin <michael-git@rodin.online>
---
 arch/x86/entry/vsyscall/vsyscall_gtod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_gtod.c b/arch/x86/entry/vsyscall/vsyscall_gtod.c
index e1216dd95c04..fc39f701fe4a 100644
--- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
+++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
@@ -17,7 +17,7 @@
 #include <asm/vgtod.h>
 #include <asm/vvar.h>
 
-int vclocks_used __read_mostly;
+int vclocks_used;
 
 DEFINE_VVAR(struct vsyscall_gtod_data, vsyscall_gtod_data);
 
-- 
2.14.1
