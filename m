Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AA5C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F402089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F402089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeJPBDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:03:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47105 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbeJPBDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:03:20 -0400
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w9FHGtRL3710778
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 15 Oct 2018 10:16:55 -0700
Subject: Re: [PATCH] kvm/x86 : avoid shifting signed 32-bit value by 31 bits
To:     peng.hao2@zte.com.cn, richard.weiyang@gmail.com
Cc:     penghao122@sina.com.cn, pbonzini@redhat.com, rkrcmar@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, joro@8bytes.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org
References: <201810080904344038939@zte.com.cn>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <717c02f3-bb36-33c4-a463-f5759fde30fd@zytor.com>
Date:   Mon, 15 Oct 2018 10:16:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <201810080904344038939@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/18 6:04 PM, peng.hao2@zte.com.cn wrote:
\>>>>>
>>>>> #define AVIC_LOGICAL_ID_ENTRY_GUEST_PHYSICAL_ID_MASK    (0xFF)
>>>>> -#define AVIC_LOGICAL_ID_ENTRY_VALID_MASK        (1 << 31)
>>>>> +#define AVIC_LOGICAL_ID_ENTRY_VALID_MASK        (1UL << 31)
>>>
>>>> It is reasonable to change to unsigned, while not necessary to unsigned
>>>> long?
>>> AVIC_LOGICAL_ID_ENTRY_VALID_MASK is used in function avic_ldr_write.
>>> here I think it doesn't matter if you use unsigned or unsigned long. Do you have any suggestions?
> 
>> In current case, AVIC_LOGICAL_ID_ENTRY_VALID_MASK is used to calculate
>> the value of new_entry with type of u32. So the definition here is not
>> harmful.
> 
>> Also, I did a quick grep and found similar definition (1 << 31) is popular
>> in the whole kernel tree.
> 
>> The reason to make this change is not that strong to me. Would you
>> minding sharing more reason behind this change?
> oh, I'm just thinking logically, not more reason.

The right way to do this would be to use the _BITUL() (or _BITULL()) macro.

	-hpa

