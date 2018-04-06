Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49cLpJbfjYhT2xyZfYfdGqVbtb7xeuKd30mqgyIVUSewGyZuf4/CgMSKpSutFEf94ADyc8G
ARC-Seal: i=1; a=rsa-sha256; t=1523021512; cv=none;
        d=google.com; s=arc-20160816;
        b=varqeBAhn7CMEJ1k2v8qJ8X29RzTTWVm8oKs8fbobSWQeQZTMgRAxbDz+J5ZyzvXpd
         CSqBYX7QVm6SSm23YYM84Q+BpyrI+lo3uJJS9guXzdPixEAVIQ3AcUSCfBTO4QQB8txt
         fRJdLCyJdZ6BD+fyF7rsHe5DF4Q0hIVbVjoYCKAWnGjxabXBKE4Zh9Fg9EHV1gpLbQmk
         ed7lcc1IoHmyW5R+zDIs4ZrDRDP1GkTkSiK/i3Zyo7+IM6BgR68RjkpXN8IRhpoBR9SQ
         OFg0JMe4K9f11SvT0ACIneOCoLWtlkA7acuohYyc5heXFnGRj5AQKnUwXmuM3iuq1Cq5
         SBfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KMFtC7DviRHpNFiDEPT72XprLhhRnBvIYiJQebEugy8=;
        b=KxRX4bM/jsM+bLYPjl3aOfuRBa+S5Vq/8vqYXZqciJ2bBW8Ox13PWgqKxRfCGTDHcl
         kNOnvp8/SyV+Sv4GLnpaMbM6y8vZSjto6IJ8h/iSaoXc76I1vvwqrYjQQEMUn+xF1YPs
         CufgaUHoRM9lyMtTVXgKrApRstxrOtK7pqN0xPHh6VwoOlT37JIiO2fk7kT087jj3oi1
         jPrQaxTNSZhoCoB72ZgKyWn+NJnCL7IV4pusHe7cPEtgt050CgpCN7IPZv8xPDqTn1BS
         HUiUBXCoPp7HaqVEF5EGCimKG2ksTSYbrrk2XyohU9z9RAWvbhbGfoVd+7daLUJlbSlt
         mi/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
	Ingo Molnar <mingo@kernel.org>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 64/72] nospec: Kill array_index_nospec_mask_check()
Date: Fri,  6 Apr 2018 15:24:05 +0200
Message-Id: <20180406084310.804074694@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003805670410036?=
X-GMAIL-MSGID: =?utf-8?q?1597003805670410036?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/nospec.h |   22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -31,26 +31,6 @@ static inline unsigned long array_index_
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
@@ -68,7 +48,7 @@ static inline unsigned long array_index_
 ({									\
 	typeof(index) _i = (index);					\
 	typeof(size) _s = (size);					\
-	unsigned long _mask = array_index_mask_nospec_check(_i, _s);	\
+	unsigned long _mask = array_index_mask_nospec(_i, _s);		\
 									\
 	BUILD_BUG_ON(sizeof(_i) > sizeof(long));			\
 	BUILD_BUG_ON(sizeof(_s) > sizeof(long));			\
