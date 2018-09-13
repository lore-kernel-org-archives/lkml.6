Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130BDC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF9720866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF9720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeIMMrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 08:47:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11699 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726680AbeIMMrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 08:47:22 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1F3D8514BD132;
        Thu, 13 Sep 2018 15:39:04 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.399.0; Thu, 13 Sep 2018
 15:39:03 +0800
Message-ID: <5B9A1416.7010405@huawei.com>
Date:   Thu, 13 Sep 2018 15:39:02 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC:     Jiri Kosina <jikos@kernel.org>, open list:
        HID CORE LAYER <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, ;
Illegal-Object: Syntax error in CC: address found on vger.kernel.org:
        CC:     ;
                        ^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
Subject: Re: [PATCH] HID: logitech: fix a used uninitialized GCC warning
References: <1536810739-27342-1-git-send-email-zhongjiang@huawei.com> <CAO-hwJJAGdUokt4rByNFsit1bY8t3ZpV3CFh-ES7-GNukZTBLw@mail.gmail.com>
In-Reply-To: <CAO-hwJJAGdUokt4rByNFsit1bY8t3ZpV3CFh-ES7-GNukZTBLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/13 15:01, Benjamin Tissoires wrote:
> On Thu, Sep 13, 2018 at 6:04 AM zhong jiang <zhongjiang@huawei.com> wrote:
>> Fix the following compile warning:
>>
>> drivers/hid/hid-logitech-hidpp.c: In function ‘hi_res_scroll_enable’:
>> drivers/hid/hid-logitech-hidpp.c:2714:54: warning: ‘multiplier’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>>   hidpp->vertical_wheel_counter.resolution_multiplier = multiplier;
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/hid/hid-logitech-hidpp.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
>> index 5f0c080..83c43dd 100644
>> --- a/drivers/hid/hid-logitech-hidpp.c
>> +++ b/drivers/hid/hid-logitech-hidpp.c
>> @@ -2696,7 +2696,7 @@ static int hi_res_scroll_look_up_microns(__u32 product_id)
>>  static int hi_res_scroll_enable(struct hidpp_device *hidpp)
>>  {
>>         int ret;
>> -       u8 multiplier;
>> +       u8 uninitialized_var(multiplier);
> I think your patch is correct (multiplier will be set given the code
> path), but IMO, it feels terribly wrong to explicitly remove this
> warning this way. The problem is that if someone else adds a new piece
> of code, we might miss the fact that multiplier is not set and we
> might show garbage in the hid_info call.
Make sense.
>
> Why don't you initialize the value to 8 as in the 'else' statement and
> remove the now duplicated assignement in this else statement?
Will do in v2.  Thank you for your suggestion.

Thanks,
zhong jiang
> Cheers,
> Benjamin
>
>>         if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_X2121) {
>>                 ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
>> --
>> 1.7.12.4
>>
> .
>


