Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B49C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C6221848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dVGlHpWR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZgLyAntn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfBSFMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 00:12:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55826 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfBSFMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 00:12:15 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 94EA1601EA; Tue, 19 Feb 2019 05:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550553134;
        bh=UceMNJY89LMvSt0KG3sLmvSflj73++pbpAjRA3dwbhE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dVGlHpWRERoT56c8KrMG++dwN1PUk+46ntfbKu47kTLOj5o1otlcvKIxiG++L7z4e
         T+dpEaeNU5lWqeBRoxdMDM6Io4etWa6GABsJLZiWEodfQYy0Gbjm5dMKYxgoE8rYYX
         XGzdSx9ETaY0qa0LgFbyobjjYkqif5PHtdk7Chgk=
Received: from [10.79.40.96] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 73679608CD;
        Tue, 19 Feb 2019 05:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550553133;
        bh=UceMNJY89LMvSt0KG3sLmvSflj73++pbpAjRA3dwbhE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZgLyAntn529KBayr9+3bK2s2SlBzAyLgA1CbK0+05B/o5/loJr4/8FoXIW5rgZVt+
         4tQDmPhByhlsnyFDlYW+4f5l51uayWohEJvcM7SmKxf05NZdpi17P/o8zD7TO1KDb1
         RSbtAMq0w68GWGjaVPcULXI7WM9xE+l9qNCn6Sy4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73679608CD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v4] PM / devfreq: Restart previous governor if new
 governor fails to start
To:     myungjoo.ham@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm-owner@vger.kernel.org" 
        <linux-arm-msm-owner@vger.kernel.org>,
        "skannan@codeaurora.org" <skannan@codeaurora.org>
References: <20181212135313.30268-1-sibis@codeaurora.org>
 <CGME20181212135338epcas5p12f7a8cd1c7aab5d5c936cbc5c33eee07@epcms1p6>
 <20181214014527epcms1p6c783b4cd1602bbcbcb6e725f840db479@epcms1p6>
From:   Sibi Sankar <sibis@codeaurora.org>
Message-ID: <39d3a906-b734-9bb8-c60a-48948bb21338@codeaurora.org>
Date:   Tue, 19 Feb 2019 10:42:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181214014527epcms1p6c783b4cd1602bbcbcb6e725f840db479@epcms1p6>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey MyungJoo,

On 12/14/18 7:15 AM, MyungJoo Ham wrote:
>> From: Saravana Kannan <skannan@codeaurora.org>
>>
>> If the new governor fails to start, switch back to old governor so that the
>> devfreq state is not left in some weird limbo.
>>
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> Hello,
> 
> In overall, the idea and the implementation looks good.
> 
> However, I have a question:
> 
> What if the following line fails?
> 
> +		df->governor->event_handler(df, DEVFREQ_GOV_START,
> +					    NULL);
> 
> Don't we still need something to handle for such events?

The original discussion went as follows:
governor_store is expected to be used only on cases
where devfreq_add_device() succeeded i.e prev->governor
is expected to be present and DEVFREQ_GOV_START is
expected to succeed. Hence falling back to the previous
governor seems like a sensible idea.

This would also prevent DEVFREQ_GOV_STOP from being called
on a governor were DEVFREQ_GOV_START had failed which is
ideal.

That being said DEVFREQ_GOV_START can still fail for the
prev-governor due to some change in state of the system.
Do you want to handle this case by clearing the state of
governor rather than switching to previous governor?

> 
> Cheers,
> MyungJoo
> 
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
