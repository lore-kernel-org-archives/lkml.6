Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932648AbeEHQN6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:13:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32886 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932737AbeEHQN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:13:56 -0400
X-Google-Smtp-Source: AB8JxZoP0VzGV2oIsvczpOlQKB9eYmMCvUwOcUlt9yLCBd59RwlhrWIuHtVsgyosl5P2qn+J1uPPJCQao/W+YLoXAkQ=
MIME-Version: 1.0
In-Reply-To: <dc197d94-b39c-e8af-97c9-e73e815b21fe@arm.com>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-19-git-send-email-suzuki.poulose@arm.com>
 <20180507202517.GC32594@xps15> <dc197d94-b39c-e8af-97c9-e73e815b21fe@arm.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 8 May 2018 10:13:54 -0600
Message-ID: <CANLsYky5wUsYa4A5LrF2BZcUvOdOu2CjpAsF=gN4j_iJ4AGE=A@mail.gmail.com>
Subject: Re: [PATCH v2 18/27] coresight: catu: Add support for scatter gather tables
To: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh@kernel.org>,
        John Horley <john.horley@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 May 2018 at 09:56, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> On 07/05/18 21:25, Mathieu Poirier wrote:
>>
>> On Tue, May 01, 2018 at 10:10:48AM +0100, Suzuki K Poulose wrote:
>>>
>>> This patch adds the support for setting up a SG table for use
>>> by the CATU. We reuse the tmc_sg_table to represent the table/data
>>> pages, even though the table format is different.
>>>
>
> ...
>
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-catu.c
>>> b/drivers/hwtracing/coresight/coresight-catu.c
>>> index 2cd69a6..4cc2928 100644
>>> --- a/drivers/hwtracing/coresight/coresight-catu.c
>>> +++ b/drivers/hwtracing/coresight/coresight-catu.c
>>> @@ -16,10 +16,419 @@
>
>
> ...
>
>>> +
>>> +/*
>>> + * Update the valid bit for a given range of indices [start, end)
>>> + * in the given table @table.
>>> + */
>>> +static inline void catu_update_state_range(cate_t *table, int start,
>>> +                                                int end, int valid)
>>
>>
>> Indentation
>>
>
> ...
>
>>> +#ifdef CATU_DEBUG
>>> +static void catu_dump_table(struct tmc_sg_table *catu_table)
>>> +{
>>> +       int i;
>>> +       cate_t *table;
>>> +       unsigned long table_end, buf_size, offset = 0;
>>> +
>>> +       buf_size = tmc_sg_table_buf_size(catu_table);
>>> +       dev_dbg(catu_table->dev,
>>> +               "Dump table %p, tdaddr: %llx\n",
>>> +               catu_table, catu_table->table_daddr);
>>> +
>>> +       while (offset < buf_size) {
>>> +               table_end = offset + SZ_1M < buf_size ?
>>> +                           offset + SZ_1M : buf_size;
>>> +               table = catu_get_table(catu_table, offset, NULL);
>>> +               for (i = 0; offset < table_end; i++, offset +=
>>> CATU_PAGE_SIZE)
>>> +                       dev_dbg(catu_table->dev, "%d: %llx\n", i,
>>> table[i]);
>>> +               dev_dbg(catu_table->dev, "Prev : %llx, Next: %llx\n",
>>> +                       table[CATU_LINK_PREV], table[CATU_LINK_NEXT]);
>>> +               dev_dbg(catu_table->dev, "== End of sub-table ===");
>>> +       }
>>> +       dev_dbg(catu_table->dev, "== End of Table ===");
>>> +}
>>> +
>>> +#else
>>> +static inline void catu_dump_table(struct tmc_sg_table *catu_table)
>>> +{
>>> +}
>>> +#endif
>>
>>
>> I think this approach is better than peppering the code with #ifdefs as it
>> was
>> done for ETR.  Please fix that to replicate what you've done here.
>>
>
> OK
>
>>> +
>>> +/*
>>> + * catu_populate_table : Populate the given CATU table.
>>> + * The table is always populated as a circular table.
>>> + * i.e, the "prev" link of the "first" table points to the "last"
>>> + * table and the "next" link of the "last" table points to the
>>> + * "first" table. The buffer should be made linear by calling
>>> + * catu_set_table().
>>> + */
>>> +static void
>>> +catu_populate_table(struct tmc_sg_table *catu_table)
>>> +{
>
>
> ...
>
>>> +       while (offset < buf_size) {
>>> +               /*
>>> +                * The @offset is always 1M aligned here and we have an
>>> +                * empty table @table_ptr to fill. Each table can address
>>> +                * upto 1MB data buffer. The last table may have fewer
>>> +                * entries if the buffer size is not aligned.
>>> +                */
>>> +               last_offset = (offset + SZ_1M) < buf_size ?
>>> +                             (offset + SZ_1M) : buf_size;
>>> +               for (i = 0; offset < last_offset; i++) {
>>> +
>>> +                       data_daddr = catu_table->data_pages.daddrs[dpidx]
>>> +
>>> +                                    s_dpidx * CATU_PAGE_SIZE;
>>> +#ifdef CATU_DEBUG
>>> +                       dev_dbg(catu_table->dev,
>>> +                               "[table %5d:%03d] 0x%llx\n",
>>> +                               (offset >> 20), i, data_daddr);
>>> +#endif
>>
>>
>> I'm not a fan of adding #ifdefs in the code like this.  I think it is
>> better to
>> have a wrapper (that resolves to nothing if CATU_DEBUG is not defined) and
>> handle the output in there.
>>
>
>
>>> +
>>> +       catu_populate_table(catu_table);
>>> +       /* Make the buf linear from offset 0 */
>>> +       (void)catu_set_table(catu_table, 0, size);
>>> +
>>> +       dev_dbg(catu_dev,
>>> +               "Setup table %p, size %ldKB, %d table pages\n",
>>> +               catu_table, (unsigned long)size >> 10,  nr_tpages);
>>
>>
>> I think this should also be wrapped in a special output debug function.
>>
>
> I could do something like :
>
> #ifdef CATU_DEBUG
> #define catu_dbg(fmt, ...)      dev_dbg(fmt, __VA_ARGS__)
> #else
> #define catu_dbg(fmt, ...)      do { } while (0)
> #endif
>
> And use catu_dbg() for the sprinkled prints.

Yes, that is exactly what I had in mind.

>
> Cheers
> Suzuki
