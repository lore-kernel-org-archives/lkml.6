Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELsp3zfAJ/5HZWTaNl0HyVX+HrNXKQK6DDsVqGb2MPgQxHB2WnPpOUa//IzFJAMEpDHBzGyi
ARC-Seal: i=1; a=rsa-sha256; t=1520824065; cv=none;
        d=google.com; s=arc-20160816;
        b=fC4wIUwamTGkQpe+QSTTdP9qKsFnnhSCyubPZ4IL0+zMHKn/Kvaxaf37IwzWPYP4Ul
         1VB8tbGInWo3pNtxrfERwO5Z26FLjyH2QP2M3Pe+urRtRUgDmuEhnQPP3GceXDuMcScL
         WuHfy7sIerc1OVgKU9JM5y0NS1B0y9Bvvy8SNFTUP7VPjzjm5FYflJWPydXpgGo8NREH
         coW0tAOYWBotka2zCeJ5el5bFaFWvbUjlavsds2/LJU7SD0jc4QE6ml4SYES6HIfaRD9
         DpAguYyBl7a0urKo6pNsGpth9199omerffyr4QJzyi9FZL8HtAY9Eaz3Fkv/E/QsWWTR
         IyEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=xa758i8MPUAvbK6RXz2RbxrM5QH76HUZzdc0Ttjiq0Y=;
        b=UIxUwchFJ8uCe6c9pF3KqlXkwh08xWynAvT5oSkjqYCFjDLUvgm4AP1+G4YR/RJEJ4
         GQUETrm6SIiPko4dZrbz2UYFTNd6L2Sw8Tt8VGJidncLF/Wv00YX36c23p8Pw9DwnKxN
         wTUF8E+vx07YptVrhtn+YdmKcESUy9F56eIuSUAbWBeGlVauFzvpQW2y03tLy4XJcncZ
         lbQTjBdYLbRbVUEu1iEVoMq8Z75S9/BbrehG3TsasCE7Mrp0ow75bTl7BUCcESy2tZeB
         vVr2jwolm3LIonFIsw/COXPfHDP7A4+7ojOlZyb0sHYcIMocHGSByndQN/zTmp7JwAlC
         f5zw==
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
CC: akpm@linux-foundation.org, kernel-hardening@lists.openwall.com,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Kees Cook" <keescook@chromium.org>,
 alan@linux.intel.com, linux-arch@vger.kernel.org,
 "Al Viro" <viro@zeniv.linux.org.uk>,
 "Ingo Molnar" <mingo@redhat.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Tom Lendacky" <thomas.lendacky@amd.com>,
 gregkh@linuxfoundation.org
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.499853632@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 101/104] x86: Introduce __uaccess_begin_nospec() and
 uaccess_try_nospec
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699614319217448?=
X-GMAIL-MSGID: =?utf-8?q?1594699614319217448?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2:
 - There's no SMAP support, so only add uaccess_try_nospec()
 - Use current_thread_info() and save the previous error state, matching
   uaccess_try()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -462,6 +462,11 @@ struct __large_struct { unsigned long bu
 	current_thread_info()->uaccess_err = 0;				\
 	barrier();
 
+#define uaccess_try_nospec do {						\
+	int prev_err = current_thread_info()->uaccess_err;		\
+	current_thread_info()->uaccess_err = 0;				\
+	barrier_nospec();
+
 #define uaccess_catch(err)						\
 	(err) |= current_thread_info()->uaccess_err;			\
 	current_thread_info()->uaccess_err = prev_err;			\
