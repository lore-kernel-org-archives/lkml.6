Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E567CC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602412086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hbweQ94S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602412086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeILDki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 23:40:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33288 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeILDki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 23:40:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id s7-v6so12979792pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 15:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QAo+lfi4UkZbHn0OT8dblft3rx2f+yRve0t+mV2m+94=;
        b=hbweQ94STvBvzTZKlD/30RonElDr+Khjd/keYPUS7GP6TbATD54vWzSMobYtwKIuU5
         TWDMxD3noZmTJFM5j3EiXSvLejnkf3cZhyDAt2XXOiinO+r/WvKNEkW0nldtilKPaMxe
         GegKV3q0TALDD8y1zrmge4cmrIqkt7EaLRnr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QAo+lfi4UkZbHn0OT8dblft3rx2f+yRve0t+mV2m+94=;
        b=e6tvgSgAcR+6huRJ6Rc4tEtlYcHXCYszgLUeM/t4D5k/mtHfCm6Ub0dRy59JP5E8BE
         LQbCzv8dwk09rADLKQblh8hAd0eVuKqMWYw6qeC3E3u1iZ5SLAP/x8v/IkFZwG3Lz/XS
         aRoxjb92tX1kZOhXA+3KqOqQX3FXYrYqfrlH7wxtfV5nXEwcozgUAoHqQIKMUAYVYe8i
         Em4wqoTkElZtspgyBi0LKQiGuSacs8WjymzB+ArTY+KITucReKo0+oW7ADif/JUxnM4S
         eV9XnsV8vwDGnWWnHOUpu66WMvGXw0yTFgWamiEWoLqoflVADxgn4DjS3wRL0BV7tABh
         Yhow==
X-Gm-Message-State: APzg51BybenZF6kOxrJ3Er4GdcIfykGpwJMiHbrmYGd5v9Htww8+irhu
        CnfJ/qEgQP4GceIKx+KATtuGxQ==
X-Google-Smtp-Source: ANB0VdaC9fAmgq8i/LBpCuMg9BC26BCXjvOpbTk+R36LlTdUMC9FMJe/vNLIQaKUGnXypYzvOkBjmA==
X-Received: by 2002:a63:5465:: with SMTP id e37-v6mr30835134pgm.316.1536705551196;
        Tue, 11 Sep 2018 15:39:11 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id b203-v6sm28048461pfb.174.2018.09.11.15.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 15:39:10 -0700 (PDT)
Date:   Tue, 11 Sep 2018 15:39:10 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Raju P L S S S N <rplsssn@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, ilina@codeaurora.org
Subject: Re: [PATCH v2 1/6] drivers: qcom: rpmh-rsc: return if the controller
 is idle
Message-ID: <20180911223910.GH22824@google.com>
References: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
 <1532685889-31345-2-git-send-email-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1532685889-31345-2-git-send-email-rplsssn@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raju/Lina,

On Fri, Jul 27, 2018 at 03:34:44PM +0530, Raju P L S S S N wrote:
> From: Lina Iyer <ilina@codeaurora.org>
> 
> Allow the controller status be queried. The controller is busy if it is
> actively processing request.
> 
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> ---
> Changes in v2:
>      - Remove unnecessary EXPORT_SYMBOL
> ---
>  drivers/soc/qcom/rpmh-internal.h |  1 +
>  drivers/soc/qcom/rpmh-rsc.c      | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
> index a7bbbb6..4ff43bf 100644
> --- a/drivers/soc/qcom/rpmh-internal.h
> +++ b/drivers/soc/qcom/rpmh-internal.h
> @@ -108,6 +108,7 @@ struct rsc_drv {
>  int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
>  			     const struct tcs_request *msg);
>  int rpmh_rsc_invalidate(struct rsc_drv *drv);
> +bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv);
>  
>  void rpmh_tx_done(const struct tcs_request *msg, int r);
>  
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index 33fe9f9..42d0041 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -496,6 +496,26 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
>  }
>  
>  /**
> + *  rpmh_rsc_ctrlr_is_idle: Check if any of the AMCs are busy.
> + *
> + *  @drv: The controller
> + *
> + *  Returns true if the TCSes are engaged in handling requests.
> + */
> +bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv)
> +{
> +	int m;
> +	struct tcs_group *tcs = get_tcs_of_type(drv, ACTIVE_TCS);
> +
> +	for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
> +		if (!tcs_is_free(drv, m))
> +			return false;
> +	}
> +
> +	return true;
> +}

This looks racy, tcs_write() could be running simultaneously and use
TCSes that were seen as free by _is_idle(). This could be fixed by
holding tcs->lock (assuming this doesn't cause lock ordering problems).
However even with this tcs_write() could run right after releasing the
lock, using TCSes and the caller of _is_idle() would consider the
controller to be idle.
