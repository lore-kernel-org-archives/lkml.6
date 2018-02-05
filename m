Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224UqbMxyy8kOQxGCiNjyc+irAOmryD9f24ZVxGEgd0cd8k+xPbVpG7EUGZwboCH0kxTpbJR
ARC-Seal: i=1; a=rsa-sha256; t=1517855081; cv=none;
        d=google.com; s=arc-20160816;
        b=wThxbYQudv64r8rdKma9bvW4Zi4PGowBBeuZUjuJecXa2OJPY17/Tc1zadrlKbybKu
         DU4swM4jywqRZV3zc1ua6e08Jw9ucMXU9ZapqfVzlmY3wUu52KdfM6RCCBbsQuSrt7Mb
         LOZ/8iAg8aA2hfTnuE9XDtBeGAzlr+NMnPRHn/pNkQa/lUZIxJWbkfnvtRP8ai7BPSF7
         Q9N6LXJ6OGCduXidlPNa4QNwxTT7QfO3hdaEW3/dfTwQo3E2swaHDrwUx04XHfsjz3dX
         PoGuillIaT9ut0yZK0lf3WbDZNjrrklqSpPMl2w+VDu4WF17hypthDWSxgvIF2pmecQs
         Do+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KRP0WrPPQri2MXtKgWyAXxyT1GB5lYXjVJjuWBMQCwU=;
        b=ql9P9IwziqK051yy+do9Iv8E/j3OSWNkLW4LSr+ljD4eJ9HQToq4uwdx92wS7IEJRv
         Z9Cuij7ynS9NWNKopvFEELDehCReN441+0pc1bCnqeAIBn8R31sKhObSzcB9bLHPeMct
         D0vNF1MxUQYNxtdMQUYNdOGZ7H60RXr8uCjWulQeYulK3wYXtnm3aXuscon9zxzEpBbS
         Cjm0GUCq+O8gqU6/e5arkVnIvjOKdMjOUzffGPi0Gb8GfAVEZYBylqim3vPX3wkLYAYi
         GeDSjO2PmzHpgJWzGAwQJs5yQXBkeIDoMpJ1COJc2LymKsAcieQT/6e/yxrm4PSH/AjZ
         mCvQ==
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
Subject: [PATCH 4.14 39/64] x86: Introduce barrier_nospec
Date: Mon,  5 Feb 2018 10:22:58 -0800
Message-Id: <20180205182140.182282620@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586409621203264?=
X-GMAIL-MSGID: =?utf-8?q?1591586409621203264?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams dan.j.williams@intel.com

commit b3d7ad85b80bbc404635dca80f5b129f6242bc7a

Rename the open coded form of this instruction sequence from
rdtsc_ordered() into a generic barrier primitive, barrier_nospec().

One of the mitigations for Spectre variant1 vulnerabilities is to fence
speculative execution after successfully validating a bounds check. I.e.
force the result of a bounds check to resolve in the instruction pipeline
to ensure speculative execution honors that result before potentially
operating on out-of-bounds data.

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
Link: https://lkml.kernel.org/r/151727415361.33451.9049453007262764675.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/include/asm/barrier.h |    4 ++++
 arch/x86/include/asm/msr.h     |    3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -48,6 +48,10 @@ static inline unsigned long array_index_
 /* Override the default implementation from linux/nospec.h. */
 #define array_index_mask_nospec array_index_mask_nospec
 
+/* Prevent speculative execution past this barrier. */
+#define barrier_nospec() alternative_2("", "mfence", X86_FEATURE_MFENCE_RDTSC, \
+					   "lfence", X86_FEATURE_LFENCE_RDTSC)
+
 #ifdef CONFIG_X86_PPRO_FENCE
 #define dma_rmb()	rmb()
 #else
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -214,8 +214,7 @@ static __always_inline unsigned long lon
 	 * that some other imaginary CPU is updating continuously with a
 	 * time stamp.
 	 */
-	alternative_2("", "mfence", X86_FEATURE_MFENCE_RDTSC,
-			  "lfence", X86_FEATURE_LFENCE_RDTSC);
+	barrier_nospec();
 	return rdtsc();
 }
 
