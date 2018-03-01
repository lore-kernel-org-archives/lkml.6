Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELs5E/ZL78Rwujlafoa60jR2elY42itEZRHqlexjzAKyNMBJHDaudRwE6urTUjPvdAwVRQUo
ARC-Seal: i=1; a=rsa-sha256; t=1519911272; cv=none;
        d=google.com; s=arc-20160816;
        b=nZgWyS5LBprWZmwjT/E/MzBUIfYGgGl+rHlE8t3Vv8ciZ5ons7ZMRIt2cp91vgO7NH
         UxAWcbMN9SAHgiPJ11RIx7/iKhmUV3EMwwjEz3qfybPB1bHmC4aH5PURo+i/Yltjm9oZ
         xv+DqKEBnh5YfmG9sTIx7t1rCZ6h3lfrjrkbbb/OOyGknyes7r/mJjsOf5o/1lrYpitY
         /Ho+QRAcY8lYR9/Ikm40cqWwR8DQ4YUL/pb/rf5GvgVQ4Bw98TF1b5J/4hRMPbhZ1Rjh
         qFgW59jAIO2LyTCsT9L7EjTYe1eyhWxslN0JkGix+IYaUExeKV74iYce/gTlawUHRE41
         gWOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=stK49IlzBzUMPbXGTk/uzcvakqauHAqYNGs4XBZ10cY=;
        b=k40hG31A+jT051LNxeWBQCfBxd6Xyp1S5TwsCIqfukWxuJ4wPbQGidVGPoH1iHUUXK
         FPVU/sfHhirRtUNmmNaxebCLib3VZcsu+40bMMI3EgwgzIe5NDIP5RMyWgpX2mTdd7Uy
         CPXAakssPRITaA07YOD8ODOj4+0RZUxKoipGokz/omsE/RaOUuOv/uZ/d78LZexqNERs
         ffNxt7czwMROJSrEC0NrFh3o5ravr3kVcaFBGwpOHPRzxqMzKyzDAvdnS2NRAwUQJkrZ
         y4x0eLnMpOrWQjWQT+mb5fN3T9nDnU64EocmKuQEiTpL2CRDUudbqdgee6OV1IgxwYNk
         mf1g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=F/pISCPD;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=F/pISCPD;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Date: Thu, 1 Mar 2018 14:34:30 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Waiman Long <longman@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
	daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	jroedel@suse.de
Subject: Re: [PATCH 12/31] x86/entry/32: Add PTI cr3 switch to non-NMI
 entry/exit points
Message-ID: <20180301133430.wda4qesqhxnww7d6@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-13-git-send-email-joro@8bytes.org>
 <afd5bae9-f53e-a225-58f1-4ba2422044e3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afd5bae9-f53e-a225-58f1-4ba2422044e3@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914904588119761?=
X-GMAIL-MSGID: =?utf-8?q?1593742482150600868?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 02:18:36PM -0500, Waiman Long wrote:
> > +	/* Make sure we are running on kernel cr3 */
> > +	SWITCH_TO_KERNEL_CR3 scratch_reg=%eax
> > +
> >  	xorl	%edx, %edx			# error code 0
> >  	movl	%esp, %eax			# pt_regs pointer
> >  
> 
> The debug exception calls ret_from_exception on exit. If coming from
> userspace, the C function prepare_exit_to_usermode() will be called.
> With the PTI-32 code, it means that function will be called with the
> entry stack instead of the task stack. This can be problematic as macro
> like current won't work anymore.

Okay, I had another look at the debug handler. As I said before, it
already handles the from-entry-stack case, but with these patches it
gets more likely that we actually hit that path.

Also, with the special handling for from-kernel-with-entry-stack
situations we can simplify the debug handler and make it more robust
with the diff below. Thoughts?

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 8c149f5..844aff1 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1318,33 +1318,14 @@ ENTRY(debug)
 	ASM_CLAC
 	pushl	$-1				# mark this as an int
 
-	SAVE_ALL
+	SAVE_ALL switch_stacks=1
 	ENCODE_FRAME_POINTER
 
-	/* Make sure we are running on kernel cr3 */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%eax
-
 	xorl	%edx, %edx			# error code 0
 	movl	%esp, %eax			# pt_regs pointer
 
-	/* Are we currently on the SYSENTER stack? */
-	movl	PER_CPU_VAR(cpu_entry_area), %ecx
-	addl	$CPU_ENTRY_AREA_entry_stack + SIZEOF_entry_stack, %ecx
-	subl	%eax, %ecx	/* ecx = (end of entry_stack) - esp */
-	cmpl	$SIZEOF_entry_stack, %ecx
-	jb	.Ldebug_from_sysenter_stack
-
-	TRACE_IRQS_OFF
-	call	do_debug
-	jmp	ret_from_exception
-
-.Ldebug_from_sysenter_stack:
-	/* We're on the SYSENTER stack.  Switch off. */
-	movl	%esp, %ebx
-	movl	PER_CPU_VAR(cpu_current_top_of_stack), %esp
 	TRACE_IRQS_OFF
 	call	do_debug
-	movl	%ebx, %esp
 	jmp	ret_from_exception
 END(debug)
 
