Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3B8C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BAA215FA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VCakmkiA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q2jugY11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BAA215FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbeHNVTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 17:19:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33848 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbeHNVTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 17:19:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 453E460710; Tue, 14 Aug 2018 18:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534271436;
        bh=+MKoJfAKL95nPnPbxaYFQaksmkgEX2WLcfVbx92Iayw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VCakmkiAfExRk1/C028msYEa2R8PvhGxFwjnejZV2UJHvwgvseC0RcnV/0I3BdJZO
         yDe58yEArbMF86Hcokjo5S5LX9H/2YV+2uPS3wdwMfdN1h4HWFEQB+0mfDoXZhAo/0
         6aAkR2okOO33GqsdM0DJEgPoCvv/weWH4thtCnYw=
Received: from [10.46.160.165] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: collinsd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 358C0600C1;
        Tue, 14 Aug 2018 18:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534271435;
        bh=+MKoJfAKL95nPnPbxaYFQaksmkgEX2WLcfVbx92Iayw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Q2jugY11peWAT0XwxZ7/IbpbPyOpIKK+W/gLB+e38r0gCbc2WitVgIk+xURQSQiAb
         nJBnkBoFRh2ngUIViDh16APuotvXv/RKv6ndDgNyjzU5LbVHGZVnamsF7swoyf4FQ1
         6aQx3vNsnFyRgjSw6vqOOM2GOInCUlItXfVayQQM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 358C0600C1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH 1/4] regulator: core: If consumers don't call
 regulator_set_load() assume max
To:     Douglas Anderson <dianders@chromium.org>, broonie@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20180814170617.100087-1-dianders@chromium.org>
 <20180814170617.100087-2-dianders@chromium.org>
From:   David Collins <collinsd@codeaurora.org>
Message-ID: <bf70f01d-41ac-dcdc-b503-5e0eb1e70329@codeaurora.org>
Date:   Tue, 14 Aug 2018 11:30:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180814170617.100087-2-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Doug,

On 08/14/2018 10:06 AM, Douglas Anderson wrote:
> Not all regulator consumers call regulator_set_load().  On some
> regulators (like on RPMh-regulator) this could be bad since the
> regulator framework will treat this as if consumer needs no load.
> It's much better to assume that a dumb client needs the maximum
> possible load so we get correctness first.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

The behavior introduced by this patch seems like an undesirable hack to
me.  It goes against the general philosophy within the regulator framework
of taking no action unless directed to do so by an explicit consumer
request (or special device tree property).  We should assume that
consumers make requests to meet their needs instead of assuming that they
are missing important votes required by their hardware.


>  drivers/regulator/core.c     | 10 +++++++++-
>  drivers/regulator/internal.h |  1 +
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 6ed568b96c0e..a4da68775b49 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -732,6 +732,7 @@ static int drms_uA_update(struct regulator_dev *rdev)
>  	struct regulator *sibling;
>  	int current_uA = 0, output_uV, input_uV, err;
>  	unsigned int mode;
> +	bool any_unset = false;
>  
>  	lockdep_assert_held_once(&rdev->mutex);
>  
> @@ -751,11 +752,17 @@ static int drms_uA_update(struct regulator_dev *rdev)
>  		return -EINVAL;
>  
>  	/* calc total requested load */
> -	list_for_each_entry(sibling, &rdev->consumer_list, list)
> +	list_for_each_entry(sibling, &rdev->consumer_list, list) {
>  		current_uA += sibling->uA_load;
> +		if (!sibling->uA_load_set)
> +			any_unset = true;
> +	}
>  
>  	current_uA += rdev->constraints->system_load;
>  
> +	if (any_unset)
> +		current_uA = INT_MAX;
> +

This check will incorrectly result in a constant load request of INT_MAX
for all regulators that have at least one child regulator.  This is the
case because such child regulators are present in rdev->consumer_list and
because regulator_set_load() requests are not propagated up to parent
regulators.  Thus, the regulator structs for child regulators will always
have uA_load==0 and uA_load_set==false.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
