Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC2BC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D806E2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iexkjktl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D806E2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeJHOCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:02:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41940 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeJHOCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:02:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id m77-v6so7884718pfi.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 23:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JPp2uR23R+lIoMLxsChrBT/YZizPdDwgdgOyL9jss+4=;
        b=IexkjktlpJ+yln3vBngCsFsuLMcaWV2f252VLX2/JTZ0Q8iy8wkCj99tBUgvK7vthj
         70LuU67zcqhJkLws/j7+9O9JP5YOiFkm0VXa3wqzMNLsP188TolI82xg1i6f6wBLAlZ5
         tVOULlAoTdvUP+RvUqDy1s5RUvE0OzMFIVWSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JPp2uR23R+lIoMLxsChrBT/YZizPdDwgdgOyL9jss+4=;
        b=Sics9vps2MMJvGO3iWP9fIPL5cpwpD1YAt926pkEps2rN3wTAuzgIAfjz1DW4ac2mU
         ayhbpMP6I9DfsW1tpuCVdD4hDOtY7fncEl94aLeHFzhmQ6j7qJEfxe60kinmv9uVQsDA
         lxbCguzFzOwi5Q5TimGtCaPCi5ooNgpA6Xfjfp2ksSQned6LMIwOuPnjwws8bjmrIs6/
         irj58bBsL0PiiDO5JIqO1klAwgo8TR6J7jWyS6nYRBOLpvEbgQuOsw2ZVUClK2YwDYYD
         Eea4ZestDhC0LJsTcBFCSDBHWaNlRkuQmoFClpQAvXqcL6UrE1QBAeHoTg1VMQMQy5JJ
         q/zw==
X-Gm-Message-State: ABuFfogGEWcu5hHrNNtzQFTpftP8+yZJM7EYvUfrYdFsdfakoYSu/CP/
        nDZal2XTjqGZLjrkVD3pDpRoqyaptpKKUg==
X-Google-Smtp-Source: ACcGV60G7lH8odWJNrY23aA2dzF9f1pWQo+GGPfptiCQkX/xaMFOZl6llQ/V3ke5+WDnHIE8vanuhA==
X-Received: by 2002:a65:5188:: with SMTP id h8-v6mr19907978pgq.288.1538981532731;
        Sun, 07 Oct 2018 23:52:12 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r18-v6sm18839062pgj.51.2018.10.07.23.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 23:52:12 -0700 (PDT)
Date:   Sun, 7 Oct 2018 23:55:02 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ohad@wizery.com, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH v3 6/6] remoteproc: qcom: q6v5-pil: Assign the relocated
 address
Message-ID: <20181008065502.GQ12063@builder>
References: <20180727152003.11663-1-sibis@codeaurora.org>
 <20180727152003.11663-7-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727152003.11663-7-sibis@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 27 Jul 08:20 PDT 2018, Sibi Sankar wrote:

> Assign the relocated base of the modem image, as the offsets
> from the virtual memory might not be based on the physical
> address.
> 

In order to get this merged before the first call to rproc_da_to_va() I
applied this patch to rproc-next.

Thanks,
Bjorn

> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/remoteproc/qcom_q6v5_pil.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
> index 22bb049c3e7f..b1296d614b8b 100644
> --- a/drivers/remoteproc/qcom_q6v5_pil.c
> +++ b/drivers/remoteproc/qcom_q6v5_pil.c
> @@ -862,6 +862,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>  	}
>  
>  	mpss_reloc = relocate ? min_addr : qproc->mpss_phys;
> +	qproc->mpss_reloc = mpss_reloc;
>  	/* Load firmware segments */
>  	for (i = 0; i < ehdr->e_phnum; i++) {
>  		phdr = &phdrs[i];
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
