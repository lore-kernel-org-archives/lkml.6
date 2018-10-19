Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343F7ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71582064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71582064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeJSRHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:07:17 -0400
Received: from mail-sz2.amlogic.com ([211.162.65.114]:23372 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeJSRHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:07:17 -0400
Received: from [10.28.18.51] (10.28.18.51) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 19 Oct
 2018 17:01:51 +0800
Subject: Re: [PATCH v5 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-mtd@lists.infradead.org>, Yixun Lan <yixun.lan@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1539839345-14021-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839345-14021-3-git-send-email-jianxin.pan@amlogic.com>
 <20181018225009.59d94aee@bbrezillon>
 <695f6a8b-d37b-bc57-215b-eb6c36252a80@amlogic.com>
 <20181019104248.528a3409@bbrezillon>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <0b07e022-60f5-6263-bfa7-779e7aa3cbe1@amlogic.com>
Date:   Fri, 19 Oct 2018 17:01:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181019104248.528a3409@bbrezillon>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.51]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/10/19 16:42, Boris Brezillon wrote:
> On Fri, 19 Oct 2018 16:29:40 +0800
> Liang Yang <liang.yang@amlogic.com> wrote:
> 
>> On 2018/10/19 4:50, Boris Brezillon wrote:
>>> On Thu, 18 Oct 2018 13:09:05 +0800
>>> Jianxin Pan <jianxin.pan@amlogic.com> wrote:
>>>    
>>>> +static int meson_nfc_buffer_init(struct mtd_info *mtd)
>>>> +{
>>>> +	struct nand_chip *nand = mtd_to_nand(mtd);
>>>> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>> +	static int max_page_bytes, max_info_bytes;
>>>> +	int page_bytes, info_bytes;
>>>> +	int nsectors;
>>>> +
>>>> +	nsectors = mtd->writesize / nand->ecc.size;
>>>> +	page_bytes =  mtd->writesize + mtd->oobsize;
>>>> +	info_bytes = nsectors * PER_INFO_BYTE;
>>>> +
>>>> +	if (nfc->data_buf && nfc->info_buf) {
>>>> +		if (max_page_bytes < page_bytes)
>>>> +			meson_nfc_free_buffer(nfc);
>>>> +		else
>>>> +			return 0;
>>>> +	}
>>>> +
>>>> +	max_page_bytes = max_t(int, max_page_bytes, page_bytes);
>>>> +	max_info_bytes = max_t(int, max_info_bytes, info_bytes);
>>>> +
>>>> +	nfc->data_buf = kmalloc(max_page_bytes, GFP_KERNEL);
>>>
>>> Is there a good reason for not using chip->data_buf and allocating a
>>> new buffer here?
>>>    
>> when calling read_oob or write_oob, i need a mid-buffer which is used in
>> meson_nfc_prase_data_oob(). i.e. after reading a page data into
>> nfc->data_buf, I will format it and transfer to chip->data_buf.
>>
>>
>>>> +	if (!nfc->data_buf)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	nfc->info_buf = kmalloc(max_info_bytes, GFP_KERNEL);
>>>> +	if (!nfc->info_buf) {
>>>> +		kfree(nfc->data_buf);
>>>> +		return -ENOMEM;
>>>> +	}
>>>
>>> I'd recommend moving this info_buf in the priv chip struct, otherwise
>>> you'll have to protect nfc->info_buf with a lock to prevent an already
>>> register chip from using this pointer while you're reallocating the
>>> buffer. Also, I think you have a memleak here.
>>>    
>> ok, i will move it in the chip struct .
>>
>> but how memleak happens even i have called meson_nfc_free_buffer before
>> and free data_buf if info_buf alloc faied.
> 
> You're right, I missed the call to meson_nfc_free_buffer() when
> max_page_bytes < page_bytes. Still, this part is racy, just like the
> nfc->data_buf replacement is if you have several NAND chips. I'd
> recommend moving those bufs to the priv chip struct.
> 

ok. i will move data_duf and info_buf to priv chip struct.

>>
>>>> +
>>>> +	return 0;
>>>> +}
>>>
>>> .
>>>    
> 
> .
> 
