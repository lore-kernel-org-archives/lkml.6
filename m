Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF40C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C02F206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C02F206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391606AbeKVM1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:27:39 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38439 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730718AbeKVM1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:27:39 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 38A67AA5664AB;
        Thu, 22 Nov 2018 09:50:32 +0800 (CST)
Received: from [127.0.0.1] (10.111.194.139) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Thu, 22 Nov 2018
 09:50:30 +0800
Subject: Re: perf tools: remove option --tail-synthesize ?
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
References: <89AC26A9-5A18-4608-8889-9C3C9C1C69D3@fb.com>
 <20181121131156.GG6248@kernel.org>
CC:     Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kernel Team" <Kernel-team@fb.com>
From:   "Wangnan (F)" <wangnan0@huawei.com>
Message-ID: <da87afd6-c291-2049-5e0b-a02512122806@huawei.com>
Date:   Thu, 22 Nov 2018 09:50:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20181121131156.GG6248@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.111.194.139]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/11/21 21:11, Arnaldo Carvalho de Melo wrote:
> Em Wed, Nov 21, 2018 at 07:45:28AM +0000, Song Liu escreveu:
>> Hi,
>>
>> I found perf-record --tail-synthesize without --overwrite breaks symbols
>> for perf-script, perf-report, etc. For example:
>>
>> [root@]# ~/perf record -ag --tail-synthesize -- sleep 1
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 1.129 MB perf.data (3531 samples) ]
>> [root@]# ~/perf script | head
>> swapper     0 [000] 1250675.051971:          1 cycles:ppp:
>>         ffffffff81009e15 [unknown] ([unknown])
>>         ffffffff81196b19 [unknown] ([unknown])
>>         ffffffff81196579 [unknown] ([unknown])
>>         ffffffff81110ca7 [unknown] ([unknown])
>>         ffffffff81a01f4a [unknown] ([unknown])
>>         ffffffff81a017bf [unknown] ([unknown])
>>         ffffffff8180e17a [unknown] ([unknown])
>>
>> perf-record with --overwrite does NOT have this issue.
>>
>> After digging into this, I found this issue is introduced by commit
>> a73e24d240bc136619d382b1268f34d75c9d25ce.
>>
>> Reverting this commit does fix this issue. However, on a second thought,
>> I feel it is probably better just drop --tail-synthesize, as it doesn't
>> make much sense without --overwrite. All we need is to do tail_synthesize
>> when --overwrite is set.
>>

Some cases we use --overwrite without --tail-synthesize. How about setting
--tail-synthesize when selecting --overwrite by default, throw a warning
when --overwrite is not set and leave a --no-tail-synthesize option?

Thank you.

>> Thoughts?
> 
> Wang, wdyt?
> 
> - Arnaldo
> 

