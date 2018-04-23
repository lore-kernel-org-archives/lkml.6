Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx4/S+uK68pEuIcARoBFUfyjr/RDRgujRta33qTtm/JcxH8YeQgUvfTCOKkclGZs2dqlIFncX
ARC-Seal: i=1; a=rsa-sha256; t=1524498476; cv=none;
        d=google.com; s=arc-20160816;
        b=d3Iajh5gGhJRAj9Km1XfOGJN/EWK+mhvyRNEAAwxuO0ZtLBWJjM89eMYPuoVddHHNQ
         CMdYzAnL67YBrCwQvAqYxY1uhO8kN1HnIUhv7NKYsrLzUqQbk5p262r2j4nbXH7czcTp
         x0N9Q+7nyiQm4JygHVMnlVK2G8EkCpXUsUX8yOMOfSIQrionmgQ7VkizTGFuWrfkGRx9
         a2yvjMWjufIOrOHprbBz8EZs0l/bzzzpaIACpU3eM04N3nO0Hx5+KyV83CAZwjF674Oy
         WOv1JqPBNhxij/9O4MBjtgai/I8H+JhBNhZgqRW3nofiD4W94jMYk4E63hTerBputAAf
         AjAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=AkL2T1gFHrvbc/GzjpwIwKONVsdxG+I5UvQKry0B44A=;
        b=AYJrfoyu877sHDbPUqGUsOWMz18xSCmkF8ruDIzW/zT2nLva26LApprEZCqCFeNCWN
         3Ji7hbFoiU//sfR2hH2vsOsARD4yZeFF+tIMRLwQuOSxYH610H3NoTwgx6NaIi3gMfbH
         JTCpqFRdXYBbFv361MYykUGUdhr2+PJrRwxCcsQtXeZu+5tFGZE2CKQvb7M1W2zhfFNw
         x0ATqktwTyM5KEWZmUHyylPv8XLNPskPLYbmwt/5UeA6XCpmi7WfKwXMusdxDY35Wnol
         HWnDLZmvbXy10AvMgFDWDYXfPDyv1LfVQ4O2MrgttOUeXvSKYVREZZ9KdmmwdzrPV7VP
         yf0A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=g7eBR9dz;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=g7eBR9dz;
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
Subject: [PATCH 27/37] x86/mm/pti: Keep permissions when cloning kernel text in pti_clone_kernel_text()
Date: Mon, 23 Apr 2018 17:47:30 +0200
Message-Id: <1524498460-25530-28-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552515043565489?=
X-GMAIL-MSGID: =?utf-8?q?1598552515043565489?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Mapping the kernel text area to user-space makes only sense
if it has the same permissions as in the kernel page-table.
If permissions are different this will cause a TLB reload
when using the kernel page-table, which is as good as not
mapping it at all.

On 64-bit kernels this patch makes no difference, as the
whole range cloned by pti_clone_kernel_text() is mapped RO
anyway. On 32 bit there are writeable mappings in the range,
so just keep the permissions as they are.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/pti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 9cceae3..e3059bb0 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -460,7 +460,7 @@ void pti_clone_kernel_text(void)
 	if (!pti_kernel_image_global_ok())
 		return;
 
-	pti_clone_pmds(start, end, _PAGE_RW);
+	pti_clone_pmds(start, end, 0);
 }
 
 /*
-- 
2.7.4
