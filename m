Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97244C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 13:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F04820665
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 13:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="fCGVPT4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F04820665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeJ1V4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 17:56:52 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:65113 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbeJ1V4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 17:56:52 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w9SDC4cE029992;
        Sun, 28 Oct 2018 22:12:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w9SDC4cE029992
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540732325;
        bh=smKeRRoagZFsLUnBzoYBhOeaRq+9D5NXq69fWsMcRAA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fCGVPT4J754FkkXvWTDS0IYP6cFYNs11rCPnSBOgdTzy8yYn9Y6b6WiZxsiEIPWVe
         viCzOf6z7xkHhjChZDF1hOnBn0ZvNeCquatyP8XnrYO/KRvHz1xRq+R0EGzoPUF8Jy
         JimeifWmKwJrWn3tpGdpZj4l8TCN5x7j7taaAcZ5vq48iQ7tE1CNCpBWXOg0VcJ/9l
         4XP9WjziGDEt/A43iCKZh3Lo0vKWkktOTyVKgObqkn5nzX3TGexjaeaX17Plrq1efH
         rFWOjhuxpwpcDVsCypQjR369CVc4kHG7o7SqtwOGz6vyrbYlXOMjPlfQde1keXiAzD
         wGQFDemVEDv9w==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id g10so2009591uak.5;
        Sun, 28 Oct 2018 06:12:04 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKg2xZ8OSd/iSwvKrjg23iWcmbdzj/2y9pP/QeM1xRF2ZVOUnbt
        xLj4ehLuRmuiWl7CXdFy1RmlR78fL5P8r/0/Y9o=
X-Google-Smtp-Source: AJdET5ejnSvwFTKk92wUXkD3Ajzdss93X8bsgCJkC1qEi8w/O0+kumxw03hZ05wfKETGwj9Njo5NS6cHOyqF0+iCOdE=
X-Received: by 2002:a9f:28c4:: with SMTP id d62mr4366243uad.42.1540732323632;
 Sun, 28 Oct 2018 06:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181019124921.13780-1-changbin.du@gmail.com> <20181019124921.13780-3-changbin.du@gmail.com>
In-Reply-To: <20181019124921.13780-3-changbin.du@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 28 Oct 2018 22:11:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNASAv3OcujS9RssGue-0Nd+zVh+O4jMOOmKQOqdtWWt9Jw@mail.gmail.com>
Message-ID: <CAK7LNASAv3OcujS9RssGue-0Nd+zVh+O4jMOOmKQOqdtWWt9Jw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 9:50 PM Du Changbin <changbin.du@gmail.com> wrote:
>
> This patch add a new kernel hacking option NO_AUTO_INLINE. Selecting
> this option will prevent the compiler from optimizing the kernel by
> auto-inlining functions not marked with the inline keyword.
>
> With this option, only functions explicitly marked with "inline" will
> be inlined. This will allow the function tracer to trace more functions
> because it only traces functions that the compiler has not inlined.
>
> Signed-off-by: Du Changbin <changbin.du@gmail.com>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>


This subject
"kernel hacking: new config NO_AUTO_INLINE to disable compiler
auto-inline optimizations"
is also too long.

Could you please make it a bit shorter?


-- 
Best Regards
Masahiro Yamada
