Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B28C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B2F217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbfBRPXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:23:53 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33244 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729977AbfBRPXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:23:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14442A78;
        Mon, 18 Feb 2019 07:23:37 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2E1C3F675;
        Mon, 18 Feb 2019 07:23:23 -0800 (PST)
Subject: Re: [PATCH 06/13] mm: pagewalk: Add 'depth' parameter to pte_hole
To:     Mark Rutland <Mark.Rutland@arm.com>
Cc:     "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <James.Morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-7-steven.price@arm.com>
 <20190218112350.GE8036@lakrids.cambridge.arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <7b0c6eed-102e-ff79-0f65-16bcec043a09@arm.com>
Date:   Mon, 18 Feb 2019 15:23:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190218112350.GE8036@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2019 11:23, Mark Rutland wrote:
> On Fri, Feb 15, 2019 at 05:02:27PM +0000, Steven Price wrote:
>> +/* If the p4ds are actually just pgds then we should report a depth
>> + * of 0 not 1 (as a missing entry is really a missing pgd
>> + */
> 
> Nit: comment style violation. This should look like:
> should be:
> 
> /*
>  * If the p4ds are actually just pgds then we should report a depth
>  * of 0 not 1 (as a missing entry is really a missing pgd
>  */
> 
>> +int depth = (PTRS_PER_P4D == 1)?0:1;
> 
> Nit: the ternary should have spacing.
> 
> We don't seem to do this at any other level that could be folded, so why
> does p4d need special care?
> 
> For example, what happens on arm64 when using 64K pages and 3 level
> paging, where puds are folded into pgds?
> 
> Thanks,
> Mark.

Yes, you are entirely correct I've missed the other potential foldings.
I somehow imagined that p4d was special and was folded the opposite
direction (I'm not sure why!).

The best solution I can come up with is a function which will convert
from the level the entry is found at, back to the 'real' level the entry
was missing at. This is needed to produce the correct output in the
debugfs file. Something like:

static int real_depth(int depth)
{
	if (depth == 3 && PTRS_PER_PMD == 1)
		depth = 2;
	if (depth == 2 && PTRS_PER_PUD == 1)
		depth = 1;
	if (depth == 1 && PTRS_PER_P4D == 1)
		depth = 0;
	return depth;
}

This should of course get folded by the compiler and not actually
generate any code.

Thanks,

Steve
