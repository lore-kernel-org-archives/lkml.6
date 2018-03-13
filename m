Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtiK9Op/g0BjH/MlEnThls+Ifc5NVYqUrrSZ+nG9SsEXdO2Ovl03g0P7EIwSHZeaBXmXwHY
ARC-Seal: i=1; a=rsa-sha256; t=1520955074; cv=none;
        d=google.com; s=arc-20160816;
        b=Cx+FDEQ8TJNhSb1Yf8UYVtc3+UQ7g+ufEWGDXWHc7SYUthMzunKcFipl0ik0WuHKxo
         iG3P4t4CpVR7BUpf8kyMY6C1fvCC9D9mx8uATuOTo5JPdzvVXvAxNvqj1K0LSTtpHrP+
         7/TUFGlUJwwbTctrIviMHMYVPLE69UeOd1fOQjG4yqpWZwsiA/HoDaByWr8+FOcMKN7v
         W+s5EWZ0E8UH1LCQtdaaVHuif8SoCpDfRuUugnm3wMY6kS9Ny/6z26/FzJBEQVwKqpON
         sJQOJkBUKARNmInDps+1A1ZHZP+/IhGZMlOXzEaSHkHt0SktK7ZPLvxSmC7NvWDLdt5o
         LtfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3v1Aa8e09oUJ3/DbK7i4CwfchK3J8Vm8skWHQw39lGc=;
        b=ky3TrveZ54L+GWimjRfUx8YeMYYaheqr0Mj3RB2nmd6z2gCZ3TYGi59n39rn9OFxZS
         ZDnAzmM/hW0jo13gNQh9IwjOMeIjc4XCnrad5DwOIPEGPhcYEUSlIAsqv0DzDnjeshVd
         o/d646LoAU5Zty0fO8+9sZQpcz4tVgo/Fbeoe2UCLgbryD3WEnVLLaJpBFmHzU1ee5bl
         r2HEe/rrrw4EjoOQK8p1xOkSCwjabeDtxUcE5cXosvPCgGOm93T5FSue7pjRsQfT+9bg
         EwqWwggXChdovR79s6QEpZjv6NoLdPSli0/R4kOLDUcU+aqNEXpYuF6zLUNQGcsfs98X
         YFWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will.deacon@arm.com>,
	linux-arch@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 080/146] nospec: Kill array_index_nospec_mask_check()
Date: Tue, 13 Mar 2018 16:24:07 +0100
Message-Id: <20180313152326.989811763@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836987780725095?=
X-GMAIL-MSGID: =?utf-8?q?1594836987780725095?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 1d91c1d2c80cb70e2e553845e278b87a960c04da upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/nospec.h |   22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -30,26 +30,6 @@ static inline unsigned long array_index_
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
@@ -67,7 +47,7 @@ static inline unsigned long array_index_
 ({									\
 	typeof(index) _i = (index);					\
 	typeof(size) _s = (size);					\
-	unsigned long _mask = array_index_mask_nospec_check(_i, _s);	\
+	unsigned long _mask = array_index_mask_nospec(_i, _s);		\
 									\
 	BUILD_BUG_ON(sizeof(_i) > sizeof(long));			\
 	BUILD_BUG_ON(sizeof(_s) > sizeof(long));			\
