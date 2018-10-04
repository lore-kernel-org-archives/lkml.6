Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A307C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0EA20877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MrkB5Xo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0EA20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJDL3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 07:29:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32929 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbeJDL3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 07:29:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id y18-v6so2561419pge.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 21:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jQeE93VbbNfp3K7xt8jRqG4vlZUs03OTr7LfpQaa+tI=;
        b=MrkB5Xo+6Yg102g/uglJPmqxNterNLrQuqrdM5BZzzRdI2jh2RS5/4tSBXh/ThHNBv
         UdIxRW1p6+52bHapMMf3LIaer0KdMdbgxrizkJE8z9e1wtw6PjqoGuBT6uonkH9PDLaB
         Q57t7CrdeE1ITvJ+sdB7p/O1HWRwhc1ggFu4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jQeE93VbbNfp3K7xt8jRqG4vlZUs03OTr7LfpQaa+tI=;
        b=gX8ksODCKPI6mPixa6vv0XpxeqaV1VDiBqXWBqUQP/cukk8zJjQNRDjNEKzeqT+woM
         tqBiqDu8KMBXwjrJo1tjyCYCoYKDlsaRJJluFHIB+KTaZmdM6e7bYyjF2qcek7JooXN0
         9BC1FKpTL9FwyNAcNfP7252ywJ5aJq6Uw/y7AdSjdcM4xMD9GJdwOx3PgHIU8GgdltXH
         zlRHhLhYJb9S27aoVg/mVj2J/rySeRnc3A303eUegUe5npaR/R7ZXcxXIFH9W/OaAsDR
         Ahufqjw+E8bav9BcA1mJZIFj1cp3a1zBv9+3m/gJfRgsyXudJoz+bX76ImfLJP7GjC+x
         3fcg==
X-Gm-Message-State: ABuFfogvffn+NCeTQX9p8UsSYXFXA3+mMKlk45v3LznZn8wTEAICb3p8
        IsTQcGVW1x0F9JXdT6+SNHHJwA==
X-Google-Smtp-Source: ACcGV62fWji7Dgwn7I4NdFyfqi835U+9NFgU3dCpnZnpJciXpS1/Q3WZX2a5c5mVYE9cbb9gVi6YVQ==
X-Received: by 2002:a63:9a19:: with SMTP id o25-v6mr4104517pge.440.1538627882126;
        Wed, 03 Oct 2018 21:38:02 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f25-v6sm4239847pfn.177.2018.10.03.21.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 21:38:01 -0700 (PDT)
Date:   Wed, 3 Oct 2018 21:37:59 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arun Kumar Neelakantam <aneela@codeaurora.org>
Cc:     davem@davemloft.net, clew@codeaurora.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        fw@strlen.de, hannes@stressinduktion.org, dvlasenk@redhat.com,
        nicolas.dechesne@linaro.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: qmi_interface: Limit txn ids to U16_MAX
Message-ID: <20181004043759.GB1656@tuxbook-pro>
References: <1538545205-17939-1-git-send-email-aneela@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538545205-17939-1-git-send-email-aneela@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02 Oct 22:40 PDT 2018, Arun Kumar Neelakantam wrote:

> Txn IDs created up to INT_MAX cause overflow while storing
> the IDs in u16 type supported by QMI header.
> 
> Limit the txn IDs max value to U16_MAX to avoid overflow.
> 
> Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/soc/qcom/qmi_interface.c | 2 +-
>  include/linux/soc/qcom/qmi.h     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/qmi_interface.c b/drivers/soc/qcom/qmi_interface.c
> index 938ca41c..c239a28 100644
> --- a/drivers/soc/qcom/qmi_interface.c
> +++ b/drivers/soc/qcom/qmi_interface.c
> @@ -318,7 +318,7 @@ int qmi_txn_init(struct qmi_handle *qmi, struct qmi_txn *txn,
>  	txn->dest = c_struct;
>  
>  	mutex_lock(&qmi->txn_lock);
> -	ret = idr_alloc_cyclic(&qmi->txns, txn, 0, INT_MAX, GFP_KERNEL);
> +	ret = idr_alloc_cyclic(&qmi->txns, txn, 0, U16_MAX, GFP_KERNEL);
>  	if (ret < 0)
>  		pr_err("failed to allocate transaction id\n");
>  
> diff --git a/include/linux/soc/qcom/qmi.h b/include/linux/soc/qcom/qmi.h
> index f4de336..5efa2b6 100644
> --- a/include/linux/soc/qcom/qmi.h
> +++ b/include/linux/soc/qcom/qmi.h
> @@ -166,7 +166,7 @@ struct qmi_ops {
>  struct qmi_txn {
>  	struct qmi_handle *qmi;
>  
> -	int id;
> +	u16 id;
>  
>  	struct mutex lock;
>  	struct completion completion;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
