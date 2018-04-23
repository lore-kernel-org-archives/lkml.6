Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx4+FvchVCkBTFxiBq8KHoSQp/ksWHuzrHLOT9C/VWLy+qmtVM3iVB4PieNYpYQDzAsL/8XiT
ARC-Seal: i=1; a=rsa-sha256; t=1524498481; cv=none;
        d=google.com; s=arc-20160816;
        b=x7BLmygTP8ZnV/cX2h0mz4uc5qUsIcSjTSzZMgpcr+fneIhG/siyDH0GTBtUYNHW3R
         i5oU3mYzl70G3sXRU2/JXAv4bmjpQxMDmqI7Cg5W477GjVaCCSN8709fOdQLSKChjhFP
         zDeWvjvh3412rHOi03WgD8UdpdjzqS06kFJhMOnlLskQLNdITLVpvbwe+0hS/kHEp3nQ
         1Evn7xnU2BtkS2p9oOFclXLCoDsm+FqATm3HdZHmQIkfLiZFNylpT+XtwMXdKrNGkpGZ
         Q0S8+GkG3TF2hBoFA/GrCtV0vXMqA3sakDgBjwhxZiAm/g2FUQkzlRatMkzVQshlo8DP
         7AGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=PnY2xhffs00kB/6OhfVYGzzrUTrH5jJhTsbd3ccvbQE=;
        b=o4oQ6Huw8ZUiF74kGKAFLjHvley2N0uZw8eXpykf5cIR1F2udLhXnZcSSuz6kxk5A6
         qEtgt/MvShw6sDrAcHSH26+VxyfR9J/lNzc7SW6b1Qyskf/EQURlxm/mitNbki7oQqGS
         9X2WAOA14mvVogw8f4FtMxVDdDZ/Plxz94b8o27EgxwOW0RXM5rx/j4/aJnYVpnEDweV
         AtOQT1EmH/5MsLe0Prc4D15a2EYBEdFboM4dAT0NwBR/tbcxGRcK+wqwvxOrOdVeE9zS
         /0al7M/UIYdvJ1doJtO0NUKZ4GFUJh1jinOaNVVS3dkJc8X0WZkqlukkj2g84ao5nzK0
         DMog==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=SqBwIYlP;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=SqBwIYlP;
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
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 36/37] x86/mm/pti: Add Warning when booting on a PCID capable CPU
Date: Mon, 23 Apr 2018 17:47:39 +0200
Message-Id: <1524498460-25530-37-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552519649623749?=
X-GMAIL-MSGID: =?utf-8?q?1598552519649623749?=
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
index e3059bb0..0ab41fb 100644
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
