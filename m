Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C728C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353F12086C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ha8L66yw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbeLPKAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 05:00:52 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38624 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbeLPKAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 05:00:51 -0500
Received: from zn.tnic (p200300EC2BE55900ADD97DAFC8659476.dip0.t-ipconnect.de [IPv6:2003:ec:2be5:5900:add9:7daf:c865:9476])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 516511EC08EA;
        Sun, 16 Dec 2018 11:00:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544954449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=F8+TUey/ytxI19iM8zL0+5+Rr2XsXpiUFkCYVnzJ90U=;
        b=ha8L66yw5VpMwbNAgKL3xwS5DBFy6rwv1yrK/sx4x7CLAs42VT29+uRdXc4ZF36kzGOvNg
        lY/z+5vSTLs3UOqoZjL8n/6lyxuWfLAq3atEY/5t6LKSoEtviTtVRquLmTqEcPjvLrypO3
        95YHdIMWkONsvGuefONZZpXXtQatlP4=
Date:   Sun, 16 Dec 2018 11:00:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nadav Amit <namit@vmware.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Richard Biener <rguenther@suse.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Alok Kataria <akataria@vmware.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH] kbuild, x86: revert macros in extended asm workarounds
Message-ID: <20181216100042.GA815@zn.tnic>
References: <1544692661-9455-1-git-send-email-yamada.masahiro@socionext.com>
 <20181213105146.GH5289@hirez.programming.kicks-ass.net>
 <CAK7LNASB=HvU8DwUQQkz_r3sY1DN8Vv-qfNa54-ZDXSpfvEYpg@mail.gmail.com>
 <07BE39B2-1F99-4AE4-97F3-0871A39C5E7D@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07BE39B2-1F99-4AE4-97F3-0871A39C5E7D@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 02:33:39AM +0000, Nadav Amit wrote:
> In general, I think that from the start it was clear that the motivation for
> the patch-set is not just performance and also better code. For example, I
> see no reason to revert the PV-changes or the lock-prefix changes that
> improved the code readability.

One thing that has caught my eye with the asm macros, which actually
decreases readability, is that I can't see the macro properly expanded
when I do

make <filename>.s

For example, I get

#APP
# 164 "./arch/x86/include/asm/cpufeature.h" 1
        STATIC_CPU_HAS bitnum=$8 cap_byte="boot_cpu_data+35(%rip)" feature=123 t_yes=.L75 t_no=.L78 always=117  #, MEM[(const char *)&boot_cpu_data + 35B],,,,
# 0 "" 2
        .loc 11 164 2 view .LVU480
#NO_APP

but I'd like to see the actual asm as it is really helpful when hacking
on inline asm stuff. And I haven't found a way to make gcc expand asm
macros in .s output.

Now, assuming the gcc inline patch will be backported to gcc8, I think
we should be covered on all modern distros going forward. So I think we
should revert at least the more complex macros.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
