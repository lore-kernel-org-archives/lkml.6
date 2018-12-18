Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF99DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B552720874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbeLRJHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:07:40 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40216 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbeLRJHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:07:40 -0500
Received: by mail-qt1-f196.google.com with SMTP id k12so17326178qtf.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 01:07:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJchzieKvEw2q1jiD8rRlxKTlS2uWfldtdARgrlnAhI=;
        b=Um6SR2Y3og2A9fBCtxXjjvai7NJo2oDk2q+P8FQ+eTGd+NJnz3OjhihwuTFTVyWdIU
         TIMl+k9pcniCvHBmA4n1bIDGnosRW4BDKnDqD6QBs3YuQrRI1b1q5t+SN+vGeyeKPN+z
         onh0hWkHcyqkNh6gIejI91DgwHBf+SMneHr+wb8SJIYSahq90iawCCoGxeM/Ws6gwDNC
         /rL7P0QDuQDrjfubwUvYBN1seIuR2huq0BXdVPmBiKnLMQ7nHcH7wL2RxBsxHovgsLAU
         Sz+pbO7mHmr8OWT6JSusrvLuFFbfcUiNIIcL9zG8uH6nwR4EMowLJbvgrr4dV30EdWhr
         l6Sg==
X-Gm-Message-State: AA+aEWZPZQLNOFJD14LBi9UcY1ms6qMlaW2oiriMGuGF9djm9Y8TLLDq
        i4Qm5wePvujMMBFfYrYWYeIzUQ2/hTa1DnjW3xI=
X-Google-Smtp-Source: AFSGD/VJ5OS7xGiWkpkncCzaZ7+vZyd8T37eKvY6Ai39wmaQ9C9l13wtX94ZlX9DDuSrKBIEL0vqlT8q5If0F5VbO6A=
X-Received: by 2002:a05:6214:1087:: with SMTP id o7mr16475667qvr.115.1545124058264;
 Tue, 18 Dec 2018 01:07:38 -0800 (PST)
MIME-Version: 1.0
References: <20181213122910.24193-1-anders.roxell@linaro.org>
 <20181213122910.24193-2-anders.roxell@linaro.org> <20181213124042.GG10669@sirena.org.uk>
 <CADYN=9KBpcUSaU_P_sZuhin60huQUBUT-H-FedH=fXu7a_7EWQ@mail.gmail.com>
In-Reply-To: <CADYN=9KBpcUSaU_P_sZuhin60huQUBUT-H-FedH=fXu7a_7EWQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 18 Dec 2018 10:07:21 +0100
Message-ID: <CAK8P3a1qn2SOsk_Uo_VDGSkR6OsDkqzm0Rbo+5F5Pc1WA3tJzQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] config: provide a fragment to enable gdb for qemu
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 9:45 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> On Thu, 13 Dec 2018 at 13:40, Mark Brown <broonie@kernel.org> wrote:
> >
> > On Thu, Dec 13, 2018 at 01:29:08PM +0100, Anders Roxell wrote:
> > > Adding a fragment to make it easier to know what options is needed to
> > > build a kernel to get the that you can debug in qemu.
> >
> > > @@ -0,0 +1,7 @@
> > > +# Enable debug info for gdb
> > > +# CONFIG_COMPILE_TEST is not set
> > > +CONFIG_DEBUG_INFO=y
> > > +CONFIG_GDB_SCRIPTS=y
> >
> > Is this specifically for qemu or is this just good for debugging with
> > GDB in general (eg, via JTAG)?
>
> I haven't tried, and I don't have a JTAG so I could test it =/

The DEBUG_INFO=y and (as a dependency for that) CONFIG_COMPILE_TEST
are definitely needed for all GDB operation. I would assume that
the scripts also work with any other gdb environment, but haven't tried either.

For CONFIG_RANDOMIZE_BASE, I'm not actually sure if that helps or
not. I think I originally suggested to Anders to turn that off when he
was analyzing a bug, but I don't know if it helped or if it works just
as well without that.

        Arnd
