Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309CBC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56C52082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56C52082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbeJ3QdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 12:33:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:54397 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbeJ3QdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 12:33:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 00:40:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,443,1534834800"; 
   d="scan'208";a="104439377"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.252.66.171]) ([10.252.66.171])
  by orsmga002.jf.intel.com with ESMTP; 30 Oct 2018 00:40:36 -0700
Subject: Re: [PATCH v2 3/4] platform/x86: intel_pmc_core: Decode Snoop / Non
 Snoop LTR
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@linux.intel.com>
References: <20181006065113.669-1-rajneesh.bhardwaj@linux.intel.com>
 <20181006065113.669-3-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75VcLN6g-6FJsVgxPZRV675N6YQzxsbm19BWgKhpiYfmG3w@mail.gmail.com>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <7d7d59a3-241d-9753-24e0-74a8f0fc9df6@linux.intel.com>
Date:   Tue, 30 Oct 2018 13:10:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VcLN6g-6FJsVgxPZRV675N6YQzxsbm19BWgKhpiYfmG3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for your review. My comments below.

If you agree then i can quickly send v3 addressing all suggestions so we 
can make it in time for 4.20 merge window.


On 19-Oct-18 6:04 PM, Andy Shevchenko wrote:
> On Sat, Oct 6, 2018 at 9:54 AM Rajneesh Bhardwaj
> <rajneesh.bhardwaj@linux.intel.com> wrote:
>> The LTR values follow PCIE LTR encoding format and can be decoded as per
>> https://pcisig.com/sites/default/files/specification_documents/ECN_LatencyTolnReporting_14Aug08.pdf
>>
>> This adds support to translate the raw LTR values as read from the PMC
>> to meaningful values in nanosecond units of time.
> While I have pushed this to my review and testing queue, it needs a
> bit more work. See my comments below.
>
>> +static u32 convert_ltr_scale(u32 val)
>> +{
>> +       u32 scale = 0;
> Redundant, see below.
>
>> +       /*
>> +        * As per PCIE specification supporting document
>> +        * ECN_LatencyTolnReporting_14Aug08.pdf the Latency
>> +        * Tolerance Reporting data payload is encoded in a
>> +        * 3 bit scale and 10 bit value fields. Values are
>> +        * multiplied by the indicated scale to yield an absolute time
>> +        * value, expressible in a range from 1 nanosecond to
>> +        * 2^25*(2^10-1) = 34,326,183,936 nanoseconds.
>> +        *
>> +        * scale encoding is as follows:
>> +        *
>> +        * ----------------------------------------------
>> +        * |scale factor        |       Multiplier (ns) |
>> +        * ----------------------------------------------
>> +        * |    0               |       1               |
>> +        * |    1               |       32              |
>> +        * |    2               |       1024            |
>> +        * |    3               |       32768           |
>> +        * |    4               |       1048576         |
>> +        * |    5               |       33554432        |
>> +        * |    6               |       Invalid         |
>> +        * |    7               |       Invalid         |
>> +        * ----------------------------------------------
>> +        */
>> +       if (val > 5)
>> +               pr_warn("Invalid LTR scale factor.\n");
> if (...) {
>   pr_warn(...); // Btw, Does it recoverable state? What user will get
> with returned 0 as a multiplier?
>   return 0; // Btw, is 0 fits better than ~0? How hw would behave with
> this value?
> }

We show 0 LTR for invalid scale as PMC output is junk sometimes.


>
>> +       else
>> +               scale = 1U << (5 * (val));
>> +
>> +       return scale;
> return 1U << (5 * val);

We intend to return 0 so for invalid LTR scale. This will make retuen 
non zero and we dont want that.

>
>> +}
>>          for (index = 0; map[index].name ; index++) {
>> -               seq_printf(s, "IP %-2d :%-32s\tRAW LTR: 0x%x\n", index,
>> -                          map[index].name,
>> -                          pmc_core_reg_read(pmcdev, map[index].bit_mask));
> We use 32 characters for the names. Here are two minor issues:
> - inconsistency with the rest

intentional.

> - ping-pong style of programming (you changed 32 to 24 in the same
> series where you introduced 32 in the first place).

This is because the formatted output looks better with this width. I 
used 32 for the earlier patch because its consistent with rest and also 
does not look bad on screen.

>
>
>> +               decoded_snoop_ltr = decoded_non_snoop_ltr = 0;
>> +               ltr_raw_data = pmc_core_reg_read(pmcdev,
>> +                                                map[index].bit_mask);
>> +               snoop_ltr = ltr_raw_data & ~MTPMC_MASK;
>> +               nonsnoop_ltr = (ltr_raw_data >> 0x10) & ~MTPMC_MASK;
>> +
>> +               if (FIELD_GET(LTR_REQ_NONSNOOP, ltr_raw_data)) {
>> +                       scale = FIELD_GET(LTR_DECODED_SCALE, nonsnoop_ltr);
>> +                       val = FIELD_GET(LTR_DECODED_VAL, nonsnoop_ltr);
>> +                       decoded_non_snoop_ltr = val * convert_ltr_scale(scale);
>> +               }
>> +
>> +               if (FIELD_GET(LTR_REQ_SNOOP, ltr_raw_data)) {
>> +                       scale = FIELD_GET(LTR_DECODED_SCALE, snoop_ltr);
>> +                       val = FIELD_GET(LTR_DECODED_VAL, snoop_ltr);
>> +                       decoded_snoop_ltr = val * convert_ltr_scale(scale);
>> +               }
>> +
>> +               seq_printf(s, "IP %-2d :%-24s\tRaw LTR: 0x%-16x\t Non-Snoop LTR (ns): %-16llu\t Snoop LTR (ns): %-16llu\n",
> Here 0x%-16x would look a bit strange and difficult to parse. 0x%016x
> much better.

Sure, I can test how it looks with 0x%016x and modify it.

> After you remove the index, it would give you 4 more characters,
> though it 4 less than 8 you got from reducing 32 to 24.

I plan to keep the index as is. Reason for this is mentioned in previous 
patch that introduces this index.

>
> OTOH, those long texts perhaps may be compressed somehow, at least
> remove LTR duplicating from the last two. Remove spaces after '\t' as
> well.

Noted.

>
>> +                          index, map[index].name, ltr_raw_data,
>> +                          decoded_non_snoop_ltr,
>> +                          decoded_snoop_ltr);
>>          }
>>          return 0;
>>   }
>> --- a/drivers/platform/x86/intel_pmc_core.h
>> +++ b/drivers/platform/x86/intel_pmc_core.h
>> @@ -177,6 +177,11 @@ enum ppfear_regs {
> It might be good idea to include linux/bits.h here.

Certainly. Luckily 0day bot didnt complain about randconfigs etc so is 
it really needed as it will increase size?

>
>> +#define LTR_REQ_NONSNOOP                       BIT(31)
>> +#define LTR_REQ_SNOOP                          BIT(15)
>> +#define LTR_DECODED_VAL                                GENMASK(9, 0)
>> +#define LTR_DECODED_SCALE                      GENMASK(12, 10)

