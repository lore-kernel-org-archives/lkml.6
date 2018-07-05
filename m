Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB41C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD1E24192
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldGpOKqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD1E24192
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753363AbeGEHVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 03:21:39 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:54436 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753172AbeGEHVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 03:21:35 -0400
Received: by mail-wm0-f50.google.com with SMTP id i139-v6so9195141wmf.4;
        Thu, 05 Jul 2018 00:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MFwvfd9B6uyq9+CAIJGVH0iY1Ew777Hv/VhE5ZSDRgk=;
        b=ldGpOKqFspxxemifysGMKwAN2fRz0xs320lk9ZAutZhhUINjjgCOUNM72rV6DkLs2v
         6S3nE6UgT83ybmUuxqdOY5mgEbYVfSCMg//fB7yThwXulSZGCMDCa/GGmXQ78Fxmx4IP
         TeF3KezdA6MOnqXVOurVYYmyZ/tmlhBNQTHOGndfinePG2XDEXn+aW4Yua/7xnIDWd77
         FFd7HkgwROqekOssf/4C7cwmXl6XIVNYlEw3SS169z/MZpiZN5ETlozWO1+8VVl1AGLc
         9EKAu9k/4n/96fUMUlbUxXMB5R/Z9l8dfhkvHfiEarjrYTBp/DstE9uUvUTJ/O+A6eHh
         ReBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MFwvfd9B6uyq9+CAIJGVH0iY1Ew777Hv/VhE5ZSDRgk=;
        b=Cf761eeJFt0TKa5DYJgIarcZ3tEcuE0xNeXqOHIurKVhfjh155NM+1Hcv8CVArq/7R
         JS8Ff/5g5r1WLRTmTyhLepYmPDo3Jkh6vB9xYd3W334LhTh4lSLCItSYlD0YXCX/B64u
         WxxfRkbTonill+msQCpHbO/s9ed8nXb6F9HaZVqVjtjSeulPa+57GzkaGa64c2f80T5B
         dh+VTQ7SIIrCFm6r9k+rd/ONjesrHwKqx1EnLy+aRcdKlYl15YxTizrqr8MBvB16cA6h
         iUhP4feH3HNL9FIIXM1IiPdwLUp9WD4JBSZxQW2AxJ0s1eoLSCLsqPS1cl/6wLqBLqQX
         oIvA==
X-Gm-Message-State: APt69E2K0cWBnpr1giiBjlTbCMkfdomftcYHMKv7Y/rmVjLItNFreAh6
        huZWuo86kdSMTpzdRMZIVvo=
X-Google-Smtp-Source: AAOMgpdVaNXss2W6D51/MW3PGpsxRHYz8bbiUvzA75K4SkvLz7l1GHALSet4Aap8Ad5yPxsRT91BWg==
X-Received: by 2002:a5d:528f:: with SMTP id c15-v6mr3603718wrv.102.1530775293723;
        Thu, 05 Jul 2018 00:21:33 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s17-v6sm4050217wmc.34.2018.07.05.00.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 00:21:33 -0700 (PDT)
Date:   Thu, 5 Jul 2018 09:21:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        syzbot+a4eb8c7766952a1ca872@syzkaller.appspotmail.com,
        Alexei Starovoitov <ast@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, X86 ML <x86@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Rik van Riel <riel@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: set_memory_* (was: Re: BUG: unable to handle kernel paging
 request in bpf_int_jit_compile)
Message-ID: <20180705072130.GA4534@gmail.com>
References: <000000000000d48c8e056f5b6c67@google.com>
 <alpine.DEB.2.21.1806240849150.8650@nanos.tec.linutronix.de>
 <20180624.161411.1560796210597132716.davem@davemloft.net>
 <20180624100249.GA9493@gmail.com>
 <b4841a84-cf65-f3fb-13b3-ea0a15f47bde@iogearbox.net>
 <CAGXu5jKndtFL7D7T00GmziYaazs7v0t4DWPp_2fdGh2tRnuuEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKndtFL7D7T00GmziYaazs7v0t4DWPp_2fdGh2tRnuuEQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kees Cook <keescook@chromium.org> wrote:

> On Tue, Jun 26, 2018 at 3:53 PM, Daniel Borkmann <daniel@iogearbox.net> wrote:
> > In any case, for pairs like set_memory_ro() + set_memory_rw() that are also used
> > outside of bpf e.g. STRICT_MODULE_RWX and friends which are mostly default these
> > days for some archs, is the choice to not check errors from there by design or from
> > historical context that it originated from 'debugging code' in that sense (DEBUG_RODATA /
> > DEBUG_SET_MODULE_RONX) earlier? Also if no-one checks for errors (and if that would
> > infact be the recommendation it is agreed upon) should the API be changed to void,
> > or generally should actual error checking occur on these + potential rollback; but
> > then question is what about restoring part from prior set_memory_ro() via set_memory_rw()?
> > Kees/others, do you happen to have some more context on recommended use around this
> > by any chance? (Would probably also help if we add some doc around assumptions into
> > include/linux/set_memory.h for future users.)
> 
> If set_memory_* can fail, I think it needs to be __must_check, and all
> the callers need to deal with it gracefully. Those markings aren't
> "advisory": they're expected to actually do what they say.

Yes - but there's probably a few exceptions like early init code where the calls 
not succeeding are signs of bugs - so any error return should probably be 
WARN_ON()ed about.

Thanks,

	Ingo
