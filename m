Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48L5b3dijbcObDpKRqhXkKsr4vD6T8FdYRWXzx7HPGA2uZPWkGsAptp6qNIPB9ZgDZiFQNu
ARC-Seal: i=1; a=rsa-sha256; t=1523399518; cv=none;
        d=google.com; s=arc-20160816;
        b=uPsdpARFXWpkNg9WlxZOzHvs1DWpUqboAnPIa5MCj3WhT8mLfdz7RE20zjIxOukXSr
         5BnZhR55XfnDnXBe5zRpGWc8u1MS62cvteVuhEP6CMgAWmqRDk1D4+EYR419ypdpHXlS
         vAjGXkICCFk8KpmpBnjhCr6UmENsHVJFmb/BKyt+Ap1C8II/goYbaY6hfUzx+guaCoOV
         QvbxOkSvML7M4Vm/sKZ3EYqYxZIRRciBRUHmrFEyrwxv2V1R1g7oETDmlzwEAPgZL0As
         rs6xogW6XJegrDcOJ8PzMwjMgYErw6ISg9s0t8cB1cgreTtLgMgLvLp+1ugkDiQXURcw
         +oBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/7jEgjhFs7H/27ZX9hpr+Ulp/VCMxt6hk19f388cqqk=;
        b=usmD0QYX8NzWj6ByLTUEzQqQElFASAQNoCjymEgToPI/mWcdNwu8q5CLivWPL53lZ8
         sDUlX1iqhJNCe3XfZodIM9BWa/+BY/J7X3Cr/2WoZas4gv9ORet5oQkDOJAuJimt18bk
         jnGezFlhHiZx3eMW2P3kyT8O/9ziAcm/5/MPPPF6Rjxs8zzGzYBVIHfsXDjqsu0C2Xov
         YPMhmjfuk/T/eluCsNe3lZSbhIKNIB3RLEFsgUSU8tgKWPgtRBannH/Q8qZ/PltLWu/+
         O/KrS1N9zPuy7VVPmukvF4uTVzAVoFVASchhTO+8sYyt+1PVOY5ef9RcaqfULKxpMkaa
         xULg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Emanuel Czirai <xftroxgpx@protonmail.com>,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ashok Raj <ashok.raj@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 4.15 119/168] x86/microcode: Attempt late loading only when new microcode is present
Date: Wed, 11 Apr 2018 00:24:21 +0200
Message-Id: <20180410212805.617427112@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400173391081776?=
X-GMAIL-MSGID: =?utf-8?q?1597400173391081776?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit 2613f36ed965d0e5a595a1d931fd3b480e82d6fd upstream.

Return UCODE_NEW from the scanning functions to denote that new microcode
was found and only then attempt the expensive synchronization dance.

Reported-by: Emanuel Czirai <xftroxgpx@protonmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Emanuel Czirai <xftroxgpx@protonmail.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lkml.kernel.org/r/20180314183615.17629-1-bp@alien8.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/microcode.h      |    1 +
 arch/x86/kernel/cpu/microcode/amd.c   |   34 +++++++++++++++++++++-------------
 arch/x86/kernel/cpu/microcode/core.c  |    8 +++-----
 arch/x86/kernel/cpu/microcode/intel.c |    4 +++-
 4 files changed, 28 insertions(+), 19 deletions(-)

--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -39,6 +39,7 @@ struct device;
 
 enum ucode_state {
 	UCODE_OK	= 0,
+	UCODE_NEW,
 	UCODE_UPDATED,
 	UCODE_NFOUND,
 	UCODE_ERROR,
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -339,7 +339,7 @@ int __init save_microcode_in_initrd_amd(
 		return -EINVAL;
 
 	ret = load_microcode_amd(true, x86_family(cpuid_1_eax), desc.data, desc.size);
-	if (ret != UCODE_OK)
+	if (ret > UCODE_UPDATED)
 		return -EINVAL;
 
 	return 0;
@@ -683,27 +683,35 @@ static enum ucode_state __load_microcode
 static enum ucode_state
 load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
 {
+	struct ucode_patch *p;
 	enum ucode_state ret;
 
 	/* free old equiv table */
 	free_equiv_cpu_table();
 
 	ret = __load_microcode_amd(family, data, size);
-
-	if (ret != UCODE_OK)
+	if (ret != UCODE_OK) {
 		cleanup();
+		return ret;
+	}
 
-#ifdef CONFIG_X86_32
-	/* save BSP's matching patch for early load */
-	if (save) {
-		struct ucode_patch *p = find_patch(0);
-		if (p) {
-			memset(amd_ucode_patch, 0, PATCH_MAX_SIZE);
-			memcpy(amd_ucode_patch, p->data, min_t(u32, ksize(p->data),
-							       PATCH_MAX_SIZE));
-		}
+	p = find_patch(0);
+	if (!p) {
+		return ret;
+	} else {
+		if (boot_cpu_data.microcode == p->patch_id)
+			return ret;
+
+		ret = UCODE_NEW;
 	}
-#endif
+
+	/* save BSP's matching patch for early load */
+	if (!save)
+		return ret;
+
+	memset(amd_ucode_patch, 0, PATCH_MAX_SIZE);
+	memcpy(amd_ucode_patch, p->data, min_t(u32, ksize(p->data), PATCH_MAX_SIZE));
+
 	return ret;
 }
 
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -607,7 +607,7 @@ static ssize_t reload_store(struct devic
 		return size;
 
 	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev, true);
-	if (tmp_ret != UCODE_OK)
+	if (tmp_ret != UCODE_NEW)
 		return size;
 
 	get_online_cpus();
@@ -691,10 +691,8 @@ static enum ucode_state microcode_init_c
 	if (system_state != SYSTEM_RUNNING)
 		return UCODE_NFOUND;
 
-	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev,
-						     refresh_fw);
-
-	if (ustate == UCODE_OK) {
+	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev, refresh_fw);
+	if (ustate == UCODE_NEW) {
 		pr_debug("CPU%d updated upon init\n", cpu);
 		apply_microcode_on_target(cpu);
 	}
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -862,6 +862,7 @@ static enum ucode_state generic_load_mic
 	unsigned int leftover = size;
 	unsigned int curr_mc_size = 0, new_mc_size = 0;
 	unsigned int csig, cpf;
+	enum ucode_state ret = UCODE_OK;
 
 	while (leftover) {
 		struct microcode_header_intel mc_header;
@@ -903,6 +904,7 @@ static enum ucode_state generic_load_mic
 			new_mc  = mc;
 			new_mc_size = mc_size;
 			mc = NULL;	/* trigger new vmalloc */
+			ret = UCODE_NEW;
 		}
 
 		ucode_ptr += mc_size;
@@ -932,7 +934,7 @@ static enum ucode_state generic_load_mic
 	pr_debug("CPU%d found a matching microcode update with version 0x%x (current=0x%x)\n",
 		 cpu, new_rev, uci->cpu_sig.rev);
 
-	return UCODE_OK;
+	return ret;
 }
 
 static int get_ucode_fw(void *to, const void *from, size_t n)
