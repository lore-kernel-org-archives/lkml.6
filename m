Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727A0C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3241421470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3241421470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbeJDENC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 00:13:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39032 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbeJDENC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 00:13:02 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yJ-7csAtK4wV; Wed,  3 Oct 2018 23:22:55 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC64F00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:4f00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 63F531EC053F;
        Wed,  3 Oct 2018 23:22:55 +0200 (CEST)
Date:   Wed, 3 Oct 2018 23:22:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-mm@kvack.org,
        x86@kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: x86/mm: Found insecure W+X mapping at address (ptrval)/0xc00a0000
Message-ID: <20181003212255.GB28361@zn.tnic>
References: <e75fa739-4bcc-dc30-2606-25d2539d2653@molgen.mpg.de>
 <alpine.DEB.2.21.1809191004580.1468@nanos.tec.linutronix.de>
 <0922cc1b-ed51-06e9-df81-57fd5aa8e7de@molgen.mpg.de>
 <alpine.DEB.2.21.1809210045220.1434@nanos.tec.linutronix.de>
 <c8da5778-3957-2fab-69ea-42f872a5e396@molgen.mpg.de>
 <alpine.DEB.2.21.1809281653270.2004@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809281653270.2004@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 04:55:19PM +0200, Thomas Gleixner wrote:
> Sorry for the delay and thanks for the data. A quick diff did not reveal
> anything obvious. I'll have a closer look and we probably need more (other)
> information to nail that down.

Just a brain dump of what I've found out so far.

Commenting out the init_mem_mapping() call below:

void __init init_mem_mapping(void)
{
        unsigned long end;

	...

        /* the ISA range is always mapped regardless of memory holes */
//      init_memory_mapping(0, ISA_END_ADDRESS);

changes the address the warning reports to:

[    4.392870] x86/mm: Found insecure W+X mapping at address 0xc0000000/0xc0000000

but the machine boots fine otherwise.

Which begs the question: why do we direct-map the ISA range at
PAGE_OFFSET at all? Do we have to have virtual mappings of it at all? I
thought ISA devices don't need that but this is long before my time...

Then, the warning say too:

[    4.399804] x86/mm: Checked W+X mappings: FAILED, 252 W+X pages found.

and there really are 252 pages  (I counted) which are W+X:

---[ Kernel Mapping ]---
0xc0000000-0xc0001000           4K     RW                     x  pte
0xc0001000-0xc0099000         608K     RW                     x  pte
0xc0099000-0xc009a000           4K     ro                     NX pte
0xc009a000-0xc009b000           4K     ro                     x  pte
0xc009b000-0xc009d000           8K     RW                     NX pte
0xc009d000-0xc00a0000          12K     RW                     x  pte
0xc00a0000-0xc00a2000           8K     RW                     x  pte
0xc00a2000-0xc00b8000          88K     RW                     x  pte
0xc00b8000-0xc00c0000          32K     RW                     x  pte
0xc00c0000-0xc00f3000         204K     RW                     x  pte
0xc00f3000-0xc00fc000          36K     RW                     x  pte
0xc00fc000-0xc00fd000           4K     RW                     x  pte
0xc00fd000-0xc0100000          12K     RW                     x  pte
...

but I can't find where those guys appear from. Will be adding more debug
printks to track it down.

Anyway, just a dump of the current state...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
