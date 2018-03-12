Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvAohc6haS41smoD2pZfgdy/E05vp516uNWdmXamxv0iASx/bWkwqZtrkUGy1V2EtvLSSag
ARC-Seal: i=1; a=rsa-sha256; t=1520824083; cv=none;
        d=google.com; s=arc-20160816;
        b=uQmDh9HF+FbudD8dmQ3FSbHV+beyAZLMaPS4Q7DTLJ2c4YxAH/ipVirQpg6HHuLcy0
         iJhCxBUkTqdEOb5hBMI7ztC90YNTF/Ce0ytC8ve2ghOqA3XEYDBcgu9haLBVt/QcCTuQ
         RvbdpKlVxCVR7VmnBGLSBHVqVh0KzTTGXSa1Xvxvrot3cEkEcfTR0wB0CZ8DUU2JVfxt
         9ugq8kausrxtGfIn4D6Zu0nLLuIOGKG1HBe2Aaj6w9x5bdtPkiChPI4H39QxU03/YQs3
         +orBS6dNh0mGCo9X9QJDOGofdWYt7PFhDF6S6MgucEVOSSbyGy09/KypNspZk989ONPp
         PxGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=CEEmENMydue+J76kX6j8NkpWiEoEbPDyukeCONYcR5s=;
        b=yN0jwJmegKPNUiyf/IJuTPQtUQHmDcUCKFUwedHKuZhL4oMK/wTNX1v9Y3cwTirRcS
         /EOrH26MbzCPo4mteGY82ucIvb0k19EI8bnC+iSC0w9On8V4FMHUs/3FPe1KKRh0156Y
         RxDm288N2L/I3U5Zi8/5quzKC51hvWFlXd/nTkqg6PCEHmV1f6Ekn3BA6G9VpltJAWFl
         H1DW0PHf/a5OlrfFUOHzCBuoRIH69oGmcvPpKKMciys56kz1XBXsmtg533d7rG/XFmRE
         y4PqfROwM+ogwkJcPD3wzhxHpZ2RyNzyb8XFup1INe0W/1RguGJjWYnhxdx/gondvf0d
         4jXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
 "Rik van Riel" <riel@redhat.com>,
 "Ingo Molnar" <mingo@kernel.org>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Brian Gerst" <brgerst@gmail.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Will Deacon" <will.deacon@arm.com>,
 "Borislav Petkov" <bp@alien8.de>,
 keescook@google.com, aliguori@amazon.com, hughd@google.com,
 "H. Peter Anvin" <hpa@zytor.com>,
 "David Laight" <David.Laight@aculab.com>,
 "Borislav Petkov" <bp@suse.de>,
 daniel.gruss@iaik.tugraz.at,
 "Greg KH" <gregkh@linuxfoundation.org>,
 "Eduardo Valentin" <eduval@amazon.com>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Borislav Petkov" <bpetkov@suse.de>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Denys Vlasenko" <dvlasenk@redhat.com>,
 "Juergen Gross" <jgross@suse.com>,
 "Dave Hansen" <dave.hansen@intel.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.187766482@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 040/104] x86/cpufeatures: Make CPU bugs sticky
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699671986206405?=
X-GMAIL-MSGID: =?utf-8?q?1594699634184863073?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 6cbd2171e89b13377261d15e64384df60ecb530e upstream.

There is currently no way to force CPU bug bits like CPU feature bits. That
makes it impossible to set a bug bit once at boot and have it stick for all
upcoming CPUs.

Extend the force set/clear arrays to handle bug bits as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bpetkov@suse.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aliguori@amazon.com
Cc: daniel.gruss@iaik.tugraz.at
Cc: hughd@google.com
Cc: keescook@google.com
Link: https://lkml.kernel.org/r/20171204150606.992156574@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/cpufeature.h | 2 ++
 arch/x86/include/asm/processor.h  | 4 ++--
 arch/x86/kernel/cpu/common.c      | 6 +++---
 3 files changed, 7 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -258,6 +258,8 @@ extern const char * const x86_power_flag
 	set_bit(bit, (unsigned long *)cpu_caps_set);	\
 } while (0)
 
+#define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
+
 #define cpu_has_fpu		boot_cpu_has(X86_FEATURE_FPU)
 #define cpu_has_vme		boot_cpu_has(X86_FEATURE_VME)
 #define cpu_has_de		boot_cpu_has(X86_FEATURE_DE)
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -130,8 +130,8 @@ extern struct cpuinfo_x86	boot_cpu_data;
 extern struct cpuinfo_x86	new_cpu_data;
 
 extern struct tss_struct	doublefault_tss;
-extern __u32			cpu_caps_cleared[NCAPINTS];
-extern __u32			cpu_caps_set[NCAPINTS];
+extern __u32			cpu_caps_cleared[NCAPINTS + NBUGINTS];
+extern __u32			cpu_caps_set[NCAPINTS + NBUGINTS];
 
 #ifdef CONFIG_SMP
 DECLARE_PER_CPU_SHARED_ALIGNED(struct cpuinfo_x86, cpu_info);
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -424,8 +424,8 @@ static const char *__cpuinit table_looku
 	return NULL;		/* Not found */
 }
 
-__u32 cpu_caps_cleared[NCAPINTS] __cpuinitdata;
-__u32 cpu_caps_set[NCAPINTS] __cpuinitdata;
+__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __cpuinitdata;
+__u32 cpu_caps_set[NCAPINTS + NBUGINTS] __cpuinitdata;
 
 void load_percpu_segment(int cpu)
 {
@@ -636,7 +636,7 @@ static void apply_forced_caps(struct cpu
 {
 	int i;
 
-	for (i = 0; i < NCAPINTS; i++) {
+	for (i = 0; i < NCAPINTS + NBUGINTS; i++) {
 		c->x86_capability[i] &= ~cpu_caps_cleared[i];
 		c->x86_capability[i] |= cpu_caps_set[i];
 	}
