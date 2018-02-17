Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x227b1mb98RbjQ2wEFL7Rivk+udGsaColNb4BTwwn908Hfkt9Kr9gHQ540dC9qeRSKljwOvhC
ARC-Seal: i=1; a=rsa-sha256; t=1518863535; cv=none;
        d=google.com; s=arc-20160816;
        b=h0wNlaQMWGckwtVwAhJg8SjeGmMpLlHwHqb7MkyuUa2PzuR3lFlCgnzZGxFqL9SW06
         GXocK6ji1BFknThby5p7oJC1wtCRZrVg0JVVgdhjZm1vEclX++Ys5LNqlKECConlvowj
         vmGp6C2vjfhRGJm+AeDAsIFOHew8yk/C4NXUFvTlTEmaVhHSaYuMcH4h7MjmXcQWHbH2
         BKhpIvKZz9g38NtUWk86OjTd+Ph4b2G3+kWcnggsfOcUc6PRRMeZJp0F2gg2ES6ozVcU
         RP/gjw5x4EAvxS/WAVTKJ8OGIv7JHSdZhKtkHqhfiKZkEEVxW7rU999/zckqxE9fEGaD
         k0+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=KrVSAMehEpIdKlYxzhXHkgVw+3bQUTzl13+x9Zb5VgQ=;
        b=OrUdv4lqf1Wi91Tc/KPSXQTnvNdLqo+mkL9Pp22lCBp803eaNwbdDcUnZiHdukeemf
         8BsHqLqY+POmVEA/brnGAeVDTelmEI8WwuqRlw60I5yJVxAKZMOvdMywTz8CXOLJZh6m
         +G+6dUDVXUU4P2i3qG/R/XgZ/PHfUGenv7mnJ261e5ok0eaE0YKCDKITZjaS1+yVUTmm
         3xxGoVp6Gp/ucpRGtqRotEswtzAglK9cA+NuuwBNhprysUuMS94+j+nXDhgST153yCtQ
         gUy/K8v9eKQ1CPACaTp6kVtKKbwcWonCZRwDTmT7yY91+51iiMvs5VMrBtlrgldRQafI
         jqpw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Sat, 17 Feb 2018 02:10:27 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-1d91c1d2c80cb70e2e553845e278b87a960c04da@git.kernel.org>
Cc: tglx@linutronix.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        bp@alien8.de, peterz@infradead.org, linux-kernel@vger.kernel.org,
        arjan@linux.intel.com, gregkh@linuxfoundation.org, dwmw2@infradead.org,
        dan.j.williams@intel.com, jpoimboe@redhat.com,
        torvalds@linux-foundation.org, will.deacon@arm.com, luto@kernel.org,
        mingo@kernel.org
Reply-To: mingo@kernel.org, luto@kernel.org, torvalds@linux-foundation.org,
        will.deacon@arm.com, jpoimboe@redhat.com, dwmw2@infradead.org,
        dan.j.williams@intel.com, arjan@linux.intel.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <151881604278.17395.6605847763178076520.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151881604278.17395.6605847763178076520.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] nospec: Kill array_index_nospec_mask_check()
Git-Commit-ID: 1d91c1d2c80cb70e2e553845e278b87a960c04da
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592643851018777560?=
X-GMAIL-MSGID: =?utf-8?q?1592643851018777560?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  1d91c1d2c80cb70e2e553845e278b87a960c04da
Gitweb:     https://git.kernel.org/tip/1d91c1d2c80cb70e2e553845e278b87a960c04da
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Fri, 16 Feb 2018 13:20:42 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 17 Feb 2018 08:40:59 +0100

nospec: Kill array_index_nospec_mask_check()

There are multiple problems with the dynamic sanity checking in
array_index_nospec_mask_check():

* It causes unnecessary overhead in the 32-bit case since integer sized
  @index values will no longer cause the check to be compiled away like
  in the 64-bit case.

* In the 32-bit case it may trigger with user controllable input when
  the expectation is that should only trigger during development of new
  kernel enabling.

* The macro reuses the input parameter in multiple locations which is
  broken if someone passes an expression like 'index++' to
  array_index_nospec().

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org
Link: http://lkml.kernel.org/r/151881604278.17395.6605847763178076520.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/nospec.h | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/include/linux/nospec.h b/include/linux/nospec.h
index fbc98e2..d6701e3 100644
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -30,26 +30,6 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 #endif
 
 /*
- * Warn developers about inappropriate array_index_nospec() usage.
- *
- * Even if the CPU speculates past the WARN_ONCE branch, the
- * sign bit of @index is taken into account when generating the
- * mask.
- *
- * This warning is compiled out when the compiler can infer that
- * @index and @size are less than LONG_MAX.
- */
-#define array_index_mask_nospec_check(index, size)				\
-({										\
-	if (WARN_ONCE(index > LONG_MAX || size > LONG_MAX,			\
-	    "array_index_nospec() limited to range of [0, LONG_MAX]\n"))	\
-		_mask = 0;							\
-	else									\
-		_mask = array_index_mask_nospec(index, size);			\
-	_mask;									\
-})
-
-/*
  * array_index_nospec - sanitize an array index after a bounds check
  *
  * For a code sequence like:
@@ -67,7 +47,7 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 ({									\
 	typeof(index) _i = (index);					\
 	typeof(size) _s = (size);					\
-	unsigned long _mask = array_index_mask_nospec_check(_i, _s);	\
+	unsigned long _mask = array_index_mask_nospec(_i, _s);		\
 									\
 	BUILD_BUG_ON(sizeof(_i) > sizeof(long));			\
 	BUILD_BUG_ON(sizeof(_s) > sizeof(long));			\
