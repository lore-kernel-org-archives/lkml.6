Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2245gylWDspaUFaLkiHME4eC5DLE+zbaykbm81thaxo2TofbfsY+faLVn0XnVnTtkwS0NWmv
ARC-Seal: i=1; a=rsa-sha256; t=1519218071; cv=none;
        d=google.com; s=arc-20160816;
        b=PjI3dN2CW1rdQcdm66I7qHB0odkjn8NtYxXS0dFmpJOWkOAUWIaK7di/an46yAsL4V
         uqdHF4ZLDz0pZCAYbNIrchxy+wLJcAAI6ADaPRr4wwXfZQkQsVX5AQWCGLHq3F1AfJh6
         rLwAEFgdWKofB/+wVj/kZJ/TMXvD7kngAQ1kzneKtDrRtQBuA1aOw5BV8nnHWZDx4rUz
         aS0yk1zZlQFlMDS8U0zBFWOStEyNPonlcGR4ie/0P51CkNo882+dP3yvTozeQCvwleww
         WQWKc3nVpi7B1JHCL+HEHQsFWjB3vaJgS0cEFDFSRid9kBNvr0Rm0oWbhZhHCXw+chj+
         A51A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/Q9sb6EKFF+NYVgdYyI7gOKKiHJrl57dVf/0kzc4Ubs=;
        b=RCgBEB5j9qk4ItmUz1W+FGcYH8YEfQjFluVAH/mSx31w5CPTtP6x2jBO9AQU8azk0H
         3tKAAv/8rlUyOvMHbxUhtELdqPdfvjL13VKWXBwzrYCA8tGnfKRXUo5lcJMus008mqBm
         2G4neBzPiB6i3VtcUaSaXV6QR7vw7VGtegzkVyRmZaY/+NRV8qiexNIWefbV6xKFz6es
         HxemU6UPOrxBqV5n0cadQoH5q5d+aXG3K98iEVdMfNxnOr4Stzb185pOqbegNJ7MYWe1
         NghCuGo+7W/OgBZN1GUR12L9XYAUpOM46gpR91xk1llkHIa1pOCtwodRKPJQroskx5ho
         10zA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Baoquan He <bhe@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Borislav Petkov <bp@suse.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-mm@kvack.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 037/167] x86/kexec: Make kexec (mostly) work in 5-level paging mode
Date: Wed, 21 Feb 2018 13:47:28 +0100
Message-Id: <20180221124526.630792321@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015609031159594?=
X-GMAIL-MSGID: =?utf-8?q?1593015609031159594?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

commit 5bf30316991d5bcda046343ee77d823cf16fdd03 upstream.

Currently kexec() will crash when switching into a 5-level paging
enabled kernel.

I missed that we need to change relocate_kernel() to set CR4.LA57
flag if the kernel has 5-level paging enabled.

I avoided using #ifdef CONFIG_X86_5LEVEL here and inferred if we need to
enable 5-level paging from previous CR4 value. This way the code is
ready for boot-time switching between paging modes.

With this patch applied, in addition to kexec 4-to-4 which always worked,
we can kexec 4-to-5 and 5-to-5 - while 5-to-4 will need more work.

Reported-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Tested-by: Baoquan He <bhe@redhat.com>
Cc: <stable@vger.kernel.org> # v4.14+
Cc: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Fixes: 77ef56e4f0fb ("x86: Enable 5-level paging support via CONFIG_X86_5LEVEL=y")
Link: http://lkml.kernel.org/r/20180129110845.26633-1-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/relocate_kernel_64.S |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -68,6 +68,9 @@ relocate_kernel:
 	movq	%cr4, %rax
 	movq	%rax, CR4(%r11)
 
+	/* Save CR4. Required to enable the right paging mode later. */
+	movq	%rax, %r13
+
 	/* zero out flags, and disable interrupts */
 	pushq $0
 	popfq
@@ -126,8 +129,13 @@ identity_mapped:
 	/*
 	 * Set cr4 to a known state:
 	 *  - physical address extension enabled
+	 *  - 5-level paging, if it was enabled before
 	 */
 	movl	$X86_CR4_PAE, %eax
+	testq	$X86_CR4_LA57, %r13
+	jz	1f
+	orl	$X86_CR4_LA57, %eax
+1:
 	movq	%rax, %cr4
 
 	jmp 1f
