Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227i9IpNGPzExkUc2E1oQMM9sP4V2Q1RuIwN2Avm0v3hCXXuyM3YHxvHgpZ/+K56wB18yvnr
ARC-Seal: i=1; a=rsa-sha256; t=1519411268; cv=none;
        d=google.com; s=arc-20160816;
        b=LFKr4OJ+d3Nn3/eHuAU6JTyPqV9jkHKW2gdkh1qg9eoCvT0xCiUSFBP88dI4yEBk1D
         QEhN5ysBu8LdAv//WlDkeoAHB+Aof66fUpTFIzVyE2j4IXBayTpsYhkoymSWNPvVDSOk
         ATHGwlQHj81Lh53Mhw55nUL3yq5+6yJ/1rQkUVcS8tcXcQPzT5zOrbr3doQAO5DoYLXD
         3Cq7Jh/+bIEAMSzOeZN1B/zNWzDveqYdmV/yt6fRHRgN9MMTtPpsZC0Rhv7NaQslBrZS
         2LjIQEUq6sAIz5pE+DBy4Mqn4aJBTk4bJTRU5UqIqQ6zFrDsW7eORZlHhhWKjyVghyIj
         uubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SwJ9WJ7ES/L+799LkA7qFuOZDpkME8PcL8MwBLOOTjg=;
        b=OXu8KW6zXadNl48P6O8dlx5A0I14vv5aBnZhb92rBvjIY7bWgmeCQ9C48WAz4GYmFG
         vS4WBxorI9DU2Nla+I496RUF+DS0FEMQ8GtgRepRU92plkEFjELVu2Psbqnbt9dGqejn
         zcd5veSc9O5o55f+UgwsR2+dj+7vZ7KQV3lVzdf308ncHt+GFV1sbSyWO98LEC3s116g
         3K7AD/o68TjVk/v4PdZIT0C40Fdhp7RyMITKdZ++D0j9gpfIqYCj53AD08SkuOOb7rsv
         HBbkCU4r6/P5c1N5yd+K7HTBDoqTlIlOroyjHnWlkMD7cy01b4eq4tQ0eL32hwt/zdpo
         ODBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arch@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Andy Lutomirski <luto@kernel.org>,
	alan@linux.intel.com,
	David Woodhouse <dwmw@amazon.co.uk>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.4 178/193] x86/syscall: Sanitize syscall table de-references under speculation
Date: Fri, 23 Feb 2018 19:26:51 +0100
Message-Id: <20180223170354.028619665@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218189881514500?=
X-GMAIL-MSGID: =?utf-8?q?1593218189881514500?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

(cherry picked from commit 2fbd7af5af8665d18bcefae3e9700be07e22b681)

The syscall table base is a user controlled function pointer in kernel
space. Use array_index_nospec() to prevent any out of bounds speculation.

While retpoline prevents speculating into a userspace directed target it
does not stop the pointer de-reference, the concern is leaking memory
relative to the syscall table base, by observing instruction cache
behavior.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727417984.33451.1216731042505722161.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[jwang: port to 4.4, no syscall_64]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/entry/common.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -20,6 +20,7 @@
 #include <linux/export.h>
 #include <linux/context_tracking.h>
 #include <linux/user-return-notifier.h>
+#include <linux/nospec.h>
 #include <linux/uprobes.h>
 
 #include <asm/desc.h>
@@ -381,6 +382,7 @@ __always_inline void do_syscall_32_irqs_
 	}
 
 	if (likely(nr < IA32_NR_syscalls)) {
+		nr = array_index_nospec(nr, IA32_NR_syscalls);
 		/*
 		 * It's possible that a 32-bit syscall implementation
 		 * takes a 64-bit parameter but nonetheless assumes that
