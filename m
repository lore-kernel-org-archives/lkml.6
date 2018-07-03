Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181A0C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C386E23CE3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ilmnv+E3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ilmnv+E3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C386E23CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934615AbeGCTHy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:07:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37060 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933265AbeGCTHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:07:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E28D9606FC; Tue,  3 Jul 2018 19:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530644871;
        bh=9sz0uVBULJUKndbKw9VAjYgwOng3Yiep83zUqJLuXbc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ilmnv+E3qzs9EHIxO5L2fQNrOzJ9RWsQbY1C4KURK0k7Ow1vou30v2ehiSKr95wZc
         g6huSun0dyWiaHPFpkRRuRqgoCE8XMyEXwla22R7ovEYqggMgeLJ76BIav2xTQVqwR
         2aEUTOEf1/3sMTDvfef3q/iGooTOS4wr1jzYDwDs=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 321766028D;
        Tue,  3 Jul 2018 19:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530644871;
        bh=9sz0uVBULJUKndbKw9VAjYgwOng3Yiep83zUqJLuXbc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ilmnv+E3qzs9EHIxO5L2fQNrOzJ9RWsQbY1C4KURK0k7Ow1vou30v2ehiSKr95wZc
         g6huSun0dyWiaHPFpkRRuRqgoCE8XMyEXwla22R7ovEYqggMgeLJ76BIav2xTQVqwR
         2aEUTOEf1/3sMTDvfef3q/iGooTOS4wr1jzYDwDs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 03 Jul 2018 12:07:51 -0700
From:   pheragu@codeaurora.org
To:     Joe Perches <joe@perches.com>
Cc:     apw@canonical.com, linux-kernel@vger.kernel.org,
        ckadabi@codeaurora.org, tsoni@codeaurora.org,
        bryanh@codeaurora.org, Patrick Pannuto <ppannuto@codeaurora.org>,
        Stepan Moskovchenko <stepanm@codeaurora.org>
Subject: Re: [PATCH] checkpatch: Check for illegal return codes
In-Reply-To: <7cce1fcb751a2ffe89af02bcb05f295879ed1040.camel@perches.com>
References: <1530641369-31098-1-git-send-email-pheragu@codeaurora.org>
 <7cce1fcb751a2ffe89af02bcb05f295879ed1040.camel@perches.com>
Message-ID: <f6498bb90c5da1ea1765412bd78071a7@codeaurora.org>
X-Sender: pheragu@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-03 11:19, Joe Perches wrote:
> On Tue, 2018-07-03 at 11:09 -0700, Prakruthi Deepak Heragu wrote:
>> The only legal integer return is 0, anything else
>> following "return" should be -ERRCODE or a function.
>> 
>> http://lkml.org/lkml/2010/7/23/318
>>   There's lots of "return -1;" statements in this patch - it's obscene
>>   that this is used to indicate "some error occurred" in kernel space
>>   rather than a real errno value - even when an existing function
>>   (eg, request_irq) gave you an error code already.
>> 
>> Signed-off-by: Patrick Pannuto <ppannuto@codeaurora.org>
>> Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
>> Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
>> ---
>>  scripts/checkpatch.pl | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index a9c0550..260d252 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -6197,6 +6197,12 @@ sub process {
>>  			     "switch default: should use break\n" . $herectx);
>>  		}
>> 
>> +# check for return codes on error paths
>> +		if ($line =~ /\breturn\s+-\d+/) {
>> +			ERROR("NO_ERROR_CODE",
>> +			      "illegal return value, please use an error code");
>> +		}
>> +
> 
> Substitute illegal to invalid as this wouldn't be illegal.
> It might be invalid and this needs a newline and $herecurr
> 
> I'm not sure this is even useful.
> 
> There are _way_ too many of these already existing
> and simple return identifiers can be OK.
> 
> $ git grep -P '\breturn\s*\-(?!0)\d+' | wc -l
> 10193
> 
> and
> 
> $ git grep -P '\breturn\s*\-(?!1)\d+' | wc -l
> 240
True. However, this would be helpful to avoid usage of such return 
statements in the future.
