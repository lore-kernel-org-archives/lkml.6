Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C7EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825B220657
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbfAKJBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:01:35 -0500
Received: from foss.arm.com ([217.140.101.70]:51112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbfAKJBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:01:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E598EBD;
        Fri, 11 Jan 2019 01:01:34 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B5D73F694;
        Fri, 11 Jan 2019 01:01:32 -0800 (PST)
Subject: Re: [PATCH v3] irqchip: gicv3-its: Use NUMA aware memory allocation
 for ITS tables
To:     Ganapatrao Kulkarni <gklkml16@gmail.com>
Cc:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, shankerd@codeaurora.org,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Robert Richter <Robert.Richter@cavium.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        John Garry <john.garry@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        Linuxarm <linuxarm@huawei.com>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        gkulkarni@marvell.com
References: <20181213105924.30384-1-shameerali.kolothum.thodi@huawei.com>
 <4fe81519-1ddc-1d73-8c7a-cd0865299b53@arm.com>
 <CAKTKpr4uvQtYKrcAMSoaA-sYv2MNCqZgRb2KQhYa23KaYptaUA@mail.gmail.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <6abeadae-99d7-bdb0-28bb-eb472cb7d783@arm.com>
Date:   Fri, 11 Jan 2019 09:01:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAKTKpr4uvQtYKrcAMSoaA-sYv2MNCqZgRb2KQhYa23KaYptaUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2019 03:53, Ganapatrao Kulkarni wrote:
> Hi Shameer,
> 
> Patch looks OK to me, please feel free to add,
> Reviewed-by: Ganapatrao Kulkarni <gkulkarni@marvell.com>
> 
> On Thu, Dec 13, 2018 at 5:25 PM Marc Zyngier <marc.zyngier@arm.com> wrote:
>>
>> On 13/12/2018 10:59, Shameer Kolothum wrote:
>>> From: Shanker Donthineni <shankerd@codeaurora.org>
>>>
>>> The NUMA node information is visible to ITS driver but not being used
>>> other than handling hardware errata. ITS/GICR hardware accesses to the
>>> local NUMA node is usually quicker than the remote NUMA node. How slow
>>> the remote NUMA accesses are depends on the implementation details.
>>>
>>> This patch allocates memory for ITS management tables and command
>>> queue from the corresponding NUMA node using the appropriate NUMA
>>> aware functions. This change improves the performance of the ITS
>>> tables read latency on systems where it has more than one ITS block,
>>> and with the slower inter node accesses.
>>>
>>> Apache Web server benchmarking using ab tool on a HiSilicon D06
>>> board with multiple numa mem nodes shows Time per request and
>>> Transfer rate improvements of ~3.6% with this patch.
>>>
>>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
>>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>
>>> This is to revive the patch originally sent by Shanker[1] and
>>> to back it up with a benchmark test. Any further testing of
>>> this is most welcome.
>>>
>>> v2-->v3
>>>  -Addressed comments to use page_address().
>>>  -Added Benchmark results to commit log.
>>>  -Removed T-by from Ganapatrao for now.
>>>
>>> v1-->v2
>>>  -Edited commit text.
>>>  -Added Ganapatrao's tested-by.
>>>
>>> Benchmark test details:
>>> --------------------------------
>>> Test Setup:
>>> -D06 with dimm on node 0(Sock#0) and 3 (Sock#1).
>>> -ITS belongs to numa node 0.
>>> -Filesystem mounted on a PCIe NVMe based disk.
>>> -Apache server installed on D06.
>>> -Running ab benchmark test in concurrency mode from a remote m/c
>>>  connected to D06 via  hns3(PCIe) n/w port.
>>>  "ab -k -c 750 -n 2000000 http://10.202.225.188/"
>>>
>>> Test results are avg. of 15 runs.
>>>
>>> For 4.20-rc1  Kernel,
>>> ----------------------------
>>> Time per request(mean, concurrent)  = 0.02753[ms]
>>> Transfer Rate = 416501[Kbytes/sec]
>>>
>>> For 4.20-rc1 +  this patch,
>>> ----------------------------------
>>> Time per request(mean, concurrent)  = 0.02653[ms]
>>> Transfer Rate = 431954[Kbytes/sec]
>>>
>>> % improvement ~3.6%
>>>
>>> vmstat shows around 170K-200K interrupts per second.
>>>
>>> ~# vmstat 1 -w
>>> procs -----------------------memory-- -  -system--
>>>  r  b         swpd         free            in
>>>  5  0            0     30166724          102794
>>>  9  0            0     30141828          171148
>>>  5  0            0     30150160          207185
>>> 13  0            0     30145924          175691
>>> 15  0            0     30140792          145250
>>> 13  0            0     30135556          201879
>>> 13  0            0     30134864          192391
>>> 10  0            0     30133632          168880
>>> ....
>>>
>>> [1] https://patchwork.kernel.org/patch/9833339/
>>
>> The figures certainly look convincing. I'd need someone from Cavium to
>> benchmark it on their hardware and come back with results so that we can
>> make a decision on this.
> 
> Hi Marc,
> My setup got altered during Lab migration from Cavium to Marvell office.
> I don't think, i will have same setup anytime soon.

Fair enough. If nobody objects, I'll take it.

Shameer, please repost this on top of 5.0-rc1, together with
Ganapatrao's RB, and we'll take it from there.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
