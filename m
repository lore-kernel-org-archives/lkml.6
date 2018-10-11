Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2E4C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2672075B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2672075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeJLA6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:58:40 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59606 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbeJLA6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:58:39 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gAemt-0002Cu-3o; Thu, 11 Oct 2018 11:30:16 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Rob Herring <robh@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>, linux-sh@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Zong Li <zong@andestech.com>, linux-mm@kvack.org,
        Olof Johansson <olof@lixom.net>,
        linux-riscv@lists.infradead.org,
        Michael Clark <michaeljclark@mac.com>,
        linux-arm-kernel@lists.infradead.org
References: <20181005161642.2462-1-logang@deltatee.com>
 <20181005161642.2462-6-logang@deltatee.com> <20181011133730.GB7276@lst.de>
 <8cea5ffa-5fbf-8ea2-b673-20e2d09a910d@deltatee.com>
Message-ID: <8ebf1a13-ec4e-c546-641c-f8dcb1f6c44d@deltatee.com>
Date:   Thu, 11 Oct 2018 11:30:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <8cea5ffa-5fbf-8ea2-b673-20e2d09a910d@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, michaeljclark@mac.com, linux-riscv@lists.infradead.org, olof@lixom.net, linux-mm@kvack.org, zong@andestech.com, sbates@raithlin.com, linux-kernel@vger.kernel.org, palmer@sifive.com, linux-sh@vger.kernel.org, andrew@sifive.com, aou@eecs.berkeley.edu, robh@kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 5/5] RISC-V: Implement sparsemem
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-10-11 10:24 a.m., Logan Gunthorpe wrote:
> On 2018-10-11 7:37 a.m., Christoph Hellwig wrote:
>>> +/*
>>> + * Log2 of the upper bound of the size of a struct page. Used for sizing
>>> + * the vmemmap region only, does not affect actual memory footprint.
>>> + * We don't use sizeof(struct page) directly since taking its size here
>>> + * requires its definition to be available at this point in the inclusion
>>> + * chain, and it may not be a power of 2 in the first place.
>>> + */
>>> +#define STRUCT_PAGE_MAX_SHIFT	6
>>
>> I know this is copied from arm64, but wouldn't this be a good time
>> to move this next to the struct page defintion?
>>
>> Also this:
>>
>> arch/arm64/mm/init.c:   BUILD_BUG_ON(sizeof(struct page) > (1 << STRUCT_PAGE_MAX_SHIFT));
>>
>> should move to comment code (or would have to be duplicated for riscv)
> 
> Makes sense. Where is a good place for the BUILD_BUG_ON in common code?

Never mind. Seems like it's pretty trivial to do this:

#define STRUCT_PAGE_MAX_SHIFT \
    ilog2(roundup_pow_of_two(sizeof(struct page)))

So the BUILD_BUG_ON becomes unnecessary.

The comment saying it can't be done is really misleading as it wasn't
actually difficult.

Logan
