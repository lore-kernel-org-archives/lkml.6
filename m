Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC65C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402C121837
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402C121837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeHVAyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 20:54:12 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:34578 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726628AbeHVAyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 20:54:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0T7.8Yf3_1534887121;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T7.8Yf3_1534887121)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Aug 2018 05:32:04 +0800
Subject: Re: [BUG] madvise05 leads kernel panic on 4.9.122
To:     Andi Kleen <ak@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, gregkh@linuxfoundation.org,
        tglx@linutronix.de, dave.hansen@intel.com, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <b205fec4-a1ed-dd44-7ba4-7b78f7429689@linux.alibaba.com>
 <1534876981.7459.1.camel@infradead.org>
 <a080e61a-70a2-872a-8849-d6599762ac7c@linux.alibaba.com>
 <20180821203631.GU12066@tassilo.jf.intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <10053bf2-3041-5262-8327-3c0254e8d211@linux.alibaba.com>
Date:   Tue, 21 Aug 2018 14:32:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180821203631.GU12066@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/18 1:36 PM, Andi Kleen wrote:
> On Tue, Aug 21, 2018 at 01:30:20PM -0700, yang.shi@linux.alibaba.com wrote:
>>
>> On 8/21/18 11:43 AM, David Woodhouse wrote:
>>> On Tue, 2018-08-21 at 11:37 -0700, Yang Shi wrote:
>>>> I just ran some regression test on stable 4.9.122 with LTP. madvise05
>>>> triggers the below kernel panic:
>> Thanks, David. It works. A silly question, I don't get why this commit could
>> solve this issue, it looks just like a code refactor. Just because it
>> changed how to get pfn from page table entries? And, this may cause some
>> mismatch on 4.9 stable without it?
> With the L1TF patches open coded pte_val() to get the PFN can cause problems
> because it doesn't do the invert for PROT_NONE mappings
>
> The cleanup changes the open coded versions to use p*_pfn(), which always
> works correctly.

Thanks. Got it.

>
> -Andi

