Return-Path: <bp@suse.de>
X-Google-Smtp-Source: AIpwx49vco2vhsUZ7Wxq/Yh4Ni6XJV7tg7XhsHNVD9SCXCZntVPZOBAkqrjxlfSIzJZxyBJTOKnO
ARC-Seal: i=1; a=rsa-sha256; t=1524140326; cv=none;
        d=google.com; s=arc-20160816;
        b=dr1se6F7OA+b+JmLVEuQc2VfIr302ORaVR5Qlem+cRbyFQSVg/UUQvYPuCLW28Kb28
         givWvhxVYNZx7F9rFCl1iceP5PbBUHtueU2UrbomlXqclr+MfwlhK6HJfKc6WzYSgf8J
         Z5WoWD8H1R7h0ovu1vfbzJV6BkhGHgOvgQi2IGEIcUhfTNdkK6hwHen8DluXIjLPVzo4
         irNEiqYtffmTDsCHOC6D6YSjO+dYps5rdP0ARPlqPXV2JbrQVBr+9xiRBK3ZEtVz5u3V
         +aSSyxhWkm8cJOdKSageBVnFLgFVqMaf6nr0AlRYk1SDP1eCM6RdyhZiNygStHWnhtUb
         egCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=uDxV3HLywSYgYyiGRRop9+OCZc92+Z3AFi4KRBlL/h8=;
        b=QuI2cFB5x1Nv7ZPor5DtZ6YYl13kHND8eDAiLJw6wr6JkhW6fG6r4ioTwC6CHZ4MfV
         4swIPVjsDCPv2AF/LyXRXN9z2BAwyejlkb+2Qg4s3lGqRg9c/rooiR3c2OaXYFsk2VRk
         kzOJfP7a7PsWDfIjDoV8OezIXlIOEeKdID1SmIbnuylZgU7wJH61T2NGWHY0GKKGYtz/
         Hrnh5kF2qhs9yYqPGIEhofwHbO4hd3UVyOKt2c5I4y87uwZhzciM8fyKZz6MYK+cggkT
         B7vUOHv41vtQfy/qQgDZWZiHxlHg+cVvwQD/dpgZm+fO26AodgFe+8f6EKIsP61PXyZM
         sY6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bp@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=bp@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bp@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=bp@suse.de
Date: Thu, 19 Apr 2018 14:18:41 +0200
From: Borislav Petkov <bp@suse.de>
To: Vitezslav Samel <vitezslav@samel.cz>
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: 4.15.17 regression: bisected: timeout during microcode update
Message-ID: <20180419121840.GF3896@pd.tnic>
References: <20180418081140.GA2439@pc11.op.pod.cz>
 <20180418100721.GA5866@pd.tnic>
 <20180418120839.GA5655@pc11.op.pod.cz>
 <20180418122212.GA4290@pd.tnic>
 <20180418135330.GA23580@araj-mobl1.jf.intel.com>
 <20180419053531.GA2224@pc11.op.pod.cz>
 <20180419104829.GE3896@pd.tnic>
 <20180419120239.GA2377@pc11.op.pod.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180419120239.GA2377@pc11.op.pod.cz>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598070825045426546?=
X-GMAIL-MSGID: =?utf-8?q?1598176967747746679?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 02:02:39PM +0200, Vitezslav Samel wrote:
>   Here it is:

Thanks!

> -------------------------------------------------------------
> microcode: __reload_late: CPU1
> microcode: __reload_late: CPU3
> microcode: __reload_late: CPU2
> microcode: __reload_late: CPU0
> microcode: __reload_late: CPU1 reloading
> microcode: __reload_late: CPU3 reloading
> microcode: __reload_late: CPU2 reloading
> microcode: __reload_late: CPU0 reloading
> microcode: __reload_late: CPU3 returning 0x0

Aaaha, there it is.

Ok, debug patch v2, please do the same.

Thx.

---
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 10c4fc2c91f8..737f93422d0b 100644
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
@@ -560,6 +562,8 @@ static int __reload_late(void *info)
 	if (__wait_for_cpus(&late_cpus_in, NSEC_PER_SEC))
 		return -1;
 
+	pr_info("%s: CPU%d reloading\n", __func__, cpu);
+
 	spin_lock(&update_lock);
 	apply_microcode_local(&err);
 	spin_unlock(&update_lock);
@@ -571,9 +575,12 @@ static int __reload_late(void *info)
 	} else if (err == UCODE_UPDATED || err == UCODE_OK) {
 		ret = 1;
 	} else {
+		pr_info("%s: CPU%d returning 0x%x\n", __func__, cpu, err);
 		return ret;
 	}
 
+	pr_info("%s: CPU%d waiting to exit\n", __func__, cpu);
+
 	/*
 	 * Increase the wait timeout to a safe value here since we're
 	 * serializing the microcode update and that could take a while on a
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 32b8e5724f96..ad0a19154c40 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -727,21 +727,32 @@ static struct microcode_intel *find_patch(struct ucode_cpu_info *uci)
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
 
@@ -805,8 +816,10 @@ static enum ucode_state apply_microcode_intel(int cpu)
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
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
