Return-Path: <bp@suse.de>
X-Google-Smtp-Source: AIpwx4/x9LB9L3rdHWfaM8FGlsdu0j1bXyqkskKcWMxcM3sAraQD5CYxGJje9bbdydxpBqauSXUx
ARC-Seal: i=1; a=rsa-sha256; t=1524155856; cv=none;
        d=google.com; s=arc-20160816;
        b=OgaYiO/67ChLEk6mJvNsT9aMrGr6hPfJTe3D3IhgwWNTPZfhEPx7HaYi0rDNgtoiwP
         2nssSGU7cnzyl9/CSgNdPS3Hfw2x+xjChepYIE8Twl8vy2fCg/E6sCEnRMRwOmZ/hM3v
         TLYYDJx5y1QYHFk3kd1zXAHHTdTlHiJcANuIZM/c2Wm8wjc80OxfyMrMH5NQ0nB8ch/n
         zVh/EyeheMXoMjbm7s0M7D2mKKfDwzOq4tBo5mPDGrafgIggUZhfh79Un0rJtV15ulr1
         T+kulOr7uS2y09HIjqF4CyMfzNDUTfK5lZtaHJwv+gM+gGFs3u/hDxafYeIbY53NfFeU
         caQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=1GorpOmyp/3kNut385ogxpv8KlsXIjz5/QdwbZTNh58=;
        b=vEPzhtblwAShok+U5u6XcWNE87nrjwVyoJWwqYZkz6sUFg2EIbUzqW73GPYJ0gj/Nb
         Xq9Fv7mSlPmo0Nj/Qhm0vUk6pVz8wuvymIGhjHFkVwfjHuSuSckLwHTBnqOvbBvdHmDG
         UJZvQ/cl3kTxuooOuQPnIgelAmX26w1XoGxEUDZt91R4ilrobuCu0GJrrZtVtuDavsqN
         RXV7AoeHMHOWuFhUaxJLVDu+2ixA/2v3cpPqMN/e0LVp7CsVz6LaXjT02sQqSavMGFai
         T6SR9adKZaStjaUoE4P3HGRCwV9Fm91f73wi1o6tcvglL911KkcxUR2WbpkuOMrfVlpX
         Erzw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bp@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=bp@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bp@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=bp@suse.de
Date: Thu, 19 Apr 2018 18:37:34 +0200
From: Borislav Petkov <bp@suse.de>
To: Vitezslav Samel <vitezslav@samel.cz>
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: 4.15.17 regression: bisected: timeout during microcode update
Message-ID: <20180419163734.GB3905@pd.tnic>
References: <20180418081140.GA2439@pc11.op.pod.cz>
 <20180418100721.GA5866@pd.tnic>
 <20180418120839.GA5655@pc11.op.pod.cz>
 <20180418122212.GA4290@pd.tnic>
 <20180418135330.GA23580@araj-mobl1.jf.intel.com>
 <20180419053531.GA2224@pc11.op.pod.cz>
 <20180419104829.GE3896@pd.tnic>
 <20180419120239.GA2377@pc11.op.pod.cz>
 <20180419121840.GF3896@pd.tnic>
 <20180419134627.GA2387@pc11.op.pod.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180419134627.GA2387@pc11.op.pod.cz>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598070825045426546?=
X-GMAIL-MSGID: =?utf-8?q?1598193251515933934?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 03:46:27PM +0200, Vitezslav Samel wrote:
> ------------------------------------------------------------
> microcode: __reload_late: CPU0
> microcode: __reload_late: CPU3
> microcode: __reload_late: CPU2
> microcode: __reload_late: CPU1
> microcode: __reload_late: CPU0 reloading
> microcode: __reload_late: CPU2 reloading
> microcode: __reload_late: CPU1 reloading
> microcode: __reload_late: CPU3 reloading
> microcode: find_patch: CPU2, NADA

Ok, I think I have it. Please run the patch below, it still has the
debugging output so please paste it here once you've done the exact same
exercise.

