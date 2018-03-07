Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520444245; cv=none;
        d=google.com; s=arc-20160816;
        b=xodGVsCbSGPFcjYRZ8CZWDqZdQ+jNor/lEgZ6vgoOC+4KCfMR0VfP5iFS7LpbxJC32
         f9DK1ovH33ju5Q8HbDOC1TCRBe/fZF/oEEnXP64ZDVcA/YfrxO8hmauyVpBg1ff2NbBD
         HkYXG5Ch1qOB7WssXHuTQQd3R3fk3UA3+eJROa5fkmPsutpbew2eYwH1kvRxN9JwZJOp
         ZQ/9iK+9l3gq7bw5A16Y8dNmHdbxec65+dUuhjYRpL9csFO67ze6PVGdKNjgkbXm7A3q
         YZ6UeDBE9TGyb82FoUx4NXWYMus+pRtMlUxGPaphJx4siAwH4QKGuFkM+8PNyKMqljUg
         p49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:sender:mime-version
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=FKzSzERvazYBQ29a7CawCVXICeHx2d6+oWCYp90yM98=;
        b=mTc78rUkMUtyNCgWtElE64kDmuDA7Ut77arfQXUgsHmSlH9XcL/qw2ZAYnX/taF83V
         NYq3gfRBCjANzXpkYnSbLwF2tSL8I2tqdSU/wjwAsIHbHDHN7ZvbNwvZ4mbG5RbXmB+U
         7LPfThKZ41bqWIng4A1FxGxHv7LzZV61EvEjSJbc3cXPfGBXecIYb1qpcfKol9eskzS0
         8OYeE2prfs8aDMxOXtvYsQPRyfyugYZrA2pwpPilEpoyOeuH7tpIqxqqm/L361rN5nGA
         3u4VAOQCgYC/JkntNPmVrHbotBjDhhXPXwatvPKcaLaZeeUSAegoe6TF3VGNLUVr+oU/
         oweg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=lSAjdjbg;
       dkim=pass header.i=@chromium.org header.s=google header.b=Q5NhX0zc;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=lSAjdjbg;
       dkim=pass header.i=@chromium.org header.s=google header.b=Q5NhX0zc;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELtmczyGK0+r+yS/YpsWaqAI72tEVKyUMZa6SoQwt7C/vM5JUaGbw5qlSclu2yJEYpS3Po9MjWJtEPC1rGybPj0=
MIME-Version: 1.0
Sender: keescook@google.com
From: Kees Cook <keescook@chromium.org>
Date: Wed, 7 Mar 2018 09:37:24 -0800
X-Google-Sender-Auth: VUMLAa237C6wEgoL0vwjYshiU-M
Message-ID: <CAGXu5jJaVPPjqtpOLapk8ABT93zaUoaKR-i7Ga6LVSK2OiX_tQ@mail.gmail.com>
Subject: VLA removal (was Re: [RFC 2/2] lustre: use VLA_SAFE)
To: "Tobin C. Harding" <tobin@apporbit.com>
Cc: "Tobin C. Harding" <me@tobin.cc>, Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Tycho Andersen <tycho@tycho.ws>, Oleg Drokin <oleg.drokin@intel.com>,
	Andreas Dilger <andreas.dilger@intel.com>, James Simmons <jsimmons@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Herbert Xu <herbert@gondor.apana.org.au>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594301344989798721?=
X-GMAIL-MSGID: =?utf-8?q?1594301344989798721?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 7, 2018 at 2:10 AM, Tobin C. Harding <tobin@apporbit.com> wrote:
> On Tue, Mar 06, 2018 at 09:46:02PM -0800, Kees Cook wrote:
>> On Tue, Mar 6, 2018 at 9:27 PM, Tobin C. Harding <me@tobin.cc> wrote:
>> > Currently lustre uses a VLA to store a string on the stack.  We can use
>> > the newly define VLA_SAFE macro to make this declaration safer.
>> >
>> > Use VLA_SAFE to declare VLA.
>>
>> VLA_SAFE implements a max, which is nice, but I think we're just
>> digging ourselves into a bigger hole with this, since now all the
>> maxes must be validated (which isn't done here, what happens if
>> VLA_DEFAULT_MAX is smaller than the strlen() math? We'll overflow the
>> stack buffer in the later sprintf).
>
> ok, lets drop this.
>
> Memory on the stack is always going to be faster than memory from the
> slub allocator, right?  Do you think using kasprintf() is going to be
> acceptable? Isn't it only going to be acceptable on non-time critical
> paths?  I'm still trying to get my head around how we get rid of VLA
> when the stack is faster?  Is this a speed vs safety trade off that must
> be tackled on a case by case basis?

It really does need to be a case-by-case basis. It'll be a balance of
speed, safety, and sanity. :) In the lustre case, that's both a bug
fix (buffer over-run) and an unbounded VLA removal. Putting a string
of unknown length on the stack tends not to be sensible, so the
kmalloc/kfree is reasonable, IMO.

Building with -Wvla, I see 209 unique locations reported in 60 directories:
http://paste.ubuntu.com/p/srQxwPQS9s/

In the case of the crypto, my past thoughts have included either
adding a buffer to some already-allocated context, or using an upper
bound on the VLAs, since there's a fixed number of implementations
built in at any given time. Though, I suspect neither will work
without more examination. Usually, if it were easy, it'd be done
already. ;)

To try to keep from adding new VLAs, maybe we could add -Wvla to the
W=n level in scripts/Makefile.extrawarn. Likely W=2:

# W=1 - warnings that may be relevant and does not occur too often
# W=2 - warnings that occur quite often but may still be relevant
# W=3 - the more obscure warnings, can most likely be ignored

And frankly, maybe -Wformat-security -- and perhaps format-truncation
and format-overflow -- should get added to W=2 too... they've gotten
it much less noisy over time, though still very noisy. ;)

Or, as mentioned in another thread, disable -Wvla in certain
directories but enable it at the top-level. I'm less of a fan of that,
though, since it tends to lead to the problem just getting forgotten.

-Kees

-- 
Kees Cook
Pixel Security
