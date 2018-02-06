Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517949800; cv=none;
        d=google.com; s=arc-20160816;
        b=ad5/y7kiIuS6lJFUV0KCrbMmXKxigb1J4KVNcjElO0y5AHKiRG0z1guUmxonNA6Rqi
         P7MHwiyFC0lhNB3X+/0RW4QvNcSeLDgQINKRNgP67xuaCX5WLPugHG6UFhVIoIbC6eUz
         WrqpaI8sah36QLH69g0PKuJWMQDQC8C8EvP+XITSBEzaHpy06rzL/g5wynQFqKXWPyc9
         5ttFns2vfpRnJLVmD/vhRfElKRS754T92sdF/uNw/TIZPPFKsulWuHh5OGcrRDtcirqd
         yQLDH335DT+6q5vYq7vF/skZRzmTN7vIqcGQ6rhftVHZKtmqUWKbYdyYuSogs9eIqJi5
         Sv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Id4A0UyU4xH5fPSpN1ganqDceG3PYm9dY87PUsTKiR0=;
        b=lfiTGgpOomEWPu767jsuiNM9Fphj63zP7Ic40C41NpSasVam3FuVYW3r4VqAv9c+cz
         v1YDGfRxG+MDYUZUwbmaIRu2SUpms+2kxG+NyC5oldo49RwelJpzx71X1FG2otIAdwll
         B/Ng94dwWe8Lov2D2ibq9rL4do9LwA9tE+1w1gL0t3chYUI6hwH1wPRHn0yA0RR54WqP
         DEqpbKhlbMflRLbrH1uAzWlecXKdZnSt5c1gFeEv41zMwmaLVBOkEM9n8t6nIE4PTsG/
         bLVB10J01JBHjrlRE8lB/Qz9gyA6IlYunLy7ukxG4Yt8O+ddQ0SdLbjL4KLpHJ3K/rRz
         HzRg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vRuMWGDN;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vRuMWGDN;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x22458WkkEvYf8vEN1Y2bucGXeT8W5yfP0K52pyCW+C8ks3sELeatdy/68IVdjpF+MyzZki1t4xCgD/Lk/PjEKJ0=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFzZVL=WVuhJAQDazj59jwnmhUrRRwNgzXS+c-q5yva0iw@mail.gmail.com>
References: <151632009605.21271.11304291057104672116.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151632014097.21271.16980532033566583357.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206192925.qkmghwsbaysr4iv2@hermes.olymp> <CAPcyv4ihN6fy5-vBtfA0PuwXvCAj8-rMhtQmevh5sdYxbH3Yfw@mail.gmail.com>
 <CA+55aFxYHX3=HN4P5M0ziSJ08WfjccyhE2T7epS-EC6ZJ6LyjQ@mail.gmail.com>
 <CAPcyv4i5oORdk-Fzypxw_+gCLUa8f=w1e_n0=47P7uHR-jT6GQ@mail.gmail.com> <CA+55aFzZVL=WVuhJAQDazj59jwnmhUrRRwNgzXS+c-q5yva0iw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Feb 2018 12:43:19 -0800
X-Google-Sender-Auth: vVoRzTrKrVwbY400v2-4UXx95fk
Message-ID: <CA+55aFziKW3=R4erPJ_35JbWv5P02qqqnmS8zDR1mn=+M-YXQw@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1591685729782798780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 12:42 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Sadly, that is *very* easy to miscompile.

Side note: don't read email, go watch the falcon heavy takeoff.

              Linus
