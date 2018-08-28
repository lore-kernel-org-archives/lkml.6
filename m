Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31ED2C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C774120868
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ST5tBNR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C774120868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeH2DDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 23:03:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47576 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeH2DDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 23:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iT0rPQd8gt2lsuYWVJsUG8Af5R06Jy6gmoIn5DJPOm8=; b=ST5tBNR2s5Okf1/LWuL3Ptfeie
        N1PO8wRskYPY7HlUV1qIoSHHYjinBvV59Mrv0guy4gkGqRym5az3HleO/36Tf7zEWFvL4LShGSDvp
        m4j1JGXZQq1qw2rn0eYibp4IMZWiP5JQ3rkeSm3DYcxwNyN7fPk99J/UAQ77vKlL+P00g2JL0T/I1
        dO8Y4Zk9gvYt8hqOEvxBMo7deiz5VJWkf4epFwU5V5hlP1rWrSKFe7fyIQ4e5z+LS0dVSS8yA7O7I
        IFu/M2QI7ref8r0mb6mFQcyv2Is/UCCBY3c5HEE3xCc+Yjn1KZjBJVsoEDDGbZITX/HfqmNKAu12k
        raQBKFGQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fun70-0005ZL-1P; Tue, 28 Aug 2018 23:09:26 +0000
Subject: Re: Tagged pointers in the XArray
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20180828222727.GD11400@bombadil.infradead.org>
 <fc15502d-8bf3-b7e3-af82-4645dc84e9cd@infradead.org>
 <20180828230329.GE11400@bombadil.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8352b2da-b638-2205-132b-f32893d1cdb7@infradead.org>
Date:   Tue, 28 Aug 2018 16:09:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828230329.GE11400@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/2018 04:03 PM, Matthew Wilcox wrote:
> On Tue, Aug 28, 2018 at 03:39:01PM -0700, Randy Dunlap wrote:
>> Just a question, please...
>>
>> On 08/28/2018 03:27 PM, Matthew Wilcox wrote:
>>>
>>> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
>>> index c74556ea4258..d1b383f3063f 100644
>>> --- a/include/linux/xarray.h
>>> +++ b/include/linux/xarray.h
>>> @@ -150,6 +150,54 @@ static inline int xa_err(void *entry)
>>>  	return 0;
>>>  }
>>>  
>>> +/**
>>> + * xa_tag_pointer() - Create an XArray entry for a tagged pointer.
>>> + * @p: Plain pointer.
>>> + * @tag: Tag value (0, 1 or 3).
>>> + *
>>
>> What's wrong with a tag value of 2?
> 
> That conflicts with the XArray's internal entries and you get a WARN_ON
> when you try to store it in the array.
> 
>> and what happens when one is used?  [I don't see anything preventing that.]
> 
> Right, there's nothing preventing you from using the value 5 or 19
> or 16777216 either ... I did put in a WARN_ON_ONCE to begin with, but
> decided that was unnecessary.
> 
> Right now our only user uses 0 and 1, so even documenting 3 as a
> possibility isn't _necessary_, but some day somebody is going to want
> to add FILE_NOT_FOUND
> https://thedailywtf.com/articles/What_Is_Truth_0x3f_
> 

Thanks.  :)

-- 
~Randy
