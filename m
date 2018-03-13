Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuNgJnmqzOmk/QqbsKR+U0sqoywgq0t0ol3paaMsJV4I0GzLOt/gDgoPpDi2CblvmlLHUqn
ARC-Seal: i=1; a=rsa-sha256; t=1520955576; cv=none;
        d=google.com; s=arc-20160816;
        b=IEEUGPlSdetzg5dKhQxxF/NeuDB65HEC+HJJgu/MYEu8Tgp+x+NRydCUJ8PkF8bzJa
         2l3U1/XAIbt9FiUwdjRnIYP4zMxjMgJjjiUNBM22H+VB84/bs3gs070rPO1if3Rp0yza
         NMNuNkmIuDgSGKpwAyXu5itzimz1ABH+RU5hqIvzL2Ijv4uBz2byD9VDp7BXiGQVH0qf
         YEG0J+P/qIdIlMCSteYDXDBgwh6Cd70+KWJquKbCwNzus09PtV+ueehOu3xYwqjVMZzh
         mtCutFpSRlH9bmRzjMTFQiFVtbhXc8pM2YRNs10TIy3uy/ISAJyIct3A79tOYUYFutmu
         0W6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oIv8HMfPf4qQ3jNd9URjgwsUlFVDkAG9jbkQXazshwY=;
        b=Yv44z958Rrr2fN3yLKqaoHfmN0Yo6bFbSqDTXSoxiXnFkGiqWwwlFQX+ijlDRCpwO5
         nkHj8yd8EmDOxy7PYEwfptploin9mM8lv/w7KPy7ibWeSU2kUaUZiRZMRjRjA+dkKQCh
         ARAQ3UFvm9lr6GbxD2d36mVn+dzRRtms3+OyT82SPrqyUHkEKAfqW0HnbCHR/tV+pyan
         sy1psT2+CHKHgCAGeJTeOAEpLcrmBUF/DuWlpAavW6WrBNjzvtofPtHDWjlQAK7yJzbA
         zLyrg1OAWFnRFluJfPmVPqzkTaQL052bxiwnR1IICrOnq+pnDiAY3xzNnD8gwEptFhHx
         8flA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	linux-edac <linux-edac@vger.kernel.org>
Subject: [PATCH 4.14 097/140] x86/MCE: Save microcode revision in machine check records
Date: Tue, 13 Mar 2018 16:25:00 +0100
Message-Id: <20180313152504.677367862@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836936296543222?=
X-GMAIL-MSGID: =?utf-8?q?1594837513932339888?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Luck <tony.luck@intel.com>

commit fa94d0c6e0f3431523f5701084d799c77c7d4a4f upstream.

Updating microcode used to be relatively rare. Now that it has become
more common we should save the microcode version in a machine check
record to make sure that those people looking at the error have this
important information bundled with the rest of the logged information.

[ Borislav: Simplify a bit. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180301233449.24311-1-tony.luck@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/uapi/asm/mce.h  |    1 +
 arch/x86/kernel/cpu/mcheck/mce.c |    4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

--- a/arch/x86/include/uapi/asm/mce.h
+++ b/arch/x86/include/uapi/asm/mce.h
@@ -30,6 +30,7 @@ struct mce {
 	__u64 synd;	/* MCA_SYND MSR: only valid on SMCA systems */
 	__u64 ipid;	/* MCA_IPID MSR: only valid on SMCA systems */
 	__u64 ppin;	/* Protected Processor Inventory Number */
+	__u32 microcode;/* Microcode revision */
 };
 
 #define MCE_GET_RECORD_LEN   _IOR('M', 1, int)
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -131,6 +131,8 @@ void mce_setup(struct mce *m)
 
 	if (this_cpu_has(X86_FEATURE_INTEL_PPIN))
 		rdmsrl(MSR_PPIN, m->ppin);
+
+	m->microcode = boot_cpu_data.microcode;
 }
 
 DEFINE_PER_CPU(struct mce, injectm);
@@ -263,7 +265,7 @@ static void __print_mce(struct mce *m)
 	 */
 	pr_emerg(HW_ERR "PROCESSOR %u:%x TIME %llu SOCKET %u APIC %x microcode %x\n",
 		m->cpuvendor, m->cpuid, m->time, m->socketid, m->apicid,
-		cpu_data(m->extcpu).microcode);
+		m->microcode);
 }
 
 static void print_mce(struct mce *m)
