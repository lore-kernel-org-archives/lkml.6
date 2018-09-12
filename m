Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D6FC07520
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A37421473
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NJ51reQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A37421473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeIMECd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 00:02:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39444 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbeIMECd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 00:02:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id w14-v6so1666556plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7jIkQMsy7dL73jCPrGtQJhHqhFWGALrp9j+xNrDXOj8=;
        b=NJ51reQCUOJ9F7IYKSm3NDs9xF5ceBf6WULs6xNZGBjTSbTtz3hQVLT7ANhV3gMQz0
         oyybue84Orsocxx1coQcOd+awd2nDzlXLvhYb/MsKC1D2dyCLPkONUu3crJ5SpJBKeg8
         S5vNYl+r7u+M75w2uEoIgGFAT3CCBO3Qari+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7jIkQMsy7dL73jCPrGtQJhHqhFWGALrp9j+xNrDXOj8=;
        b=rhK/rqKZPt3GxEZttCmtS7RgR+G0z4yblSfL7hrllnuO4du+TClZogh5YlA1GNyAdu
         SyvVhaGgWg7HdjuEqf+Oo83tykbcNQZuhMGGV4N0BOoDSylEdfQDeTWnzSodNms5rEaq
         XfBoCgq5tIpQvg5dWYvNmx+CYXhUqk+djFAJ3xOIYDDd2dhbeDQEMjB1mm1mnDJuL/9H
         BnCBQ0HgMIVbubCqSO8fborHQGlXRHnFlpkgUndNzlMrADeaY+7Cg9J4vvLQGO7RHbxC
         1m1Act48+p06DAlSXvZomIfWh0whHIZToPYGvLyh7p3xMILonsqGVrOSQexTb4XZrQ9L
         3eKw==
X-Gm-Message-State: APzg51AZN9pEHShMqHJR8g6hrkmtZHovHr2H5ic/r1iPn+NVxgq8EYAM
        /ccxDP1iKq2zT0CItdEtVwvo/A==
X-Google-Smtp-Source: ANB0VdZ1eHly+X2f9k+CSrkBBYnpJgTZubLkBn8c+9KFnLFk4HKkmWeeITpxTkv6gGU3MlNGoGFc0A==
X-Received: by 2002:a17:902:d213:: with SMTP id t19-v6mr4476171ply.63.1536792953669;
        Wed, 12 Sep 2018 15:55:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id c1-v6sm2737101pfi.142.2018.09.12.15.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 15:55:53 -0700 (PDT)
Date:   Wed, 12 Sep 2018 15:55:52 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Raju P L S S S N <rplsssn@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, ilina@codeaurora.org
Subject: Re: [PATCH v2 6/6] drivers: qcom: rpmh: write PDC data
Message-ID: <20180912225552.GM22824@google.com>
References: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
 <1532685889-31345-7-git-send-email-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1532685889-31345-7-git-send-email-rplsssn@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 03:34:49PM +0530, Raju P L S S S N wrote:
> From: Lina Iyer <ilina@codeaurora.org>
> 
> In addition to requests that are send to the remote processor, the
> controller may allow certain data to be written to the controller for
> use in specific cases like wakeup value when entering idle states.
> Allow a pass through to write PDC data.
> 
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmh.c | 28 ++++++++++++++++++++++++++++
>  include/soc/qcom/rpmh.h |  6 ++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index 0d276fd..f81488b 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -472,6 +472,34 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
>  }
>  EXPORT_SYMBOL(rpmh_write_batch);
>  
> +/**
> + * rpmh_write_pdc_data: Write PDC data to the controller
> + *
> + * @dev: the device making the request
> + * @cmd: The payload data
> + * @n: The number of elements in payload
> + *
> + * Write PDC data to the controller. The messages are always sent async.
> + *
> + * May be called from atomic contexts.
> + */
> +int rpmh_write_pdc_data(const struct device *dev,
> +			const struct tcs_cmd *cmd, u32 n)
> +{
> +	DEFINE_RPMH_MSG_ONSTACK(dev, 0, NULL, rpm_msg);

At first I was concerned about the message being created on the stack
and sent asynchronously, however there is no asynchronous access
to the on-stack memory after returning from rpmh_rsc_write_pdc_data().

> +	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
> +
> +	if (!n || n > MAX_RPMH_PAYLOAD)
> +		return -EINVAL;
> +
> +	memcpy(rpm_msg.cmd, cmd, n * sizeof(*cmd));
> +	rpm_msg.msg.num_cmds = n;
> +	rpm_msg.msg.wait_for_compl = false;
> +
> +	return rpmh_rsc_write_pdc_data(ctrlr_to_drv(ctrlr), &rpm_msg.msg);
> +}
> +EXPORT_SYMBOL(rpmh_write_pdc_data);
> +
>  static int is_req_valid(struct cache_req *req)
>  {
>  	return (req->sleep_val != UINT_MAX &&
> diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
> index 018788d..d5e736e 100644
> --- a/include/soc/qcom/rpmh.h
> +++ b/include/soc/qcom/rpmh.h
> @@ -28,6 +28,9 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
>  
>  int rpmh_mode_solver_set(const struct device *dev, bool enable);
>  
> +int rpmh_write_pdc_data(const struct device *dev,
> +			const struct tcs_cmd *cmd, u32 n);
> +
>  #else
>  
>  static inline int rpmh_write(const struct device *dev, enum rpmh_state state,
> @@ -56,6 +59,9 @@ static inline int rpmh_ctrlr_idle(const struct device *dev)
>  static inline int rpmh_mode_solver_set(const struct device *dev, bool enable)
>  { return -ENODEV; }
>  
> +static inline int rpmh_write_pdc_data(const struct device *dev,
> +				      const struct tcs_cmd *cmd, u32 n)
> +{ return -ENODEV; }
>  #endif /* CONFIG_QCOM_RPMH */
>  
>  #endif /* __SOC_QCOM_RPMH_H__ */

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
