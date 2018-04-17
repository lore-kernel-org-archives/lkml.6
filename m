Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/1NcI/AlH+eoy2obh6rx/Fv2dry3xu97TfRCWldaw7BtuuL6ZusLJOF7zhBS3WRxvCi2dW
ARC-Seal: i=1; a=rsa-sha256; t=1523981297; cv=none;
        d=google.com; s=arc-20160816;
        b=UNuPnnN5TWERrl/5/JZLCE58y9Ym+J23waxba3RoRv+6tsGS3F+AWImIOtbQGW5Z/k
         YN3hrUX7DkusnEHFccWbFyNaq117L+KkHLgYZpP99trxZQvUlKUVmAh3y/L1xJKpnDpd
         jou7+t5PvZFY0bm1ADHSEy4f+Jh55xvDt3d+wZgFlAJk7kopaQ2V7ehf7vuoEfYxGfHm
         NyBEzu+bCM+BCnY0Tppo0WWACas6IAhNI+BHIDX97lqcKWoCcnAMjk0MbMoY5JbwBiaz
         l7poC555tTKc56KYea7b3o650+4KeiT3jpbVA/4+cY5cOPze0y9O9Ng1Ih0QDBI1ywL3
         3R9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ilNKYfVdMdrzvAM8nORJTrAF6BlaRIAbNfK7T8WqzYw=;
        b=Ta1Knmb0rGNFNzjLoGQBsSsGvIRF5qyvmQKa4rKWgG0JeIfBP27nLZo5fGKhjMYBND
         96HpqRWBIKe4v7b/4bA9Nt7Wx1ZNn/n6qrOv3FfZHc6lCIpkWltV5za2VigyR+mLEh5w
         IumiC+QE1wCfRzAqCy5x5u109gQBMsZP57OGQJR08nx/vLNESxLh5DQbiozbEvJ8xrbb
         6G/IbzsfgJ1glCDj5g0Scfr+o9Cs5UiArWaYAJ8SHHsZqDaNILRdr35zKAnIUD5Wedec
         t7mhQ+oGxPYXfvn7kcPufq6OsgY91lCzdO/co9T2GuTmxjm35F6x208CIAt8u3OhWlUk
         ea7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 14/66] arm64: Use pointer masking to limit uaccess speculation
Date: Tue, 17 Apr 2018 17:58:47 +0200
Message-Id: <20180417155646.457770527@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010212913590085?=
X-GMAIL-MSGID: =?utf-8?q?1598010212913590085?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Robin Murphy <robin.murphy@arm.com>

commit 4d8efc2d5ee4c9ccfeb29ee8afd47a8660d0c0ce upstream.

Similarly to x86, mitigate speculation past an access_ok() check by
masking the pointer against the address limit before use.

Even if we don't expect speculative writes per se, it is plausible that
a CPU may still speculate at least as far as fetching a cache line for
writing, hence we also harden put_user() and clear_user() for peace of
mind.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/uaccess.h |   26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -129,6 +129,26 @@ static inline unsigned long __range_ok(u
 	"	.popsection\n"
 
 /*
+ * Sanitise a uaccess pointer such that it becomes NULL if above the
+ * current addr_limit.
+ */
+#define uaccess_mask_ptr(ptr) (__typeof__(ptr))__uaccess_mask_ptr(ptr)
+static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
+{
+	void __user *safe_ptr;
+
+	asm volatile(
+	"	bics	xzr, %1, %2\n"
+	"	csel	%0, %1, xzr, eq\n"
+	: "=&r" (safe_ptr)
+	: "r" (ptr), "r" (current_thread_info()->addr_limit)
+	: "cc");
+
+	csdb();
+	return safe_ptr;
+}
+
+/*
  * The "__xxx" versions of the user access functions do not verify the address
  * space - it must have been done previously with a separate "access_ok()"
  * call.
@@ -202,7 +222,7 @@ do {									\
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
 	might_fault();							\
 	access_ok(VERIFY_READ, __p, sizeof(*__p)) ?			\
-		__get_user((x), __p) :					\
+		__p = uaccess_mask_ptr(__p), __get_user((x), __p) :	\
 		((x) = 0, -EFAULT);					\
 })
 
@@ -270,7 +290,7 @@ do {									\
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
 	might_fault();							\
 	access_ok(VERIFY_WRITE, __p, sizeof(*__p)) ?			\
-		__put_user((x), __p) :					\
+		__p = uaccess_mask_ptr(__p), __put_user((x), __p) :	\
 		-EFAULT;						\
 })
 
@@ -331,7 +351,7 @@ static inline unsigned long __must_check
 static inline unsigned long __must_check clear_user(void __user *to, unsigned long n)
 {
 	if (access_ok(VERIFY_WRITE, to, n))
-		n = __clear_user(to, n);
+		n = __clear_user(__uaccess_mask_ptr(to), n);
 	return n;
 }
 
