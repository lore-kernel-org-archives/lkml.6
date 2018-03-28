Return-Path: <kernel-hardening-return-12783-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49XL3lTIoG5bxAkcMa/FVOCwWNfQdiMlqIGm7qg+IhFRb8KYCjas/qoeUlVGsPbG3/peyRl
ARC-Seal: i=1; a=rsa-sha256; t=1522196571; cv=none;
        d=google.com; s=arc-20160816;
        b=JMlfeY7HKBIQVSY92PwlN6WiN+ABZVd5s+2MTy0YgZziFG8828nSwCZ4w73OkBI7AV
         FIZGOT0wx9JNtpgyJ3UlVgN2wX61CwqRpMxWPNVEeXlBg6DhpW0lwqcs+yNHNRnGp3oX
         +hEpqN1areTFCHg4Evld1BSYnHlYmLlFxyqPUbr8XKyEGiWmbzGqnQyGpSyRH4wG3SFe
         fC2uHL9HJhATBiFnxf62DT983ND7N9dpLu9DtcbRLUPXQ7YdNLWzjUtqQVJiq/v1pR4a
         Dq5gRSxafpzrZSMCXu7TEGthkFnt2QDJTK4AWWBwqB4z3xU5+C+kdG6RNt+VMb05s87f
         OnVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=5k0xCcRiIb60zPTugGFNwY2iBJ9EwN8k9d1iPnJG1fM=;
        b=TZGCPFT4svD+WPWK5ZfSIeQNFEDn1t9rLgt6FEnc90RjeSb3Dgj9cPFijT1DShtDdp
         m4/hc3OY8L7h9rsdohwWWhxfgVJoYLxlC/Q8Rb6RXSzrtegtho+NokLnmfow4grWm4AK
         EbuGJyFnu0b8KxALp6UTO/N45UTMyJj7O09pqWDAwdoWifDOn4ENL8xRBoo7OquN7b0b
         SOgQOEdYmTDOOZ+Uhy9dZHWae23MnS24kqyLQWI5qv/FSI0+mOYiChmQowktHKg8pOUO
         XU1VnqrHDrohvK98MKeygP1n+HRaSQFf0GsmekC7yNn5LIuPTtHVPYlX2Itxq+aGDC9x
         GD4g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TACnGfn3;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=YeqZflyb;
       spf=pass (google.com: domain of kernel-hardening-return-12783-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12783-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TACnGfn3;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=YeqZflyb;
       spf=pass (google.com: domain of kernel-hardening-return-12783-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12783-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180327160342.e2bc9a15afda5823c8daf4fb@linux-foundation.org>
References: <20180327213609.GA2964@beast> <20180327160342.e2bc9a15afda5823c8daf4fb@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Mar 2018 14:22:31 -1000
X-Google-Sender-Auth: abZPuoaTG5JCSEHWewmMBtTJQPA
Message-ID: <CA+55aFzi0aUGuxDOwj1HkrP6r2Df2jk5F0HDTOQCG6_eeytbYw@mail.gmail.com>
Subject: Re: [PATCH] task_struct: Only use anon struct under randstruct plugin
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596128328848013628?=
X-GMAIL-MSGID: =?utf-8?q?1596138792068222129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 1:03 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> Why?  What caused this padding?  It happens in all configs?

I assume what happens is that the anonymous struct ends up containing
fields that are cacheline-aligned, and then the whole anonymous struct
is cacheline-aligned.

Which is all kinds of stupid, since the anonymous struct itself does
not exist outside of the outer struct. So it would be entirely
sufficient to just make the outer struct cacheline aligned (like it
used to be), but not align the inner anonymous one - just the fields
in it.

But there may be "reasons" why the inner anonymous  one needs to be
aligned. Maybe it's some standards requirement, or maybe it's just an
internal gcc implementation detail.

Regardless, it's a bit sad. It also means that when randomization is
on, that unnecessary padding will be there.

I wonder if there is some acceptable trick to avoid it. Maybe the
anonymous struct can be marked as not needing alignment, even if the
fields inside of it would still need to be aligned wrt the outer
struct.

>> Instead,
>> move the anonymous struct to being only used when struct layout
>> randomization is enabled.
>
> So the mysterious 40 byte bloat is still present in this case?

Almost certainly. And the struct randomization will possibly add much
*more* padding elsewhere, since at least some of  our structures are
laid out to try to avoid padding, and then the randomization might be
breaking that.

               Linus
