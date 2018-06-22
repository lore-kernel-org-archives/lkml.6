Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33366C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7DE246D9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7DE246D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934068AbeFVRoC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:44:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58926 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932973AbeFVRoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:44:01 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UXTxjJ_I_wwg; Fri, 22 Jun 2018 19:44:00 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCF3400329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:3400:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 237301EC0136;
        Fri, 22 Jun 2018 19:44:00 +0200 (CEST)
Date:   Fri, 22 Jun 2018 19:43:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH REBASED RESEND] x86/cpu: Move early cpu initialization
 into a separate translation unit
Message-ID: <20180622174359.GD1882@zn.tnic>
References: <20180612103657.18041-1-kirill.shutemov@linux.intel.com>
 <alpine.DEB.2.21.1806221603150.2402@nanos.tec.linutronix.de>
 <20180622151446.lqqmk6nkzzkb6lew@black.fi.intel.com>
 <alpine.DEB.2.21.1806221720500.2402@nanos.tec.linutronix.de>
 <20180622155824.npfinfnpidplufad@black.fi.intel.com>
 <alpine.DEB.2.21.1806221809070.2402@nanos.tec.linutronix.de>
 <20180622163635.GO2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1806221848030.1589@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806221848030.1589@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 06:50:56PM +0200, Thomas Gleixner wrote:
> > The magic, which I cut out, will rewrite the "jmp 6f, nops" thing to
> > "jmp %l[y_{yes,no}]" at the alternative patching and we'll loose the
> > dynamic test, pinning the condition forever more.
> 
> Hrm. Memory seems have to tricked me. So yes, it should work then.

Yes, but do verify that it does still. Because depending on how early
you call it, boot_cpu_data.x86_capability might not be populated
properly yet and then the dynamic case is wrong too. So check the order
pls.

> Though I still prefer the two liners fixup of the cpu_init() section
> mismatch thingy for now over the whole code move. Especially since Borislav
> and I have plans to rework that insanity completely once the speculative
> distractions are subsiding.

Hell yeah.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
