Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517948793; cv=none;
        d=google.com; s=arc-20160816;
        b=mUJbBBZlXvK3pPdMPB8oPi+ivO4HR3uSTVefOS1Jnxp1kznmfynTZnxDlTvaXltfxI
         Y4l8qLNsRIYPDJ1hB5og7vEB6y7Z6AyBz4m/8N+DnQ0/6L+aZ54am30bonxVJK9Z80Kr
         1rxp1SCnxMjMWLdxas+tzBEr7GoLqS680yqP69wv+8DGzXQpcxzIpBQrEW20oTvjDCx3
         pBkeVGoGIJ4IJYZLLsgB1gxWaaJCv+xwBTUzTz/MNHnrq1HnwO6GB2IiZocLUj7CbNjw
         o18hX614oGXLvIEV2ybJprlt3Ho+TU7zd10S2k4JFCvRDAmEywOZnq4DCJqVX4gpZeWH
         MG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=rlTM2WLKd/G1RWWP3nDYVV63LfOxjXtygEDLWm72h7g=;
        b=NIvJRjth3qPqvLNitbzZY5T+y163hxe7lkuPy3oxesUCc3KdSm2XgJRCi9DYFhMaM/
         Lhlbh4YUznYS9pQgncHpLCeGs2dTrLL6z3IJTRDcCrKu18b8FCCfx/KERiuoFqwZl88F
         m8v/GCdSJ57tO0ALSWjYqZe5shRcb1QK8bwrShYnpBJnP5cr8dxQ5NRMnX1lnmrUSAVr
         h8UgMgQ6rLaMN/blE8DpyCynFviq42pxHd3IL4y1/o3Aw5JWrnuO8ITho8eFCzqgETRK
         mBk8uRwErZZJ3WNrvsFi2QoRpHhbXoqzHGiI8pWJ56WVba78w+Mo6VGkNvMR/8QzslRL
         dRSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uhQxmYPQ;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uhQxmYPQ;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x227WRjlTq7rsYwpwj7rRNFSJFWuynRjZZ9/Ya9OlfDSQwjl5hWOa3vsbOpuLlrJhxDAbATaeALalDyJzRuWFeBI=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAPcyv4ihN6fy5-vBtfA0PuwXvCAj8-rMhtQmevh5sdYxbH3Yfw@mail.gmail.com>
References: <151632009605.21271.11304291057104672116.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151632014097.21271.16980532033566583357.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206192925.qkmghwsbaysr4iv2@hermes.olymp> <CAPcyv4ihN6fy5-vBtfA0PuwXvCAj8-rMhtQmevh5sdYxbH3Yfw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Feb 2018 12:26:32 -0800
X-Google-Sender-Auth: MAeBTM3fNyuapp4YMuNXfE4Zdsk
Message-ID: <CA+55aFxYHX3=HN4P5M0ziSJ08WfjccyhE2T7epS-EC6ZJ6LyjQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] x86: narrow out of bounds syscalls to sys_read
 under speculation
To: Dan Williams <dan.j.williams@intel.com>
Cc: Luis Henriques <lhenriques@suse.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, Greg KH <gregkh@linuxfoundation.org>,
	X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589977480308913684?=
X-GMAIL-MSGID: =?utf-8?q?1591684674147658322?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 11:48 AM, Dan Williams <dan.j.williams@intel.com> wrote:
>
> Just to clarify, when you say "this patch" you mean:
>
>      2fbd7af5af86 x86/syscall: Sanitize syscall table de-references
> under speculation
>
> ...not this early MASK_NOSPEC version of the patch, right?

I suspect not. If that patch is broken, the system wouldn't even boot.

That said, looking at 2fbd7af5af86, I do note that the code generation
is horribly stupid.

It's due to two different issues:

 (a) the x86 asm constraints for that inline asm is nasty, and
requires a register for 'size', even though an immediate works just
fine.

 (b) the "cmp" is inside the asm, so gcc can't combine it with the
*other* cmp in the C code.

Fixing (a) is easy:

  +++ b/arch/x86/include/asm/barrier.h
  @@ -43 +43 @@ static inline unsigned long
array_index_mask_nospec(unsigned long index,
  -                       :"r"(size),"r" (index)
  +                       :"ir"(size),"r" (index)

but fixing (b) looks fundamentally hard. Gcc generates (for do_syscall()):

        cmpq    $332, %rbp      #, nr
        ja      .L295   #,
        cmp $333,%rbp
        sbb %rax,%rax;   #, nr, mask

note how it completely pointlessly does the comparison twice, even
though it could have just done

        cmp $333,%rbp
        jae      .L295   #,
        sbb %rax,%rax;   #, nr, mask

Ho humm. Sad.

              Linus
