Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523895203; cv=none;
        d=google.com; s=arc-20160816;
        b=De4RhXuAemOJjdXBn40kRhs+0l4XtWG6vni1JsfP1tVFYRhxISMe7C/v2bO7mSF4yc
         ZhXyocv+a/mdc3yzu7FzEZtTqR/VrFoRca9ENnmEAT2Qnsv53euEuGSgP8EcEDajTFRz
         BCNMoe81gMy9+XsDiFqX1/zQ22ucBSCADlgskDqX4vpk6iaNIdGjodSBlouRC9REXNwq
         AcFQi8C7/65Sje4Lj5zlwmNAXn3WwfZzArHyIU1aOYNGPaRuqaSDez4eesngyIkfOi8/
         q2ZoYBhB+L9X2N4NoB5ZE6lo7CvQuQhXkGjcPl735QM6wuHIstXolvK/0wE7GNCjuY5d
         PPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=G0VsOfz9ukenE7UojhF1BaXBzapb1wzYLdjxxmr5F1s=;
        b=osnqckykxbeLJLSZ/RJPJAvKkQzW3FXH87OYZEY8/yAARrK9OS1NpMUm7BGB5kbDzD
         0aY/2t1asvnQMurwKI7X7Jwoxvn26l7q6n/1kFzT/4nx0GFkzdOjMB5EDE7hZVxrEW7l
         Nvqrtnh1oPO8+KLf3+M3tV2hg9UynekJBTmwanfs2WYpUyWIG7IF2QDCTHng9PT0azPQ
         hvdb8tQASVc9RggMI0maeCgwz6jBMMc4TNVDQZ/V4nmRvJL4qHIZxN2ufgSxiSNOcSyh
         Y/VvcIya1Xhn4Q6p4ARj0qkTBq5EfuIZpl1eaC7fyS3iz8xdmvuS4DHE1Mxhs+GIu21s
         Rslg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jb+f0ovH;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=e0gnmvox;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jb+f0ovH;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=e0gnmvox;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AIpwx4/5O16noms2ZNQODdozufjb9TLENBVJLYQ8Jj/VwnksMMEAwngZD8cFGYlrX47hugutR+kkidgDqGBlDl+m9ow=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180416160154.GE15462@8bytes.org>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
 <CA+55aFwGTOgSonVquab63PZG5z_NfgVF2A08iHaNeeqY5pdfnA@mail.gmail.com> <20180416160154.GE15462@8bytes.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Apr 2018 09:13:22 -0700
X-Google-Sender-Auth: NdGpPiXuCOORQRAYGhyAonDCS8M
Message-ID: <CA+55aFzrYbTMXyZBVqRV875HwQJNxD+822RGeeDb7BLDLU8aWA@mail.gmail.com>
Subject: Re: [PATCH 00/35 v5] PTI support for x32
To: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, "the arch/x86 maintainers" <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
	Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>, Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>, "Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>,
	Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>, Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916931664810234?=
X-GMAIL-MSGID: =?utf-8?q?1597919937035459817?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 9:01 AM, Joerg Roedel <joro@8bytes.org> wrote:
>
> Okay, I verify if there are any global bits left in the page-tables.
> According to the PTDUMP_X86 the cpu_entry_area is mapped with G=1 (which
> should be fine?) and another 4M range in the kernel mapping. I need to
> check what that is.

All the kernel entry code that is both in the user mapping and the
kernel mapping should be marked G.

We had missed a lot of it (and the impact is very small with PCID),
but if you rebased on top of 4.17-rc1 you should have it fixed at
least on 64-bit.

See for example commit 8c06c7740d19 ("x86/pti: Leave kernel text
global for !PCID") and in particular the performance numbers (that's
an Atom microserver, but it was chosen due to lack of PCID).

                  Linus
