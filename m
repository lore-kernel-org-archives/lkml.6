Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D31C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534D920870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lGUPlC0F";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Yrpwkn3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfAVV5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:57:48 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47754 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfAVV5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:57:48 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 19A1E6074E; Tue, 22 Jan 2019 21:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548194267;
        bh=slzva9b7Horeo6+Qx1RPzLwHG79/nUlFt6Dz5noHP0s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lGUPlC0FpDuZE2erlxY2KSjUWFa+tUcKAKahj0e7U8e4Sqbk64kNXu1yhYsJq88JK
         2NYBMk+tG8Ldwdx+DLATlzhIHu88MG140gQ6c0rHfrNV2vp9Q+NEoGyx/ZRBTk8nCu
         i+dRLSzs+uD2e1V/NLP5M3losCzHXLDBqYihZZbs=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0E3A660740;
        Tue, 22 Jan 2019 21:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548194266;
        bh=slzva9b7Horeo6+Qx1RPzLwHG79/nUlFt6Dz5noHP0s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Yrpwkn3Jg16ugIDXT5ZAHWUNyq9zaEtfvjMSDPbobCZF16WBRE+w8Pn4P5WtMNgqU
         TpxjAnfhowbYS7ncif5ZV1J2wNm10VahWS0UgyxuqUFb+IoLbuQpLQvTRvT53A0yt/
         luHBdscU99XrZyVdVXH/wSsqF7J9FsmYr8iP7yrI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0E3A660740
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH] regulator: qcom-smd: Batch up requests for disabled
 regulators
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20190122190147.26735-1-bjorn.andersson@linaro.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <5165f4d3-5c98-86de-4813-589e1e3da3d8@codeaurora.org>
Date:   Tue, 22 Jan 2019 14:57:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122190147.26735-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/2019 12:01 PM, Bjorn Andersson wrote:
> In some scenarios the early stages of the boot chain has configured
> regulators to be in a required state, but the later stages has skipped
> to inform the RPM about it's requirements.
> 
> But as the SMD RPM regulators are being initialized voltage change
> requests will be issued to align the voltage with the valid ranges. The
> RPM aggregates all parameters for the specific regulator, the voltage
> will be adjusted and the "enabled" state will be "off" - and the
> regulator is turned off.
> 
> This patch addresses this problem by caching the requested enable state,
> voltage and load and send the parameters in a batch, depending on the
> enable state - effectively delaying the voltage request for disabled
> regulators.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

This happens to fix an annoyance I've been avoiding on 8998.

Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
