Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517949745; cv=none;
        d=google.com; s=arc-20160816;
        b=p76pTJySPJNWEsoraT/vlypvmyuyvmPfsIWXNwS1HMyJ/UgDHk69eMP/blWnysTVUF
         CAF6WJTV9+xdCz9RkR7pNiluDDc6JKt/rJx4RxLrhCZ2K8DI+F+36sA6P2nIAory2rS0
         a+qZVxK+vK3m1c5ZSBDzOKbL2EnH5eUBn7bf9R0994y+M0G319IrMFxoVX9T6k3nFmff
         q7fHtNcw1jJA0tOBydoypnlB22FAQTK1U2n2ZsHjWBrlJgsrIt44x57liZb40DVTFtgS
         r9j/aaD3cBg+KU8JkpNgHz03oR9+bXCbYmkao1/oax1h/Mc8nHLDFF6OH+yI0pD0xLIy
         OGAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=HmSuJ0Ln96HzQ25RmLoBJfNJ/1Bx8Er0G88Hvb2CWo8=;
        b=Vtgo3jGrBMCG7yj5lSlEu2kbGTzo67uzM3Je/FRrib0BNXqpwJAdI+6ENSd1DiMzDM
         RBjWiiV1Kso+YGAFonVJ3B466nh70qgDi9t9cEz3K76BCq+q1r/5Nf27hWKdsNWjYCkf
         tDiPlV/59GpseKH89rIz6DWG5jYq4RK7CJqaf7lhyOeuVXxUXCOK034YXsxGUH0egkTn
         y+LUu/3rU0VxwmjDBIzotrOvL6Xq6zX0hTrQBDAYAg3xfNxnUFZrXVPpQ6NXnmDhmbzw
         SOyBX+RvMeVQc3Q2MOqB7OxTnJxHp0d01JndFrHgjd7ZQx0vPl117uM6ye9Rc/m+lNCw
         OqRg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JjtzRoXh;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JjtzRoXh;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x226f2WT5XOnQvMmu8yURuAO0oFjxtIfJoduQRumUYujCTYvZnQZ/LdRIVJ6unLboFI3km8xOPRxJGX//ErC0E5s=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAPcyv4i5oORdk-Fzypxw_+gCLUa8f=w1e_n0=47P7uHR-jT6GQ@mail.gmail.com>
References: <151632009605.21271.11304291057104672116.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151632014097.21271.16980532033566583357.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206192925.qkmghwsbaysr4iv2@hermes.olymp> <CAPcyv4ihN6fy5-vBtfA0PuwXvCAj8-rMhtQmevh5sdYxbH3Yfw@mail.gmail.com>
 <CA+55aFxYHX3=HN4P5M0ziSJ08WfjccyhE2T7epS-EC6ZJ6LyjQ@mail.gmail.com> <CAPcyv4i5oORdk-Fzypxw_+gCLUa8f=w1e_n0=47P7uHR-jT6GQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Feb 2018 12:42:24 -0800
X-Google-Sender-Auth: gNdwm8oBfina1kT0TJpTDxK9qvo
Message-ID: <CA+55aFzZVL=WVuhJAQDazj59jwnmhUrRRwNgzXS+c-q5yva0iw@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1591685672885878598?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 12:37 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>
> Are there any compilers that would miscompile:
>
>     mask = 0 - (index < size);
>
> That might be a way to improve the assembly.

Sadly, that is *very* easy to miscompile. In fact, I'd be very
surprised indeed if any compiler worth its name wouldn't combine the
comparison with the conditional branch it accompanies, and just turn
that into a constant. IOW, you'd get

        mask = 0 - (index < size);
        if (index <= size) {
                 ... use mask ..

and the compiler would just turn that into

        if (index <= size) {
                mask = -1;

and be done with it.

               Linus
