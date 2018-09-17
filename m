Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DE2ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184C62088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LgCPxhrz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LgCPxhrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184C62088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbeIREPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:15:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44628 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbeIREPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:15:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DA10660866; Mon, 17 Sep 2018 22:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537224388;
        bh=zRv99Chku28ICpwA8TGNIr5/YTU70qmdKai4DezKo7o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LgCPxhrzr4SlSxgqWCsN2BHxFhwDbxZHHwIakf7ixKbA+vXYMB3+Q27jV+QF14UkO
         msKift5S/EXt46xOcbmslkGgPQN/3u3Z/Jovq3Mkq+O+xVW94EBp2RqJNiVBawuXeu
         wQnVRTUdNTgZpoGmzTaFdFlPK0GsKb5ilTf1/ykE=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8F12C602F1;
        Mon, 17 Sep 2018 22:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537224388;
        bh=zRv99Chku28ICpwA8TGNIr5/YTU70qmdKai4DezKo7o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LgCPxhrzr4SlSxgqWCsN2BHxFhwDbxZHHwIakf7ixKbA+vXYMB3+Q27jV+QF14UkO
         msKift5S/EXt46xOcbmslkGgPQN/3u3Z/Jovq3Mkq+O+xVW94EBp2RqJNiVBawuXeu
         wQnVRTUdNTgZpoGmzTaFdFlPK0GsKb5ilTf1/ykE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F12C602F1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v2 2/2] ACPI/PPTT: Handle architecturally unknown cache
 types
To:     Sudeep Holla <sudeep.holla@arm.com>, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
        jeremy.linton@arm.com
Cc:     linux-kernel@vger.kernel.org, vkilari@codeaurora.org
References: <1536942489-4018-1-git-send-email-jhugo@codeaurora.org>
 <1536942489-4018-3-git-send-email-jhugo@codeaurora.org>
 <71208e0e-fba9-ad6c-7578-a53fd1aa3f40@arm.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <0a40d4e5-8b5b-dc6c-17e3-d6f02e396b2d@codeaurora.org>
Date:   Mon, 17 Sep 2018 16:46:27 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <71208e0e-fba9-ad6c-7578-a53fd1aa3f40@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/2018 10:17 AM, Sudeep Holla wrote:
> 
> 
> On 14/09/18 17:28, Jeffrey Hugo wrote:
>> The type of a cache might not be specified by architectural mechanisms (ie
>> system registers), but its type might be specified in the PPTT.  In this
>> case, we should populate the type of the cache, rather than leave it
>> undefined.
>>
>> This fixes the issue where the cacheinfo driver will not populate sysfs
>> for such caches, resulting in the information missing from utilities like
>> lstopo and lscpu, thus degrading the user experience.
>>
>> Fixes: 2bd00bcd73e5 (ACPI/PPTT: Add Processor Properties Topology Table parsing)
>> Reported-by: Vijaya Kumar K <vkilari@codeaurora.org>
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> ---
>>   drivers/acpi/pptt.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index d1e26cb..bb00ed9 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -402,11 +402,18 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>>   		}
>>   	}
>>   	/*
>> -	 * If the above flags are valid, and the cache type is NOCACHE
>> -	 * update the cache type as well.
>> +	 * If cache type is NOCACHE, then the cache hasn't been specified
>> +	 * via other mechanisms.  Update the type if either the cache has
>> +	 * been fully specified in PPTT, or a cache type has been provided.
>> +	 *
>> +	 * Note, we assume such caches are unified based on conventional system
>> +	 * design and known examples.  Significant work is required elsewhere to
>> +	 * fully support data/instruction only type caches which are only
>> +	 * specified in PPTT.
>>   	 */
>> -	if (this_leaf->type == CACHE_TYPE_NOCACHE &&
>> -	    valid_flags == PPTT_CHECKED_ATTRIBUTES)
>> +	if ((this_leaf->type == CACHE_TYPE_NOCACHE) &&
>> +	    (valid_flags == PPTT_CHECKED_ATTRIBUTES ||
>> +	     found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID))
>>   		this_leaf->type = CACHE_TYPE_UNIFIED;
> 
> I thought I did mention that we can drop the valid_flags altogether
> unless Jeremy has reasons not to.
> 

You suggested that perhaps that could be the case.  It seemed like an 
open question to me.  I'm at Linaro Connect without access to the device 
this week, so I guess someone has roughly a week to chime in that the 
valid flags should be kept, otherwise I'll try a v3 with them removed.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
