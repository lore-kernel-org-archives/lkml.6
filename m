Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083E4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA50223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA50223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732775AbeKMVyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:54:11 -0500
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:35241 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726934AbeKMVyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:54:11 -0500
Received: from [IPv6:2001:420:44c1:2579:cc8b:c08b:b11b:69b9] ([IPv6:2001:420:44c1:2579:cc8b:c08b:b11b:69b9])
        by smtp-cloud7.xs4all.net with ESMTPA
        id MXIogpYNQRKKoMXIrgIG8V; Tue, 13 Nov 2018 12:56:21 +0100
Subject: Re: [PATCH] media: videobuf2-core: Fix error handling when fileio is
 deallocated
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Myungho Jung <mhjungk@gmail.com>, pawel@osciak.com,
        kyungmin.park@samsung.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20181112005053epcas4p1c674759797b4a930cfcce3abc7edd9ad@epcas4p1.samsung.com>
 <20181112004951.GA3948@myunghoj-Precision-5530>
 <9402424d-6e0c-b628-c6c2-8f87b5276a36@samsung.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <636c6ed7-25ef-fd51-4555-3aeb28e96f89@xs4all.nl>
Date:   Tue, 13 Nov 2018 12:56:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <9402424d-6e0c-b628-c6c2-8f87b5276a36@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMGbsIzdaBLUSPh+IQe4kaKPqKkZ/6RSQ3hMGP5fNDzhxWzIiFuWXF2HQZG6xcM/0RLDo1nio+UKR9EJktGMiCM1uzkPXp7pU+VcM9fxDlcsRKlm01R7
 hx0R7LoBoVwP8L8vQNmuZFmkH0X3o22Mkuz7EAuudlU2uPYy4eg3SXz3/el8JyeDcvx38FeAT+f5lUUYnauUk2Me66M1kEFMdIZWUtYMU/Ksqi/guYyO2vvf
 uQCLPj3gR496QY3J9t9i9B+CVGyNukv+OsluewyFFMdZN/VlSdzN2FttdiIT7jr0ZVVdbP2/MAvMmDccbsua1xE64T71L78Di/762AM0iTtyyEA/Y8AKesef
 g3Z5TbaYlf11HVN8Fr0oaxc6cSLia8Zc0iaIP/FIw48rWZZVLuXCQFySL03tM88jdMWWMcqzQRy6ExUijXnaBca3jsw88Q7DHCDOlwIE9UM0ll1SSV4ktzXS
 Yn8NnNCBSsHdBLNa
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/18 11:27, Marek Szyprowski wrote:
> Hi Myungho,
> 
> On 2018-11-12 01:49, Myungho Jung wrote:
>> The mutex that is held from vb2_fop_read() can be unlocked while waiting
>> for a buffer if the queue is streaming and blocking. Meanwhile, fileio
>> can be released. So, it should return an error if the fileio address is
>> changed.
>>
>> Signed-off-by: Myungho Jung <mhjungk@gmail.com>
>> Reported-by: syzbot+4180ff9ca6810b06c1e9@syzkaller.appspotmail.com
> 
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

Sorry:

Nacked-by: Hans Verkuil <hans.verkuil@cisco.com>

This addresses the symptom, not the underlying cause.

I have a patch that fixes the actual cause that I plan to post soon
after I review it a bit more.

Regards,

	Hans

> 
> Thanks for analyzing the code and fixing this issue!
> 
>> ---
>>  drivers/media/common/videobuf2/videobuf2-core.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
>> index 975ff5669f72..bff94752eb27 100644
>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>> @@ -2564,6 +2564,10 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
>>  		dprintk(5, "vb2_dqbuf result: %d\n", ret);
>>  		if (ret)
>>  			return ret;
>> +		if (fileio != q->fileio) {
>> +			dprintk(3, "fileio deallocated\n");
>> +			return -EFAULT;
>> +		}
>>  		fileio->dq_count += 1;
>>  
>>  		fileio->cur_index = index;
> 
> Best regards
> 

