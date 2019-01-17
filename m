Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4387DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11CCB206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfAQCfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 21:35:34 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:57156 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbfAQCfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 21:35:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TIOZkKT_1547688773;
Received: from ali-6c96cfd98fb5.local(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0TIOZkKT_1547688773)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Jan 2019 09:32:54 +0800
Subject: Re: [PATCH 1/2] tpm/eventlog/tpm1: Simplify walking over *pos
 measurements
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, tweek@google.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1547197173-52826-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1547197173-52826-2-git-send-email-zhang.jia@linux.alibaba.com>
 <20190116220952.GH25803@linux.intel.com>
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
Message-ID: <8709dd61-2422-1c20-9937-d6003fa0354e@linux.alibaba.com>
Date:   Thu, 17 Jan 2019 09:32:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190116220952.GH25803@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/17 上午6:09, Jarkko Sakkinen wrote:
> Please use "tpm:" tag for commits, not "tpm/eventlog/tpm1".
> 
> On Fri, Jan 11, 2019 at 04:59:32PM +0800, Jia Zhang wrote:
>> The responsibility of tpm1_bios_measurements_start() is to walk
>> over the first *pos measurements, ensuring the skipped and
>> to-be-read measurements are not out-of-boundary.
>>
>> Current logic is complicated a bit. Just employ a do-while loop
>> with necessary sanity check, and then get the goal.
>>
>> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> 
> What does this fix? Even if the current logic is "complicated", it is
> still a pretty simple functiion.


OK. Let me point out the fix part. Here is the original implementation:

 87         /* read over *pos measurements */
 88         for (i = 0; i < *pos; i++) {
 89                 event = addr;
 90
 91                 converted_event_size =
 92                     do_endian_conversion(event->event_size);
 93                 converted_event_type =
 94                     do_endian_conversion(event->event_type);
 95
 96                 if ((addr + sizeof(struct tcpa_event)) < limit) {
 97                         if ((converted_event_type == 0) &&
 98                             (converted_event_size == 0))
 99                                 return NULL;
100                         addr += (sizeof(struct tcpa_event) +
101                                  converted_event_size);
102                 }
103         }

The problem (just ignore all off-by-1 issues) is that accessing to
event_size and event_type is not pre-checked carefully. In the latter
part of tpm1_bios_measurements_start() and
tpm1_bios_measurements_next(), there is a fixed patter to do the sanity
check like this:

136         /* now check if current entry is valid */
137         if ((v + sizeof(struct tcpa_event)) >= limit)
138                 return NULL;

So if we simply change this read-over chunk with sanity check like this:

        /* read over *pos measurements */
        for (i = 0; i < *pos; i++) {
                event = addr;

                if ((addr + sizeof(struct tcpa_event)) >= limit)
                        return NULL;

                converted_event_size =
                    do_endian_conversion(event->event_size);
                converted_event_type =
                    do_endian_conversion(event->event_type);

                if ((converted_event_type == 0) &&
                    (converted_event_size == 0))
                        return NULL;
                addr += (sizeof(struct tcpa_event) +
                         converted_event_size);
        }

We will get two highly similar code chunks in
tpm1_bios_measurements_start(). Here is the latter part:

106         /* now check if current entry is valid */
107         if ((addr + sizeof(struct tcpa_event)) >= limit)
108                 return NULL;
109
110         event = addr;
111
112         converted_event_size = do_endian_conversion(event->event_size);
113         converted_event_type = do_endian_conversion(event->event_type);
114
115         if (((converted_event_type == 0) && (converted_event_size == 0))
116             || ((addr + sizeof(struct tcpa_event) +
converted_event_size)
117                 >= limit))
118                 return NULL;
119
120         return addr;

So using a do while logic can simply merge them together and thus simply
and optimize the logic of walking over *pos measurements.

Sorry I admit my initial motivation is to fix up the sanity check
problem. If you would like to accept the optimization part, I will split
this patch.

Jia

> 
> Applying clean ups for fun has the side-effect of making backporting
> more difficult. And swapping implementation randomly has the side-effect
> of potentially introducing regressions. The current code might be messy
> but it is still field tested.
> 
> I'm sorry but I have to reject this patch.
> 
> /Jarkko
> 
