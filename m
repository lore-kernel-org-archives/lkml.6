Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224rXzMTjr21oJlPe38HurcA++hioPeL9v2NAfHW0b6gYg0q4GFde2pMz86SAfTrr5Rf7/Ke
ARC-Seal: i=1; a=rsa-sha256; t=1517855042; cv=none;
        d=google.com; s=arc-20160816;
        b=lgRg/6l6ivExLaAZ8K1LWhG821dBaxkTM50V2o3igWw+bPkdr4MhSbB/deHKN/rtc+
         I7RuAGFx2TAeKlufjqbQC/7YciWKGlLVwAj5eeC9WIKuj29ceNFdOtuCjqwjt6Y8gEx4
         Z6RZRqFZ3oE0F7LE9+6QDkSFKaZjmeN+lkN4JP4Op114Feauxrr6jrgyYIIPjScbEEHr
         rcRKL7KOZ4z9XeYPNM5tvDfDPH4nUSM034JiWa9BV/ZBzKHO9OY84eIgJcLPmNJnJKbj
         uUBHXRW0CGg7vXklx7vmscsCqGexL9rasjdofs0tfQc5Vf8XHI3H1hnEnLxMWN3WPDkK
         Is+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=of0FQ1lexdSFh/STXrA6+djCaMJDhpxdA/kTh32LK2Y=;
        b=msv2S2xzwvJitCGlq0jE2HFsBQtbWi1Yoh7/P9OwQygxiTSvzod8Irgkt5DxCAYQYs
         vgoW4mmuykc2QgLKzDQ5+VUy5b7JjdQy0Y7nT9qKOH5XOfbAt7tTfURYesioil+PvvS2
         3Y+p0hwjq3AESQxMF0AYey/CWxXcx+BDqdpKn5dg8wx5k8qnqpnTZEzhB9kFadufPDio
         +kzcx5NJQCkrFKAAv/PMOyD5yOLD2VrZvXgguN8Gytk/aFqXj8IStk3zS6g9MMiEFwA8
         P8f4AvtT9EqyLq9tSlQnfr1fWJ3F+3IpcmUTnK8ijL+knuNMZdvV0xpWQkjECsoVlPaV
         ahxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
	Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH 4.14 06/64] KVM: VMX: Make indirect call speculation safe
Date: Mon,  5 Feb 2018 10:22:25 -0800
Message-Id: <20180205182138.829766515@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586369408444524?=
X-GMAIL-MSGID: =?utf-8?q?1591586369408444524?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra peterz@infradead.org

commit c940a3fb1e2e9b7d03228ab28f375fb5a47ff699

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9118,14 +9118,14 @@ static void vmx_handle_external_intr(str
 #endif
 			"pushf\n\t"
 			__ASM_SIZE(push) " $%c[cs]\n\t"
-			"call *%[entry]\n\t"
+			CALL_NOSPEC
 			:
 #ifdef CONFIG_X86_64
 			[sp]"=&r"(tmp),
 #endif
 			ASM_CALL_CONSTRAINT
 			:
-			[entry]"r"(entry),
+			THUNK_TARGET(entry),
 			[ss]"i"(__KERNEL_DS),
 			[cs]"i"(__KERNEL_CS)
 			);