It should not explode this time! (Famous last words :-))

Thx!

---
 arch/x86/kernel/cpu/microcode/core.c  | 11 +++++++----
 arch/x86/kernel/cpu/microcode/intel.c | 17 ++++++++++++++---
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 10c4fc2c91f8..e84877b0f7d7 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -553,6 +553,8 @@ static int __reload_late(void *info)
 	enum ucode_state err;
 	int ret = 0;
 
+	pr_info("%s: CPU%d\n", __func__, cpu);
+
 	/*
 	 * Wait for all CPUs to arrive. A load will not be attempted unless all
 	 * CPUs show up.
@@ -560,20 +562,21 @@ static int __reload_late(void *info)
 	if (__wait_for_cpus(&late_cpus_in, NSEC_PER_SEC))
 		return -1;
 
+	pr_info("%s: CPU%d reloading\n", __func__, cpu);
+
 	spin_lock(&update_lock);
 	apply_microcode_local(&err);
 	spin_unlock(&update_lock);
 
+	/* siblings return UCODE_OK because their engine got updated already */
 	if (err > UCODE_NFOUND) {
 		pr_warn("Error reloading microcode on CPU %d\n", cpu);
-		return -1;
-	/* siblings return UCODE_OK because their engine got updated already */
 	} else if (err == UCODE_UPDATED || err == UCODE_OK) {
 		ret = 1;
-	} else {
-		return ret;
 	}
 
+	pr_info("%s: CPU%d waiting to exit\n", __func__, cpu);
+
 	/*
 	 * Increase the wait timeout to a safe value here since we're
 	 * serializing the microcode update and that could take a while on a
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 32b8e5724f96..725e0bb6df03 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -485,7 +485,6 @@ static void show_saved_mc(void)
  */
 static void save_mc_for_early(u8 *mc, unsigned int size)
 {
-#ifdef CONFIG_HOTPLUG_CPU
 	/* Synchronization during CPU hotplug. */
 	static DEFINE_MUTEX(x86_cpu_microcode_mutex);
 
@@ -495,7 +494,6 @@ static void save_mc_for_early(u8 *mc, unsigned int size)
 	show_saved_mc();
 
 	mutex_unlock(&x86_cpu_microcode_mutex);
-#endif
 }
 
 static bool load_builtin_intel_microcode(struct cpio_data *cp)
@@ -727,21 +725,32 @@ static struct microcode_intel *find_patch(struct ucode_cpu_info *uci)
 {
 	struct microcode_header_intel *phdr;
 	struct ucode_patch *iter, *tmp;
+	int cpu = smp_processor_id();
 
 	list_for_each_entry_safe(iter, tmp, &microcode_cache, plist) {
 
 		phdr = (struct microcode_header_intel *)iter->data;
 
+		pr_info("%s: CPU%d, phdr: 0x%x, uci: 0x%x\n",
+			__func__, cpu, phdr->rev, uci->cpu_sig.rev);
+
 		if (phdr->rev <= uci->cpu_sig.rev)
 			continue;
 
+		pr_info("%s: CPU%d, find_matching_signature: sig: 0x%x, pf: 0x%x\n",
+			__func__, cpu, uci->cpu_sig.sig, uci->cpu_sig.pf);
+
 		if (!find_matching_signature(phdr,
 					     uci->cpu_sig.sig,
 					     uci->cpu_sig.pf))
 			continue;
 
+
+		pr_info("%s: CPU%d, found phdr: 0x%x\n", __func__, cpu, phdr->rev);
 		return iter->data;
 	}
+
+	pr_info("%s: CPU%d, NADA\n", __func__, cpu);
 	return NULL;
 }
 
@@ -805,8 +814,10 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	mc = find_patch(uci);
 	if (!mc) {
 		mc = uci->mc;
-		if (!mc)
+		if (!mc) {
+			pr_info("%s: CPU%d, NFOUND\n", __func__, cpu);
 			return UCODE_NFOUND;
+		}
 	}
 
 	/*
-- 
2.13.0

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
