Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754012AbeA3XCA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 18:02:00 -0500
Received: from terminus.zytor.com ([65.50.211.136]:56431 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753642AbeA3XB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 18:01:58 -0500
Date: Tue, 30 Jan 2018 15:00:45 -0800
From: tip-bot for Vitaly Kuznetsov <tipbot@zytor.com>
Message-ID: <tip-89a8f6d4904c8cf3ff8fee9fdaff392a6bbb8bf6@git.kernel.org>
Cc: vkuznets@redhat.com, luto@kernel.org, hpa@zytor.com, mmorsy@redhat.com,
        pbonzini@redhat.com, sthemmin@microsoft.com, rkagan@virtuozzo.com,
        Michael.H.Kelley@microsoft.com, mingo@kernel.org,
        haiyangz@microsoft.com, cavery@redhat.com, tglx@linutronix.de,
        kys@microsoft.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, kys@microsoft.com, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, haiyangz@microsoft.com,
        Michael.H.Kelley@microsoft.com, mingo@kernel.org, cavery@redhat.com,
        mmorsy@redhat.com, rkagan@virtuozzo.com, pbonzini@redhat.com,
        sthemmin@microsoft.com, luto@kernel.org, vkuznets@redhat.com,
        hpa@zytor.com
In-Reply-To: <20180124132337.30138-2-vkuznets@redhat.com>
References: <20180124132337.30138-2-vkuznets@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/hyperv] x86/hyperv: Check for required priviliges in
 hyperv_init()
Git-Commit-ID: 89a8f6d4904c8cf3ff8fee9fdaff392a6bbb8bf6
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

Commit-ID:  89a8f6d4904c8cf3ff8fee9fdaff392a6bbb8bf6
Gitweb:     https://git.kernel.org/tip/89a8f6d4904c8cf3ff8fee9fdaff392a6bbb8bf6
Author:     Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate: Wed, 24 Jan 2018 14:23:31 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jan 2018 23:55:32 +0100

x86/hyperv: Check for required priviliges in hyperv_init()

In hyperv_init() its presumed that it always has access to VP index and
hypercall MSRs while according to the specification it should be checked if
it's allowed to access the corresponding MSRs before accessing them.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: kvm@vger.kernel.org
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: devel@linuxdriverproject.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Cathy Avery <cavery@redhat.com>
Cc: Mohammed Gamal <mmorsy@redhat.com>
Link: https://lkml.kernel.org/r/20180124132337.30138-2-vkuznets@redhat.com

---
 arch/x86/hyperv/hv_init.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 189a398..21f9d53 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -110,12 +110,19 @@ static int hv_cpu_init(unsigned int cpu)
  */
 void hyperv_init(void)
 {
-	u64 guest_id;
+	u64 guest_id, required_msrs;
 	union hv_x64_msr_hypercall_contents hypercall_msr;
 
 	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
 		return;
 
+	/* Absolutely required MSRs */
+	required_msrs = HV_X64_MSR_HYPERCALL_AVAILABLE |
+		HV_X64_MSR_VP_INDEX_AVAILABLE;
+
+	if ((ms_hyperv.features & required_msrs) != required_msrs)
+		return;
+
 	/* Allocate percpu VP index */
 	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
 				    GFP_KERNEL);
