Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517957580; cv=none;
        d=google.com; s=arc-20160816;
        b=tL3U2G0/LiDZCznynCIpLhbllO8uLk1SBplaDCIGWf7IOoMuEGJmohwBgJiUnC3p5A
         Uywj8ZqGcyBPB9oAIFSUHARkoQrutr9zsc3TIJdSSe19T1UoHIsJGj3Dbo3rxmEYIPFk
         31p2EVdxOLjSEjMP8gWogCCYRHApRZqygN/8eC1ZR6EiCsrEQOHNAcTXM0/OtKNpC92T
         neZ57p9YjHE43KDSDyu3oAtmpy5qD6jgWFp9ZhEVGUqIYv+iyeeMwjwhB+4LJ20kG5H3
         dMl9yWGT6PpVDyoHU68Z01GK1LLp73R5h2NTraiLHrP+W7Dj7ZwX/K4CiNLwzlSybeq7
         ZJzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=QX0zFOQWpFQFm1SRbqnkZJxgmLvrgXII3QK9k9gcHrg=;
        b=HjpBMHEC9Mq11v746C1uHg2lzWdy7+0OIcJSxv7BgMUQkPGEhe+dBX2cLLSsX5qu59
         VCnhVc7ySFEgUEBLocgh/3I1M0Cc7CFRrFPJcdOhspq1AtwF6Pb56IQi+W94xZCcVMye
         E97afqPc54jbBo9hmIUxv5SW4qzCu8Ktv+q9BlOyJjJlCXgQ6yg268+HVk3c8yzUf6ZF
         JWGAIBAeMlCqqi9YWbrBEq4uVfdEYAarcCmjpzHaf3T6GUx7HgtZ8fjl8Nwl+Bb6vXmS
         RMMfcTsis4QquCe9EbmjBPLiT2YicxmgVI4EXxThttNlMXl2aPuhW/16udY1RZGfv0mp
         +xxw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fxL0gtKM;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fxL0gtKM;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x226lXXAyYTfxfWfG9c2tEPJcd0CixC5RgX4QfO7SYjoOUmLOq+oi/6DqTpkl00eNazrXaR/Xgi8fSO4/yi+lmtU=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAPcyv4hELJQMEBQ_gi+_bh4D=7h47ypzK++XTdQjhDGnOs2uRg@mail.gmail.com>
References: <151632009605.21271.11304291057104672116.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151632014097.21271.16980532033566583357.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206192925.qkmghwsbaysr4iv2@hermes.olymp> <CAPcyv4ihN6fy5-vBtfA0PuwXvCAj8-rMhtQmevh5sdYxbH3Yfw@mail.gmail.com>
 <CA+55aFxYHX3=HN4P5M0ziSJ08WfjccyhE2T7epS-EC6ZJ6LyjQ@mail.gmail.com>
 <CAPcyv4i5oORdk-Fzypxw_+gCLUa8f=w1e_n0=47P7uHR-jT6GQ@mail.gmail.com>
 <CA+55aFzZVL=WVuhJAQDazj59jwnmhUrRRwNgzXS+c-q5yva0iw@mail.gmail.com>
 <CALCETrXV3rHb7Z8iaoieAJ5hRY0+UT7eTknxe4-FiOoke9XoGg@mail.gmail.com>
 <CA+55aFy2-OMMCatHTXL7wfP7H=4CEKv4Y_pRvfeEOCwxriDP4Q@mail.gmail.com> <CAPcyv4hELJQMEBQ_gi+_bh4D=7h47ypzK++XTdQjhDGnOs2uRg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Feb 2018 14:52:59 -0800
X-Google-Sender-Auth: IsKuuxJzSRaTOIUlbpHqUiZEfoo
Message-ID: <CA+55aFxU_vo+JFBZcvE5EOs2D_QHNXBf4G=-KT=3LeP2zjECHw@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] x86: narrow out of bounds syscalls to sys_read
 under speculation
To: Dan Williams <dan.j.williams@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Luis Henriques <lhenriques@suse.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, Greg KH <gregkh@linuxfoundation.org>,
	X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
	Alan Cox <alan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589977480308913684?=
X-GMAIL-MSGID: =?utf-8?q?1591693888032927029?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 1:37 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>
> At that point we're basically just back to the array_ptr() version
> that returned a sanitized pointer to an array element.

.. that one does an extra unnecessary 'andq' instead of the duplicated
cmp.  But at least it avoids comparing that 32-bit integer twice, so
it's probably slightly smaller.

(And your code generation is without the "r" -> "ir" fix for the size argument)

Probably doesn't matter. But a "asm goto" would give you at least
potentially optimal code.

            Linus
