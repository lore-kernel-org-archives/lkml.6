Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE38BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFC221104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFC221104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeK3I1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:27:17 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34937 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbeK3I1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:27:16 -0500
Received: by mail-qk1-f195.google.com with SMTP id w204so1981047qka.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 13:20:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9Rfb+lVN7i/hvB6AzWSnntwOaRyBCSxdJ7uGmruUMo=;
        b=n0QlC2EGnWIXIN+MVw+evz+6ZNpKePnrvgQbv3h/ihlrAoHx+hukE+v8LY6dGiqG9U
         8JS4Ggos3wDjE65QqjMvNQYmRyMPSBQAGpZbFm986+UBqVDdiwMDBLqmVr0tBwQmYCeW
         NNJPrrfKVIkFomb7EPhHWPGulZn1WRtbUcWrs0Xl2O0yIWtVoGM6pnxi9p7Gs6sQux6+
         SryS7EdYEKC0AwZzrpxTyxJIFYyzzJmXx7WI9H05a8nPuixmHityzFbt8USQ/hj+fkXL
         euA0DcNpXdezPzoy1ncwxz5ZKs/P9h2EbqBf9XViqqP8q1fyERtvaHdBpktMNGEMPIEM
         zaCQ==
X-Gm-Message-State: AA+aEWarQgkeJp/35ZJMibxPchKL4jc9A7IIAANpmkumUUaPd7BIInAe
        nXsQX57Uu0kFyr1BdU37dcw/RyLYd5WtcAActtA=
X-Google-Smtp-Source: AFSGD/UzofXfz9egDXryzp3T0lAGPTgnfoAWOfA+gNJXAVs8RI9CQE3QOSK/MXJAa2JlO514cu8np37cXAGukYZNuOw=
X-Received: by 2002:a37:a3c6:: with SMTP id m189mr2931663qke.173.1543526429418;
 Thu, 29 Nov 2018 13:20:29 -0800 (PST)
MIME-Version: 1.0
References: <19fb2e394afcb073bbc109e432417fbbc03323f6.1543499759.git.joabreu@synopsys.com>
 <ff1e11923e92405d883474d715008c0a@AcuMS.aculab.com> <89122bd8-bca2-2ae1-0dd0-160abbebcace@synopsys.com>
 <d2d133e5-267c-c42a-7329-22892bbbdee4@synopsys.com>
In-Reply-To: <d2d133e5-267c-c42a-7329-22892bbbdee4@synopsys.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 29 Nov 2018 22:20:11 +0100
Message-ID: <CAK8P3a2U3ft3crF2SiAuc=PQdDooEUaVAN9gQDyxsxvBn5+xRw@mail.gmail.com>
Subject: Re: [PATCH v2] ARC: io.h: Implement reads{x}()/writes{x}()
To:     jose.abreu@synopsys.com
Cc:     David Laight <David.Laight@aculab.com>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        alexey.brodkin@synopsys.com, Joao Pinto <joao.pinto@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 5:14 PM Jose Abreu <jose.abreu@synopsys.com> wrote:

> --->8--
> static noinline void test_readsl(char *buf, int len)
> {
>         readsl(0xdeadbeef, buf, len);
> }
> --->8---
>
> And the disassembly:
> --->8---
> 00000e88 <test_readsl>:
>  e88:    breq.dr1,0,eac <0xeac>        /* if (count) */
>  e8c:    and r2,r0,3
>
>  e90:    mov_s lp_count,r1            /* r1 = count */
>  e92:    brne r2,0,eb0 <0xeb0>        /* if (bptr % ((t) / 8)) */
>
>  e96:    sub r0,r0,4
>  e9a:    nop_s
>
>  e9c:    lp eac <0xeac>                /* first loop */
>  ea0:    ld r2,[0xdeadbeef]
>  ea8:    st.a r2,[r0,4]
>  eac:    j_s [blink]
>  eae:    nop_s
>
>  eb0:    lp ed6 <0xed6>                /* second loop */
>  eb4:    ld r2,[0xdeadbeef]
>  ebc:    lsr r5,r2,8
>  ec0:    lsr r4,r2,16
>  ec4:    lsr r3,r2,24
>  ec8:    stb_s r2,[r0,0]
>  eca:    stb r5,[r0,1]
>  ece:    stb r4,[r0,2]
>  ed2:    stb_s r3,[r0,3]
>  ed4:    add_s r0,r0,4
>  ed6:    j_s [blink]
>
> --->8---
>
> See how the if condition added in this version is checked in
> <test_readsl+0xe92> and then it takes two different loops.

This looks good to me. I wonder what the result is for CPUs
that /do/ support unaligned accesses. Normally put_unaligned()
should fall back to a simple store in that case, but I'm not
sure it can fold the two stores back into one and skip the
alignment check. Probably not worth overoptimizing for that
case (the MMIO access latency should be much higher than
anything you could gain here), but I'm still curious about
how well our get/put_unaligned macros work.

       Arnd
