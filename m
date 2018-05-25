Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967161AbeEYQHO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 12:07:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35932 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966599AbeEYQHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 12:07:11 -0400
Subject: Re: [PATCH 08/11] coresight: Add generic TMC sg table framework
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, sudeep.holla@arm.com, frowand.list@gmail.com,
        coresight@lists.linaro.org, mark.rutland@arm.com
References: <1526661567-4578-1-git-send-email-suzuki.poulose@arm.com>
 <1526661567-4578-9-git-send-email-suzuki.poulose@arm.com>
 <20180523202552.GA4609@xps15>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <21fef51b-2afe-1a2c-6006-5cf3de4e74e8@arm.com>
Date: Fri, 25 May 2018 17:07:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523202552.GA4609@xps15>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/18 21:25, Mathieu Poirier wrote:
> On Fri, May 18, 2018 at 05:39:24PM +0100, Suzuki K Poulose wrote:
>> This patch introduces a generic sg table data structure and
>> associated operations. An SG table can be used to map a set
>> of Data pages where the trace data could be stored by the TMC
>> ETR. The information about the data pages could be stored in
>> different formats, depending on the type of the underlying
>> SG mechanism (e.g, TMC ETR SG vs Coresight CATU). The generic
>> structure provides book keeping of the pages used for the data
>> as well as the table contents. The table should be filled by
>> the user of the infrastructure.
>>
>> A table can be created by specifying the number of data pages
>> as well as the number of table pages required to hold the
>> pointers, where the latter could be different for different
>> types of tables. The pages are mapped in the appropriate dma
>> data direction mode (i.e, DMA_TO_DEVICE for table pages
>> and DMA_FROM_DEVICE for data pages).  The framework can optionally
>> accept a set of allocated data pages (e.g, perf ring buffer) and
>> map them accordingly. The table and data pages are vmap'ed to allow
>> easier access by the drivers. The framework also provides helpers to
>> sync the data written to the pages with appropriate directions.
>>
>> This will be later used by the TMC ETR SG unit and CATU.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Changes since v1:
>>   - Address code style issues, more comments
>> ---
>>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 290 ++++++++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tmc.h     |  50 ++++
>>   2 files changed, 340 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> index 9780798..1e844f8 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> @@ -17,9 +17,299 @@


>> +static inline dma_addr_t tmc_sg_table_base_paddr(struct tmc_sg_table *sg_table)
>> +{
>> +	if (WARN_ON(!sg_table->data_pages.pages[0]))
>> +		return 0;
>> +	return sg_table->table_daddr;
>> +}
>> +
>> +static inline void *tmc_sg_table_base_vaddr(struct tmc_sg_table *sg_table)
>> +{
>> +	if (WARN_ON(!sg_table->data_pages.pages[0]))
>> +		return NULL;
>> +	return sg_table->table_vaddr;
>> +}
> 
> The above two functions deal with DMA'able and virtual addresses for the table
> page buffer.  Yet the test in the WARN_ON is done on the data page array.
> Shouldn't this be sg_table->table_pages.pages[0] instead?

The table is as good as empty if there are no data pages associated with
the table. Hence the data_pages check.

> 
> If not please add a comment justifying your position so that someone else
> looking at the code does't end up thinking the same in a year from now.

I will add a comment to reflect the above.

> 
>> +
>> +static inline void *
>> +tmc_sg_table_data_vaddr(struct tmc_sg_table *sg_table)
>> +{
>> +	if (WARN_ON(!sg_table->data_pages.nr_pages))
>> +		return 0;
>> +	return sg_table->data_vaddr;
>> +}
> 
> I see that tmc_sg_table_base_vaddr() and tmc_sg_table_data_vaddr() are both
> returning the virtual address of the contiguous buffer for table and data
> respectively.  Yet there is a discrepency in the naming convention.  I would
> have expected tmc_sg_table_base_vaddr() and tmc_sg_data_base_vaddr() so that
> there is a little symmetry between them.

Agree. I will fix it.

Suzuki
