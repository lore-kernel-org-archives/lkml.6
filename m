Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E2FC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 23:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0652082A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 23:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbzEBTLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0652082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbeKEIzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 03:55:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37786 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbeKEIzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 03:55:44 -0500
Received: by mail-pl1-f195.google.com with SMTP id p6-v6so3501996pll.4;
        Sun, 04 Nov 2018 15:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2b76jeE14kiA/hiCWYGI9qRvEkd0f0ntH5BI3esnAxA=;
        b=lbzEBTLZXs12SkrtobuSNWg/s4ezveoEaNAss0VT8u+owjVnxFf126QB7PP7yWF21+
         hlcV6jFj9siBreYldN5bz6o1zLoQyx6IQ7V5GEC6TKmp2h2SfHU6z9IzYNk/ZSw8wwRr
         8Zuv7dfUCgx4VKWa6SzZuSMQGvgA3D1AhL80ucYhEglL+J9EkatGSyY7dyAAzGIfgxp7
         P09LUV1FZHOwZVxwx5MrtedxpegYgp1tiQakZJG0v9q72UBWGUAeO/f6ddQZPBY4JJ82
         zH5HROy4rTPTbjGV/0xwCr5kAqCIWA5n34p1MHxI6ErbQO4jAvDpf077apYzGh57eiBD
         wZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2b76jeE14kiA/hiCWYGI9qRvEkd0f0ntH5BI3esnAxA=;
        b=MG23ixvMZ1zjj8lehUbxo25f9QGyTsgMnEptv6SQkeyKJ8lIt1NsSiJFEGVUgTabZO
         pdFLbyaPOUOyAE3cuEwQBkJHh34W4CdpEF55rExGTQVB0dxzeoqtVnv4XXmUWMqbt2DE
         G8O8KHiMf3oxBm0F32FaU/7SAHjrRu4Wn26dfcGxSTBW27zGKDEX4FQdu2KR73kemN58
         yCHZ017b0FQOqMavJohxIrzoJyGmxVcedYAprocyCPMz9Bi6FWFhvd87D6jUR3fomfO/
         Ju9RHYqeqwHAwwMQXwpVXDBomfabcaZCaulo8KYaieGKBq+diEDa4CyU59PNptBiRaDU
         VnBw==
X-Gm-Message-State: AGRZ1gJau2TQAQzWNqd6Z5ESOJZXmByv/MrbXfAF8t3yN63GYy8SxDnv
        3LAjya+51FMWAXYoieDDid0=
X-Google-Smtp-Source: AJdET5ef6gNlfoC1fBqdmW7PaAv5M9zb2oBJhNCO1ibGrS/XFn7NnTLuxQK0Cr3YcX3mlsej4Ml17g==
X-Received: by 2002:a17:902:4083:: with SMTP id c3-v6mr20079620pld.181.1541374741048;
        Sun, 04 Nov 2018 15:39:01 -0800 (PST)
Received: from mail.google.com ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id n26-v6sm28466051pfh.166.2018.11.04.15.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 15:39:00 -0800 (PST)
Date:   Sun, 4 Nov 2018 23:38:58 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Changbin Du <changbin.du@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: linux-next: Tree for Oct 31 (vboxguest)
Message-ID: <20181104233857.b4ou3b7doclw2vi2@mail.google.com>
References: <20181031145907.1ee2e866@canb.auug.org.au>
 <661e44c7-396a-6d58-efa7-ed292f2677c6@infradead.org>
 <CAK8P3a3aygFrD3PyZ8P==JzeYamE-x--MWCL54xzXDE_8u_R6Q@mail.gmail.com>
 <CAK7LNATirQwke8tqk5XukhkwKra6mWEXZ3AHcywNcwGFD2-voA@mail.gmail.com>
 <20181101142946.u5luuctqav6fec6k@mail.google.com>
 <CAK7LNAQbBG=KV5Q8o5-JiNCswuse94jECoqT+T+UEY7bLCRPNw@mail.gmail.com>
 <CAK8P3a1w8p8OC-9_0mtMUxEojvyVfXvF8Ka4J7TnoyZ=gr2Fow@mail.gmail.com>
 <CAK7LNAQp2xU_ThE_q3TmoT16cwUjKx=rB9msVB12+Y9FkaQVmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQp2xU_ThE_q3TmoT16cwUjKx=rB9msVB12+Y9FkaQVmw@mail.gmail.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2018 at 11:43:44AM +0900, Masahiro Yamada wrote:
> On Sat, Nov 3, 2018 at 12:55 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On 11/2/18, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> > > On Thu, Nov 1, 2018 at 11:32 PM Changbin Du <changbin.du@gmail.com> wrote:
> > >> On Thu, Nov 01, 2018 at 12:32:48PM +0900, Masahiro Yamada wrote:
> > >
> > > How about clang?
> > >
> > > For clang, -Og might be equivalent to -O1 at this moment, but I am not
> > > sure.
> > >
> > > In my understanding, Clang does not inline functions marked with 'static
> > > inline'
> > > for -Og (or -O1) optimization level.
> > >
> > > Theoretically, 'inline' keyword is a just hint for the compiler, after all.
> >
> > I think this means that we cannot build the kernel in that configuration,
> > at least with CONFIG_OPTIMIZE_INLINING=y. Without that option,
> > every 'inline' becomes 'always_inline'.
> >
> 
> Sorry, I missed that fact.
> 
> 
> At this moment of time, it is OK given the following:
> 
>  - CONFIG_OPTIMIZE_INLINING is defined only for x86
>  - Clang cannot build x86 due to missing asm-goto
> 
> 
> However, Clang with -Og
> does not inline even such simple code like this:
> 
> 
> -----test code------
> static inline int foo(int x)
> {
>         return x;
> }
> 
> int bar(int x)
> {
>         return foo(x);
> }
> -------------------
> 
> 
> 
> $ clang -Og -c -o bar.o  bar.c
> $ objdump -d  bar.o
> bar.o:     file format elf64-x86-64
> 
> 
> Disassembly of section .text:
> 
> 0000000000000000 <bar>:
>    0: eb 0e                jmp    10 <foo>
>    2: 66 2e 0f 1f 84 00 00 nopw   %cs:0x0(%rax,%rax,1)
>    9: 00 00 00
>    c: 0f 1f 40 00          nopl   0x0(%rax)
> 
> 0000000000000010 <foo>:
>   10: 89 f8                mov    %edi,%eax
>   12: c3                    retq
> 
> 
I see. Thanks for your explanation. So I think we should disable
CONFIG_DEBUG_EXPERIENCE for clang. Do you know how to distinguish
different copmilers in Kconfig?

> 
> -- 
> Best Regards
> Masahiro Yamada

-- 
Thanks,
Changbin Du
