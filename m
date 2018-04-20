Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AIpwx48dFrHQOLoUXUy9NddtYExGVOTovKYQmcHHAgTDOBnPwCS7JmJCGzJ1SvoWNUWm2ClkrXJT
ARC-Seal: i=1; a=rsa-sha256; t=1524263058; cv=none;
        d=google.com; s=arc-20160816;
        b=f8PFizqMdRsHwfIHQo2a1FaQLH3wh+QsnYpFYaCA/Cwk8DJMar3XfyqZle+TBsRYUR
         3QLBeQhud7MtzTvp+e8DDUQKsbp2AUrH7hJHLe06dcILGUO5ZhUEbZnbGynXuwrxggtQ
         ir/dvHtRW14JL70PIQ4BmCo3zHX8NtB+rTadak+TI9G2Akth12mUV3SAAJan8UgwqKs8
         1QRYO/no5vYIaM9V8ok8zBzL/vR6EYATy0587WI8N0hrPB5yqV4A0n7gi1FNkN+ysKI1
         Z81yE8PZ4PMq48ruyjeZJnRGBfX/F4V54mMiUPoZmRkIj58p4pjKhzb3Y7XK3PfrsMLe
         w+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:in-reply-to:references:date:from:cc:to:subject
         :arc-authentication-results;
        bh=dEP72a3ALXZBVcNJ6LCv79jYFNiYTgidTtiJ9cQuhMw=;
        b=YLHPJ3HyptZMrAJMlXxohfAjflHY2pppfH761fyXe3zo7fgUIcZnHw/P9s2sKiRn4M
         6Pkg0sg1czfuY9HddSqO/A49U8TgAqpSsxTDyRRpujr7pNBh7bCBKDWD9s6q4x2mYL82
         y0QeRS0wQ+kV0iaXwRjWcFdjsPa4vbjb+BXNd2pPRq4AyG74XdPx/gstC5MQOuCEuFgy
         iBmkRws7ypyeGpNKmfeBENie/PRkjGsyvVJAdWB89u83ggIs+nxQAAPTwQ/tA8d5xCT6
         Bf8wOnShvSIJD6Pas7UsL8Ry+pTCLNEl9reld7UfcX/tKW0UGcdxLDFr48pruOE44ruo
         W/4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,303,1520924400";
   d="scan'208";a="33512854"
Subject: [PATCH 4/5] x86, pti: disallow global kernel text with RANDSTRUCT
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,Dave Hansen <dave.hansen@linux.intel.com>,keescook@google.com,aarcange@redhat.com,luto@kernel.org,arjan@linux.intel.com,bp@alien8.de,dan.j.williams@intel.com,dwmw2@infradead.org,gregkh@linuxfoundation.org,hughd@google.com,jpoimboe@redhat.com,jgross@suse.com,torvalds@linux-foundation.org,namit@vmware.com,peterz@infradead.org,tglx@linutronix.de,vbabka@suse.cz
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 20 Apr 2018 15:20:26 -0700
References: <20180420222018.E7646EE1@viggo.jf.intel.com>
In-Reply-To: <20180420222018.E7646EE1@viggo.jf.intel.com>
Message-Id: <20180420222026.D0B4AAC9@viggo.jf.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598305661118147565?=
X-GMAIL-MSGID: =?utf-8?q?1598305661118147565?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


I believe this was originally reported by the grsecurity team who
tweeted about it (link below).

RANDSTRUCT derives its hardening benefits from the attacker's lack of
knowledge about the layout of kernel data structures.  Keep the kernel
image non-global in cases where RANDSTRUCT is in use to help keep the
layout a secret.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reported-by: Kees Cook <keescook@google.com>
Link: https://twitter.com/grsecurity/status/985678720630476800
Fixes: 8c06c7740 (x86/pti: Leave kernel text global for !PCID)
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org
---

 b/arch/x86/mm/pti.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff -puN arch/x86/mm/pti.c~pti-glb-disable-with-compile-options arch/x86/mm/pti.c
--- a/arch/x86/mm/pti.c~pti-glb-disable-with-compile-options	2018-04-20 14:10:02.702749165 -0700
+++ b/arch/x86/mm/pti.c	2018-04-20 14:10:02.706749165 -0700
@@ -421,6 +421,16 @@ static inline bool pti_kernel_image_glob
 	if (boot_cpu_has(X86_FEATURE_K8))
 		return false;
 
+	/*
+	 * RANDSTRUCT derives its hardening benefits from the
+	 * attacker's lack of knowledge about the layout of kernel
+	 * data structures.  Keep the kernel image non-global in
+	 * cases where RANDSTRUCT is in use to help keep the layout a
+	 * secret.
+	 */
+	if (IS_ENABLED(CONFIG_GCC_PLUGIN_RANDSTRUCT))
+		return false;
+
 	return true;
 }
 
_
