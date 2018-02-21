Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226LmIJHJv8CQmQZcPtCL1k0TixP4WTz5r115pfwJz15AdRdUgzeBKTi+MYPcLPgxnIIucSf
ARC-Seal: i=1; a=rsa-sha256; t=1519218562; cv=none;
        d=google.com; s=arc-20160816;
        b=FjV25Yu1MYyIG4EsGgB3LGG9LbrRXXnnIwLZKvqtb7toVbVIJc2oLCaD6/9Ii2qui5
         BoQankzdFNgsdDhlIUmTqREGi0MAvjrbVYrXjl3ygFqd/C4x4himtxpWYJMZtmn1GQgY
         qR2s0XlXj6USII+OWRINXtHtAswBsXAd7aLII7s5vxOLHTlmX8k22ay/QXd2n0XdJ4ws
         Qm+eSzUH0tw0DODcgI8RXkS1kX3udsZ6hqRbxGZJYEvhbGuVtnfJuUWz/l9BHNgzu+mR
         astmEHBQj1GD2GQ5Z5sMpi/AJcp6Y0xcmqdnvDzIuzG4ZxKNkVeJj6bmS3smLEoIMmJN
         R9XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fhyX205zNX6orm9c9M1eZGGaKeV1ukebj2eD2JP5Rxs=;
        b=xoPDpRLs2rskxG4ZoKi0x/clalWm1jHu3EB8/dH/d+BleAeHcB/f5yz66h/uXaBwLw
         WAU1bEsrRAZ5WN8YTuVmglGD6gYlOYB8iOP4lrxfEqF7JCyeSbRUSjXPmP67cA1jxZW1
         keT9fI0M5SvExEl9DrDpi/w7UWaOX0EFFSw/8Oz7tkJEMm8uVqyRepTH+kJIeRzNZewy
         YGMcZvMvjDcIL8nlNg7+GR+C0GCqCKFnXWZoaMgobfySYUU9oPMXiRyg+rWALp9aqOKX
         c0j/yXzFzu7/wi31Tp8ZKb9AtPQVgV5NUtUb6O/3iRVBfo9yfqvh5RkRXteJ6/45zYTQ
         oEAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rui Wang <rui.y.wang@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	dave.hansen@linux.intel.com,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 083/163] selftests/x86/mpx: Fix incorrect bounds with old _sigfault
Date: Wed, 21 Feb 2018 13:48:32 +0100
Message-Id: <20180221124535.007730540@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015332922490474?=
X-GMAIL-MSGID: =?utf-8?q?1593016123280105246?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rui Wang <rui.y.wang@intel.com>

commit 961888b1d76d84efc66a8f5604b06ac12ac2f978 upstream.

For distributions with old userspace header files, the _sigfault
structure is different. mpx-mini-test fails with the following
error:

  [root@Purley]# mpx-mini-test_64 tabletest
  XSAVE is supported by HW & OS
  XSAVE processor supported state mask: 0x2ff
  XSAVE OS supported state mask: 0x2ff
   BNDREGS: size: 64 user: 1 supervisor: 0 aligned: 0
    BNDCSR: size: 64 user: 1 supervisor: 0 aligned: 0
  starting mpx bounds table test
  ERROR: siginfo bounds do not match shadow bounds for register 0

Fix it by using the correct offset of _lower/_upper in _sigfault.
RHEL needs this patch to work.

Signed-off-by: Rui Wang <rui.y.wang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dave.hansen@linux.intel.com
Fixes: e754aedc26ef ("x86/mpx, selftests: Add MPX self test")
Link: http://lkml.kernel.org/r/1513586050-1641-1-git-send-email-rui.y.wang@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/mpx-mini-test.c |   32 ++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/x86/mpx-mini-test.c
+++ b/tools/testing/selftests/x86/mpx-mini-test.c
@@ -315,11 +315,39 @@ static inline void *__si_bounds_upper(si
 	return si->si_upper;
 }
 #else
+
+/*
+ * This deals with old version of _sigfault in some distros:
+ *
+
+old _sigfault:
+        struct {
+            void *si_addr;
+	} _sigfault;
+
+new _sigfault:
+	struct {
+		void __user *_addr;
+		int _trapno;
+		short _addr_lsb;
+		union {
+			struct {
+				void __user *_lower;
+				void __user *_upper;
+			} _addr_bnd;
+			__u32 _pkey;
+		};
+	} _sigfault;
+ *
+ */
+
 static inline void **__si_bounds_hack(siginfo_t *si)
 {
 	void *sigfault = &si->_sifields._sigfault;
 	void *end_sigfault = sigfault + sizeof(si->_sifields._sigfault);
-	void **__si_lower = end_sigfault;
+	int *trapno = (int*)end_sigfault;
+	/* skip _trapno and _addr_lsb */
+	void **__si_lower = (void**)(trapno + 2);
 
 	return __si_lower;
 }
@@ -331,7 +359,7 @@ static inline void *__si_bounds_lower(si
 
 static inline void *__si_bounds_upper(siginfo_t *si)
 {
-	return (*__si_bounds_hack(si)) + sizeof(void *);
+	return *(__si_bounds_hack(si) + 1);
 }
 #endif
 
