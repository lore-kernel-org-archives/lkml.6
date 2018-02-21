Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226sGsnebCRseyuvSw/RSQKTuRzNCuyx5rcBWDA0ktIkDKQz3ZPWK96ojxfmxvg+oGXcFxEc
ARC-Seal: i=1; a=rsa-sha256; t=1519218427; cv=none;
        d=google.com; s=arc-20160816;
        b=EN6BZNIIMWByQNsg4QGxrYvkVBMOJH7y76LfwsxMmXoi0SvK+kiDOjjcMOvVZUcBxI
         OzpwWE+satdtfQol9QxFFnuqrBanpELKs1jDGC3Ru4WpZZX+0QeMYk9ECwD9LLY7N/EJ
         Dy9G28FABfydG0wUAkpLiuBQB3bpX4JB9540TXt7THflVqkhNSU5au0ChRCyFg2aBjj/
         A1qe0EHzpP2cIzxPTovxbmp/qgv9k8CdkuklInp1gwj6famKiiNM/AzxeoRxmt9vDNxs
         Rla+DzoHmQ22Y5uKYBGUT7CPcmrlovQ2fWS86NOeo+w7jtitUfmNgx/QEiMlNYS/zXwl
         T5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=g9aoSn4q71gUjfiBVkAz6f6dHq8U3M1+CcTpkPm7EK8=;
        b=KHmkBbAojEocGhN1YPxVGoVUdtlWPkYO5Ei9lU2L3o14aC/H7GwlWdw7viin0WJchq
         uAkJKctU9XA6iuJuXI0mgLgTvTtyqT+ICfMS5lND6QGeKjRAplxCwQ9jtpZQx7gzK2/Z
         0r6Sc2o2naVsFtOgpPTbJ4yY1m6eFhK1nxI0s5DTmMVlBYuTg1alpR63pJGjI/bNx+A2
         nGcynkVqOefW8zPcqjQ/lOPd7sh2Gz37El/Quzk9gl+sizQ2ZZT/huuGK9VXRkmgIbtA
         fNWCrVVZNfAvAN9z6Gke7FF6s1/Ak4TGK8fg4I4JidoB1UHHpmlzjXPE4utEdAeWUVvB
         4W3w==
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
Subject: [PATCH 4.15 036/163] x86/kexec: Make kexec (mostly) work in 5-level paging mode
Date: Wed, 21 Feb 2018 13:47:45 +0100
Message-Id: <20180221124532.287826013@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015609031159594?=
X-GMAIL-MSGID: =?utf-8?q?1593015982068241726?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
