Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226I3cvVD9r9LBrMwdSHK+MR9+pFi7Rgk3yTBR+zX62y9SA8kwWnx4fKMSO4/R4rJqYz4yzo
ARC-Seal: i=1; a=rsa-sha256; t=1517855082; cv=none;
        d=google.com; s=arc-20160816;
        b=H240qzk8qQfWA4yp287g90SJK3fUh8lB03XrPnfTrB3MR6MqN9ufk1Xcu0K9RMp505
         r+565FEWry3br6ZQPmgOg3419xZiPGe0l/+pcARQDaE6GTmTeOeawBH5jkAJtucE63r0
         Da3nJ9dTn4SeAOUoVe7jdXuQer0BWBIWjlkSWmA4lZ1m22gBwZ6RRTMk9WBY/XN2UFUm
         JVUgVVyqUHT7iEt/46kJIlaAkUPrvyUijbDRfmbO2Qt/SDdr+3xLDABwFVj6MvcyCSH+
         OEV2s073SeNHA+dSTANg9ciNYMm2JtNbDy5J5wV6qluiyENRJqcLE8KlSZzpmtHCRSJ6
         5BRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7uXzr6ZV7KBwGAEWofiwZ5E1NtHV+Y0YNMxOfNlbceQ=;
        b=L2zAdb4owI7uT4nqNEYHUlIjgO+GMXC0JT36QdWgV5/5pBUKqr6ZhcrHrzFbAItzSP
         PCXq4GZBta91Z7Z2oxe/VwIMtBuD1m6DKXAqZIqA8Z/TBtiRXthrOtsaFpuE9HJYmPlJ
         UR4srsTuXZsGCgEr0tGzIsMc0D5WEs4TPMp9skpHY8f+5pqzXz16oJ0r0VFaxyhBptbC
         rWBmVhiw0MLMqNKSiRQXDGYqaHz3IVw8bhhaI6L8MTzhT0t8Be3EdzmWGkkYeUG93J6K
         MgggcXNYTnyLKut55WjHtJju4oYu6aXfQ38wKPfHPdPQX1vaCfPS8fWeePCJBnDrCd83
         J4XA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andi Kleen <ak@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arch@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Kees Cook <keescook@chromium.org>,
	kernel-hardening@lists.openwall.com,
	Al Viro <viro@zeniv.linux.org.uk>,
	alan@linux.intel.com
Subject: [PATCH 4.14 40/64] x86: Introduce __uaccess_begin_nospec() and uaccess_try_nospec
Date: Mon,  5 Feb 2018 10:22:59 -0800
Message-Id: <20180205182140.224786185@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586411057561407?=
X-GMAIL-MSGID: =?utf-8?q?1591586411057561407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams dan.j.williams@intel.com

commit b3bbfb3fb5d25776b8e3f361d2eedaabb0b496cd

For __get_user() paths, do not allow the kernel to speculate on the value
of a user controlled pointer. In addition to the 'stac' instruction for
Supervisor Mode Access Protection (SMAP), a barrier_nospec() causes the
access_ok() result to resolve in the pipeline before the CPU might take any
speculative action on the pointer value. Given the cost of 'stac' the
speculation barrier is placed after 'stac' to hopefully overlap the cost of
disabling SMAP with the cost of flushing the instruction pipeline.

Since __get_user is a major kernel interface that deals with user
controlled pointers, the __uaccess_begin_nospec() mechanism will prevent
speculative execution past an access_ok() permission check. While
speculative execution past access_ok() is not enough to lead to a kernel
memory leak, it is a necessary precondition.

To be clear, __uaccess_begin_nospec() is addressing a class of potential
problems near __get_user() usages.

Note, that while the barrier_nospec() in __uaccess_begin_nospec() is used
to protect __get_user(), pointer masking similar to array_index_nospec()
will be used for get_user() since it incorporates a bounds check near the
usage.

uaccess_try_nospec provides the same mechanism for get_user_try.

No functional changes.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Andi Kleen <ak@linux.intel.com>
Suggested-by: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727415922.33451.5796614273104346583.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/include/asm/uaccess.h |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -124,6 +124,11 @@ extern int __get_user_bad(void);
 
 #define __uaccess_begin() stac()
 #define __uaccess_end()   clac()
+#define __uaccess_begin_nospec()	\
+({					\
+	stac();				\
+	barrier_nospec();		\
+})
 
 /*
  * This is a type: either unsigned long, if the argument fits into
@@ -487,6 +492,10 @@ struct __large_struct { unsigned long bu
 	__uaccess_begin();						\
 	barrier();
 
+#define uaccess_try_nospec do {						\
+	current->thread.uaccess_err = 0;				\
+	__uaccess_begin_nospec();					\
+
 #define uaccess_catch(err)						\
 	__uaccess_end();						\
 	(err) |= (current->thread.uaccess_err ? -EFAULT : 0);		\
