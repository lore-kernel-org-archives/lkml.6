Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvgbVX9aE56oZIfPDFDRpOZM4WPK6ezPGj7HoR1jRBfrNmuCVeabCV429/PaVKjBoE+YLGx
ARC-Seal: i=1; a=rsa-sha256; t=1519411232; cv=none;
        d=google.com; s=arc-20160816;
        b=eJGk2r0v7lgXB7IGnrTjeYkBXYvzF8JQGNTwDs7XAlP9b+lxk3/ee6Ocp+dh6wbG5F
         n6q8S/MGmwBaVEW8fNPQlYDACpPkP/7GoGvtjtP+ldVS25C72j3uLWf6AfSx0/Jh8WjO
         QCWTawtL5n/a0/ZdEOvnaDw1lew4qyDPvcil7HWItkjmh2yB/I0+eSfV144sWoo2nZ63
         17l3kCWuWUZLDdYOPOOcoPQE1xfU3pmTYufQPZQdCs11Ka1fgQAQu1JzuvkE/jN1B5sJ
         HLa85RkAESAKKgU789n6MdxIvbZoz31hPK0XnSQGNP6S+4kZGG9e4rQ9dvMhEAvbQ6Kj
         jTZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8VKifSbo5V/hJVx00oirItETWkNUhM0BXOUtDUG7TQg=;
        b=VcgZ03eocEA34m69pPbxVkUZiZz71GMslQ67fS12HmscoIDe4rWi1ab4FJDwusDO+Q
         m9Orw6x33CcyI85mHONv0bM71rz4Tly0TPGdndK6lp+yS6DNwNv4udqZKDLnvQ4+rMAH
         w9fS5rQijkbdyTIlArmrIWPwwR+ua4+8E4P7b4BC1TyAQ80g9ryHKZWITcCIkU0u8vxP
         ezvrJWFs8Scb5JOAbrxQmbHZSE4A5wgmSH+M4UxrQIhsAHlRw6Va6Yl0BBEqyLvI737C
         t/M+5T75Vr+cn/JKforT5VCjFDTkw7TTv2ws8KDIsQp2wwF9+Jvc2TgeGkXlDjAaG6Vd
         +8WQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	rga@amazon.de,
	Dave Hansen <dave.hansen@intel.com>,
	Asit Mallick <asit.k.mallick@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Jason Baron <jbaron@akamai.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.4 167/193] KVM: VMX: Make indirect call speculation safe
Date: Fri, 23 Feb 2018 19:26:40 +0100
Message-Id: <20180223170352.192414345@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218151996189200?=
X-GMAIL-MSGID: =?utf-8?q?1593218151996189200?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

(cherry picked from commit c940a3fb1e2e9b7d03228ab28f375fb5a47ff699)

Replace indirect call with CALL_NOSPEC.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Jun Nakajima <jun.nakajima@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rga@amazon.de
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Link: https://lkml.kernel.org/r/20180125095843.645776917@infradead.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[backport to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8377,13 +8377,13 @@ static void vmx_handle_external_intr(str
 			"pushf\n\t"
 			"orl $0x200, (%%" _ASM_SP ")\n\t"
 			__ASM_SIZE(push) " $%c[cs]\n\t"
-			"call *%[entry]\n\t"
+			CALL_NOSPEC
 			:
 #ifdef CONFIG_X86_64
 			[sp]"=&r"(tmp)
 #endif
 			:
-			[entry]"r"(entry),
+			THUNK_TARGET(entry),
 			[ss]"i"(__KERNEL_DS),
 			[cs]"i"(__KERNEL_CS)
 			);
