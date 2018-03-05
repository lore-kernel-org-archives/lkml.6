Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELskv96aLu1rKVuoTVe8xB38rK8d91Xf7DsxNvCdlf15baYrqgFBwrodN5MyOaN9KkT1cDk3
ARC-Seal: i=1; a=rsa-sha256; t=1520245584; cv=none;
        d=google.com; s=arc-20160816;
        b=wm3thkx6zF1xwqkiwTsb1NwB7Tjg50KuTcOc1ApVaVPJdqA2SwlC6tsf0nWh4/MGIV
         I4kNBgLjdw4HmxC6JbEfaLPqgYuTJIFVMGkO5XzweTtBWCLSZOeO3AHhvTwpd+0q8Yf8
         G0upe7AAEwUiu3x5+nCTJb/pQImwj6LkOGcVaqFiq3uRWkYGiju6AKUpit0ZtBYKUPSH
         ggs4cW5UlNGYVhlA/6F2R/yxUsoTpqxn5gpDlat73lB2DcfzTAtnMBSoGFbEXR9iV45I
         LeSGeaB5kP6tqUWbVo+NOc8uqvGpw13RIEX3L8pa3jEdrHFyRoR8ccucihWII3flDl9U
         wKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Bb0yXFnnfWeJuIId9R35QPqjkYX4kDq1nzrBg7fvyCM=;
        b=PFUM9vnyiOpbSh71yMCZAsTwWIuDN2sG4pXxGdNnOlWF+gr+x00AfHbmCTIC2HV2vC
         kKlalBzJXnZF++wBcMFtnNwpfkTv1xUpXHpMhWFJ+SGKVwa7cJqx/HrHydi14tcMX2aG
         T2doXW9lw0jPTKSCmYPHHAxJfrPuqFKlvusZzRSAZtXbSblnb/Fn+kl3gx3N3QUlecO0
         IU61PVEXGwTmjzli76KXO41KffRFuzFxRkUjaopGmvXQExn08bIApi+QYqb56ZDi3a6S
         X/Oi6cSldCUPXNIgIx/LVFxnML3fX+ljCSuHPpIxIDIxM0fz2FgmbPXu1R0iHL9PUu0P
         AxUw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=hsmbDYuS;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=hsmbDYuS;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
From: Joerg Roedel <joro@8bytes.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	aliguori@amazon.com,
	daniel.gruss@iaik.tugraz.at,
	hughd@google.com,
	keescook@google.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 34/34] x86/mm/pti: Add Warning when booting on a PCIE capable CPU
Date: Mon,  5 Mar 2018 11:26:03 +0100
Message-Id: <1520245563-8444-35-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520245563-8444-1-git-send-email-joro@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093033976694451?=
X-GMAIL-MSGID: =?utf-8?q?1594093033976694451?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Warn the user in case the performance can be significantly
improved by switching to a 64-bit kernel.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/pti.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 3ffd923..8f5aa0d 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -385,6 +385,22 @@ void __init pti_init(void)
 
 	pr_info("enabled\n");
 
+#ifdef CONFIG_X86_32
+	if (boot_cpu_has(X86_FEATURE_PCID)) {
+		/* Use printk to work around pr_fmt() */
+		printk(KERN_WARNING "\n");
+		printk(KERN_WARNING "************************************************************\n");
+		printk(KERN_WARNING "** WARNING! WARNING! WARNING! WARNING! WARNING! WARNING!  **\n");
+		printk(KERN_WARNING "**                                                        **\n");
+		printk(KERN_WARNING "** You are using 32-bit PTI on a 64-bit PCID-capable CPU. **\n");
+		printk(KERN_WARNING "** Your performance will increase dramatically if you     **\n");
+		printk(KERN_WARNING "** switch to a 64-bit kernel!                             **\n");
+		printk(KERN_WARNING "**                                                        **\n");
+		printk(KERN_WARNING "** WARNING! WARNING! WARNING! WARNING! WARNING! WARNING!  **\n");
+		printk(KERN_WARNING "************************************************************\n");
+	}
+#endif
+
 	pti_clone_user_shared();
 	pti_clone_entry_text();
 	pti_setup_espfix64();
-- 
2.7.4
