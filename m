Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48GIZdbJP130k+O3K0wmpUV5GRGIL3JMzEiLia8CQc1Kp7oFwrlwq7AIXpwzILjGv+Pu29h
ARC-Seal: i=1; a=rsa-sha256; t=1523021509; cv=none;
        d=google.com; s=arc-20160816;
        b=cU9kANNob4SdfR/ugK/mzthMxcEwgTtmkz4BR2yMgfsXMuhpNMTcULqjrtHK5znYgj
         slQRjITnLdQdSzqshe/F3RuV2YTSjd86vcMr89hP+RLCkqNk0GA5GOo1yw7NdvlVjb/k
         f1PNKCQf/vKY+vWpBOnDHCmTsNivXKp2GyVsj2JJWYG4hJXPGQ/kcebiBQdn+Vdw9b2z
         A0dwn3K3trZDX0ktnbaoZrLvdYx7OxvNMmqVHBlf43CZq90g87q2Xcos4Bz+nRFu9SlG
         PA+VgCwz6bkfiBgl45RuBteItaUzt31sL6f1z3eJGN/nsGVtq7ap48Frh+fYkKQPSYZE
         xn7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IhM+Udd2W3LNd1j2SldlyRcijHKg9KhrYaOl4khzCNk=;
        b=qIC/cbEsR3MA/oq6wyD0AE1J9j/EMUWKwi1dY34JGZOIjJ0FKFt3xzo9i64o/VQkok
         C4g4Z3guf009yNg37SqHM+YMAD/0QIRagTZ9Nk4UxYbKTqvmnedgubBSX2hhsypKyVFi
         2W6Evh23T6raWvLP1Eged8zRcWrQBaMTy+54LqeXmZBc4dptxyvcX2OBc6Hobv6eJLiG
         kRESwYIy5W/T3/zCjVECsQcsA3KpMFYSYF6RHjMguHuUxEyUNWGnvEUCsQOFKbMN6iMT
         5LS+0uabc8bEu8gFYIpTQ3m1XA3zpRMUqRqG9yG+x3AcJ1wIrbLfqEI6XEUUtsP5e6Jx
         9gag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 63/72] nospec: Move array_index_nospec() parameter checking into separate macro
Date: Fri,  6 Apr 2018 15:24:04 +0200
Message-Id: <20180406084310.714705931@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003802507858226?=
X-GMAIL-MSGID: =?utf-8?q?1597003802507858226?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/nospec.h |   36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -21,20 +21,6 @@ static inline unsigned long array_index_
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
@@ -45,6 +31,26 @@ static inline unsigned long array_index_
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
@@ -62,7 +68,7 @@ static inline unsigned long array_index_
 ({									\
 	typeof(index) _i = (index);					\
 	typeof(size) _s = (size);					\
-	unsigned long _mask = array_index_mask_nospec(_i, _s);		\
+	unsigned long _mask = array_index_mask_nospec_check(_i, _s);	\
 									\
 	BUILD_BUG_ON(sizeof(_i) > sizeof(long));			\
 	BUILD_BUG_ON(sizeof(_s) > sizeof(long));			\
