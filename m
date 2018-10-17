Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67981ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4D121526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4D121526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbeJQXHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:07:25 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45944 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJQXHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:07:25 -0400
Received: by mail-qk1-f194.google.com with SMTP id m8-v6so16675688qka.12;
        Wed, 17 Oct 2018 08:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKaGTVrDoB3wM70SDy9cZPLZvYt4VflSq8YoDlpWSDE=;
        b=nxFZ6EYLzEan6NUSSIGEyCGTmJExXZi506FPLjpNlVl7Yj+8mOav3CXwbRq9u6jvvf
         lt0pPan2PyBuoq2HofiagZoi93QOJu+S0+vSDYKv6GSQSkpPH6ZYSE4884moFN/6Pdip
         8duHtDNlyuRSfcogiWmkl/uBvl3TpB7O7n5ChSw0JmDU8xPD2YgKbPjhhe4z9mdr4IbF
         ndurbqUTiwkGDXpPlRLJ+L7O8SrRJsA7VbcSsPy7lQJaq2UWKiF2y4L8JHa9p7dClhR9
         oSqoqgfrpXAq8R0+4USB56QIP/0cRB0Cr47wBD5Ih3IkaRLa4Upgg0SRrjIRDHGqgTy0
         0syA==
X-Gm-Message-State: ABuFfogmxIS6MAjk6YoATdy5HUU1jSOWyHwG6uQxQKm4TIY0VWN6R0bx
        TXRXCFVXSPRSyYL6GDC1MRxMMDvjVf73lVIA8PY=
X-Google-Smtp-Source: ACcGV63Ifr8mYTn2NQG6A+s7WdZteIZ35upOrBk3toeSNWS2uLr5aiTnYVuzgYxBBPoWpsNUjUhm+BeJqwYzTbZwXNc=
X-Received: by 2002:a37:38b:: with SMTP id 133-v6mr25029036qkd.173.1539789076799;
 Wed, 17 Oct 2018 08:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <9ae1d1609a49d976ae7659157507018b0c846423.1539655732.git.ren_guo@c-sky.com>
In-Reply-To: <9ae1d1609a49d976ae7659157507018b0c846423.1539655732.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Oct 2018 17:11:00 +0200
Message-ID: <CAK8P3a31sVAMCPXLqyqMpvj-gsxOmuf2qL0bT5crDQo0Wcg__g@mail.gmail.com>
Subject: Re: [PATCH V9 08/21] csky: Process management and Signal
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 5:01 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch adds files related to task_switch, sigcontext, signal,
> fpu context switch.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
> Changelog:
>  - abiv2/fpu.c: Userspace should never be sent NSIGXXX as a si_code.
>    Use FPE_FLTUNK instead.
>  - abiv2/fpu.c: Use force_sig_fault instead.

I'm hesitant to provide a Reviewed-by: tag for this one, as I don't
understand the signal handling enough myself, and it's something
that should be reviewed properly because of the ABI implications.

Maybe someone else can have a closer look at this?

       Arnd
