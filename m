Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755128AbeEHP4M (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 11:56:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60372 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754544AbeEHP4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 11:56:11 -0400
Subject: Re: [PATCH v2 18/27] coresight: catu: Add support for scatter gather
 tables
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-19-git-send-email-suzuki.poulose@arm.com>
 <20180507202517.GC32594@xps15>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <dc197d94-b39c-e8af-97c9-e73e815b21fe@arm.com>
Date: Tue, 8 May 2018 16:56:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507202517.GC32594@xps15>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/18 21:25, Mathieu Poirier wrote:
> On Tue, May 01, 2018 at 10:10:48AM +0100, Suzuki K Poulose wrote:
>> This patch adds the support for setting up a SG table for use
>> by the CATU. We reuse the tmc_sg_table to represent the table/data
>> pages, even though the table format is different.
>>

...

>>
>> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
>> index 2cd69a6..4cc2928 100644
>> --- a/drivers/hwtracing/coresight/coresight-catu.c
>> +++ b/drivers/hwtracing/coresight/coresight-catu.c
>> @@ -16,10 +16,419 @@

...

>> +
>> +/*
>> + * Update the valid bit for a given range of indices [start, end)
>> + * in the given table @table.
>> + */
>> +static inline void catu_update_state_range(cate_t *table, int start,
>> +						 int end, int valid)
> 
> Indentation
> 

...

>> +#ifdef CATU_DEBUG
>> +static void catu_dump_table(struct tmc_sg_table *catu_table)
>> +{
>> +	int i;
>> +	cate_t *table;
>> +	unsigned long table_end, buf_size, offset = 0;
>> +
>> +	buf_size = tmc_sg_table_buf_size(catu_table);
>> +	dev_dbg(catu_table->dev,
>> +		"Dump table %p, tdaddr: %llx\n",
>> +		catu_table, catu_table->table_daddr);
>> +
>> +	while (offset < buf_size) {
>> +		table_end = offset + SZ_1M < buf_size ?
>> +			    offset + SZ_1M : buf_size;
>> +		table = catu_get_table(catu_table, offset, NULL);
>> +		for (i = 0; offset < table_end; i++, offset += CATU_PAGE_SIZE)
>> +			dev_dbg(catu_table->dev, "%d: %llx\n", i, table[i]);
>> +		dev_dbg(catu_table->dev, "Prev : %llx, Next: %llx\n",
>> +			table[CATU_LINK_PREV], table[CATU_LINK_NEXT]);
>> +		dev_dbg(catu_table->dev, "== End of sub-table ===");
>> +	}
>> +	dev_dbg(catu_table->dev, "== End of Table ===");
>> +}
>> +
>> +#else
>> +static inline void catu_dump_table(struct tmc_sg_table *catu_table)
>> +{
>> +}
>> +#endif
> 
> I think this approach is better than peppering the code with #ifdefs as it was
> done for ETR.  Please fix that to replicate what you've done here.
> 

OK

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

...

>> +	while (offset < buf_size) {
>> +		/*
>> +		 * The @offset is always 1M aligned here and we have an
>> +		 * empty table @table_ptr to fill. Each table can address
>> +		 * upto 1MB data buffer. The last table may have fewer
>> +		 * entries if the buffer size is not aligned.
>> +		 */
>> +		last_offset = (offset + SZ_1M) < buf_size ?
>> +			      (offset + SZ_1M) : buf_size;
>> +		for (i = 0; offset < last_offset; i++) {
>> +
>> +			data_daddr = catu_table->data_pages.daddrs[dpidx] +
>> +				     s_dpidx * CATU_PAGE_SIZE;
>> +#ifdef CATU_DEBUG
>> +			dev_dbg(catu_table->dev,
>> +				"[table %5d:%03d] 0x%llx\n",
>> +				(offset >> 20), i, data_daddr);
>> +#endif
> 
> I'm not a fan of adding #ifdefs in the code like this.  I think it is better to
> have a wrapper (that resolves to nothing if CATU_DEBUG is not defined) and
> handle the output in there.
> 


>> +
>> +	catu_populate_table(catu_table);
>> +	/* Make the buf linear from offset 0 */
>> +	(void)catu_set_table(catu_table, 0, size);
>> +
>> +	dev_dbg(catu_dev,
>> +		"Setup table %p, size %ldKB, %d table pages\n",
>> +		catu_table, (unsigned long)size >> 10,  nr_tpages);
> 
> I think this should also be wrapped in a special output debug function.
> 

I could do something like :

#ifdef CATU_DEBUG
#define catu_dbg(fmt, ...)	dev_dbg(fmt, __VA_ARGS__)
#else
#define catu_dbg(fmt, ...)	do { } while (0)
#endif

And use catu_dbg() for the sprinkled prints.

Cheers
Suzuki
