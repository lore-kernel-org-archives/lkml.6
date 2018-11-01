Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72834C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E399205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QLm6iK3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E399205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeKBEK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 00:10:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41507 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725722AbeKBEK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 00:10:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id c16so14971130lfj.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 12:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sAdyijJANdHXrZS7Rhy3SlpitoiP+F4HljNHFT3Q6h0=;
        b=QLm6iK3yWs27nIzZ2pM2WZg7LUjUDqDg6URDt6pOhlyh7k3cN660A+J6c18S1uCc/y
         tnr/I7p4mnFgSUp1kKhTS23iB5r1GfpvS5afsvW42SSgPiQgKGNAbVhs8EMfYgndu93g
         jrqkQ7wkUdB0OzKlCzqwTIoBCMuuAmFqL5ScE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sAdyijJANdHXrZS7Rhy3SlpitoiP+F4HljNHFT3Q6h0=;
        b=iIBHiIkRyRQlX2HrRqFZaPbQDOonDokPBfVDGBubq+0wJ0DcKUdUT8cbHruH8Xk2aV
         AjByDgdZkd2mrs/tCXjhjhP+gcWPz2gORL2A0exZhcaVJsGXR2z1+aDUe+bZDQhzJfT+
         hLja4bF7sPhv9TEBqWbsZOXv3g2WE1JPjurNNXZohwlsOeayatGth+BEEhn0reSu2gDA
         lFX/97XCphVo7fyisLD54ByI6120oVO89VwP55MuRSl78XXoQr6OWM3cY39eyMAfegJj
         sFkoF9j2Eye+BNznsbPg1nQSFGX4KUBb8ROwOxOqMqUMwY6xQMoLrf5P1ywug7AslSYs
         ShCw==
X-Gm-Message-State: AGRZ1gKyWdTeQQPW7weUczV3LXkXRt8YkTZqrLYaxu8hIuEvvesuVoy7
        SSCMyYQG2PT2iHxD3VCqzZut6x5sVIvsNQ==
X-Google-Smtp-Source: AJdET5d2NXsHn5RvQyzI0YubfU2LxfDr7/UpU/a4/IEmkVOn40hLP1ixxx4F2xaFb1K0Z9gqG/f2Gg==
X-Received: by 2002:a19:db4a:: with SMTP id s71mr5289551lfg.36.1541099199732;
        Thu, 01 Nov 2018 12:06:39 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id p134-v6sm5188886lfd.80.2018.11.01.12.06.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 12:06:38 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id f3-v6so19029764ljk.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 12:06:38 -0700 (PDT)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr5513348ljh.59.1541099197588;
 Thu, 01 Nov 2018 12:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrWdpoDkbZjkucKL91GWpDPG9p=VqYrULade2pFDR7S=GQ@mail.gmail.com>
In-Reply-To: <CALCETrWdpoDkbZjkucKL91GWpDPG9p=VqYrULade2pFDR7S=GQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Nov 2018 12:06:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJhdr3JCnGrMKqL-prxYd__kkAspKVYBO3BYYmq2hu4A@mail.gmail.com>
Message-ID: <CAHk-=wjJhdr3JCnGrMKqL-prxYd__kkAspKVYBO3BYYmq2hu4A@mail.gmail.com>
Subject: Re: RFC: userspace exception fixups
To:     luto@kernel.org
Cc:     dave.hansen@linux.intel.com, sean.j.christopherson@intel.com,
        jethro@fortanix.com, jarkko.sakkinen@linux.intel.com,
        fweimer@redhat.com, linux-api@vger.kernel.org,
        Jann Horn <jannh@google.com>, x86@kernel.org,
        linux-arch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, dalias@libc.org,
        nhorman@redhat.com, npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 10:53 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> There's been some discussion of adding a vDSO entry point to wrap
> EENTER and do something sensible with the exceptions,

I think that's likely the right thing to do, and would be similar to sysenter.

> The basic idea would be to allow libc, or maybe even any library, to
> register a handler that gets a chance to act on an exception caused by
> a user instruction before a signal is delivered.  As a straw-man
> example for how this could work, there could be a new syscall:
>
> long register_exception_handler(void (*handler)(int, siginfo_t *, void *));

I'm not a huge fan of signals, but the above is an abomination.

It has all the problems of signals _and_ then some.

And it in absolutely no way fixes the problem with libraires. In fact,
it arguably makes it much much worse, since now there's only one
single library that can register it.

Yes yes, maybe a library would then expose _another_ interface to
other libraries and act as some kind of dispatch point, but on the
whole the above is just crazy and fundamentally broken.

If you want to register an exception, you need to make it clear

 (a) which _thread_ the exception registration is valid for

 (b) which _range_ the exception registration is valid for

 (c) which _fault_ the exception registration is valid for (page
fault, div-by-zero, whatever)

 (d) which save area (aka stack) and exception handler point.

Note that (b) might be more than just an exception IP range. It might
well be interesting to register the exception by page fault address
(in addition to code range).

If you do something that does all of (a)-(d), and you allow some
limited number of exception registrations, then maybe. Because at that
point, you have something that is actually actively more powerful than
signal handling is.

But your suggested "just register a broken form of signal handling for
a special case" is just wrong. Don't do it.

              Linus
