Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303C6C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8D62087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D03o6j0l";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QjtkoBgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfAGHh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:37:29 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55980 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfAGHh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:37:29 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5FC2460300; Mon,  7 Jan 2019 07:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546846648;
        bh=Lje7J2lQdvFGTk5vgncIv6FawbQ1LMuYmtajnVp+ltc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=D03o6j0lwWMWqxwZvUkHK5pSLolDcnuyEjSCFeFdiwKsvgXTxuigCiGIycK5TQhyT
         Ez5wpFBPRckk4uHvdecdOmnYOtsS9CPLojzHgvt9/jBN8Mly4KgU9masPngh76xldN
         CclIicvCbTciYAThe1z1nZ3JWk1VeSvnhcWNzc08=
Received: from [192.168.225.247] (unknown [49.33.229.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A9518601B4;
        Mon,  7 Jan 2019 07:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546846647;
        bh=Lje7J2lQdvFGTk5vgncIv6FawbQ1LMuYmtajnVp+ltc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QjtkoBgXl6NSw8zH7VzbnGc+hS8/C2iHcp39es1GGtiRXzYgtB1BXRRFptBhnioPr
         wzDk8OKe2ZTTnmyz8yowesz88/huGUFrpuznYpPaTbJzKCrx6xImQlEKLFi9pbS12q
         qxySh430Q/TPd7Dn8x/CefsWlmSJ7VMQyY7fnKR4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A9518601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v1] cpufreq: qcom: Read voltage LUT and populate OPP
To:     Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        Matthias Kaehlcke <mka@chromium.org>, evgreen@google.com
References: <1545415608-15163-1-git-send-email-tdas@codeaurora.org>
 <154542875327.13075.3548703610883534822@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <10e458b8-e17f-0502-5b2a-84ca179656ea@codeaurora.org>
Date:   Mon, 7 Jan 2019 13:07:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154542875327.13075.3548703610883534822@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/22/2018 3:15 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-12-21 10:06:48)
>> Add support to read the voltage look up table and populate OPP for all
>> corresponding CPUS.
> 
> Yes, but why? Please specify the motivations in the commit text.
> 
Sure, would update in the next patch.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
