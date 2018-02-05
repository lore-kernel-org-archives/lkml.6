Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227CK6lHxUo9cBhnQnbEVUf8X9CfP8yno5fiiS/ghv+Zgs+QYPFknbnfYf6L7TA2WBpYElFn
ARC-Seal: i=1; a=rsa-sha256; t=1517855134; cv=none;
        d=google.com; s=arc-20160816;
        b=05Tq4l6DaUY3Emjq00TInzczooNXCSMGzbozMMisvVtXraY5wQy1rVxLdVr/wCr+1X
         z0wHhqMk/iF1ha7kGuRGK27+abKR3VxdXczsUwsJgdTtThA5UL6tV0cX91LGiQ3VM0ZJ
         uy/fSTZdDm73fJFhDuTVw6ouZtGzab8VLiTF1rw1NYe9bzVu+a7Yk7yE447tAZ0TdE/y
         0dmNB/SW2YNQhUcdFsjcuMPqXj7N6wJZeOtLYTaiyYaBph6JfoHxy2UjXSFnFXGRkFuO
         mtrSnyTatS60yC6UsMdQJV1DiYmDmCuz9D7KARpuDcNShWDMscUsiE9klAnW99aBOcQ9
         etbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AjWaYYVRHVrrbCDSTkPUaDmfm98xKdt76jMFyP/RDJ8=;
        b=ceGrtnOqqJgpZXmKAO0tpTd8gvSQsxsAVqIIkvVQnIOlECQWS3ZgB/t+GNQrErNaqe
         59d4j2Y+rpvIt++KzZ6O+anu1pyZOxna9OPfoILAhSArtKsVwRZOZmWnF5A4+Pt4SrkD
         l528qaJyujj7aiXriHLic1iqkja+pUYmOH87C9C7IrQveNpErXxgiZrlKOr/fkzudSgz
         bmBr6nrxdmBcNCZC30wUMazWP3OniXFFIdFkNtR50LnMKIii9LzRRC6yJjuAqvz2zYxK
         IpbHmVz7t8sktWSVMcCbZifrD2rJJonPcVHjtsK43NAxFSqEmFoSQ/kSGROlv6eN7Ffx
         oIfg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arch@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Kees Cook <keescook@chromium.org>,
	kernel-hardening@lists.openwall.com,
	Al Viro <viro@zeniv.linux.org.uk>,
	torvalds@linux-foundation.org,
	alan@linux.intel.com
Subject: [PATCH 4.15 37/60] x86/usercopy: Replace open coded stac/clac with __uaccess_{begin, end}
Date: Mon,  5 Feb 2018 10:23:10 -0800
Message-Id: <20180205182215.491244329@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586412411529132?=
X-GMAIL-MSGID: =?utf-8?q?1591586465957615680?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams dan.j.williams@intel.com

commit b5c4ae4f35325d520b230bab6eb3310613b72ac1

In preparation for converting some __uaccess_begin() instances to
__uacess_begin_nospec(), make sure all 'from user' uaccess paths are
using the _begin(), _end() helpers rather than open-coded stac() and
clac().

No functional changes.

Suggested-by: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: torvalds@linux-foundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727416438.33451.17309465232057176966.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/lib/usercopy_32.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/lib/usercopy_32.c
+++ b/arch/x86/lib/usercopy_32.c
@@ -331,12 +331,12 @@ do {									\
 
 unsigned long __copy_user_ll(void *to, const void *from, unsigned long n)
 {
-	stac();
+	__uaccess_begin();
 	if (movsl_is_ok(to, from, n))
 		__copy_user(to, from, n);
 	else
 		n = __copy_user_intel(to, from, n);
-	clac();
+	__uaccess_end();
 	return n;
 }
 EXPORT_SYMBOL(__copy_user_ll);
@@ -344,7 +344,7 @@ EXPORT_SYMBOL(__copy_user_ll);
 unsigned long __copy_from_user_ll_nocache_nozero(void *to, const void __user *from,
 					unsigned long n)
 {
-	stac();
+	__uaccess_begin();
 #ifdef CONFIG_X86_INTEL_USERCOPY
 	if (n > 64 && static_cpu_has(X86_FEATURE_XMM2))
 		n = __copy_user_intel_nocache(to, from, n);
@@ -353,7 +353,7 @@ unsigned long __copy_from_user_ll_nocach
 #else
 	__copy_user(to, from, n);
 #endif
-	clac();
+	__uaccess_end();
 	return n;
 }
 EXPORT_SYMBOL(__copy_from_user_ll_nocache_nozero);
