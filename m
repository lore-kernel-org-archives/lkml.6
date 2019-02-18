Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8B4C10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D2E2184A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DsbETMis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387926AbfBRPx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:53:57 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37676 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbfBRPx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:53:57 -0500
Received: by mail-qk1-f193.google.com with SMTP id m9so10226153qkl.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 07:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=92e/VznH5XQ4jHrphTiBJuS311THvP1Iy46wzOErUls=;
        b=DsbETMist337QY5KKYKHkpzezMciT+GLylX1erdZoBCKWX4nvmz61RYdb7Szq86sRq
         75GGfxI2YcpFrI+AW7/ebgWdxJKsaF/Rd0NIrBzedSxh/F2at05G45HzaYKPpIZTSICC
         v9Nw6rOudP5/g0fma1ixw15BHIMXSsCWeIkfP6wXvMwszvQxJby3D6t029qhHMmkFGBK
         /B8dxtPMcZs2XfBRVjqa6KKPdsbsD8Ey0yyKLlvCjuMnzVINxK6yyX9KBdLIL+MY14Ox
         Sf8e1eSRKjCo7CJ/UyHL6pFcvMbM9dlAwoCQiS3/0lY9aJKgAw6mfoYgW8CKLkRH6qbJ
         0ZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=92e/VznH5XQ4jHrphTiBJuS311THvP1Iy46wzOErUls=;
        b=pOJfNJO1eYZX4BjWvKaYQqdx0L5VKzPdd02WEzWEr8euAH/Cv0fp0U2AjE/i4JAVZ8
         JR2p6wMin+ynCOUiyhPStlKAxpiH0nT33d1m88NajgbYjESTt3uVnQAjtrZgFg4ysjuJ
         ES16JWeKVbneb+f+PcBDdocjjU6SQChCynbscK+puPuUgzgu3Uif1bOYNo8WDXb6ok/D
         L+ImrkFnmKlruZPyNDi5PbbI4yHH9MyQt9MIvRsYWSAnVrCwvfVB7xGGCKnSAT+AcCpt
         Gbn/FwBFMFdHZNdquWkm+UbswwaNFeaoIJBlVztZwiB5KOd+w2ou8ugpfSX3km+ASBCm
         ZsaA==
X-Gm-Message-State: AHQUAuapl7Z4SUwWCErTFp0niUQBwIP2UwytCP4tfN7zWERjZs0edpPw
        zTkgktVtr/s4Q/Fn9nj4pFJ1ENjsnG4=
X-Google-Smtp-Source: AHgI3IZLkBNNpsUQecN0Y1ZnuWfF04xr+lqzQJYkbkrq3vrOP3KcGPWjfd7022Qxx+aKpuo93OXLaQ==
X-Received: by 2002:a37:9201:: with SMTP id u1mr17606536qkd.258.1550505236132;
        Mon, 18 Feb 2019 07:53:56 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 50sm1038107qtr.96.2019.02.18.07.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 07:53:55 -0800 (PST)
Subject: Re: [PATCH] trace: skip hwasan
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190217043434.46233-1-cai@lca.pw>
 <CAAeHK+y8Xd1J2DppUMQLVhoc69wrqgNA=9hV45Jsd7V97CN6yw@mail.gmail.com>
From:   Qian Cai <cai@lca.pw>
Message-ID: <dddc0e6e-af71-c98c-c8db-20c6d9fa87c3@lca.pw>
Date:   Mon, 18 Feb 2019 10:53:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAAeHK+y8Xd1J2DppUMQLVhoc69wrqgNA=9hV45Jsd7V97CN6yw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/19 10:25 AM, Andrey Konovalov wrote:
> On Sun, Feb 17, 2019 at 5:34 AM Qian Cai <cai@lca.pw> wrote:
>>
>> Enabling function tracer with CONFIG_KASAN_SW_TAGS=y (hwasan) tracer
>> causes the whole system frozen on ThunderX2 systems with 256 CPUs,
>> because there is a burst of too much pointer access, and then KASAN will
>> dereference each byte of the shadow address for the tag checking which
>> will kill all the CPUs.
> 
> Hi Qian,
> 
> Could you check if adding "CFLAGS_REMOVE_tags.o = -pg" into
> mm/kasan/Makefile helps with that?

Yes, you nailed it!
