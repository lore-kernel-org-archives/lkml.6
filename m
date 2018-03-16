Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELvd/8AMb+KJrV2cWVT01+BUoDojhZbraau7YuOf+tW3TOt2y4MmrnQBqbDFE7J7weTu4HuD
ARC-Seal: i=1; a=rsa-sha256; t=1521228612; cv=none;
        d=google.com; s=arc-20160816;
        b=JAggwjNc5E5ASwHMXcO/go52grJJEK8WZLpLl8BHS8J5E3Wst8anXDjPxzipXEhKm8
         Ja/LiEKo4NLmuS0B8gSubLzLzGgAAf3Wo8bbbQdgA7aMXSDWur5nEy/Kbw0uPqtharqT
         qdO4RU8SWMJNEq3HhpbcPbpwIXPqu4TyhqoWJnif5523xJl35Qe7e7VKvHnjrVphZ9dT
         oWhzDWfD1rmcktU5U6m0Jfnvd2tZmCiJCyI4VdomrxI7jFedcCsisWstNsXhdpIRM8pb
         DMTDA7RssVOOmGoibtfC9uR7xz8CLX+5ABZLj1FtBJFmixz2ogJNKtA371Fbw6/xignD
         zE5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Bb0yXFnnfWeJuIId9R35QPqjkYX4kDq1nzrBg7fvyCM=;
        b=d4gM55uIHc6dU08s2V4DXa+jBcVqvjJOx6Tg/jfEXjL95cBZCuUkn7Emz1v6UBJ25P
         s8NL0NF+/zRbFbLCF3f2Mg1ZzVMV2HutV/nMZ3WZRtBLpSuyXLG3/WxksodGDuFfxzdz
         kZJjcJ8U9Mtx/pY46dXDz5EoHprkDu+6s+VOCds6YgQ672MUwFtvKE/PzdFVbEM7Nlwm
         cyCGgOrQbn68n7hK+gG5NrLiI80q2MVfhd4cjNl5WrUmrCa4FeKTxvSNNuTmpNoZPDWQ
         tieb0Fzw3Q7zHmg3o7hxN2UROmzU7Tlc8qqbuPSqel+WqAOeoEaPl9J4DwFx3Jhaw+i8
         sRJw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=d648/3Kd;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=d648/3Kd;
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
Subject: [PATCH 34/35] x86/mm/pti: Add Warning when booting on a PCID capable CPU
Date: Fri, 16 Mar 2018 20:29:52 +0100
Message-Id: <1521228593-3820-35-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521228593-3820-1-git-send-email-joro@8bytes.org>
References: <1521228593-3820-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595123814075618195?=
X-GMAIL-MSGID: =?utf-8?q?1595123814075618195?=
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
