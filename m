Return-Path: <maran.wilson@oracle.com>
X-Google-Smtp-Source: AG47ELvRokE0K1te3B3R7CMlTGq/zPwRfN7RW0LOHrr+d1M3UMlvWAIDOvYnh0uEv5KIpM+fmcfh
ARC-Seal: i=1; a=rsa-sha256; t=1519842560; cv=none;
        d=google.com; s=arc-20160816;
        b=rOqIpIT0YJ30nTTygud2mz02/9YhiAo+H5KufJTaNHIc33PHgWsgNvyWh9LZLP/pWp
         zvYGfEQv6YtWVHGZsZeOaIjDOCWPmA5zP6Af/VxC745vRy7pcC7hJ9OCUJvf2WKu2RGI
         c2BtcGqpcYXKe2kNUPwZ1M3f9k+7tWAhz6LBOOJMR74Vb9VpcXGrptBTrgCGZUGCIXrC
         uM6Iia4XZgAY9Ayh1v6aSnpo6QgB8RD8R6zC0HrKQjKf5cLtqmmq8pkvv4RvyJsMCfsb
         4AikHVz1N0BKjIoDO3wrP359N4aVFu0ebVOTDTh9rXX2Wg/CBynIUq0uY+IK9sj/BSYE
         e1tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=LpPXQBBTQ3lMwM4sTuCN8AlXrwBuQXb7ILt8nDLC4zM=;
        b=ddZISU14zfXHOgxTWoBoTktYTqb6DOujMcR1aeKX9c0Iv3BqCxHEeQg1sS/Ta4+3Ld
         XdARQrAkRfAzhdutOW7HCQIykJSuVMECUglpMJgBX5BM5Nl547GZ+Dzccnrxb5L6m52b
         t2WX5cPlC+nAqlUrUlTFsfqjhuDNj3tXIFGMA6MBMUBi+nsUND05L5sLwjLLyjZbB0dz
         8shYK8hYwHUsRMJ8UNz+/sc8Rk52O8qWZlusYVo8u3TSC85YpxIqx8/ynO2ZN2weokjb
         tyAybvxhzASnDogfheaqN4V4Fu4BSbPBG2FwYCzBxJSleQiPxucmvQlXBPCB1brIF4za
         XA5A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=SC4neS4M;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=SC4neS4M;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Maran Wilson <maran.wilson@oracle.com>
To: pbonzini@redhat.com, jgross@suse.com, boris.ostrovsky@oracle.com,
        roger.pau@citrix.com, andrew.cooper3@citrix.com, hch@infradead.org,
        JBeulich@suse.com, x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rkrcmar@redhat.com,
        jpoimboe@redhat.com, bp@suse.de, kirill.shutemov@linux.intel.com,
        thomas.lendacky@amd.com, luto@kernel.org, maran.wilson@oracle.com,
        dave.hansen@linux.intel.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, mchehab@kernel.org,
        linus.walleij@linaro.org, rdunlap@infradead.org
Subject: [RFC PATCH v4 1/7] xen/pvh: Split CONFIG_XEN_PVH into CONFIG_PVH and CONFIG_XEN_PVH
Date: Wed, 28 Feb 2018 10:27:57 -0800
Message-Id: <1519842483-8887-2-git-send-email-maran.wilson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8818 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=991
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280224
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670432609567761?=
X-GMAIL-MSGID: =?utf-8?q?1593670432609567761?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In order to pave the way for hypervisors other then Xen to use the PVH
entry point for VMs, we need to factor the PVH entry code into Xen specific
and hypervisor agnostic components. The first step in doing that, is to
create a new config option for PVH entry that can be enabled
independently from CONFIG_XEN.

Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
---
 arch/x86/Kconfig          | 8 ++++++++
 arch/x86/kernel/head_64.S | 4 ++--
 arch/x86/xen/Kconfig      | 3 ++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index eb7f43f23521..fa7cd0305125 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -791,6 +791,14 @@ config KVM_GUEST
 	  underlying device model, the host provides the guest with
 	  timing infrastructure such as time of day, and system time
 
+config PVH
+	bool "Support for running PVH guests"
+	depends on KVM_GUEST || XEN
+	def_bool n
+	---help---
+	  This option enables the PVH entry point for guest virtual machines
+	  as specified in the x86/HVM direct boot ABI.
+
 config KVM_DEBUG_FS
 	bool "Enable debug information for KVM Guests in debugfs"
 	depends on KVM_GUEST && DEBUG_FS
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 0f545b3cf926..fc9f678c6413 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -41,7 +41,7 @@
 
 #define pud_index(x)	(((x) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
 
-#if defined(CONFIG_XEN_PV) || defined(CONFIG_XEN_PVH)
+#if defined(CONFIG_XEN_PV) || defined(CONFIG_PVH)
 PGD_PAGE_OFFSET = pgd_index(__PAGE_OFFSET_BASE)
 PGD_START_KERNEL = pgd_index(__START_KERNEL_map)
 #endif
@@ -387,7 +387,7 @@ NEXT_PAGE(early_dynamic_pgts)
 
 	.data
 
-#if defined(CONFIG_XEN_PV) || defined(CONFIG_XEN_PVH)
+#if defined(CONFIG_XEN_PV) || defined(CONFIG_PVH)
 NEXT_PGD_PAGE(init_top_pgt)
 	.quad   level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
 	.org    init_top_pgt + PGD_PAGE_OFFSET*8, 0
diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index f605825a04ab..021c8591c3c0 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -77,8 +77,9 @@ config XEN_DEBUG_FS
 	  Enabling this option may incur a significant performance overhead.
 
 config XEN_PVH
-	bool "Support for running as a PVH guest"
+	bool "Support for running as a Xen PVH guest"
 	depends on XEN && XEN_PVHVM && ACPI
 	# Pre-built page tables are not ready to handle 5-level paging.
 	depends on !X86_5LEVEL
+	select PVH
 	def_bool n
-- 
2.16.1
