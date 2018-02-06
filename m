Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517950708; cv=none;
        d=google.com; s=arc-20160816;
        b=0gR+sRmCmrLnjNY93Lx/FbB9ad4FBk4TyRt2L+hVgEfen/7gy6Y4c4tPK39T7ClWuI
         3foWc/P1CrKXod2LEasSHnDlWOHjyXMF18//DOAWKpu7R1IoOWSf8iADkj7qPGLi/51F
         /h2DlG6WhGuDwCyBqVfTx7SP4F/dD75VERmS+pkHGT/ls5n9NEhbBnlBSx5dP4J5/hgZ
         V/tjKtWh7qLvB8Qg033bo8S0UaLKL7EXwlHHN+Re9Af1JyqACpTzNR6VP4BKi3/2XSA/
         URS6mSmMESU3WDWd6QNgcdK0q5fLQfRrCuCflSJdbDbReBYZehtBey2jvxsR2atGP4RA
         xN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=w5Njh8HugnDq92qceM9wlSGI8tpLQx6Ay1uVosh9kWc=;
        b=0oe9aXFm04ShU5rQbzeu49r5ZewgArPQLrWzRInnW1d4XhDVNagsQLxUObifl6rSEs
         3HppnnqVi1Fm08h+hVPq9ld6eY9xXTYoMwE5OjQ7iX6ldv/YwB6faFXEhkslCeZHmH7a
         OctLfgOyOLKZCxwUl65p9PcRyneWjJPpiUyoJDP/4liWnEbKKguKktuxr+594kVpS6AP
         OWm+k7L73thJH4ZAtdM3B7PaYw0WrJ9qmU9mRz4RBG5Rw10zC32O3+eE1DQnJiPmWvlJ
         6H5XaKeufo4jUg13cn5dImvUV9Kr6dJsHACZHJ83mbaHOBrRVDcnQ6Qn4xJiiEmK2Lt9
         akIA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eeYQOIfN;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eeYQOIfN;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x227ukBel4ktGG3LN5Khb/ZKQVnUYdtLfiIHXIKAf7qq/Oz/fMQgKS5pUnEkJmxTKWedniJjRgJH9S6A3Tbh820c=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CALCETrXV3rHb7Z8iaoieAJ5hRY0+UT7eTknxe4-FiOoke9XoGg@mail.gmail.com>
References: <151632009605.21271.11304291057104672116.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151632014097.21271.16980532033566583357.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206192925.qkmghwsbaysr4iv2@hermes.olymp> <CAPcyv4ihN6fy5-vBtfA0PuwXvCAj8-rMhtQmevh5sdYxbH3Yfw@mail.gmail.com>
 <CA+55aFxYHX3=HN4P5M0ziSJ08WfjccyhE2T7epS-EC6ZJ6LyjQ@mail.gmail.com>
 <CAPcyv4i5oORdk-Fzypxw_+gCLUa8f=w1e_n0=47P7uHR-jT6GQ@mail.gmail.com>
 <CA+55aFzZVL=WVuhJAQDazj59jwnmhUrRRwNgzXS+c-q5yva0iw@mail.gmail.com> <CALCETrXV3rHb7Z8iaoieAJ5hRY0+UT7eTknxe4-FiOoke9XoGg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Feb 2018 12:58:27 -0800
X-Google-Sender-Auth: SvoU4KpQKcRtIDULILL7PgBmuVo
Message-ID: <CA+55aFy2-OMMCatHTXL7wfP7H=4CEKv4Y_pRvfeEOCwxriDP4Q@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] x86: narrow out of bounds syscalls to sys_read
 under speculation
To: Andy Lutomirski <luto@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Luis Henriques <lhenriques@suse.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, Greg KH <gregkh@linuxfoundation.org>,
	X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
	Alan Cox <alan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589977480308913684?=
X-GMAIL-MSGID: =?utf-8?q?1591686682217443965?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 12:49 PM, Andy Lutomirski <luto@kernel.org> wrote:
>
> Can you use @cc to make an asm statement that outputs both the masked
> array index and the "if" condition?  I can never remember the syntax,
> but something like:

Yes. Although I'd actually suggest just using an "asm goto" if we
really want to optimize this. Give the "index_mask_nospec()" a third
argument that is the label to jump to for overflow.

Then you can just decide how to implement it best for any particular
architecture (and compiler limitation).

              Linus
