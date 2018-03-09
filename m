Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520622738; cv=none;
        d=google.com; s=arc-20160816;
        b=yDhHMpOsaHpxSdCu848p62GuTceqRPgt7ye/8Ri2ImeAtXOar7VBPmqVXBRxa9jqVz
         5kmapIAuROcKb4jaW+pahjT8sgrMyrWkNUqdpZZlT6aLUvyQkSjNnjbR3oHrXJEyBY/+
         aTozDX/mmMGsrxVXELdX1Em5wBop+wPWYoOLBGC2w4bWTqTVY2qB5RZMLvjS8pkWbRvV
         uEpmCMzjlAIRWPmLZwfavL9dEtKKormXUiIU/wiQ5XY37XiN+lgcYq2VFChPNsxfkAza
         jWnrigEHFE3hjxXMNdr9bQrcIjBCBOzgapxbuEUzl7e01G/f6viZdCKQbX8niDKHcsRs
         apIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=emR2rNpi3UgkskimCuyu/h02sF7w5c2T/vQveuW+z3I=;
        b=gXqGcHXEZRew25U3XyZBYlj/Prji5uUyQbVKU5UlMVSuo6a/VE64Au3rVox3EyJE/s
         u8qRZ24XrvrrlqPUqTVT4cjBehdJ5mlL/Pja5JdSKvDZ9h6Bdio7pc4URn8GFjzj9k9j
         ofHRL+SV+bvefW/CO2NhbOA+XRQ+orshDkjw0fi3IAfuxvX8y6gG4/OWESHbjGJN5uR6
         RfG7qYqpWa/A02WdlR6E39LpKhjpfrgbK9P8qMuHHFPoNBNBzS0gKcW9eVJvOR1Z7pmz
         GOeJgQ1+ZRn+JjCoETBKSk1khZK3s3C6ZoWwll8CXVndbFNXRiK2GLMyrKYdKrily/ZY
         sn8g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=B86fh9A0;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=YmBVCeql;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=B86fh9A0;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=YmBVCeql;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELtZMV0BPNm5nMd6mx/qoZi7pDBHA1lyVEXyLSydfrUSpYw8AhFy5iJEhYCiC+25/LB0Fkm+gZPJWQFHl+AFaXs=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180309.135724.452219538059491199.davem@davemloft.net>
References: <CA+55aFwfcXzD+pzjN=vTcvscpK97pSztUZ2JK7pABs+rMtM7BQ@mail.gmail.com>
 <E459E6CC-F51B-4F2A-9D26-FFB7166E0A47@amacapital.net> <CA+55aFx7w1s7=5HzeczPkkksaU4oVsWQf+_c=aHS0O7i_9g+Kg@mail.gmail.com>
 <20180309.135724.452219538059491199.davem@davemloft.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Mar 2018 11:12:17 -0800
X-Google-Sender-Auth: x6oqJ8uIvDxP4weB1pqSi0OCM3s
Message-ID: <CA+55aFyN8JDh76bm1VinBvrgMH5jNL6RbuFAkrH8vuYU1s9GDQ@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: David Miller <davem@davemloft.net>
Cc: Andy Lutomirski <luto@amacapital.net>, Alexei Starovoitov <ast@fb.com>, Kees Cook <keescook@chromium.org>,
	Alexei Starovoitov <ast@kernel.org>, Djalal Harouni <tixxdz@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Daniel Borkmann <daniel@iogearbox.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>, Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-team <kernel-team@fb.com>,
	Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594150201283124044?=
X-GMAIL-MSGID: =?utf-8?q?1594488508830249090?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 10:57 AM, David Miller <davem@davemloft.net> wrote:
>
> Once the helper UMH is invoked, it runs asynchronously taking eBPF
> translation requests.

How?

Really. See my comment about mutual exclusion. The current patch is
*broken* because it doesn't handle it. Really.

Think of it this way - you may have now started *five* of those things
concurrently by mistake.

The actual module loading case never does that, because the actual
module loading case has per-module serialization that got
short-circuited.

How are you going to handle five processes doing the same setup concurrently?

                  Linus
