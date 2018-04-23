Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754235AbeDWIF4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:05:56 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:52701 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753109AbeDWIFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:05:53 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] KVM: x86: use timespec64 for KVM_HC_CLOCK_PAIRING
Date: Mon, 23 Apr 2018 10:04:26 +0200
Message-Id: <20180423080512.1614520-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:qv2vviUhSJ/fJDEihO9m+rlRZf7wod8efxdcrvfrNvYnweN3G+J
 ovKLKEjuzPiK1CSZ7DvSr3VG6anwI21T4+Ht8xIt7y6UW9y+1VclYSna821QQKWoVw9xPMC
 SAlge54zvTlubOk5/4QpyCUgNiBYaFcEwPUtotwwVtO0iRHLqddrKBYtIH1WY4Go+GnL6NF
 JbI4T0ks7NCETFuD8vmQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:duqV5tNnCtA=:uvTtFl1LuujZI0F3iRZxh+
 H2K5qOpzZdJv2gtyenJT10S/lvUdjEBO7Y0ur5mqbpkaDLRsGwM0gIBVDpw+RLFU5Np4krzVx
 osdAecD0e/x8IFub/tlXouePewX/3n8xscU364RGds58guuXLUO36jv3CMsTfdIGKPww0HrRa
 saH5Q3zFOJkMQu+hrFZT9hBH9JS5JVNOjQsR6GSsz0IrHG6Cql/EjPNKR/9i5ye+EKczf2joL
 juCU03few0CZP3Btm2/8FBZQHW0ArA5XnZDneOrhRFFyduOPO8oARzlJUKeauMUQ5btVylgGH
 Ege1pjIlf3uxqrlWCt+llaFCqx3xhqHH2da7FDJPTa6/NRgEGOCCv8ImyiHzNWTW/iyr27l6h
 LW6zeJpvkPmZFkPjnmEpLTyc9jOcIP7MFB66DrVcYaHDB8q7TNBVB/6MDzBM6FhBS1EZ9X8hy
 l9lLCvMFSPZHSc7kqGg1oCE7SwzoH4rNvNBxVxTwOsqnA/OFiv8L4k6t4OPB7IkpxmGdVNOUm
 YaF/TGqCMOUIsTtg8FBSL6oPyCM8AgmxQuhiteeRQVQz6dM9fstaRFk14c6V9poPpkgXM3AJs
 o1imzMmE2naW3cFZtoSU3EqqAVf5EnhVCGqZMYHAVuCI+YFn4mXuuY8qx/xKGwOceflLphv85
 PaO/SNT++4qo4Mz+S4IvbnWAHI57EQkUqFtmn0wr0abfu4ZNFIb6cDsgw7xM5QYbuwpaWnpcW
 c/Cgt0nM1HCgzQZ29VUaLkTa0YfeB3/fsu454g==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hypercall was added using a struct timespec based implementation,
but we should not use timespec in new code.

This changes it to timespec64. There is no functional change
here since the implementation is only used in 64-bit kernels
that use the same definition for timespec and timespec64.

Fixes: 55dd00a73a51 ("KVM: x86: add KVM_HC_CLOCK_PAIRING hypercall")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I originally sent this in October, but got no reply. The patch
is still required for the overall cleanup of 'timespec' uses
in the kernel, please apply.
---
 arch/x86/kvm/x86.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b2ff74b12ec4..961ee64cb137 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1755,7 +1755,7 @@ static int do_monotonic_boot(s64 *t, u64 *tsc_timestamp)
 	return mode;
 }
 
-static int do_realtime(struct timespec *ts, u64 *tsc_timestamp)
+static int do_realtime(struct timespec64 *ts, u64 *tsc_timestamp)
 {
 	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
 	unsigned long seq;
@@ -1788,7 +1788,7 @@ static bool kvm_get_time_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp)
 }
 
 /* returns true if host is using TSC based clocksource */
-static bool kvm_get_walltime_and_clockread(struct timespec *ts,
+static bool kvm_get_walltime_and_clockread(struct timespec64 *ts,
 					   u64 *tsc_timestamp)
 {
 	/* checked again under seqlock below */
@@ -6610,7 +6610,7 @@ static int kvm_pv_clock_pairing(struct kvm_vcpu *vcpu, gpa_t paddr,
 			        unsigned long clock_type)
 {
 	struct kvm_clock_pairing clock_pairing;
-	struct timespec ts;
+	struct timespec64 ts;
 	u64 cycle;
 	int ret;
 
-- 
2.9.0
