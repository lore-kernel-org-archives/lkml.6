Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1C0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D68C20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ow/tgEas";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W5lN0GEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbfBFREW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:04:22 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41262 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730733AbfBFREV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:04:21 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5EDEA6047C; Wed,  6 Feb 2019 17:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549472660;
        bh=7edcRz5sqQjS5pMCHSsqf/9aYnpmwbMb2pKXj2ZcDfs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ow/tgEaso8KD/PWjSC0dG0+44fPoof1m6u5Hd0doJE3ODFDX65/CWWozbWLfm5HL9
         VjcX5fUEUAp5v+2fLULLcWZRwlfNwtbUSLMjHmzujCpCO8lz3vQNQy2s8GX+VVNy7q
         d10wBS6XdfYRLayqP2Bc4JHanN0DTrA4bBcV/qB8=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5EC676047C;
        Wed,  6 Feb 2019 17:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549472659;
        bh=7edcRz5sqQjS5pMCHSsqf/9aYnpmwbMb2pKXj2ZcDfs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W5lN0GEchkKjWlcoMwoZUEmFMAL7qHYfSKAG9TAGnJK9KWrKvt4R/BdzJC0qeC308
         P0DRtUphnPXVaUsd+nx5req7QlUo/bZ84xIszNJTWomPR1O9exJOV8MTGXvrhnA+b2
         +2SpnxSavJIGgl/Gn840byNiHmrMRfbtD7+L2Dl4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5EC676047C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v1 1/4] clk: qcom: smd: Add XO clock for MSM8998
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, bjorn.andersson@linaro.org,
        mturquette@baylibre.com
Cc:     marc.w.gonzalez@free.fr, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1548866102-30224-1-git-send-email-jhugo@codeaurora.org>
 <1548866144-30265-1-git-send-email-jhugo@codeaurora.org>
 <154940408967.169292.15276398799323074789@swboyd.mtv.corp.google.com>
 <6e62a49a-fdb1-a087-fe83-e86aed969ae7@codeaurora.org>
 <154940592132.169292.15811923452101983358@swboyd.mtv.corp.google.com>
 <40ae31ba-7464-22c2-5782-a225d0f17b3b@linaro.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <cc7e1104-0fbd-5948-4ed2-af17cdf17e3d@codeaurora.org>
Date:   Wed, 6 Feb 2019 10:04:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <40ae31ba-7464-22c2-5782-a225d0f17b3b@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/2019 6:55 AM, Georgi Djakov wrote:
> Hi Jeffrey,
> 
> On 2/6/19 00:32, Stephen Boyd wrote:
>> Quoting Jeffrey Hugo (2019-02-05 14:15:16)
>>> On 2/5/2019 3:01 PM, Stephen Boyd wrote:
>>>> Quoting Jeffrey Hugo (2019-01-30 08:35:44)
>>>>> The XO clock generally feeds into other clock controllers as the parent
>>>>> for a lot of clock generators.
>>>>>
>>>>> Fixes: 6131dc81211c (clk: qcom: smd: Add support for MSM8998 rpm clocks)
>>>>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>>>>
>>>> We've historically left out the XO clk because it causes problems where
>>>> the XO vote goes away during late init because nobody references it from
>>>> the rest of the clk tree and also because RPM defers probe of the system
>>>> and then the console blows up when it gets a clk that can't change rate.
>>>> See commit 54823af9cd52 ("clk: qcom: Always add factor clock for xo
>>>> clocks") for some more info on why we removed all the workarounds and
>>>> stuff around here too.
>>>>
>>>> So are you sure this is OK to do?
>>>>    
>>>>
>>>
>>> So, I've got pretty much everything as modules, and I haven't seen any
>>> issues.  However let me take a look at the commit you point out and see.
>>>
>>
>> Is the name of the clk "xo_clk_src"? That isn't the name that we were
>> expecting the XO clk from RPM to be called. You might have to look back
>> at the history of the rpm clk driver on the list and see when Georgi
>> dropped the XO clk from it and if there was anything wrong with that. I
>> can't recall if this was discussed on the list or if he just told me in
>> some hallway conversation at Connect.
> 
> The problem back then was the following: The RPM clock driver has
> various dependencies on other drivers (hwspinlock, smem, smd, rpmsg etc)
> and may probe defer multiple times during boot. Meanwhile the GCC clocks
> are registered as orphans, as their parent clock (RPM XO) is not there
> yet. And when some driver calls clk_get_rate() on an orphan clock, a
> bogus rate is returned. The consequence of this was that the serial
> console was broken, because of the baud rate being calculated based on
> this bogus clock rate.

Ok.  As far as I am aware, that issue still basically exists but I don't 
seem to be hitting it.  I suspect timing.  However, it seems like the 
key point is that GCC is initing, doesn't have its dependencies in 
place, but is allowing client activity anyways.  It seems like either 1) 
GCC should detect XO isn't present (yet), and probe defer or 2) clocks 
are somehow not usable if the parent hasn't appeared yet (maybe such 
parents are marked as critical somehow?)

Stephen, what are your thoughts?


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
