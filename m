Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELtDubWZcCKsiBCuR3aHUN/qN0CSN1/55/gvIE58mKz0JKmseYAxCac4WURKd49CwL9iDv9t
ARC-Seal: i=1; a=rsa-sha256; t=1520339222; cv=none;
        d=google.com; s=arc-20160816;
        b=t3dajoZsMgfyFNVjHMhaWkHAzNB6aQ7AMyR1SyWGYQCNqtefayGFlK8EuE8fp2OrKc
         Sv0i2YzC2y08ErDri/JgmAXWsd1rWFLSUXb0tTD6rqo5C1mKwrSMc/s1JK8DyoAaJAcg
         LtJg+5k+ed4jP4gn7Q0CMesXATqFsCnqoRDIHzv7oIacNpIjAzg/5kXxA4aT7hgzI570
         mwyCJhlVtu1cOjK+y2FYkmU8sbiS2WFzhBOckCUdGYdGOsmDw8Mov+w4/uDNMKdp1oUh
         T30F41nRL8+H+XOG114YsSkeKUUbg+VEiMJNJFErDgMoJM/oafNKLQwUYKuHkQNlZ/qh
         rlzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=gAUgk5GTvx/QzLj6PGcqNbDBun/2G/+8uRjTGFPiius=;
        b=vJVQNvRt1YgjWynjsq3hfeTdAOClolTAnr4fMTsCAawxOwNAiFWPy4WTLbw0n9gei8
         /b2wzng1JS8eYZ8nLllodvHg1jeEMidTHZBds1MK9vFDV2+3zEdXVK6rReTjbrP6L9/1
         R1HSG8hcA22lV199Ha5VkFMBxF5kiUi/6eFiZn3WigQkJ22Xu2DSPFk4S+cQofeDiWsX
         EztUbER40tBvpg/4g+Sj56wT0gBc14r5XOlQFojCyn+qvtMucWUN/RKmqOc/3p+phFkH
         j2onIyS744Aa9xoiMRiqT0H19Tg1YOMqmNghVnKivdz9VOQJzeO4wHs7dN39SVP2bgWZ
         7FYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=Tqaq9a4d;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=Tqaq9a4d;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Date: Tue, 6 Mar 2018 13:27:01 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 11/34] x86/entry/32: Handle Entry from Kernel-Mode on
 Entry-Stack
Message-ID: <20180306122701.GX16484@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
 <1520245563-8444-12-git-send-email-joro@8bytes.org>
 <CAMzpN2h3xkhw_A4VeeA47=oykKgxXeumHM-q0QpaA8+fwFVRjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2h3xkhw_A4VeeA47=oykKgxXeumHM-q0QpaA8+fwFVRjw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093022557312692?=
X-GMAIL-MSGID: =?utf-8?q?1594191220384640864?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Brian,

On Mon, Mar 05, 2018 at 11:41:01AM -0500, Brian Gerst wrote:
> We can keep the same process as the existing debug/NMI handlers -
> leave the current exception pt_regs on the entry stack and just switch
> to the task stack for the call to the handler.  Then switch back to
> the entry stack and continue.  No copying needed.

I looked into this and things are a bit more complicated than in the NMI
and debug handlers. The current code after pt_regs is set up relies on
%esp pointing to the pt_regs structure. But if pt_regs could be on
another stack we need to carry the pt_regs pointer in another register
through the whole ret_from_exception code-path until we actually switch
back the stack.

Since the code-path is used for all stack/cr3 entry/exit cases we need
to setup the extra pt_regs pointer unconditionally and update all places
that reference it through %esp.

It can certainly be done but it looks like another major surgery in the
entry code to optimize a slow-path for handling unlikely segment-loading
exceptions and debug traps. I am not sure if it's worth it.

Regards,

	Joerg
