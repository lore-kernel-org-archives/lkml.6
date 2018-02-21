Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227xqbCu5ECvBuRruA0s8lKyzkNt8JdPlc7Rvf9HiNTQBApJmUFyldhMDlWxUWu8Q1ks96Yv
ARC-Seal: i=1; a=rsa-sha256; t=1519218553; cv=none;
        d=google.com; s=arc-20160816;
        b=iLG/BnW8KzkQfd4vCUal6Pd2/I1v++9EqDd8YIDf8X87a4d9P3DQhPvyu0+WSNBpJ1
         0ANp0GQJFQa4wkdrDbcBIoE51n7NubhYrwCEa0gzFB5Rfy5rxzHiEc4dyXpcp+jgsopM
         up1JNI93MZOBXR+19iNjXaXGA8JL8eaYJNmngoYL4A0mH7lBGNqZLN5Ax128mZ2U38e3
         bT92X7oUpglUyrQEoN9SId0p7sjzfqcyH5iGOUzTBB/3uBa9d0sWtV760JOtnxdndERk
         eDbckPVuXoWxd5aIWmwKKcmzhpBFnZlZBxcLCGnmdxdvWGLTcQLAsqjX2fu129c88Rw4
         OnOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=e9pzlwU/p2sRW8TEUHPWxvdjjPXXAcMhmnFqHUEIA0E=;
        b=wjGtLHNUOrRAuf45u6VPoHR5YLyjTOQp9zrDuo7uVpFDlZHe0USM9jTAMrwRZmbrvU
         TRyfuUPNzCguzkajDSc4L6zPao6nWqiaXyFEwqaKgBnCgsdNEDs8ACz4pVtIGjq6Tb0X
         P+3/SYgxcTvpCfuyazc+Jek2ovUcRA7VTvOIb4nnYWb3Df/ZHnJytxM+M9TOqP8+c9PV
         FgOF+ywgwFR/1Gaw/Hi0eaUAeE25/zj8IoJp+UxD55Dg12ekV8dNkIP0YiwBAy5vQI9O
         Gt5Fy2qqOYrCeowuooyjqbhQ2ns7gTAjUufDh5fj8HK7ER0+a5BWF1jsEvGFdUl2Ht/L
         Rgag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 080/163] nospec: Move array_index_nospec() parameter checking into separate macro
Date: Wed, 21 Feb 2018 13:48:29 +0100
Message-Id: <20180221124534.867810766@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015327190817338?=
X-GMAIL-MSGID: =?utf-8?q?1593016114754913796?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 8fa80c503b484ddc1abbd10c7cb2ab81f3824a50 upstream.

For architectures providing their own implementation of
array_index_mask_nospec() in asm/barrier.h, attempting to use WARN_ONCE() to
complain about out-of-range parameters using WARN_ON() results in a mess
of mutually-dependent include files.

Rather than unpick the dependencies, simply have the core code in nospec.h
perform the checking for us.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1517840166-15399-1-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/nospec.h |   36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -20,20 +20,6 @@ static inline unsigned long array_index_
 						    unsigned long size)
 {
 	/*
-	 * Warn developers about inappropriate array_index_nospec() usage.
-	 *
-	 * Even if the CPU speculates past the WARN_ONCE branch, the
-	 * sign bit of @index is taken into account when generating the
-	 * mask.
-	 *
-	 * This warning is compiled out when the compiler can infer that
-	 * @index and @size are less than LONG_MAX.
-	 */
-	if (WARN_ONCE(index > LONG_MAX || size > LONG_MAX,
-			"array_index_nospec() limited to range of [0, LONG_MAX]\n"))
-		return 0;
-
-	/*
 	 * Always calculate and emit the mask even if the compiler
 	 * thinks the mask is not needed. The compiler does not take
 	 * into account the value of @index under speculation.
@@ -44,6 +30,26 @@ static inline unsigned long array_index_
 #endif
 
 /*
+ * Warn developers about inappropriate array_index_nospec() usage.
+ *
+ * Even if the CPU speculates past the WARN_ONCE branch, the
+ * sign bit of @index is taken into account when generating the
+ * mask.
+ *
+ * This warning is compiled out when the compiler can infer that
+ * @index and @size are less than LONG_MAX.
+ */
+#define array_index_mask_nospec_check(index, size)				\
+({										\
+	if (WARN_ONCE(index > LONG_MAX || size > LONG_MAX,			\
+	    "array_index_nospec() limited to range of [0, LONG_MAX]\n"))	\
+		_mask = 0;							\
+	else									\
+		_mask = array_index_mask_nospec(index, size);			\
+	_mask;									\
+})
+
+/*
  * array_index_nospec - sanitize an array index after a bounds check
  *
  * For a code sequence like:
@@ -61,7 +67,7 @@ static inline unsigned long array_index_
 ({									\
 	typeof(index) _i = (index);					\
 	typeof(size) _s = (size);					\
-	unsigned long _mask = array_index_mask_nospec(_i, _s);		\
+	unsigned long _mask = array_index_mask_nospec_check(_i, _s);	\
 									\
 	BUILD_BUG_ON(sizeof(_i) > sizeof(long));			\
 	BUILD_BUG_ON(sizeof(_s) > sizeof(long));			\
