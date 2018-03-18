Return-Path: <kernel-hardening-return-12693-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELssfWq8AV/CL26DlAoUMZKYeY6miSKSXW40keLHncZEZXZpAeN+E30pwNci5QBaKPh00HJY
ARC-Seal: i=1; a=rsa-sha256; t=1521407630; cv=none;
        d=google.com; s=arc-20160816;
        b=XpKRU70bwiwrpAsUUSoml39Kgm+iAJ4h2GEkQ4F0zz9YL5R2Oy7EiCWTa31lp61920
         gUep3TN3LztzcxQyi3bCLXdjJaSyHIlt0YjYno0VRYbGxJOL2m1n4XJD75jqP/fjeaQ5
         GVvYJ7EzbyZ6fZb736z+RWW81myQ/bi8Y8xud6RhhUGyT2Yinh29SDnzssfryyRjP4w1
         o/Ulo1HH+Sx/AKzP60KTOlbB2HIdiWvrcGfS0aiS1tBtN76y+cgj4teBIbHMwejI47BC
         ZJg9oj9YSfuWrbA+i0xcFgM3RwOwgVDC7Kvv6WL7wpYFZBfPkcTRvRkQ/DpGV9zL7NsV
         0pUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=9rij1HjYbCVwhDDnJiidP7Z+G1WLgSilLi2QdoJiobU=;
        b=MDu2L0ikMN/UFDrF5PtZ3XwuipkhJWNAvrtyt53BtknLnbq2wlnRusRTy0avVCrZwg
         tVc7Tfq9Kny+XJkfqOT6gdXY2iXcWbyPOuddl1kOKwxOvuoxb4hBQ8y4MAGkoa87T61Y
         M9RMzndNXXXgPb8P0ZOipebB1AtB240/cXcnWRCtJLT8H0d9HLixgTHPMhmAnfmWVudo
         0JsJRpPeA+blmJQ1yLv9xad6WRs7kfQYCnt/EYfEowgelvspfSll/E8wf4JNyXzl48ND
         abrhmsy2KWh6g7u0FQb8ZqCASwRjRXyQ0zw91/tUj2HO79bpWjmoU0cb64Ml4YbutyXC
         jpfg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@rasmusvillemoes.dk header.s=google header.b=E/heuBlP;
       spf=pass (google.com: domain of kernel-hardening-return-12693-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12693-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@rasmusvillemoes.dk header.s=google header.b=E/heuBlP;
       spf=pass (google.com: domain of kernel-hardening-return-12693-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12693-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH v5 0/2] Remove false-positive VLAs when using max()
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Florian Weimer <fweimer@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Randy Dunlap <rdunlap@infradead.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, David Laight <David.Laight@aculab.com>,
 Ian Abbott <abbotti@mev.co.uk>, linux-input <linux-input@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com>
 <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
 <20180316175502.GE30522@ZenIV.linux.org.uk>
 <CA+55aFzsrVF7W+YQye=EeF4Wk3yDOTbb_vSiM8s1zkKbE4JV4Q@mail.gmail.com>
 <CAGXu5jJmAAgaq3VCsUN2yjpHLSc7P-kNrM_4c4cqP=ysFcETXA@mail.gmail.com>
 <CA+55aFwv0VC67cx2W9yrf7qSFKf6ncVRrsVyLGqdmfSBn4yTYw@mail.gmail.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <42b4342b-aefc-a16a-0d43-9f9c0d63ba7a@rasmusvillemoes.dk>
Date: Sun, 18 Mar 2018 22:13:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFwv0VC67cx2W9yrf7qSFKf6ncVRrsVyLGqdmfSBn4yTYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595311526970331271?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-17 19:52, Linus Torvalds wrote:
> On Sat, Mar 17, 2018 at 12:27 AM, Kees Cook <keescook@chromium.org> wrote:
>>
>> Unfortunately my 4.4 test fails quickly:
>>
>> ./include/linux/jiffies.h: In function ‘jiffies_delta_to_clock_t’:
>> ./include/linux/jiffies.h:444: error: first argument to
>> ‘__builtin_choose_expr’ not a constant
> 
> Ok, so it really looks like that same "__builtin_constant_p() doesn't
> return a constant".
> 
> Which is really odd, but there you have it.

Not really. We do rely on builtin_constant_p not being folded too
quickly to a 0/1 answer, so that gcc still generates good code even if
the argument is only known to be constant at a late(r) optimization
stage (through inlining and all). So unlike types_compatible_p, which
can obviously be answered early during parsing, builtin_constant_p is
most of the time a yes/no/maybe/it's complicated thing. Sure, when the
argument is just a literal or perhaps even any kind of ICE, gcc can fold
it to "yes", and I think it does (though the details of when and if gcc
does that can obviously be very version-dependent, which may be some of
what we've seen). But when it's not that obvious, gcc leaves it in the
undetermined state. That's not good enough for builtin_choose_expr,
because even the type of the resulting expression depends on that first
argument, so that really must be resolved early.

So to have some kind of builtin_constant_p control a
builtin_choose_expr, it would need to be a "builtin_ice_p" or
"builtin_obviously_constant_p" that would always be folded to 0/1 as
part of evaluating ICEs.

So I don't think there's any way around creating a separate macro for
use with compile-time constants.

Rasmus
