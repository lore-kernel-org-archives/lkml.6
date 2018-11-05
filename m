Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4E0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F162085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F162085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbeKFGwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:52:49 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:36092 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFGwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:52:49 -0500
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gJmSM-0005kC-3q; Mon, 05 Nov 2018 22:30:46 +0100
Date:   Mon, 5 Nov 2018 22:30:45 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Binderman <dcb314@hotmail.com>
cc:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linux-4.20-rc1/arch/x86/mm/pageattr.c:366: logical error ?
In-Reply-To: <VI1PR08MB3342300DBD63B02DA1E40BD79CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.1811052143320.1659@nanos.tec.linutronix.de>
References: <VI1PR08MB3342300DBD63B02DA1E40BD79CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David,

On Mon, 5 Nov 2018, David Binderman wrote:

> 
> linux-4.20-rc1/arch/x86/mm/pageattr.c:366]: (style) Same expression on both sides of '||' because 'r1_start<=r2_end&&r1_end>=r2_start' and 'r2_start<=r1_end&&r2_end>=r1_start' represent the same value.
>

The compiler is actually right.

The moron who wrote that code obviously thought that checking the same
thing twice makes sure that the result is more correct. :)

> Source code is
> 
> static bool overlaps(unsigned long r1_start, unsigned long r1_end,
>                      unsigned long r2_start, unsigned long r2_end)
> {
>         return (r1_start <= r2_end && r1_end >= r2_start) ||
>                 (r2_start <= r1_end && r2_end >= r1_start);
> }
> 
> Maybe better code
> 
> static bool overlaps(unsigned long r1_start, unsigned long r1_end,
>                      unsigned long r2_start, unsigned long r2_end)
> {
>         /* r1_start inside r2_start .. r2_end
>             or r1_end inside r2_start .. r2_end
>           */
>         return (r1_start >= r2_start && r1_start <= r2_end) ||
>                 (r1_end >= r2_start && r1_end <= r2_end);
> }

That maybe better code fails with these ranges:

r1 0x0100 - 0x01ff
r2 0x0110 - 0x011f

It claims that there is no overlap between the two ranges. I leave it to
you to figure out why it fails.

But the function which the compiler complains about is actually correct for
all variants of input pairs.

It's just having the same condition twice. The second part after the || is
just the reverse expressed, but identical variant of the first.

So the obvious solution is to remove that redundant part.

Thanks,

	tglx
