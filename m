Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELtv1/sP3T0Q4F+PxWxtlZDakGldfds+A4GLszCMK8cpxU9sTnQE59cadxzNrh5HoUQ4sfpu
ARC-Seal: i=1; a=rsa-sha256; t=1520824088; cv=none;
        d=google.com; s=arc-20160816;
        b=kqxncxKtuhrvZhslqzEXhEMB2Nzn2eFBnE7sj2q2OL11Ydxgjm9o1y3VSGslgb1g1h
         Vc9sn2BbJpaYXCejHFGHuK2RL01eji0KOFAOA2DaiYq54tXZebFZwJ3/hGKlJA2FTKw9
         gNj9ZOtqCw+Pc7Y0D3+DRUgqSxKm6s/0njcz+LBYq3S19pSMC5zfbssSQ6FTCE15NsGn
         ECt+2c/x4WnTF0E27jVg6faKVzjoqTqyG9vgHMM5JS2C09xi5yN3MDk2PM0L9nYcqFpE
         pdCtl+C7gAm/is4X/9nhe2C3dlhL0kBuIFwlvS1LAsegBWV/sjn7K+kBt92tsrIyDqwu
         C2yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=or97DfBn5qV7qXaU7b7ns9tZwZAR6gPsvmUbRFNZqVI=;
        b=RwKgyZY+FazS5xNJ1Z7TKe4LWYvxsbgnjEwSl7kLUBIM6NGeiSAktkKDtJCUwNxNtF
         HxXH93NWlfxAcwMfVOv/iEHLai+r8AxYxn/pahPg3zkJQvlAeVG8rNYJb/GnnujOvag2
         dWZh+fYn1aMrwreLtYdpBik13sjGpMCeCQv3Ojckvq8ZcAifIvfCl409iF2bjKEG8wH6
         QgDXIO89GX7DgL2rJGeG7GPAcffT0w61OiQaliHjx74JqFG/yuxrl9ppXfOVwBwdJKvz
         RS5vy89lEOQkhWyZEyMHM/z4be/sP3nkroCP1gkeERo6CErES2tTJ0h17qziuE7owYrZ
         Q+ig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Kees Cook" <keescook@chromium.org>,
 kernel-hardening@lists.openwall.com,
 "Al Viro" <viro@zeniv.linux.org.uk>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Tom Lendacky" <thomas.lendacky@amd.com>,
 "Ingo Molnar" <mingo@redhat.com>,
 "Dan Williams" <dan.j.williams@intel.com>,
 alan@linux.intel.com,
 "Thomas Gleixner" <tglx@linutronix.de>,
 gregkh@linuxfoundation.org, linux-arch@vger.kernel.org
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.837680702@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 73/76] x86: Introduce __uaccess_begin_nospec() and
 uaccess_try_nospec
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699614319217448?=
X-GMAIL-MSGID: =?utf-8?q?1594699639685828669?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit b3bbfb3fb5d25776b8e3f361d2eedaabb0b496cd upstream.

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
[bwh: Backported to 3.16: use current_thread_info()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/uaccess.h | 9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -145,6 +145,11 @@ extern int __get_user_bad(void);
 
 #define __uaccess_begin() stac()
 #define __uaccess_end()   clac()
+#define __uaccess_begin_nospec()	\
+({					\
+	stac();				\
+	barrier_nospec();		\
+})
 
 /*
  * This is a type: either unsigned long, if the argument fits into
@@ -470,6 +475,10 @@ struct __large_struct { unsigned long bu
 	__uaccess_begin();						\
 	barrier();
 
+#define uaccess_try_nospec do {						\
+	current_thread_info()->uaccess_err = 0;				\
+	__uaccess_begin_nospec();					\
+
 #define uaccess_catch(err)						\
 	__uaccess_end();						\
 	(err) |= (current_thread_info()->uaccess_err ? -EFAULT : 0);	\
