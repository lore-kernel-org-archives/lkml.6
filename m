Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4EF4BC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A722089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NJATUnor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A722089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933537AbeFLTnH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:43:07 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35086 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754146AbeFLTnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:43:05 -0400
Received: by mail-pf0-f179.google.com with SMTP id c22-v6so73000pfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 12:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pE7G2Jmpz8oQI6dryddEkQgATlm2Fhjorz6xJTcdsN8=;
        b=NJATUnorz31JRCcDoHaI7H2ignLBzder9mBsSZDH7TVCwdLNHj7mLRNv+F74VI4tU2
         tWoXedpgTM3V2L3Jq0x/1nDiJxX5LjFFNu/Z9PJqHNMPgPItxSm8DWclQNhpTDME/jx/
         nkrziZmZOFTz09ZBH48TXF41Dx4Er1Ixd371s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pE7G2Jmpz8oQI6dryddEkQgATlm2Fhjorz6xJTcdsN8=;
        b=MGDB4K8IUZoL9mAVV20OkM1C4GkGOQhnwrsER6wMRQzUwQKHYY3lCtxJeYXJdMu0er
         evbZRpt6FilHJ03TWKaGNCWRF6XuOZ94VHcaIAfPhUS9fQ/T1pOC5bVHh2j4oKU4jJXe
         LweSdoIhbvHgk6cgwVp6DMMmgtSiHi2fMFaPAyY3hZ6WDincorDL0SBvG+49xDT5iD0I
         qewU3BP9Qz84Q6mNZWDphWHflvj04WAGyuj3btu3GeB7SrUZP9FKpLU6Aq4DqR6eUb9b
         f51dG+/uEpcZnn7PmxBGCVtPNfOlsn3T7wwm5hJYg3TAEAcFWdabbqz9b4d/QuX8J+nV
         GyXw==
X-Gm-Message-State: APt69E3sQI1YKRI79+6VtnGvzbf2Itf6nJzyRIDgMSYXaQqfC93vygNK
        PGsdvGQ2bNHht5l6UpkPkn546g==
X-Google-Smtp-Source: ADUXVKL5oSfZ03epOe4rl5cGAzAXIWRyd1I3vQQ4k//ZNmwevb50TERQHJ7dJKaADyjujEEgpeowXw==
X-Received: by 2002:a63:6e4e:: with SMTP id j75-v6mr1471643pgc.125.1528832584574;
        Tue, 12 Jun 2018 12:43:04 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y18-v6sm1027799pfl.122.2018.06.12.12.43.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 12:43:03 -0700 (PDT)
Date:   Tue, 12 Jun 2018 12:43:02 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] thermal: tsens: Move 8996 get_temp() to common
 code for reuse
Message-ID: <20180612194302.GP14924@minitux>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
 <ed6b51a1b08e195968f5423a86e40146279a8807.1528799892.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed6b51a1b08e195968f5423a86e40146279a8807.1528799892.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12 Jun 03:54 PDT 2018, Amit Kucheria wrote:
> diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-8996.c
[..]
>  static const struct tsens_ops ops_8996 = {
>  	.init		= init_common,
> -	.get_temp	= get_temp_8996,
> +	.get_temp	= get_temp_tsens_v2,
>  };
>  
>  const struct tsens_data data_8996 = {
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
[..]
> +int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)

I like the function name, but it's not really common for tsens, it's
just common for tsens v2. Also as patch 4 shows we end up adding a set
of essentially empty platform specific files for referencing this
function.

I would suggest that you instead rename tsens-8996.c to tsens-v2.c,
rename ops_8996 to ops_v2 and either add new tsens_data for each
platform or simply rename that too to data_v2 which we point to from
tsens_table.


I think we should take it once step further and add "qcom,tsens-v2" as a
valid compatible in tsens_table and make the dts do:

	comaptible = "qcom,msm8996-tsens", "qcom,tsens-v2";

and
	compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";

Regards,
Bjorn
