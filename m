Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49rIKMwmMjljHdfPYMKkCEQ/f8Yx5UNw6EyPZSSuypG7EFOSKIcXtzuUGJN3nU9wP56oNuB
ARC-Seal: i=1; a=rsa-sha256; t=1523399917; cv=none;
        d=google.com; s=arc-20160816;
        b=MLdRlsSTDSRoqUp4j3w0FBp34Eqog3BDHvL/2K4kto+DEJf0dXMmD1Z9c76NpiiEiW
         QVe2wFmNunUBOPTv2pMH4s6NKYMY0HMr1WWkOCQ82DUg2AXkXAkACLmiR5dGeuPx05rl
         SrjbRUFP3dt/PZu5Uu0S8PuGW3+4clGXVxzliCW+zE4AWPUaTVSKxz2IjocugvO6uoJd
         IjQVNcCOXh8N7ByQs2lNNi1OfANT6BFYI4yp/TDj07/ti3o2S/nKrqFMCZsNZ/ihcvap
         MWOVQpfyzOiFBc3hcv/vGkwY9f+dhLivya5Is+4O9rh+5gNBPDteSMJejyDdnvrZYs0l
         Jw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dlvwjSrEjcX8RAx5WMGVnXm1JAK6FVfyAfZhBzcT4sY=;
        b=YRv9mj1qVQuJQqg3kwtFRcsONFHq2kuob6+FhSne+MtvB3TxOJRKX3TxYSTLD3Ph4l
         gMJC1mDHO6DfzHz2C6KYvy3c4BWGVjSujsqrO3c+SZ3UtK4USC1Sm4lxGOFJMoobltAJ
         5fVm0b+hw9LOlNplbLgi9GSfT5PyiEiyv+a8mndO5m41hrkcw+BIrohYyaiQxzr2BCY4
         vfmPQzp6R24nqUb78LdYlsGGHa/nkDKrNXAROJe8iQX82TFTRNLQFy3t7wPRluZtXjwC
         cyYB293yPig8UVJosoJ3t9gp+fW+gkss9ANXqWZAHKWrF0dmcHL1y6ke7c9uIj7qhtOK
         bi8w==
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
Subject: [PATCH 4.14 092/138] x86/microcode/intel: Look into the patch cache first
Date: Wed, 11 Apr 2018 00:24:42 +0200
Message-Id: <20180410212912.864356848@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400165626923506?=
X-GMAIL-MSGID: =?utf-8?q?1597400591854359565?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
