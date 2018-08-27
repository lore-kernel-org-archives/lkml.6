Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72B7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BC621722
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VvXbLXIg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VvXbLXIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BC621722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeH0Kl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 06:41:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39220 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbeH0Kl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 06:41:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BBB8160241; Mon, 27 Aug 2018 06:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535352997;
        bh=Q3K6GjTnFMoCzhIVMZa3f5obK+2n76xcgfCLmGrt2OQ=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=VvXbLXIgzk8STg4F3/ziy628ThcSs8YJfmPqGZSoFjL6wZ6U7kqnFz6xfdtUOHUjT
         pVBfjyixMS6fmx2Rnf4zp4afPSOnNMdu0e6KElrLsb9OkVTfRRGee7EMLicJtVqexg
         L6jBFgnlOQ6X0GfM4dCjpAEovQatScbPCTIkLMjM=
Received: from [10.204.79.20] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gkohli@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B48F60241;
        Mon, 27 Aug 2018 06:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535352997;
        bh=Q3K6GjTnFMoCzhIVMZa3f5obK+2n76xcgfCLmGrt2OQ=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=VvXbLXIgzk8STg4F3/ziy628ThcSs8YJfmPqGZSoFjL6wZ6U7kqnFz6xfdtUOHUjT
         pVBfjyixMS6fmx2Rnf4zp4afPSOnNMdu0e6KElrLsb9OkVTfRRGee7EMLicJtVqexg
         L6jBFgnlOQ6X0GfM4dCjpAEovQatScbPCTIkLMjM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B48F60241
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH] percpu_counter: Remove debug_object_free call twice
From:   "Kohli, Gaurav" <gkohli@codeaurora.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, nborisov@suse.com,
        akpm@linux-foundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1523612103-15071-1-git-send-email-gkohli@codeaurora.org>
 <20180416214810.GF1911913@devbig577.frc2.facebook.com>
 <a9ef4575-bfb9-c854-ea71-0a5e1af97f5d@codeaurora.org>
Message-ID: <5703acbf-da53-7409-7d73-f48e580ce1cd@codeaurora.org>
Date:   Mon, 27 Aug 2018 12:26:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a9ef4575-bfb9-c854-ea71-0a5e1af97f5d@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,

Sorry for very late reminder, just wanted to know is below understanding 
of code is wrong?

Regards
Gaurav

On 4/17/2018 11:59 AM, Kohli, Gaurav wrote:
> On 4/17/2018 3:18 AM, Tejun Heo wrote:
> 
>> On Fri, Apr 13, 2018 at 03:05:03PM +0530, Gaurav Kohli wrote:
>>> During percpu_counter destroy, debug_object_free is calling
>>> twice which may create race. So removing once instance of call
>>> from debug_percpu_counter_deactivate.
>> I don't quite follow.  Can you please elaborate how it can be called
>> twice?
> 
> Hi Tejun,
> 
> In percpu_counter_fixup_free function, first call is 
> percpu_counter_destroy -> debug_percpu_counter_deactivate (this will set 
> inactive and free the debug object as well for percpu counter) -> 
> free_percpu (finally freeing the counters).
> 
> Below is the code snippet:
> 
>          case DEBUG_STATE_ACTIVE:
> 
>                  percpu_counter_destroy(fbc); -> first call
> 
>                  debug_object_free(fbc, &percpu_counter_debug_descr); -> 
> this will again call the same debug object free, if somehow counters 
> will reinitialize between these two calls.
> 
> 
> We are seeing one race condition issue where one object of db list is 
> corrupted and just before object of that corrupted node is 
> percpu_counter, Still i am not sure the reason of race as it is very
> 
> difficult to reproduce. But i have found this during code review. Please 
> correct me, if i misunderstood this.
> 
>>
>> Thanks.
>>
>>

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
