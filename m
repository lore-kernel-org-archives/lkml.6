Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754024AbeA3XCV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 18:02:21 -0500
Received: from terminus.zytor.com ([65.50.211.136]:49875 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbeA3XCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 18:02:20 -0500
Date: Tue, 30 Jan 2018 15:01:10 -0800
From: tip-bot for Vitaly Kuznetsov <tipbot@zytor.com>
Message-ID: <tip-e2768eaa1ca4fbb7b778da5615cce3dd310352e6@git.kernel.org>
Cc: rkrcmar@redhat.com, tglx@linutronix.de, kys@microsoft.com,
        mmorsy@redhat.com, luto@kernel.org, mingo@kernel.org,
        pbonzini@redhat.com, Michael.H.Kelley@microsoft.com, cavery@redhat.com,
        vkuznets@redhat.com, haiyangz@microsoft.com, hpa@zytor.com,
        sthemmin@microsoft.com, rkagan@virtuozzo.com,
        linux-kernel@vger.kernel.org
Reply-To: haiyangz@microsoft.com, cavery@redhat.com, vkuznets@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, sthemmin@microsoft.com,
        rkagan@virtuozzo.com, mmorsy@redhat.com, rkrcmar@redhat.com,
        tglx@linutronix.de, kys@microsoft.com, pbonzini@redhat.com,
        Michael.H.Kelley@microsoft.com, luto@kernel.org, mingo@kernel.org
In-Reply-To: <20180124132337.30138-3-vkuznets@redhat.com>
References: <20180124132337.30138-3-vkuznets@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/hyperv] x86/hyperv: Add a function to read both TSC and
 TSC page value simulateneously
Git-Commit-ID: e2768eaa1ca4fbb7b778da5615cce3dd310352e6
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

Commit-ID:  e2768eaa1ca4fbb7b778da5615cce3dd310352e6
Gitweb:     https://git.kernel.org/tip/e2768eaa1ca4fbb7b778da5615cce3dd310352e6
Author:     Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate: Wed, 24 Jan 2018 14:23:32 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jan 2018 23:55:32 +0100

x86/hyperv: Add a function to read both TSC and TSC page value simulateneously

This is going to be used from KVM code where both TSC and TSC page value
are needed.

Nothing is supposed to use the function when Hyper-V code is compiled out,
just BUG().

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
Link: https://lkml.kernel.org/r/20180124132337.30138-3-vkuznets@redhat.com

---
 arch/x86/hyperv/hv_init.c       |  1 +
 arch/x86/include/asm/mshyperv.h | 23 +++++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 21f9d53..1a6c63f 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -37,6 +37,7 @@ struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 {
 	return tsc_pg;
 }
+EXPORT_SYMBOL_GPL(hv_get_tsc_page);
 
 static u64 read_hv_clock_tsc(struct clocksource *arg)
 {
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 8bf450b..6b1d4ea 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -325,9 +325,10 @@ static inline void hyperv_setup_mmu_ops(void) {}
 
 #ifdef CONFIG_HYPERV_TSCPAGE
 struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
-static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
+static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
+				       u64 *cur_tsc)
 {
-	u64 scale, offset, cur_tsc;
+	u64 scale, offset;
 	u32 sequence;
 
 	/*
@@ -358,7 +359,7 @@ static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
 
 		scale = READ_ONCE(tsc_pg->tsc_scale);
 		offset = READ_ONCE(tsc_pg->tsc_offset);
-		cur_tsc = rdtsc_ordered();
+		*cur_tsc = rdtsc_ordered();
 
 		/*
 		 * Make sure we read sequence after we read all other values
@@ -368,7 +369,14 @@ static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
 
 	} while (READ_ONCE(tsc_pg->tsc_sequence) != sequence);
 
-	return mul_u64_u64_shr(cur_tsc, scale, 64) + offset;
+	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
+}
+
+static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
+{
+	u64 cur_tsc;
+
+	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
 }
 
 #else
@@ -376,5 +384,12 @@ static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 {
 	return NULL;
 }
+
+static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
+				       u64 *cur_tsc)
+{
+	BUG();
+	return U64_MAX;
+}
 #endif
 #endif
