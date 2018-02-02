Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517612212; cv=none;
        d=google.com; s=arc-20160816;
        b=jzr41He1jmkUz2tk+LylMg/sNF3MxlRnLb6bKYojxi5x57faeMFKPq+RS+vtwJ6ZBA
         Ona/t9EYXHIQkvZy56Yo0ety9HpuH0PXmq7gJrSn82wPqi3RoxnDpFLslMKBAAJEIkuF
         23b9pB5cWQOryHm7n/jZcakEVnGF2klvaHB4TkmuUzbkw+fSsslVujrKqoTRL9SCvXxV
         ZylQJKpfnatL8EyV9KuX4Zf7XAt9BRUUxS6klWicWe/N35aqOKmrSA7k3PuLeQ/lerB8
         9XuKS/wTcFAOCp1+F/XwDYiLb7gtfCJScq+mTSKtWXeXXk+osr0CzuXWhFgFwekf9YCA
         hO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=a3ws2QNpI7dvY4c1MUH7guZ2uUNy8kp4hHtiC3b8ho8=;
        b=1EtaijAWeoIHNhdaseth2LfXkKme/Tmxuio6i2C2QG/WYd0PIgnmZSMNhZ9uoB+jqv
         EjhWfDDa7xN4vuzGkr765UktIfRuTLwCEM4PCO5aRtL/np5T8XNETZdknDe+Kd4n/bZ8
         BOehZ6Ap5AQeuLqwny9Taw+YA2BdaVG6X1LEpqT0A0VbEE4GqmyA0zSplIgl93Z+1VMn
         Mam+BCASZapR6lConzVbxOhSKNgQdBllC0v9I5X4fGDmjZEhf1XThmocrgGb7ZugJba1
         hOAvShxDcW4JiOGKOFWSVeMKGnSNjbFFKFIIo4ccPggKfxo+TCBBkwk8quKg9KrQPxXv
         MlWw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=C9thoMvO;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=C9thoMvO;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x227K+n71QhpgmNrsbxcrdVyoDIXjEPLBbxFYUKKIn9HpEtnr3eT3yIqt2b30Ux0R7vF2/d8gN7mnr4Sb/dSMd5E=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CACRpkdaTv4NBrRXeJE6dVi4W88+LZdsTCSzTHi0vdcKMW3Qfmw@mail.gmail.com>
References: <CACRpkdaTv4NBrRXeJE6dVi4W88+LZdsTCSzTHi0vdcKMW3Qfmw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Feb 2018 14:56:51 -0800
X-Google-Sender-Auth: oRyUvEIU1cGCIJ5WcX4bM3e50bY
Message-ID: <CA+55aFzMBptQt-QHMR0MM9MA3=1rxcf8ca5qHxrf4Mm0ZobE_A@mail.gmail.com>
Subject: Re: [GIT PULL] pin control bulk changes for v4.16
To: Linus Walleij <linus.walleij@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591331743286572652?=
X-GMAIL-MSGID: =?utf-8?q?1591331743286572652?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 2, 2018 at 5:28 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> here is the big slew of changes in pin control for the v4.16 cycle.

So I pulled this, and then was surprised by how *everything* got
rebuilt even though it only touched pinctl files.

The reason for that seems to be that the pinctl pull got me this:

   include/linux/pinctrl/devinfo.h                    |    2 +

and in include/linux/device.h we have

  #include <linux/pinctrl/devinfo.h>

so pretty much *every* driver ends up depending on that silly two-line change.

I *think* that the only reason that happens is because of this:

  #ifdef CONFIG_PINCTRL
          struct dev_pin_info     *pins;
  #endif

and honestly, that could be trivially done by just having a forward
declaration, replacing the pinctrl/devinfo.h header include entirely.

Ironically, that two-line change to pinctrl/devinfo.h was a forward
declaration in the exact reverse direction:

    +struct device;
    +

so I would really prefer to speed up recompiles and just generally try
to avoid horrible header file inclusion by doing the same thing in
<linux/device.h>, adding just that

    struct dev_pin_info;

declaration, and removing the <linux/pinctrl/devinfo.h> include.

Hmm?

I also wonder if there are any automated tools that try to find these
kinds of crazy things. I suspect a lot of our build times is the poor
compiler just reading and parsing header files over and over again,
and a lot of them are probably not needed.

A year ago, Ingo did patches limit some of the header file issues for
the core headers (<linux/sched.h> in particular). Maybe he had
tooling? Ingo?

                  Linus
