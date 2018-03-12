Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELt6OCmBcALrhrwEgDYkpzG/lT/yhQ2J4S1WqkXhZYq/RN0HNRxVYTY4GJMJyBQTw7ZUrJ40
ARC-Seal: i=1; a=rsa-sha256; t=1520824082; cv=none;
        d=google.com; s=arc-20160816;
        b=Myfw0HWv6hlDHMy77v/DJ/K0JI3vk8y5pjDThg8ubiwWdd15XSxBXMEmLIS179QQiq
         uWLKnesclDFFNysMMhhnm+/jcHpc0rY29yMmIiwdTSF+/yB7hDjzIpaV6VKXhJpz8eQT
         5zpVCtgDuBiEkCC5wmiiYGk7LvO0dUB+HGb0f76HBpAUuZmi47QMpKw3ry/0ayT7/R42
         EatroNnASmuJ/wpk03gp3lrnpRm1OBO1eIyU6iZaq93XSDe/KiFOTHREuAPPR+Z6G9/Z
         hCL6WzqFsYwarbXJ3nCanvtgX2VHgmxFbtWA96Y+sMGPuSjBDyymZxchO0g8NC8UqJ7h
         FSgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=6GrWQo82E3GSCpmP3GovxAjI7a2iaqXhqM2xOGoLzp4=;
        b=skBMDmDlPiFWCOit+Nkau8JTPKXDTMIRWIbfzj96i6wnRidcWgy5GIrQYzs9SEQqon
         CLEbTst0ZBWfqLBhFs9wpB2tvxF6LS3FAW1t0gRR8Ai5PJcoDhWhd+ejzibb9E8yweBQ
         e/Buw+MKvIVd53Qx0S16qT8DXKOF9Qfm3x0N98RisFffxFOzO83k4Kg0RLxzZwBFR4kn
         Ed9Y0lif+gaZ7qC650aztqCeKnYhHhjSJ+I/WZlqbky8EKtfhEXowaP8w+ZNxUSKJ2fr
         sQvaBPYlJBnDZeZT1kt9Yr6orHReb5kANv19fUpYUFthI6uyoe0elMHQTN6eOZ2egkJz
         3WNQ==
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
 "Ingo Molnar" <mingo@kernel.org>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Brian Gerst" <brgerst@gmail.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Will Deacon" <will.deacon@arm.com>,
 aliguori@amazon.com, keescook@google.com,
 "Borislav Petkov" <bp@alien8.de>,
 "David Laight" <David.Laight@aculab.com>,
 hughd@google.com,
 "H. Peter Anvin" <hpa@zytor.com>,
 daniel.gruss@iaik.tugraz.at,
 "Greg KH" <gregkh@linuxfoundation.org>,
 "Eduardo Valentin" <eduval@amazon.com>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Denys Vlasenko" <dvlasenk@redhat.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Juergen Gross" <jgross@suse.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.435783386@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 041/104] x86/cpufeatures: Add X86_BUG_CPU_INSECURE
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699632893002612?=
X-GMAIL-MSGID: =?utf-8?q?1594699632893002612?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit a89f040fa34ec9cd682aed98b8f04e3c47d998bd upstream.

Many x86 CPUs leak information to user space due to missing isolation of
user space and kernel space page tables. There are many well documented
ways to exploit that.

The upcoming software migitation of isolating the user and kernel space
page tables needs a misfeature flag so code can be made runtime
conditional.

Add the BUG bits which indicates that the CPU is affected and add a feature
bit which indicates that the software migitation is enabled.

Assume for now that _ALL_ x86 CPUs are affected by this. Exceptions can be
made later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
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
Cc: Will Deacon <will.deacon@arm.com>
Cc: aliguori@amazon.com
Cc: daniel.gruss@iaik.tugraz.at
Cc: hughd@google.com
Cc: keescook@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.2:
 - Assign the first available bug number
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -214,6 +214,8 @@
  */
 #define X86_BUG(x)		(NCAPINTS*32 + (x))
 
+#define X86_BUG_CPU_INSECURE	X86_BUG(0) /* CPU is insecure and needs kernel page table isolation */
+
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
 
 #include <asm/asm.h>
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -767,6 +767,9 @@ static void __init early_identify_cpu(st
 
 	if (this_cpu->c_bsp_init)
 		this_cpu->c_bsp_init(c);
+
+	/* Assume for now that ALL x86 CPUs are insecure */
+	setup_force_cpu_bug(X86_BUG_CPU_INSECURE);
 }
 
 void __init early_cpu_init(void)
