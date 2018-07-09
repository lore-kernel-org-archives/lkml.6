Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FF7C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF4D2089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF4D2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933542AbeGIPaF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:30:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33038 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933271AbeGIPaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:30:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66BFAED1;
        Mon,  9 Jul 2018 08:30:03 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 546403F589;
        Mon,  9 Jul 2018 08:30:01 -0700 (PDT)
Date:   Mon, 9 Jul 2018 16:29:58 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "greg@kroah.com" <greg@kroah.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>
Subject: Re: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Message-ID: <20180709152958.565weccfaktqauef@lakrids.cambridge.arm.com>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
 <20180709140717.GR2476@hirez.programming.kicks-ass.net>
 <20180709141056.GR2512@hirez.programming.kicks-ass.net>
 <44727d3cebda7bee5b68fb388bd2fecfc6dc7b89.camel@synopsys.com>
 <20180709144925.GU2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709144925.GU2476@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 04:49:25PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 09, 2018 at 02:33:26PM +0000, Alexey Brodkin wrote:
> > > In fact, since alloc_dr() uses kmalloc() to allocate the entire thing,
> > > it is impossible to guarantee a larger alignment than kmalloc does.
> > 
> > Well but 4-bytes [which is critical for atomic64_t] should be much less
> > than a sane cache line length so above should work.
> 
> AFAICT ARCH_KMALLOC_MINALIGN ends up being 4 on x86_32 (it doesn't
> define ARCH_DMA_MINALIGN and doesn't seem to otherwise override the
> thing).

Shouldn't that be 8? AFAICT, __alignof__(unsigned long long) is 8 on
x86_32:

----
[mark@lakrids:~]% cat test.c     
#include <stdio.h>

#define PRINT_TYPE_INFO(t) \
        printf("%10s %5d %5d\n", #t, sizeof(t), __alignof__(t))

int main(int argc, char *argv[])
{
        printf("%10s %5s %5s\n", "TYPE", "SIZE", "ALIGN");
        PRINT_TYPE_INFO(int);
        PRINT_TYPE_INFO(long);
        PRINT_TYPE_INFO(long long);

        return 0;
}
[mark@lakrids:~]% gcc -m32 test.c -o test
[mark@lakrids:~]% ./test 
      TYPE  SIZE ALIGN
       int     4     4
      long     4     4
 long long     8     8
----

Mark.
