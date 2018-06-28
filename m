Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D867C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A871727161
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="igwJWOfq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A871727161
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935095AbeF1JZQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:25:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53164 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935016AbeF1JZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MHURYBeQVeoBPbObVLSYcO/S6E2cSgoicvv6fj2+D0E=; b=igwJWOfqW6fZAREOPe3F0OorP
        hUW3vmGDEaXrUC16MNfIvMBm7gMBfpBErraIlc4GmKEydnCSZqNTRB0XbPsVMRh+q5lFNrK4a18IY
        WScqX90kaHQO5uNvZFYTIANVo8dt7Lc8zPIzciNMDVTDDynDm0nUPxGTpfDpUniij6N2e6tixd2Qh
        IMsnYzUno/KWGQAFanQh/h3CPc8FDUqpLlpZuFIwBHCgFh1bgvGYcJKBkkd9+olv4JxjHs2zBDK0I
        ulWpXcZY/59IxAUDC3v/r60Ua86Y7ly0Vrzbogf2blFueoWUtxKWUQc1nfyBSX8aWFrYGNHW5wX+e
        ejweBnX4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYTAo-0002yp-4A; Thu, 28 Jun 2018 09:25:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 904982029F1D5; Thu, 28 Jun 2018 11:25:04 +0200 (CEST)
Date:   Thu, 28 Jun 2018 11:25:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/5] kernel/jump_label: implement generic support for
 relative references
Message-ID: <20180628092504.GC2494@hirez.programming.kicks-ass.net>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
 <20180627160604.8154-3-ard.biesheuvel@linaro.org>
 <20180628085003.GA2494@hirez.programming.kicks-ass.net>
 <CAKv+Gu87DmGLG7N8X8+V7LppXm72SJUmCcEpaehCE5Rt0Z4FNw@mail.gmail.com>
 <CAKv+Gu-xPR6UEiP0NT0zYXKRYXqwFCXP=nf0cC87PZdDYBZB4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-xPR6UEiP0NT0zYXKRYXqwFCXP=nf0cC87PZdDYBZB4A@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 11:04:45AM +0200, Ard Biesheuvel wrote:
> On 28 June 2018 at 11:02, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >>> @@ -56,7 +72,9 @@ jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
> >>>
> >>>       size = (((unsigned long)stop - (unsigned long)start)
> >>>                                       / sizeof(struct jump_entry));
> >>> -     sort(start, size, sizeof(struct jump_entry), jump_label_cmp, NULL);
> >>> +     sort(start, size, sizeof(struct jump_entry), jump_label_cmp,
> >>> +          IS_ENABLED(CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE) ? jump_label_swap
> >>> +                                                           : NULL);
> >>>  }
> >>
> >> That will result in jump_label_swap being an unused symbol for some
> >> compile options.
> >
> > No, and isn't that the point of IS_ENABLED()? The compiler sees a
> > reference to jump_label_swap(), so it won't complain about it being
> > unused.

Ah, ok. I hadn't figured it was quite that smart about it.

> > Meh. I thought IS_ENABLED() was preferred over #ifdef, no?

Dunno, I just reacted to the proposed code's uglyness :-)

> ... and it means the sort() routine will unconditionally perform an
> indirect function call even if the arch does not require it.

Yeah, not sure I care about that here, this is a one time affair, very
far away from any fast paths.

