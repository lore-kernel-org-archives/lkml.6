Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E65CC07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C60F20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C60F20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbeLCKXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:23:34 -0500
Received: from mail5.windriver.com ([192.103.53.11]:58574 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbeLCKXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:23:34 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wB3AKP5h027153
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 3 Dec 2018 02:20:56 -0800
Received: from [128.224.162.162] (128.224.162.162) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 3 Dec
 2018 02:20:20 -0800
Subject: Re: [PATCH] kernel/dma: Fix panic caused by passing swiotlb to
 command line
To:     Konrad Rzeszutek Wilk <konrad@darnok.org>
CC:     <konrad.wilk@oracle.com>, <hch@lst.de>, <m.szyprowski@samsung.com>,
        <robin.murphy@arm.com>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
References: <1537154831-447363-1-git-send-email-zhe.he@windriver.com>
 <c3536f4f-9bde-4f7f-a180-aa569d4e786d@windriver.com>
 <20181022192921.GA20677@dhcp-10-175-29-12.vpn.oracle.com>
 <87ee40fa-7a01-4d4c-7fa3-81aafc93e14f@windriver.com>
 <5fa82cb9-bd32-8a3f-ddca-053f544e2883@windriver.com>
 <20181202123032.GA3166@localhost.localdomain>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <b81eaa10-0799-40e6-9271-150d21b24e33@windriver.com>
Date:   Mon, 3 Dec 2018 18:20:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181202123032.GA3166@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.162]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/12/2 20:30, Konrad Rzeszutek Wilk wrote:
> On Tue, Oct 30, 2018 at 07:06:10PM +0800, He Zhe wrote:
>>
>> On 2018/10/23 19:14, He Zhe wrote:
>>> On 2018/10/23 03:29, Konrad Rzeszutek Wilk wrote:
>>>> On Sat, Sep 22, 2018 at 08:56:58PM +0800, He Zhe wrote:
>>>>> May I have your input?
>>>> Alternatively would it make more sense for it to assume some default
>>>> value?
>>> Maybe, but the original code has no default value and I have no idea
>>> what default value is proper here.
>> Can anyone give some suggestions? Though I'd prefer to do nothing when
>> no option is provided.
> One provided the paramter for a reason. I would just do a small one, say
> 4MB.

OK. Thanks, I'll send v2.

Zhe

>> Thanks,
>> Zhe
>>
>>> Zhe
>>>
>>>>> Thanks,
>>>>> Zhe
>>>>>
>>>>> On 2018年09月17日 11:27, zhe.he@windriver.com wrote:
>>>>>> From: He Zhe <zhe.he@windriver.com>
>>>>>>
>>>>>> setup_io_tlb_npages does not check input argument before passing it
>>>>>> to isdigit. The argument would be a NULL pointer if "swiotlb", without
>>>>>> its value, is set in command line and thus causes the following panic.
>>>>>>
>>>>>> PANIC: early exception 0xe3 IP 10:ffffffffbb9b8e9f error 0 cr2 0x0
>>>>>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc3-yocto-standard+ #9
>>>>>> [    0.000000] RIP: 0010:setup_io_tlb_npages+0xf/0x95
>>>>>> ...
>>>>>> [    0.000000] Call Trace:
>>>>>> [    0.000000]  do_early_param+0x57/0x8e
>>>>>> [    0.000000]  parse_args+0x208/0x320
>>>>>> [    0.000000]  ? rdinit_setup+0x30/0x30
>>>>>> [    0.000000]  parse_early_options+0x29/0x2d
>>>>>> [    0.000000]  ? rdinit_setup+0x30/0x30
>>>>>> [    0.000000]  parse_early_param+0x36/0x4d
>>>>>> [    0.000000]  setup_arch+0x336/0x99e
>>>>>> [    0.000000]  start_kernel+0x6f/0x4e6
>>>>>> [    0.000000]  x86_64_start_reservations+0x24/0x26
>>>>>> [    0.000000]  x86_64_start_kernel+0x6f/0x72
>>>>>> [    0.000000]  secondary_startup_64+0xa4/0xb0
>>>>>>
>>>>>> This patch adds a check to prevent the panic.
>>>>>>
>>>>>> Signed-off-by: He Zhe <zhe.he@windriver.com>
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Cc: konrad.wilk@oracle.com
>>>>>> Cc: hch@lst.de
>>>>>> Cc: m.szyprowski@samsung.com
>>>>>> Cc: robin.murphy@arm.com
>>>>>> ---
>>>>>>  kernel/dma/swiotlb.c | 5 +++++
>>>>>>  1 file changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>>>>>> index 4f8a6db..46fc34e 100644
>>>>>> --- a/kernel/dma/swiotlb.c
>>>>>> +++ b/kernel/dma/swiotlb.c
>>>>>> @@ -109,6 +109,11 @@ static int late_alloc;
>>>>>>  static int __init
>>>>>>  setup_io_tlb_npages(char *str)
>>>>>>  {
>>>>>> +	if (!str) {
>>>>>> +		pr_err("Config string not provided\n");
>>>>>> +		return -EINVAL;
>>>>>> +	}
>>>>>> +
>>>>>>  	if (isdigit(*str)) {
>>>>>>  		io_tlb_nslabs = simple_strtoul(str, &str, 0);
>>>>>>  		/* avoid tail segment of size < IO_TLB_SEGSIZE */
>>>>> _______________________________________________
>>>>> iommu mailing list
>>>>> iommu@lists.linux-foundation.org
>>>>> https://lists.linuxfoundation.org/mailman/listinfo/iommu

