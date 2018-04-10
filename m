Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4//7MDko0nS0E3az0xuAC8B6Ikgi76p9Z5MQ59cBo15jUF3hTwcqwJAMOEidFq3MP+0STUs
ARC-Seal: i=1; a=rsa-sha256; t=1523399510; cv=none;
        d=google.com; s=arc-20160816;
        b=BEi9REuAE5kz4zBcoM44I4vpn+S+Ws4lsmybjKM1xnVmlOX4UwL6LsfvUZG3vg8DdH
         YiV+W465OgSfDUZ8Z7jJTRSRfUhj0vz0hmuz61JfXfxotWGBbTrfCWPXaWrvEgaLbZdB
         Oz1+J7rkvv88kgEuEDVhiB38KBCPa+eGTZm2YSmyGmnCEMry3gxxjQf55vlGde0Fj2lU
         +NIrUAOgq2ve0GUJgkV+VshUqMYWV43kLWTx8jv9bRqbf3oBvUg0/OEKvHR83F/NN1Qk
         u3IEViIzrbangbmpUsWqaUvrXp/71JGqQ7afoOHTVFoM1TF3YYLVj1bLUrEbS+f2qnYG
         ysGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UF4VIDUvrbwLO3+ZHyrxx3kXwCQ/HgxpdZrY2LLGkGo=;
        b=NIKZ0VUcXWKj8zQmLwbLySqk/cybrtJHMMH+F7ZMdJyvy787n3u/kH/u27iSeAk1IK
         q9eoqtj6bttEewVGD7sXUOynSB0WSr1BzbQkBdt5c2qB58ep7OjmtTZHbwUc2aZeey6/
         T9jX+3PlzrZU2zRCP38e+G+DqHoPNvJeUgwxYDRMlrMDOM1roQwT3tfC+5ZNt9F7TT0r
         05b9r9ARf+JRQBQNZ9fBNqK6rAzxvrs7O2eUEJdK8fdfi0dXn/KL+B7hwc3rNhbdUyLp
         NJRBoWIgseKiEkhsExZSZUb1xiwhpcVK/MfFk/IJwWOyxDvHSVX4+8Pc0/o1PZ+zMlFH
         BMyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: [PATCH 4.15 116/168] x86/microcode/intel: Look into the patch cache first
Date: Wed, 11 Apr 2018 00:24:18 +0200
Message-Id: <20180410212805.443922815@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400165626923506?=
X-GMAIL-MSGID: =?utf-8?q?1597400165626923506?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit d8c3b52c00a05036e0a6b315b4b17921a7b67997 upstream.

The cache might contain a newer patch - look in there first.

A follow-on change will make sure newest patches are loaded into the
cache of microcode patches.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Link: https://lkml.kernel.org/r/20180228102846.13447-6-bp@alien8.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/microcode/intel.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -791,9 +791,9 @@ static int collect_cpu_info(int cpu_num,
 
 static enum ucode_state apply_microcode_intel(int cpu)
 {
-	struct microcode_intel *mc;
-	struct ucode_cpu_info *uci;
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
+	struct microcode_intel *mc;
 	static int prev_rev;
 	u32 rev;
 
@@ -801,11 +801,10 @@ static enum ucode_state apply_microcode_
 	if (WARN_ON(raw_smp_processor_id() != cpu))
 		return UCODE_ERROR;
 
-	uci = ucode_cpu_info + cpu;
-	mc = uci->mc;
+	/* Look for a newer patch in our cache: */
+	mc = find_patch(uci);
 	if (!mc) {
-		/* Look for a newer patch in our cache: */
-		mc = find_patch(uci);
+		mc = uci->mc;
 		if (!mc)
 			return UCODE_NFOUND;
 	}
