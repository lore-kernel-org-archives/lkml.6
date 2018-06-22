Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEA1C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C47123F4A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C47123F4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbeFVJBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:01:30 -0400
Received: from foss.arm.com ([217.140.101.70]:60194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751086AbeFVJB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:01:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5CDF1435;
        Fri, 22 Jun 2018 02:01:27 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.1.207.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C14503F819;
        Fri, 22 Jun 2018 02:01:26 -0700 (PDT)
Subject: Re: [PATCH 5/6] coresight: catu: Add support for scatter gather
 tables
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1529319379-17895-1-git-send-email-suzuki.poulose@arm.com>
 <1529319379-17895-6-git-send-email-suzuki.poulose@arm.com>
 <20180621171337.GA10307@xps15>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <d5bbff9b-2730-f708-8a4e-f16241f6f5ce@arm.com>
Date:   Fri, 22 Jun 2018 10:01:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180621171337.GA10307@xps15>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 21/06/18 18:13, Mathieu Poirier wrote:

>> +
>> +/*
>> + * catu_populate_table : Populate the given CATU table.
>> + * The table is always populated as a circular table.
>> + * i.e, the "prev" link of the "first" table points to the "last"
>> + * table and the "next" link of the "last" table points to the
>> + * "first" table. The buffer should be made linear by calling
>> + * catu_set_table().
>> + */
>> +static void
>> +catu_populate_table(struct tmc_sg_table *catu_table)
>> +{
>> +	int i, dpidx, s_dpidx;
>> +	unsigned long offset, buf_size, last_offset;
>> +	dma_addr_t data_daddr;
>> +	dma_addr_t prev_taddr, next_taddr, cur_taddr;
>> +	cate_t *table_ptr, *next_table;
>> +
>> +	buf_size = tmc_sg_table_buf_size(catu_table);
>> +	dpidx = s_dpidx = 0;
> 
>  From the reading the code below variable s_dpidx stands for "small" data page
> index, which isn't obvious from the get go and could easily be mistaken for
> "system" data page index.  Please add a comment to make your intentions clear.

Sure, I will add comments. They are supposed to mean :

dpidx => Data page index
s_dpidx => Sub-page index within the System page.

May be I can rename the variables to =>

sys_pidx and catu_pidx


> 
>> +	offset = 0;
>> +
>> +	table_ptr = catu_get_table(catu_table, 0, &cur_taddr);
>> +	prev_taddr = 0;	/* Prev link for the first table */
>> +
>> +	while (offset < buf_size) {
>> +		/*
>> +		 * The @offset is always 1M aligned here and we have an
>> +		 * empty table @table_ptr to fill. Each table can address
>> +		 * upto 1MB data buffer. The last table may have fewer
>> +		 * entries if the buffer size is not aligned.
>> +		 */
>> +		last_offset = (offset + SZ_1M) < buf_size ?
>> +			      (offset + SZ_1M) : buf_size;
>> +		for (i = 0; offset < last_offset;
>> +		     i++, offset += CATU_PAGE_SIZE) {
> 
> I really like the choice of "table_end" in function catu_dump_table().  I think
> using the same denomination here would make it easier to understand the code.
> 
> I wouldn't bother with such details if you weren't respinning this set.  But now
> that you are and these are extremely simple I think it's worth it, and it will
> help slowing the prolifiration of gray hair around my head when I look back at
> this a year or two down the road.

Sure, I can make those changes in the next revision. Thanks for the review.

Cheers
Suzuki
