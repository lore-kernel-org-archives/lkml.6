Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755459AbeCHJZL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:25:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54201 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751374AbeCHJZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:25:07 -0500
Date: Thu, 8 Mar 2018 01:24:50 -0800
From: tip-bot for Konrad Rzeszutek Wilk <tipbot@zytor.com>
Message-ID: <tip-36268223c1e9981d6cfc33aff8520b3bde4b8114@git.kernel.org>
Cc: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        konrad.wilk@oracle.com, kernellwp@gmail.com, pbonzini@redhat.com,
        rkrcmar@redhat.com, kvm@vger.kernel.org, bp@alien8.de,
        linux-kernel@vger.kernel.org
Reply-To: konrad.wilk@oracle.com, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, bp@alien8.de, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rkrcmar@redhat.com, pbonzini@redhat.com,
        kernellwp@gmail.com
In-Reply-To: <20180226213019.GE9497@char.us.oracle.com>
References: <20180226213019.GE9497@char.us.oracle.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/spectre_v2: Don't check microcode versions when
 running under hypervisors
Git-Commit-ID: 36268223c1e9981d6cfc33aff8520b3bde4b8114
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  36268223c1e9981d6cfc33aff8520b3bde4b8114
Gitweb:     https://git.kernel.org/tip/36268223c1e9981d6cfc33aff8520b3bde4b8114
Author:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
AuthorDate: Mon, 26 Feb 2018 09:35:01 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 10:13:02 +0100

x86/spectre_v2: Don't check microcode versions when running under hypervisors

As:

 1) It's known that hypervisors lie about the environment anyhow (host
    mismatch)
 
 2) Even if the hypervisor (Xen, KVM, VMWare, etc) provided a valid
    "correct" value, it all gets to be very murky when migration happens
    (do you provide the "new" microcode of the machine?).

And in reality the cloud vendors are the ones that should make sure that
the microcode that is running is correct and we should just sing lalalala
and trust them.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Wanpeng Li <kernellwp@gmail.com>
Cc: kvm <kvm@vger.kernel.org>
Cc: Krčmář <rkrcmar@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180226213019.GE9497@char.us.oracle.com

---
 arch/x86/kernel/cpu/intel.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index d19e903214b4..4aa9fd379390 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -144,6 +144,13 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
 {
 	int i;
 
+	/*
+	 * We know that the hypervisor lie to us on the microcode version so
+	 * we may as well hope that it is running the correct version.
+	 */
+	if (cpu_has(c, X86_FEATURE_HYPERVISOR))
+		return false;
+
 	for (i = 0; i < ARRAY_SIZE(spectre_bad_microcodes); i++) {
 		if (c->x86_model == spectre_bad_microcodes[i].model &&
 		    c->x86_stepping == spectre_bad_microcodes[i].stepping)
