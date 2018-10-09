Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289D8C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC7B214DD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OZA8QYex";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OZA8QYex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC7B214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeJIX0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:26:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37982 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJIX0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:26:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8050A60769; Tue,  9 Oct 2018 16:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539101326;
        bh=zFZULSunT5LnxaYk6Ecs0J2mSCvVfeKE6bGpHn8yKFk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OZA8QYexIGhet398cF+5XnRv7jQzGInzL2zcr1YYy9Ye5lbgLZlMCTGdAUKEI16bO
         RuObgvp+nwy1/Mtit7tOCAGo1hFYdhv28Tfcg1+krCMwAfCRPCBTRgbMNc6YPgxagF
         F4EaSCTn9Di55OmCqhPQN8TuHl9XEjFUBnFvxUX4=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0DBB460591;
        Tue,  9 Oct 2018 16:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539101326;
        bh=zFZULSunT5LnxaYk6Ecs0J2mSCvVfeKE6bGpHn8yKFk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OZA8QYexIGhet398cF+5XnRv7jQzGInzL2zcr1YYy9Ye5lbgLZlMCTGdAUKEI16bO
         RuObgvp+nwy1/Mtit7tOCAGo1hFYdhv28Tfcg1+krCMwAfCRPCBTRgbMNc6YPgxagF
         F4EaSCTn9Di55OmCqhPQN8TuHl9XEjFUBnFvxUX4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 09 Oct 2018 21:38:46 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ohad@wizery.com, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org, linux-remoteproc-owner@vger.kernel.org
Subject: Re: [PATCH v3 1/6] remoteproc: Introduce custom dump function for
 each remoteproc segment
In-Reply-To: <20181008062333.GN12063@builder>
References: <20180727152003.11663-1-sibis@codeaurora.org>
 <20180727152003.11663-2-sibis@codeaurora.org>
 <20181008062333.GN12063@builder>
Message-ID: <002930d1f2515a5988f98a3bb1a5ceed@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
Thanks for the review :)

On 2018-10-08 11:53, Bjorn Andersson wrote:
> On Fri 27 Jul 08:19 PDT 2018, Sibi Sankar wrote:
> 
>> Introduce custom dump function per remoteproc segment. It is 
>> responsible
>> for filling the device memory segment associated with coredump
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  drivers/remoteproc/remoteproc_core.c | 15 ++++++++++-----
>>  include/linux/remoteproc.h           |  3 +++
>>  2 files changed, 13 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/remoteproc/remoteproc_core.c 
>> b/drivers/remoteproc/remoteproc_core.c
>> index 283b258f5e0f..ec56cd822b26 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -1183,13 +1183,18 @@ static void rproc_coredump(struct rproc 
>> *rproc)
>>  		phdr->p_align = 0;
>> 
>>  		ptr = rproc_da_to_va(rproc, segment->da, segment->size);
>> -		if (!ptr) {
>> -			dev_err(&rproc->dev,
>> +
>> +		if (segment->dump) {
>> +			segment->dump(rproc, ptr, segment->size, data + offset);
> 
> rproc_da_to_va() is an exported symbol, so if you pass segment to the
> dump function the driver can, if it needs to, call the function itself.
> 
> A typical use case, that I see, is to use the custom dump function to
> write out CPU or hardware state to the dump file, in which case the 
> "da"
> won't be valid.
> 
> 
> So please make this call dump(rproc, segment, data + offset) and move
> the rproc_da_to_va() into the else block.
> 

yup will redefine it.

>> +		} else {
>> +			if (!ptr) {
>> +				dev_err(&rproc->dev,
>>  				"invalid coredump segment (%pad, %zu)\n",
>>  				&segment->da, segment->size);
>> -			memset(data + offset, 0xff, segment->size);
>> -		} else {
>> -			memcpy(data + offset, ptr, segment->size);
>> +				memset(data + offset, 0xff, segment->size);
>> +			} else {
>> +				memcpy(data + offset, ptr, segment->size);
>> +			}
>>  		}
>> 
>>  		offset += phdr->p_filesz;
>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>> index e3c5d856b6da..0fbb01a9955c 100644
>> --- a/include/linux/remoteproc.h
>> +++ b/include/linux/remoteproc.h
>> @@ -399,6 +399,8 @@ enum rproc_crash_type {
>>   * @node:	list node related to the rproc segment list
>>   * @da:		device address of the segment
>>   * @size:	size of the segment
>> + * @dump:	custom dump function to fill device memory segment 
>> associated
>> + *		with coredump
>>   */
>>  struct rproc_dump_segment {
>>  	struct list_head node;
>> @@ -406,6 +408,7 @@ struct rproc_dump_segment {
>>  	dma_addr_t da;
>>  	size_t size;
>> 
>> +	void (*dump)(struct rproc *rproc, void *ptr, size_t len, void 
>> *priv);
> 
> "priv" isn't the best name to represent the memory to which you expect
> dump to write to. Please call it "dest".
> 

will rename it

>>  	loff_t offset;
>>  };
> 
> Regards,
> Bjorn

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
