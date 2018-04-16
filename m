Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523900589; cv=none;
        d=google.com; s=arc-20160816;
        b=wUKPbbYDvu5qF5CGAD2AHmK57bho/H7BcVU8PkXZ22aO+mnmlb/z5CvoBU3vQnNqMZ
         h42p59z56kQdatDh9VvTYvVdNojN81hDfdK27q1rPYG9i1Ot5P6Vs0deWqGcmd12Nr5k
         OoG9D6WxewQywCPGfv6MwD9k4BtwpNAnbG849rZ8ZHahcJdaKdbNIf0jLqyUTNLOJO5M
         a1ycY4OhCKnWJrnPhV7Nwhj6G4ADbskhiCL3FpC0ih3XRr0jAAA1c/yBMH7kV9N9Hbzd
         G7QetP4OECTmVcsIz8mIQeIHBjJqMMZ54aAmIpOxfIjH00L/oCppTSAiCGCZZjCpImEa
         Tm7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=QIba5sAwcLyEyDESYLjun6T2sBIqBXsQvWS8o7uwoMk=;
        b=c0vZve+VvmEyMJfPF/nqWEvyVGl1JfrEvNIdBJ5tNEbpZu4p0sTT86MOjJ5J9x+Io7
         VUN3YlkCSxb04bjum4UhUu8S2esq9+eiJok1J1xicSePc9a6K0U5MZcYo7NqOYHfObMq
         Agsd7+Xq0FevJcXWdlDMXHG9nzTAoAlccnT7OldlBV66tx1EZcYNlOcr03lXxFAh3JEa
         NNelOcL3fIN99cLssS1xylX+3AdJCPnf8Pjr72udHOgKyiggkendPh7Bn3Pzk+ERpKP2
         6XqQ3IYd3yS+Q9m3utD1DfrzDpX+zJ+qpJJFGLXHbE/V7uD+532uEfTPvsDlh2nMAZsn
         aYpA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=e2DGUJCa;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=ZD1TK/CV;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=e2DGUJCa;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=ZD1TK/CV;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AIpwx4897e56Ze6BCGZ7Q0j5yP81iZoSoep5hImuzkBZ0wHXmDhj6SxN4gPkkFY6mO72ceRiX/rDk+TyQhymG2Sz8a4=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1dcd116c-9384-6885-2d9e-f620c14bd955@osg.samsung.com>
References: <1dcd116c-9384-6885-2d9e-f620c14bd955@osg.samsung.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Apr 2018 10:43:07 -0700
X-Google-Sender-Auth: SGqIu3JshTG17HL6szwN1BrC0dc
Message-ID: <CA+55aFwE1SR87+Xkkmfr+D0Yq3R0HRkdf1GdgScEfXXWN4ba6w@mail.gmail.com>
Subject: Re: Linux 4.17-rc1 - kernel paging errors running x86 selftests
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>,
	"# .39.x" <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597922964171604923?=
X-GMAIL-MSGID: =?utf-8?q?1597925584439385345?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 10:01 AM, Shuah Khan <shuahkh@osg.samsung.com> wrote:
>
> [  884.496588] BUG: unable to handle kernel paging request at fffffe8000010030

This is the LDT remap area.

> [  884.496614] Oops: 0009 [#1] SMP KASAN PTI

This is RSVD + P, so it's a system read access that got a protection
fault due to reserved bits.

> [  884.496741] RIP: 0033:0x4031c2
> [  884.496745] RSP: 002b:00007ffd805b56d8 EFLAGS: 00010246

This is not actually a kernel paging request, it's all user space, but
it's user space that does a system access.

That's normal - something loading a segment in user space, and thus
accessing the system LDT.

But:

> [  884.496601] PGD 372870067 P4D 372870067 PUD 346e84067 PMD 34005f067 PTE ffffffffffffffff

WTF? What's that odd bogus PTE entry?

That's also why it gets a RSVD fault. That's just garbage. All-ones is
not a valid PTE.

The other levels look valid, although it strikes me that maybe we
shouldn't have the user bit set in the kernel page tables. I realize
that we clear it at the leaf node, but..

So the user page table is somehow badly set up.

I don't see *why* it would be badly set up, and that test works fine
for me, though.

It doesn't seem to have anything to do with KASAN, although

> [  884.650095] BUG: unable to handle kernel paging request at fffffe8000000000
> [  884.650103] PGD 363699067 P4D 363699067 PUD 3371c6067 PMD 37cfbc067 PTE ffffffffffffffff
> [  884.650112] Oops: 0009 [#2] SMP KASAN PTI
> [  884.650200] RIP: 0033:0x401471
> [  884.650203] RSP: 002b:00007fc8e6775eb0 EFLAGS: 00010206

The other one is exactly the same thing.

                 Linus
