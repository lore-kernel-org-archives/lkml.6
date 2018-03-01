Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELthHU1UEEiuf+ZPlJQq+twmzNz46BQFphU95d8IGC19sJw76BZB3JwaxzHoBzW6nyW8Xi2r
ARC-Seal: i=1; a=rsa-sha256; t=1519905810; cv=none;
        d=google.com; s=arc-20160816;
        b=FdEVnlrpzi4Q4cqdJeysYRXDWBw0C3cSG8+aJVqnLg00slRne+oJ8PnmE2y5vi26KP
         1UE0OAr6+VmUiK40gzpgAqM8uT5yoWfW/Kqq7ILP3BOQGVHd0Z+aN9k4c/VzPSr9lj8k
         MrgxS6+P1ECP1o9ruNF6Icqg6pChY2PClxfgtco1Uiiu0lQ9n1/rpWCcy9ey/XFF8aLO
         n7E2oqEzYRGgee70BP1n7uM31Uf/BBI03Q/sSxuNJ8RYQ6EBUE6zOXfwTeRXgXi0/3Da
         KJWb6qrafLcgnP7oUPO5JNTt/vjBFjHq1j5Cdj791L88A/NgFUmfpPCZY+JSyg9O4tPf
         0OqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=2nhz6guC/zvzqvTI90jFxnHZfx6V27TYaQyfyu7o/oA=;
        b=nAVz/pfRhBJwtLB5wXMt2HYvC3aOLoMA9NUGTTHo+hsslaMw9iQQVSeK3PRwEoDJ0V
         JVMnOI/XeXj7Wok4u68MiLTmrFIwNG3kBUQ96vu+H/cB89uZRW5dEAvjPhembaEpUL/U
         EkV7Y+4nyTJK4zCHuGEd4NmhGZBs0/pmxnT/JUIBrfeGvcecq0uZSoq4i6A1bY8vnZKn
         LHtO9C0L8YGRKxlzQ1tBbeWCbWRhdKoiK8CkhvAC6iGTu49jKBaOs1kaRbs8itfnGxiK
         56BDETaksBZ0+d/yRzE/rS7/OtzMJHT/C2UHtyqMizzolK9aO60BQpU5cC3jVkBYGROl
         dBSw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=pgeQ3yWL;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=pgeQ3yWL;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Date: Thu, 1 Mar 2018 13:03:26 +0100
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
Message-ID: <20180301120326.GN16484@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-13-git-send-email-joro@8bytes.org>
 <afd5bae9-f53e-a225-58f1-4ba2422044e3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afd5bae9-f53e-a225-58f1-4ba2422044e3@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914904588119761?=
X-GMAIL-MSGID: =?utf-8?q?1593736754174060753?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 02:18:36PM -0500, Waiman Long wrote:
> On 02/09/2018 04:25 AM, Joerg Roedel wrote:
> >  	SAVE_ALL
> >  	ENCODE_FRAME_POINTER
> > +
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

This is not different from before, no? The debug handler already can be
entered on entry stack before this patch-set.


	Joerg
