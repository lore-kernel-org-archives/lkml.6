Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx49yzYoSb1jKihVZ8dV2Cv2memNK/6g4LbdDoklfYytprF6VI6q14wyGJiSqEft0NTJR9ERz
ARC-Seal: i=1; a=rsa-sha256; t=1523892352; cv=none;
        d=google.com; s=arc-20160816;
        b=qRQQbUYEfK/Wbp/zxM8j7EMgzWjtUSKLfHtZ/SAxOMZ91fhMksBKslFP+VyQO00ejc
         qBBp2JeTbkHjXy/iwJ4AQG0i+TLx0ibv7tuT7MrOQ/71MlsJ01jGhq8D1ZSMHn8aJ0/Z
         y4p/WqVmCB59OsHezNliy16m16kkQix063o/EoaJD7Bjm9MqnzfYcrCEcBIWizvZyQcs
         cG+mWCJFAP5RpM7yKvmcmk9oYSPjv9GghNVFiELFrH7v925gidEzVtlxuas5oIFFKRVN
         nQFoQFi+QfpEyPmZGObdqCffMwYWlG8WV3yDhWslXrbMfQvv+t66DPyjTtflMdWc2Jut
         RTZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=n9v3/D9uFnHXbMksWDxOkHcDCOvgQWwinJ14oMwdSPs=;
        b=lpHdXiwV5DN3N4G6AMyXS0Mdx18ITENe6DchnhVbpgeDTLVemzC4zxMeBSUx7Bnnm+
         0bqCuHf6pEiXZxs+qj7cIuImIOVvAmGKigwvFR3OMfEb8KC4w6gfK7DEld89gsz5EQ4f
         LVPTTgqcEF7xFfJJ6bVrhpcm0hedrAbHVINy+OG8io1LaoAkJk2JsfMUk+BU/vnONQS8
         +60tCXFy08Abm9r5gq2xkNeWe0AKVlCMFKy7rHF4cM9wPhrsqgryRc/EPbA/Cw1UGUYy
         TYPz7LtEZMT1r+1wASmAZzYe5l3WtbNsF82LjtcMhxyQ4v1cV+/awWCm4VqQ38zT8SVn
         xeNA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=Igoi0VTB;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=Igoi0VTB;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
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
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 34/35] x86/mm/pti: Add Warning when booting on a PCID capable CPU
Date: Mon, 16 Apr 2018 17:25:22 +0200
Message-Id: <1523892323-14741-35-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523892323-14741-1-git-send-email-joro@8bytes.org>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916947512269715?=
X-GMAIL-MSGID: =?utf-8?q?1597916947512269715?=
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
index 60a1ee0..ad905e0 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -497,6 +497,22 @@ void __init pti_init(void)
 
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
 
 	/* Undo all global bits from the init pagetables in head_64.S: */
-- 
2.7.4
