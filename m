Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx4+1Nv4BOpq8RQ0MPsNyzQB+CNJ85Hc4LtEkgF9P6qFduSPhc3gJdWwd8nCSyry2M7zGtdIc
ARC-Seal: i=1; a=rsa-sha256; t=1524498476; cv=none;
        d=google.com; s=arc-20160816;
        b=kdFkaFZt8ULmlJ01zZG10I6SPnQckFsMaglDxdCbF6H8KIKFqwLz9lzJtG1Fgnn5o5
         voZQOwcb76FvuYyG15EQTV/eiyfdZmPvyV/S7iC0Cb+mg5+57ez+LOC7ee0q0txXH+Lm
         Q0Qiql/QKeEMWd4nQ5Fz+rFLOdhgUHlDUefWUuWUrtYdHg69DcMrn0fYEcvTHTYy6i2T
         JFRLutr9pp+N3m+2cnW/gbV1VuwL3WJVCZSpKp1CXqUGbuNgTyuWa0Q8ti5bzNa7HJNu
         k2kcohkBa0Kty6zN6SwM43X6CH8iTBCPabYPiMPKhbNJGpMM1lN1YE/E03EVLOR7QoYZ
         lNjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=0qmWb7xiSzU7S3Tuxgcnd74RbQVyw7wJWYfNbHnb9fM=;
        b=vAOz5B8VhVdxbv6b55Q5MEISQRY5jQMvahXi4yRUjpacGpRNn9rQ6xkxZt75XT4VEC
         eA3giyIZcxNp/mDFyFFF80ADOpOMyw5rjrM0fp9ePSKNaEj4tbzxYpRgLJe2g9eWegXe
         H+BTpE2nyj/sJCgbJgckNJztZvi9F/86VJQNblDZkTyBeh278mPM1tQae/n6x2PoyyGA
         n2Jcco+JVbzpOBwyUrlQp9dx11m1E7JeKyUUD/H78bxCwNRd4O2cPbYdZfjGsBlCDiD+
         lRsORmtZMInqBAZmpoUdnaaZw7ItufWIWO/5W2macPnuFYMv8TqjFdthhE8yh7mia32/
         6blw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=GlLcSiHw;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=GlLcSiHw;
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
Subject: [PATCH 28/37] x86/mm/pti: Map kernel-text to user-space on 32 bit kernels
Date: Mon, 23 Apr 2018 17:47:31 +0200
Message-Id: <1524498460-25530-29-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552514601150146?=
X-GMAIL-MSGID: =?utf-8?q?1598552514601150146?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Keeping the kernel text mapped with G bit set keeps its
entries in the TLB across kernel entry/exit and improved the
performance. The 64 bit x86 kernels already do this when
there is no PCID, so do this in 32 bit as well since PCID is
not even supported there.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/init_32.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index c893c6a..8299b98 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -956,4 +956,10 @@ void mark_rodata_ro(void)
 	mark_nxdata_nx();
 	if (__supported_pte_mask & _PAGE_NX)
 		debug_checkwx();
+
+	/*
+	 * Do this after all of the manipulation of the
+	 * kernel text page tables are complete.
+	 */
+	pti_clone_kernel_text();
 }
-- 
2.7.4
