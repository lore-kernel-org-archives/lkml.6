Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AH8x225MBy918Id60mujS/EJhPa2feqnEsuhWtZg8guv1fV6RmD/mewLoeen64RhUZKwgimLPv1W
ARC-Seal: i=1; a=rsa-sha256; t=1518168357; cv=none;
        d=google.com; s=arc-20160816;
        b=cxDRTjP24Kd2MS76aoiqEkx0j7VERd0ahRyizqnGObZRAo1oulrRdClVTNMMCHl8M4
         lVbJld1lIBJkuRi/MwrQae32BrRD3dvD9UvxorDsw5v7kitsWrZXludoTfA5/8wdZOSO
         peY1NnzXUw9EG5Fjl6bg96lxWQvLjDedVSLXp11elD32RPuk7tzCPp1WzdWEL+rIkKEv
         O2zJvRAoPEpckeSUC4lKq+4tGUi0kKXQBXKhQ1byAd8tcOQKAJY2thwZH7uMYdbP8A/a
         x6NZjnhLrziOWhvA+lrFEXLp5BXwteUDunJZRg+r1B9H2i2fq2SuwkbEZvm1CPLrN+GX
         u91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=qxWeLBWPXfhZcdORXt/N8vBDLLsrpvteBpcTwZSO2Cc=;
        b=ns1sFOgNnOk3nUGYcyEh90IqN3HZ99k/OwYUekGH7vAQAyTg6DSxBYxfDkTimrNC6z
         mrmAVZplTtOXHCs4DnVqvzIYxglfpouHXZKHVZXCNdRnYZAhbv6MO0IHXIOXyRcgCyDU
         bPa5JpIvnMUE0siALfEmlkgV+Lc9qi08hoGY3cogeb7QoauCSbJM68V8pJDzk2dfX7PL
         qh1WCVr7c6sZqYeeUnX0ehjAZU32lJuurHN0LiMLQ7sR4tE6pP/1ceHhgOoy+yq+143b
         KcDgoKOPZxPrw1EcmCqHsJiOC0e5LLfXyddkYXFGp0A/zbNxunFtjuLl0xdzFsn4F109
         279A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=IgJy5pSi;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=IgJy5pSi;
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
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 05/31] x86/entry/32: Unshare NMI return path
Date: Fri,  9 Feb 2018 10:25:14 +0100
Message-Id: <1518168340-9392-6-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518168340-9392-1-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914903662894087?=
X-GMAIL-MSGID: =?utf-8?q?1591914903662894087?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

NMI will no longer use most of the shared return path,
because NMI needs special handling when the CR3 switches for
PTI are added. This patch prepares for that.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 0289bde..00ae759 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1007,7 +1007,7 @@ ENTRY(nmi)
 
 	/* Not on SYSENTER stack. */
 	call	do_nmi
-	jmp	.Lrestore_all_notrace
+	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:
 	/*
@@ -1018,7 +1018,11 @@ ENTRY(nmi)
 	movl	PER_CPU_VAR(cpu_current_top_of_stack), %esp
 	call	do_nmi
 	movl	%ebx, %esp
-	jmp	.Lrestore_all_notrace
+
+.Lnmi_return:
+	CHECK_AND_APPLY_ESPFIX
+	RESTORE_REGS 4
+	jmp	.Lirq_return
 
 #ifdef CONFIG_X86_ESPFIX32
 .Lnmi_espfix_stack:
-- 
2.7.4
