Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526235703; cv=none;
        d=google.com; s=arc-20160816;
        b=xgEhZUZa6Tr0eRmi6aNNUXhq93ZzUjVZ7tjs64c3XB8Zq2Z+6Ay2TVzAem8FMyNq20
         d28vLw3hiClhaRqIk14vc0r92Dg2sDS48k9sbBtdfJFzKkWY9P+Wxy0woVSni4zQLfwy
         PHn4HMRAo3OtPe/eT3J/m5tNSBaeJLpRe3lJ23PtwCj1Vwp7tAzFPOv3NbyktP9ibRMk
         kelvSHoWJIhrBn7OxltQ98Dwe2WK9LRLVm8achyqn5iHYZXf7QtTXOpB/G4GLf7uxXB0
         1mYcdDEh8FLv2yWMUBl70/XELiCYOV/Mi28l57xP3CUlvJqLii+BK8e9xQZIUi/niggM
         0WkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=zx2v4yHSWYJyoKxqczZgnNDQRHQrnGhT4P1bdzTvX6g=;
        b=zhSDZIxpkKYyP/5Yh9kY78QJ9L7B0seM4I5hGZyXtlUXDBqpMhdmn/JzvTsXfwpmj8
         JtKxd2GD0rFDu8eNiT9osI/QPPM7eL7CYDTpn51nR8MNO+CdRoTJXqmdX4wS/z5G9j7X
         Y1/sMKxjXGmsnSG3fUyArjKPbks0ZreR1zCOeYq4EZuIq5tZDIJwHUIsDzgYG8EdnP6i
         wX1LjFPVG5bfnzWsNr4FY/1vdcEB1wfGIFAslewKhbiuqsAYQEgJfkIDaTsy+3+1nNiM
         3bXl08aGdnf+lvmtQmnJKYqnDFrdvz7T7tc2Znz1zPhjaBzotqWwXb3+/rOp9Jk656rV
         xikg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=AsPMQoTb;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=AsPMQoTb;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AB8JxZqQNoDbclOPzRejPqGIyJ6GcDHdS5pVZE54GaZDFQZ95sBdjm6co9AMxVxb7EDiCH1nV2MlkH63o+bldITHFuw=
MIME-Version: 1.0
References: <KL1P15301MB000678289FE55BA365B3279ABF990@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KL1P15301MB000678289FE55BA365B3279ABF990@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 13 May 2018 11:21:31 -0700
Message-ID: <CA+55aFx5_qcUHBQ50RfOnH+pS=jqA_Wg2YYCcm=fTXRFJjs3rg@mail.gmail.com>
Subject: Re: for_each_cpu() is buggy for UP kernel?
To: Dexuan Cui <decui@microsoft.com>
Cc: Ingo Molnar <mingo@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rakib Mullick <rakib.mullick@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599966610262155638?=
X-GMAIL-MSGID: =?utf-8?q?1600374128951281414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 8, 2018 at 11:24 PM Dexuan Cui <decui@microsoft.com> wrote:

> Should we fix the for_each_cpu() in include/linux/cpumask.h for UP?

As Thomas points out, this has come up before.

One of the issues is historical - we tried very hard to make the SMP code
not cause code generation problems for UP, and part of that was just that
all these loops were literally designed to entirely go away under UP. It
still *looks* syntactically like a loop, but an optimizing compiler will
see that there's nothing there, and "for_each_cpu(...) x" essentially just
turns into "x" on UP.  An empty mask simply generally doesn't make sense,
since opn UP you also don't have any masking of CPU ops, so the mask is
ignored, and that helps the code generation immensely.

If you have to load and test the mask, you immediately lose out badly in
code generation.

So honestly, I'd really prefer to keep our current behavior. Perhaps with a
debug option that actually tests (on SMP - because that's what every
developer is actually _using_ these days) that the mask isn't empty. But
I'm not sure that would find this case, since presumably on SMP it might
never be empty.

Now, there is likely a fairly good argument that UP is getting _so_
uninteresting that we shouldn't even worry about code generation. But the
counter-argument to that is that if people are using UP in this day and
age, they probably are using some really crappy hardware that needs all the
help it can get.

At least for now, I'd rather have this inconsistency, because it really
makes a surprisingly *big* difference in code generation.  From the little
test I just did, adding that mask testing to a *single* case of
for_each_cpu() added 20 instructions.  I didn't look at exactly why that
happened (because the code generation was so radically different), but it
was very noticeable. I used your macro replacement in kernel/taskstats.c in
case you want to try to dig into what happened, but I'm not surprised. It
really turns an unconditional trivial loop into a much more complex thing
that needs to look at and test a value that we didn't care about before.

Maybe we should introduce a "for_each_cpu_maybe_empty()" helper for cases
like this?

                    Linus
