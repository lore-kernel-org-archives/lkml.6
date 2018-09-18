Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9498C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73520206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GOJbcxsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73520206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbeISBEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:04:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38734 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729234AbeISBEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:04:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id t84-v6so1516392pgb.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 12:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xi8jRQBEwQF8lgdORjPfsCnEPFBSZxipoHoEMjNvXXs=;
        b=GOJbcxsXmsulwfiz95PM8rXxOhS9IfbwG/GaBgyxkxygRsqjVKv8+jGkp/Hi6GMayP
         61myYHkxMdGeajcSujNpAQBq9N42tj0QLV+f52Mql0CbxSh0DlgrSHn8UBffrMPdtauE
         t8sFlWlYylhtGiBZ4iFyRzmyG5DJWmWScO7gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xi8jRQBEwQF8lgdORjPfsCnEPFBSZxipoHoEMjNvXXs=;
        b=uH1iU3PUBroHJ45woSAoLQrruF97pP1lyiTmJyw73l8jnxX3yp/ZY6zSI0dp2FNKGs
         52OFciOviUWrog4RCN9GRsBKvCATFO5SrSexbT+E2c5LD64Pz/1pHTkdl1nWubln65f7
         vLp2zRelPaB9mF+dDf/qUyCKF5mje/EiEfemu3vafJxWBO2OjJn7g7sLTsl/IqfvaXX9
         wcWscRsPms5J2h9QBZtadwO9k5M8ipzzju40mLd8nDr2wmXPRHnToxiUp4l1267/Yo+d
         1wqN+SIKSSnvC38PcvUg9CVshJK5O3WNhmbUZ1Y6AbJPZi7Yh1u8ywWAwOFG0U2c2EOM
         uSyw==
X-Gm-Message-State: APzg51Dn3zIAIDeyAZkl38ABJLIpvZR2vGWOf+EuUIBEnwfbBEw7mpUn
        O8NhFAlukyIvcrPKtoWfsUyumg==
X-Google-Smtp-Source: ANB0Vdb5Q9IkvcfHAgVK27A27csTVXRrGL/BTAkSK60tBax9H4Ycw75xZp+JAO4pYoDm7AcB0VFADA==
X-Received: by 2002:a62:3a08:: with SMTP id h8-v6mr32253737pfa.61.1537299039967;
        Tue, 18 Sep 2018 12:30:39 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m26-v6sm35049738pfi.102.2018.09.18.12.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 12:30:39 -0700 (PDT)
Date:   Tue, 18 Sep 2018 12:34:48 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 07/16] thermal: tsens: Pass register offsets as
 private data
Message-ID: <20180918193448.GA1367@tuxbook-pro>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
 <dccdcf386d8d5298a77ec31cde699852cc4409c5.1536744310.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dccdcf386d8d5298a77ec31cde699852cc4409c5.1536744310.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12 Sep 02:52 PDT 2018, Amit Kucheria wrote:
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 9a8e8f7b4ae1..f1ec9bbe4717 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -144,6 +144,9 @@ static int tsens_probe(struct platform_device *pdev)
>  		else
>  			tmdev->sensor[i].hw_id = i;
>  	}
> +	for (i = 0; i < REG_ARRAY_SIZE; i++) {
> +		tmdev->reg_offsets[i] = data->reg_offsets[i];
> +	}

Unnecessary {}

>  
>  	if (!tmdev->ops || !tmdev->ops->init || !tmdev->ops->get_temp)
>  		return -EINVAL;
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index b9c4bcf255fa..7b7feee5dc46 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -48,15 +48,23 @@ struct tsens_ops {
>  	int (*get_trend)(struct tsens_device *, int, enum thermal_trend *);
>  };
>  
> +enum reg_list {
> +	SROT_CTRL_OFFSET,
> +
> +	REG_ARRAY_SIZE,
> +};
> +
>  /**
>   * struct tsens_data - tsens instance specific data
>   * @num_sensors: Max number of sensors supported by platform
>   * @ops: operations the tsens instance supports
>   * @hw_ids: Subset of sensors ids supported by platform, if not the first n
> + * @reg_offsets: Register offsets for commonly used registers

Order doesn't match struct.

>   */
>  struct tsens_data {
>  	const u32		num_sensors;
>  	const struct tsens_ops	*ops;
> +	const u16		reg_offsets[REG_ARRAY_SIZE];
>  	unsigned int		*hw_ids;
>  };

Except of that you have my:

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
