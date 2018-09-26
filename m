Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266FEC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4EF920842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4EF920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeIZUcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:32:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:48800 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbeIZUcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:32:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 07:19:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,306,1534834800"; 
   d="scan'208";a="266869055"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.252.74.64]) ([10.252.74.64])
  by fmsmga006.fm.intel.com with ESMTP; 26 Sep 2018 07:19:22 -0700
Subject: Re: [PATCH 3/4] platform/x86: intel_pmc_core: Decode Snoop / Non
 Snoop LTR
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
References: <20180903180415.31575-1-rajneesh.bhardwaj@linux.intel.com>
 <20180903180415.31575-3-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75VcKSVJQ54qFV1BwqnwUu4dkS6sOACT3nTntJV+Ww56Oag@mail.gmail.com>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <d8df94fd-cf7d-197f-0532-24e2da8116a7@linux.intel.com>
Date:   Wed, 26 Sep 2018 19:49:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VcKSVJQ54qFV1BwqnwUu4dkS6sOACT3nTntJV+Ww56Oag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26-Sep-18 7:23 PM, Andy Shevchenko wrote:
> On Mon, Sep 3, 2018 at 9:05 PM Rajneesh Bhardwaj
> <rajneesh.bhardwaj@linux.intel.com> wrote:
>> The LTR values follow PCIE LTR encoding format and can be decoded as per
>> https://pcisig.com/sites/default/files/specification_documents/ECN_LatencyTolnReporting_14Aug08.pdf
>>
>> This adds support to translate the raw LTR values as read from the PMC
>> to meaningful values in nanosecond units of time.
>> +static void get_ltr_scale(u32 *val)
> What's wrong to return converted value? Actually the name should
> reflect what it does, ie *convert* value.

I can change it as per your suggestion.

>
>> +{
>> +       /*
>> +        * As per PCIE specification supprting document
> supporting

oops. Will fix.

>
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
>> +       if (*val > 5) {
>> +               *val = 0;
>> +               pr_warn("Invalid LTR scale factor.\n");
>> +       } else {
>> +               *val = 1U << (5 * (*val));
>> +       }
>> +}
>> +
>>   static int pmc_core_ltr_show(struct seq_file *s, void *unused)
>>   {
>>          struct pmc_dev *pmcdev = s->private;
>>          const struct pmc_bit_map *map = pmcdev->map->ltr_show_sts;
>> +       u64 decoded_snoop_ltr = 0, decoded_non_snoop_ltr = 0;
>> +       union ltr_payload ltr_data;
>> +       u32 scale = 0;
> Redundant assignment.

Ok

>
>>          int index;
>>
>>          for (index = 0; map[index].name ; index++) {
>> -               seq_printf(s, "%-32s\tRAW LTR: 0x%x\n",
>> +               ltr_data.raw_data = pmc_core_reg_read(pmcdev,
>> +                                                     map[index].bit_mask);
>> +
>> +               if (ltr_data.bits.non_snoop_req) {
>> +                       scale = ltr_data.bits.non_snoop_scale;
>> +                       get_ltr_scale(&scale);
>> +                       decoded_non_snoop_ltr =
>> +                               ltr_data.bits.non_snoop_val * scale;
>> +               }
>> +
>> +               if (ltr_data.bits.snoop_req) {
>> +                       scale = ltr_data.bits.snoop_scale;
>> +                       get_ltr_scale(&scale);
>> +                       decoded_snoop_ltr =
>> +                               ltr_data.bits.snoop_val * scale;
>> +               }
>> +
>> +               seq_printf(s, "%-24s\tRaw LTR: 0x%-16x\t Non-Snoop LTR (ns): %-16llu\t Snoop LTR (ns): %-16llu\n",
>>                             map[index].name,
>> -                          pmc_core_reg_read(pmcdev, map[index].bit_mask));
>> +                          ltr_data.raw_data,
>> +                          decoded_non_snoop_ltr,
>> +                          decoded_snoop_ltr);
>> +
>> +               decoded_snoop_ltr = decoded_non_snoop_ltr = 0;
> You may do this at the beginning of the loop and get rid of assignment
> in the definition block.

Fine.

>
>>          }
>>          return 0;
>>   }
>> +union ltr_payload {
>> +       u32 raw_data;
>> +       struct {
>> +       u32 snoop_val : 10;
>> +       u32 snoop_scale : 3;
>> +       u32 snoop_res : 2;
>> +       u32 snoop_req : 1;
>> +       u32 non_snoop_val : 10;
>> +       u32 non_snoop_scale : 3;
>> +       u32 non_snoop_res : 2;
>> +       u32 non_snoop_req : 1;
>> +       } bits;
>> +};
> Just use normal masks and shifts.

I chose union over masks and shifts to reduce code size and ensured 
correct endian-ness. Just for my understanding, can you please let me 
know why you feel masks/shift are better suited here?

>

