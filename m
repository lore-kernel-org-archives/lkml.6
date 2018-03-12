Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELt8ALb6+SRcP6ynoijU2LQ+WtBGAeDK1K6FWtkzPyokiVkM6YdQKgvNjgdipCekZypjlTyU
ARC-Seal: i=1; a=rsa-sha256; t=1520824072; cv=none;
        d=google.com; s=arc-20160816;
        b=hbukYfaS/mI5prMABRhCukpD0G26xn/V7gysZnhB/WeHoKjKOKlgdgNMo0zoH732o/
         RYdbOJfR47HRHCWGd1Tbk/6yasuDIWI+8ZW412uQz+ArqynGiv3lhEIE6ap2+VjyqRia
         7FEmTDXbSqfdWVQxBSlHoq5arBMbo8QXjMP/ZM8VFzx3JQFlmwoYVtUOxO4MGhOTbmGh
         KgDItgzy4KY9+wuQAMVPITjmJTFRYiemvDfqkx8xjTICTnkKcUQVRVMLuXKo1mjhAwpO
         Ls2S4k3IKe3XsXrBfxrppoH7F1Qq5ZZZEYyAzzbUlLZfERUzVtWlPls7iiTkc+NNnIGW
         bj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=k3dfATwK0Tyr0cWMeJQnE0XEjeSki4O6eEAdxvaiMtA=;
        b=QDc1wyK3sJSozzycoV7vMwLku2+kLlUwJFRHkaFathVo20Hn+UoHo950372e4jzSzF
         EwuFhRjRu+UHVXrlibvchOirnEnv44Z9kxgFvBOnDNem+5Zmp+vNJZiFWzCB+WxleafI
         3R6/azPIyUzzuCM0cPn/YZ9EzmZKYBc3q89pXd7th7fpp/klFFt4C71WeLcM6AfJrPvA
         JGcoITVzOMBR2mtQ849aeF326LMBwnb8IawUKbuy/cMoNwRD/ddG7xzYKk2uMP1eWMiz
         Wy8EhxwAwxWLnvd4XgYDhAD59EUbp92DFvDHyS5Amj3c1aIpDrBOcMESc5TgOzI/KDAJ
         Xa0w==
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
 "David Woodhouse" <dwmw2@infradead.org>,
 "Andrea Arcangeli" <aarcange@redhat.com>,
 "Greg KH" <gregkh@linuxfoundation.org>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Jun Nakajima" <jun.nakajima@intel.com>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Arjan Van De Ven" <arjan.van.de.ven@intel.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Ashok Raj" <ashok.raj@intel.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Jason Baron" <jbaron@akamai.com>,
 rga@amazon.de,
 "Asit Mallick" <asit.k.mallick@intel.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Dave Hansen" <dave.hansen@intel.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.370097886@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 45/76] KVM: VMX: Make indirect call speculation safe
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699622716884504?=
X-GMAIL-MSGID: =?utf-8?q?1594699622716884504?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit c940a3fb1e2e9b7d03228ab28f375fb5a47ff699 upstream.

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
[bwh: Backported to 3.16: also add ASM_CALL_CONSTRAINT]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -7248,13 +7248,14 @@ static void vmx_handle_external_intr(str
 			"pushf\n\t"
 			"orl $0x200, (%%" _ASM_SP ")\n\t"
 			__ASM_SIZE(push) " $%c[cs]\n\t"
-			"call *%[entry]\n\t"
+			CALL_NOSPEC
 			:
 #ifdef CONFIG_X86_64
-			[sp]"=&r"(tmp)
+			[sp]"=&r"(tmp),
 #endif
+			ASM_CALL_CONSTRAINT
 			:
-			[entry]"r"(entry),
+			THUNK_TARGET(entry),
 			[ss]"i"(__KERNEL_DS),
 			[cs]"i"(__KERNEL_CS)
 			);
