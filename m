Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6D0C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B3B21848
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="EmdFrLU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfA2PZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:25:10 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56442 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfA2PZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:25:09 -0500
Received: from zn.tnic (p200300EC2BCC54006D3D030A08A1426E.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:5400:6d3d:30a:8a1:426e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0C3C21EC03D8;
        Tue, 29 Jan 2019 16:25:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548775508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TP6+d2no+eIDbqN062CASqwgZolZNT+F4QuSiSVUOjg=;
        b=EmdFrLU9pBLeWltiMB/8UZ5nt1AR6x7KMyqtStOrKmMT+FTaoNQtMteeXqZR0Q79kfSXuR
        H2J2jRzZkGt+9RZybxofGHChAwLdf8BkvdJc8Nh40lEIJs0eUAmEPIyNMQ5ZUGzrB/8wvv
        Vpfkk2w6CG5+1OmA9KKoMUm4e/4SMUg=
Date:   Tue, 29 Jan 2019 16:25:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/events: Mark expected switch fall-throughs
Message-ID: <20190129152500.GA25706@zn.tnic>
References: <20190125184917.GA7289@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190125184917.GA7289@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 12:49:17PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> In file included from arch/x86/events/intel/core.c:22:
> arch/x86/events/intel/core.c: In function ‘intel_pmu_init’:
> arch/x86/events/intel/../perf_event.h:668:17: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   x86_pmu.quirks = &__quirk;     \
>   ~~~~~~~~~~~~~~~^~~~~~~~~~
> arch/x86/events/intel/core.c:4170:3: note: in expansion of macro ‘x86_add_quirk’
>    x86_add_quirk(intel_clovertown_quirk);
>    ^~~~~~~~~~~~~
> arch/x86/events/intel/core.c:4171:2: note: here
>   case INTEL_FAM6_CORE2_MEROM_L:
>   ^~~~
> arch/x86/events/intel/lbr.c:929:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enabling -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  arch/x86/events/intel/core.c | 2 ++
>  arch/x86/events/intel/lbr.c  | 1 +
>  2 files changed, 3 insertions(+)

You do know how to use scripts/get_maintainer.pl, right?

Because I don't see PeterZ on CC.

Please use that script when preparing patches.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
