Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54881C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BB22073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BB22073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeH3UfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:35:08 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45514 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727200AbeH3UfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:35:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F8A27A9;
        Thu, 30 Aug 2018 09:32:11 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF85B3F557;
        Thu, 30 Aug 2018 09:32:09 -0700 (PDT)
Subject: Re: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
To:     wufan <wufan@codeaurora.org>
Cc:     mchehab@kernel.org, bp@alien8.de, baicar.tyler@gmail.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
 <c70fa799-bc9f-64c8-e151-088ca8c3ed3e@arm.com>
 <000f01d4406f$6ce8f160$46bad420$@codeaurora.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <1ac15a80-6f9a-cf9d-8e79-37d10549a4ca@arm.com>
Date:   Thu, 30 Aug 2018 17:32:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <000f01d4406f$6ce8f160$46bad420$@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fan,

On 30/08/18 15:40, wufan wrote:
>>> @@ -327,12 +349,20 @@ void ghes_edac_report_mem_error(int sev,
>> struct cper_sec_mem_err *mem_err)
>>>  		p += sprintf(p, "bit_pos:%d ", mem_err->bit_pos);
>>>  	if (mem_err->validation_bits &
>> CPER_MEM_VALID_MODULE_HANDLE) {
>>>  		const char *bank = NULL, *device = NULL;
>>> +		int index = -1;
>>> +
>>>  		dmi_memdev_name(mem_err->mem_dev_handle, &bank,
>> &device);
>>
>>> +		p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
>>> +			     mem_err->mem_dev_handle);
>>>  		if (bank != NULL && device != NULL)
>>>  			p += sprintf(p, "DIMM location:%s %s ", bank, device);
>>> -		else
>>> -			p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
>>> -				     mem_err->mem_dev_handle);
>>
>> Why do we now print the handle every time? The handle is pretty
>> meaningless, it can only be used to find the location-strings, if we get those
>> we print them instead.
> 
> For ghes_edac the bank/device is informational, and nothing would go wrong
> if the bank/device numbers are the same as another entry. But the handle
> is now critical for DIMM lookup, thus pull it out.

Is printing the handle to the kernel log critical?

I'd expect something collecting errors to read from sysfs, not dmesg. I thought
the whole point here was to update the per-dimm counters in sysfs.


Thanks,

James
