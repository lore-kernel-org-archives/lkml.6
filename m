Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521220118; cv=none;
        d=google.com; s=arc-20160816;
        b=LK+awU5pDc+bMAaAFgWvEyHgf4rpDI9QKv7d0/xgY/CLE9wicqbHe49PF8FsopbGMw
         hKul5SDtRJmQo05JajKsq1Llzw9YmE4E6VhVGtVeSD3pgFYYoYxaXZvGTvYfsKkfGFCA
         2NnTea3vu4kkSkpTJxQ2sV2Mmv9uYZWjMTl9QHDu5jf1eEfDOaK2dPyVJ4DjVHJ+NgNJ
         iyDTBwECvg/C5IoZhLCMfUqiYlU089Ws0dQD0wleWpMnxy4LWn46EdlT8KQtnp3NAsiH
         qDXid+K2AchdfN8eRYtIlQ5oFcCcajvf7Q2IiJC6PUW39lzZcHnKbkPjgNGYRmCbE7E2
         WUAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:sender:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=ff570FfFXpMZV+/82QxBSoLjAB3IKqWSlgFxdzvHNtY=;
        b=PMRqX7MbHUMpG2pu+qFCT5jM3GGvjQEA0hyKfjeOrhmbBEqtLHdXb6L1qFA6d/XK6V
         KsGpDNrjDJsWgj1Gx54LylOI0zn6aumHonXzgktMIKvkHsiqCIgbIoRc2jBpLDfabl9a
         PfGWHbA1FHQkF8T5RKGvkZTtyDLnRdcl8XJOnmBIRNBFa244z5j3XNpjx2wRClnOa3bO
         RUa48LZUr+MVMEh+aAP/XrcxLYNxQlpbeEOuvvvm+gfrLnXVg+6cGzXFxPav1uxbusOt
         +0JF/gd3NqIOGlVNOeV4F2EBkvmLHd4iUzM6Vl+IVGez45r+sJhf4IsYRemtNJYDoI8n
         5j8A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RI5+8VuY;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=gl2zCaVR;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RI5+8VuY;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=gl2zCaVR;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELtcRsF/oDrc+AtJwmi9H/zV680Zu+cn/Gany98JqEza4kiwhyrMAN8jyqzzbMsy7tSjbmoM7fDCxtfLxgwJZ7k=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180316101549.31238bdf@naga.suse.cz>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
 <cover.1521141122.git.msuchanek@suse.de> <b8253774e223530c808eed65d116deecc46ad36b.1521141122.git.msuchanek@suse.de>
 <20180316151823.2f28d5ea@roar.ozlabs.ibm.com> <20180316101549.31238bdf@naga.suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Mar 2018 10:08:37 -0700
X-Google-Sender-Auth: N0Nnk7CjhwB43UvIMC3yMRLWujw
Message-ID: <CA+55aFxYOrn0XRPF8EXvizqAf3GOGmUxu-aKrqvtOsbgxwP2tg@mail.gmail.com>
Subject: Re: [PATCH RFC rebase 3/9] powerpc/64: Use barrier_nospec in syscall entry
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Nicholas Piggin <npiggin@gmail.com>, Kate Stewart <kstewart@linuxfoundation.org>,
	Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Paul Mackerras <paulus@samba.org>,
	Michael Neuling <mikey@neuling.org>, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>,
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>, Philippe Ombredanne <pombredanne@nexb.com>,
	Joe Perches <joe@perches.com>, "Oliver O'Halloran" <oohall@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595032347539334628?=
X-GMAIL-MSGID: =?utf-8?q?1595114906766646446?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 2:15 AM, Michal Such=C3=A1nek <msuchanek@suse.de> w=
rote:
>
> As far as I understand barriers they separate code before the barrier
> and code after the barrier.

Almost certainly not. Even if you were to do an expensive
serialization before the branch, the branch will still predict after
the serialization.

The thing is, it doesn't make sense to insert a barrier before a
conditional branch for Spectre mitigation.

The problem is not that the data isn't ready for the branch - the
problem is that the branch is predicted _regardless_ of the data.

Sure, some micro-architecture might not predict branches at all if
they have a stable conditional, so a barrier _can_ make sense.

But fundamentally, good branch prediction - in order to be optimal -
has to happen before instructions have even been parsed, much less
things like "stable conditional register state" having been decided
on. You'll want to do I$ prefetching etc.

So the problem is that even if the data is ready, the branch will be
predicted according to some unrelated historical data, and a barrier
to make the branch conditional be stable is pointless.

A barrier *after* the branch, making sure that you don't actually
start executing instructions past it (even if you might have predicted
and fetched stuff past it) *if* you have mis-predicted the previous
branch, is what a sane architecture would specify.

Of course, on x86, we mostly tried to avoid branch prediction being
the critical problem and having to have barriers by just making it an
address generation dependency instead. That should presumably work on
powerpc too, since address generation is part of the memory ordering
definition. But obviously a microarchitecture *could* end up
speculating and just redoing even for memory ordering, and maybe the
ppc architects prefer the barrier since they are already used to crazy
and not very well architected barriers elsewhere.

              Linus
