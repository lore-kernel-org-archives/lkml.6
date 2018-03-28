Return-Path: <kernel-hardening-return-12791-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49J2lROW0h12SIVhZ3Pw+ktbrOSymI5VhEzUaao45XuShCdP4d/x1FRWKhjJz16WmUETG4i
ARC-Seal: i=1; a=rsa-sha256; t=1522231875; cv=none;
        d=google.com; s=arc-20160816;
        b=TGiDxmvDtUiv9Q0+chotqrymLLPofy9rvjI6f0NeG2VyC6ORRE36eS4SzlhLKcxowL
         a4yGMUZDAdfEnsdqzbLnz6Bp00fN3G855SPU2vMfydNW2jqUMaMeAtHxt7hC17BNoX1P
         G1v0qOGslKcPEc9JSy/xUwBwhMM0vGjNqPDeCtYgFJrSMjVFDQUVMIQNl2vZdQxW2mRP
         AtUGRUHviv3VkVzWNgLwkjmAgI/O83Af14FBfWIqP7WTDRXv14O2sa0lwop8UAD8boBe
         PFwE5dJhxflGpWGc0/LDizLL1L+PiV+xu5QFPv4xGIRHBUt3FUvDIz7fzHVYITsd+2EN
         UBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=1kIOyPKCpmKIyEHK60bvt1OitPRY5uXJkftmAxtOQSo=;
        b=zv8Q09toy2gOGknsxYym7INGzn3sqSD6sFvvUSxXWvSTkji66RS4J53oAIxAcy7nuG
         HYrlaXlh4pcqkKdMnM414AFsdaeiHgQkKr8at23jvF/cq4C2Ju2P+wRolcCb0PLkg5Oi
         hf2hP6c8AgizuxvS40Ch1h3W0OlDuy406IJGaSz/DYaebSp7j4Ti8iNUTcGa5NsJO5Yk
         x1Zx5YGQ1WSHs2Q8XMwaZyG+U/ct8C8qii/uXNfzp93USKMWwWrZWd7VfRNbo2ZIjapH
         PARP3vGxpi2kvYL1gsxDAYOel+7VO0ya1GB9tQ+bOb4Nlmz74QG3ll6g7iUjE9UPZDm5
         Z9iA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12791-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12791-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12791-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12791-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 28 Mar 2018 12:10:52 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Kees Cook <keescook@chromium.org>
cc: Andrew Morton <akpm@linux-foundation.org>,
    LKML <linux-kernel@vger.kernel.org>,
    Segher Boessenkool <segher@kernel.crashing.org>,
    Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v2] rslib: Remove VLAs by setting upper bound on nroots
In-Reply-To: <alpine.DEB.2.21.1803281020390.3247@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1803281210040.3247@nanos.tec.linutronix.de>
References: <20180315225919.GA43806@beast> <20180316155950.35fda7c63ec59277ba504201@linux-foundation.org> <CAGXu5jLAqki8oE7AF9BEwLxKzpTOOPsT1imjdSAG_U44uGXJdQ@mail.gmail.com> <CAGXu5j+utmcN_ot-3NJ-8C0onnu8O-DOdbAxVoatzE9UcJ-O4A@mail.gmail.com>
 <20180327164532.796cdd043fece53cd9b56f8f@linux-foundation.org> <CAGXu5j+7cG+BQQLfxSm8xLPzF1de7_+fU-s0R5ZXjfD0jx4c8w@mail.gmail.com> <alpine.DEB.2.21.1803281020390.3247@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595046396754035881?=
X-GMAIL-MSGID: =?utf-8?q?1596175810731942356?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 28 Mar 2018, Thomas Gleixner wrote:
> On Tue, 27 Mar 2018, Kees Cook wrote:
> 
> > > I guess if we put this storage into the rs_control (rather than on the
> > > stack) then we'd have to worry about concurrent uses of it.  It looks
> > > like all the other fields are immutable once it's set up so there might
> > > be such users.  In fact, I suspect there are...
> > 
> > Exactly. :( This is the same conclusion tglx and I came to.
> 
> I think we can lift that and just let all users set up a new rs_control
> from scratch. Takes some time to init the tables, but ....

Bah, no. dm-verity really wants to share them.....
