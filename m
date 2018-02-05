Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517849716; cv=none;
        d=google.com; s=arc-20160816;
        b=0la1czwcBp+QxvD0iaDWV/W1/J+yOyhL4seEYPEmsDyvPborElHOPQ9bSUpnu++p9x
         /2htcd1y60XqzM0GgduYwFmrxiB0/bouDPVnh69klkZnTdSJ9EpUjg+EtZGzDYikXJkR
         M9WFbqtCiijqYN0wMeHzMsU9smGY+G9VM7Oi09p79LXi18VxaT/IugKcwyYsQAy6vkvr
         36pmWoEyRWzM3170mlrgZ0ee8EZTp7zl03AFYRH/u1xXMKA1DEYXsNRUxi06AEKF1Nav
         32DMCIf795ULIi0MOIXqfM/CagY70K9aUhGW1QDs1isps389kRVC0wthchP7/e6zlixk
         c6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ahKwl6s20V24TMGhR4GmLhMLs4fwoIMkpFc9LyWvyi0=;
        b=wfFvwYX/UoKaxGpenvS8PnuG4vRz96iNS6ABfjsUJPo5njR/MUzYCaper8EVv00fTl
         UEztog//Z7HOxo5teEWrRt/pwPnTi8+WTQntFLyne9rCxTcJLI/M0S/7Ai0Vl7ihc1ov
         /YP9LVDTKyP+GMLnS7TwIeAixVwRM0ffUTWx2FgoFlxuC5dybbWNQeHReFthLKyeWqm/
         GuE46XDb4ADwWLqng9eyYA3/g+W5vno6Zdq/TavoiNHqjpAR6R3ipP5YNhNct5EQF0kw
         3Ny1VblM7ZSCj9ULdtNaM5Z7s4l2oyajxMBCIj4q6N/Uo9C9zi4gLp9c08U6xc+1q3G8
         6XGw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hgBC+fvD;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hgBC+fvD;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x224YREKl8dW/OACnyXM5oej379gGYBBsjeq5p9KyQlFbCV0fgV4lX866KKzCgaWm1QLVGcmSvdj+a39rPT3jZ6A=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <b82adbc32e4444debb947582d3a8291c@AcuMS.aculab.com>
References: <CACRpkdaTv4NBrRXeJE6dVi4W88+LZdsTCSzTHi0vdcKMW3Qfmw@mail.gmail.com>
 <CA+55aFzMBptQt-QHMR0MM9MA3=1rxcf8ca5qHxrf4Mm0ZobE_A@mail.gmail.com> <b82adbc32e4444debb947582d3a8291c@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Feb 2018 08:55:15 -0800
X-Google-Sender-Auth: TojHmJ3uYlwsg6IOey4emNa7xdc
Message-ID: <CA+55aFxdK3CJiAN_yytM7nYubYOeShvCNFGpEU9SR1HC0b8WiQ@mail.gmail.com>
Subject: Re: [GIT PULL] pin control bulk changes for v4.16
To: David Laight <David.Laight@aculab.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591331743286572652?=
X-GMAIL-MSGID: =?utf-8?q?1591580784098781016?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 5, 2018 at 2:09 AM, David Laight <David.Laight@aculab.com> wrote:
> From: Linus Torvalds
>> Sent: 02 February 2018 22:57
> ...
>> I also wonder if there are any automated tools that try to find these
>> kinds of crazy things. I suspect a lot of our build times is the poor
>> compiler just reading and parsing header files over and over again,
>> and a lot of them are probably not needed.
>
> I've counted system calls during a NetBSD kernel build, I imagine Linux is
> much the same.
> Most of the calls were open(), and most of those failing opens.
> I suspected that most came from searching the -I path to find headers.
> Build over NFS and the cost is even more significant (every directory
> name in the path (used to) require an NFS message exchange).

I suspect that Linux is actually very _different_ in this area,
because Linux has a very extensive name cache for pathname lookup that
also captures negative path component entries.

End result: opening a file - whether it exists or not - doesn't
actually go down to the filesystem at all when things are cached. My
kernel profiles also show that very clearly, there's absolutely no
filesystem component to the build at all (but there is a noticeable
VFS component to it, and __d_lookup_rcu is generally one of the
hottest kernel functions along with the system call entry/exit code).

Now, on NFS the caching will be a bit less effective because we have a
timeout that forces re-validation of the caches, but even there at
least the "look up the same header pathname" will be captured very
well. So the most common case - of doing the include path lookup for
all those really core header files that _everbody_ ends up including -
ends up being captured pretty much 100% in the caches even on NFS. On
a local filesystem, as long as you have enough RAM, those lookups will
be cached even across multiple kernel compiles.

At least if you are like me, and all you do all day long is build the kernel ;)

                 Linus
