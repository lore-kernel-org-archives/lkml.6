Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49OTZuhvZ4xBNtJ5Mwi1uSL2Duwtzul3+REZpj0Iu6ISNwYC9PzIOutJUpyDikajzXQ9zMH
ARC-Seal: i=1; a=rsa-sha256; t=1523399925; cv=none;
        d=google.com; s=arc-20160816;
        b=wR2GnC+76K0m2p1vxMi5vefmL7zW7WJ2a9sHMUWZz3ZwKyJrtVZQvwWtVs7/fFfzVN
         7gpRqEXb+ouIIO11eyE/0AYpMWrWU8LpktCGEvurrrVtOsR2VYJFu68hZoxK6EmThbNU
         rB7tplNtORJN+/AsRROaCEYsYyy8AP9L0FPKfnb7nuUe+DWn2/SIuN080ATYNwBetfdb
         FN24qjfIPVLLBSIVduZCh7UZfzWSGtCT+qvrmUCDp71BTVjYpxIv5ppunmA1DoSUz15A
         n9dKu6j2OyvYGwb5EjkFK92YV7blH44BIFQ/oAKrK/5vHi6/2EuObtE30R9SeoefnKbD
         toGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=m08hRyvQYDlCsrj6nhebuHJL8CCqkwVyUB8dXn/K0aA=;
        b=tQ4cgpO9TopkYk5647YV41MLzjQVh3c1rl7WfzHgaDTik2mM5RnXgYpFHxo3KOggSG
         NP1p3IL2sT5Lk/9sO9PcwQHV0Rk2AJHxwH0tYhpprC/XuegRB7sj0LpQCJqeiUyID+vg
         xbeVa5jSxMr0psF3E58Gq9ZX7Mw69/V+kKT8VnXWHmJ0qqnS0bgaOqYhgNtYvWMac7P4
         4MYL0eT60JUM7QPooY28n1z0clCroyoOC4POsA/0TuFG/Oe9BFn9PWGgjTZDAOBU3a6i
         g4dBchaq8qiH3MRZ+ChcxOcxnhKun7qy/Fc36Hxb/Z3enuzaYgKKeFKgJ+7Wp4EZY+y5
         dlJA==
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
Subject: [PATCH 4.14 095/138] x86/microcode: Attempt late loading only when new microcode is present
Date: Wed, 11 Apr 2018 00:24:45 +0200
Message-Id: <20180410212913.215180092@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400173391081776?=
X-GMAIL-MSGID: =?utf-8?q?1597400600885173825?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
