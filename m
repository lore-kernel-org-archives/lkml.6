Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD962C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9788221A12
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5HPvgpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9788221A12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388046AbeHGI2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 04:28:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387889AbeHGI2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 04:28:33 -0400
Received: from localhost (unknown [122.167.122.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B376C21A12;
        Tue,  7 Aug 2018 06:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533622549;
        bh=/G2kfNUROlE/u06AIPMdhxwC2w4vV5swH0y+jORv/SU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z5HPvgpWYnHXA8AOI+JbgSXwLTy7iKdfL84bgruZ6nHGL7fCWAZFNr437dh/yn7Tz
         b0DqwwnHvp7fw+wd+i311Q0Q1Gg/tXVFlJlwpv/QgF5YA0B+mUtyyN9difRYo89zHG
         1UKHb3X5LIKIMinSG7xIRGeSdqLCuVWcSDH+0nlo=
Date:   Tue, 7 Aug 2018 11:45:39 +0530
From:   Vinod <vkoul@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ohad@wizery.com, kyan@codeaurora.org,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Subject: Re: [PATCH v3 1/6] remoteproc: Introduce custom dump function for
 each remoteproc segment
Message-ID: <20180807061539.GG2395@vkoul-mobl>
References: <20180727152003.11663-1-sibis@codeaurora.org>
 <20180727152003.11663-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727152003.11663-2-sibis@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

On 27-07-18, 20:49, Sibi Sankar wrote:
> Introduce custom dump function per remoteproc segment. It is responsible
> for filling the device memory segment associated with coredump
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/remoteproc/remoteproc_core.c | 15 ++++++++++-----
>  include/linux/remoteproc.h           |  3 +++
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 283b258f5e0f..ec56cd822b26 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1183,13 +1183,18 @@ static void rproc_coredump(struct rproc *rproc)
>  		phdr->p_align = 0;
>  
>  		ptr = rproc_da_to_va(rproc, segment->da, segment->size);
> -		if (!ptr) {
> -			dev_err(&rproc->dev,
> +
> +		if (segment->dump) {
> +			segment->dump(rproc, ptr, segment->size, data + offset);

Am not sure I follow, you are calling this w/o checking if ptr is valid,
so you maybe passing null to segment->dump() ?

> +		} else {
> +			if (!ptr) {
> +				dev_err(&rproc->dev,
>  				"invalid coredump segment (%pad, %zu)\n",
>  				&segment->da, segment->size);
> -			memset(data + offset, 0xff, segment->size);
> -		} else {
> -			memcpy(data + offset, ptr, segment->size);
> +				memset(data + offset, 0xff, segment->size);
> +			} else {
> +				memcpy(data + offset, ptr, segment->size);
> +			}

-- 
~Vinod
