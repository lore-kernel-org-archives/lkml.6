Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuIcBZvRlb4HAHzjzEDPV6Wn77W2lUShUQ5tClsRD0WlajAnq7TOqNmlK2JSL2B7PzjhlA8
ARC-Seal: i=1; a=rsa-sha256; t=1521483573; cv=none;
        d=google.com; s=arc-20160816;
        b=j2vf5Zwgla0jnRf/UT6wGCvVeg3tdv2XKVd3ore+tP8CcrdNlqjsZ2Na9VtR/GelTp
         i4nu1onhdFMhuNChrO6ptVFYFS0cQwx0qQW9BmhyEY8SwzH5WV8F9p1eVGRUchTyiQxF
         JzvPVtsIrGAiGejNcai75gni05A8K1S2ZJw65trqDJ1Ct1dKlHL00FTVLBzG+D/CnVPl
         99VBB5xMeqMyEL9JATeIezA+6Wo5g3u4OQB1nn1rQsYG2/muKFyu6Fi9eWL6nNXYd653
         brdWYQ42mmMqtglGUGPZZKpx2fo6tS6NlPFARc7wCMzSBKm6aFHX7MKLIE1aA+Duxqug
         EgTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=I/VF54YjZQsL1ts/95HTXmA4W82V2jErnI6rOYS4h4A=;
        b=srFnGHM+HyJsT0IoyqUKSJnvQqPyHJAUlkXx4ErD8kL8yoUInpErWfjc/mrMbVdZf7
         CDJIOpXnFc2vcGf7CCVWRdzYE+Xbtuv9a8A/3S4QGuXMzUP9YJNxuYcOt9RncqSYdV4b
         C+uN9JtUQurxjNBdbioRgjKdOOWf7Y2HeznPWUsqw8t4imZSZUydowkfz39SvQAeaRrW
         5ofkfbbZmTiFz/GsxmHjHFWxGhn8uJC10TSX9qJPzLagepafTz6S1rtWCQauM5SpvpKH
         3HOFMaTrQKz77FoOTUu9yfvEWpeP06eWJVy5qD7A5KMObUJfSuAcLhVyVvLmMdfe5CYs
         RcUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yazen Ghannam <Yazen.Ghannam@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac <linux-edac@vger.kernel.org>,
	x86-ml <x86@kernel.org>,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 039/241] x86/mce: Init some CPU features early
Date: Mon, 19 Mar 2018 19:05:04 +0100
Message-Id: <20180319180752.824360363@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391159458560633?=
X-GMAIL-MSGID: =?utf-8?q?1595391159458560633?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yazen Ghannam <Yazen.Ghannam@amd.com>


[ Upstream commit 5204bf17031b69fa5faa4dc80a9dc1e2446d74f9 ]

When the MCA banks in __mcheck_cpu_init_generic() are polled for leftover
errors logged during boot or from the previous boot, its required to have
CPU features detected sufficiently so that the reading out and handling of
those early errors is done correctly.

If those features are not available, the decoding may miss some information
and get incomplete errors logged. For example, on SMCA systems the MCA_IPID
and MCA_SYND registers are not logged and MCA_ADDR is not masked
appropriately.

To cure that, do a subset of the basic feature detection early while the
rest happens in its usual place in __mcheck_cpu_init_vendor().

Signed-off-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/1489599055-20756-1-git-send-email-Yazen.Ghannam@amd.com
[ Massage commit message and simplify. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/mcheck/mce.c |   30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1695,30 +1695,35 @@ static int __mcheck_cpu_ancient_init(str
 	return 0;
 }
 
-static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
+/*
+ * Init basic CPU features needed for early decoding of MCEs.
+ */
+static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 {
-	switch (c->x86_vendor) {
-	case X86_VENDOR_INTEL:
-		mce_intel_feature_init(c);
-		mce_adjust_timer = cmci_intel_adjust_timer;
-		break;
-
-	case X86_VENDOR_AMD: {
+	if (c->x86_vendor == X86_VENDOR_AMD) {
 		mce_flags.overflow_recov = !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
 		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
 		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
 
-		/*
-		 * Install proper ops for Scalable MCA enabled processors
-		 */
 		if (mce_flags.smca) {
 			msr_ops.ctl	= smca_ctl_reg;
 			msr_ops.status	= smca_status_reg;
 			msr_ops.addr	= smca_addr_reg;
 			msr_ops.misc	= smca_misc_reg;
 		}
-		mce_amd_feature_init(c);
+	}
+}
 
+static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
+{
+	switch (c->x86_vendor) {
+	case X86_VENDOR_INTEL:
+		mce_intel_feature_init(c);
+		mce_adjust_timer = cmci_intel_adjust_timer;
+		break;
+
+	case X86_VENDOR_AMD: {
+		mce_amd_feature_init(c);
 		break;
 		}
 
@@ -1804,6 +1809,7 @@ void mcheck_cpu_init(struct cpuinfo_x86
 
 	machine_check_vector = do_machine_check;
 
+	__mcheck_cpu_init_early(c);
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(c);
 	__mcheck_cpu_init_clear_banks();
