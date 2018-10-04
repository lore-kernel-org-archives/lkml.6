Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B28AC00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A5F213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GrpsRIeU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A5F213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeJDHhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 03:37:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37170 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbeJDHhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 03:37:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id c10-v6so2319090pgq.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 17:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yXq7WaIA5/1C1bQUQgfHQgg2s7mL6W/0vj3Vq7W3wrc=;
        b=GrpsRIeUj7xkAa//lpR9Jtfk7L3g93RMQmGLyC7/ep3YVzSEw/I+hrZiy/FkLdNJR2
         JiVR1O6O674EHSP0ex1rS5PDMAyMkEKnw0cDrbOGHRRZd6s5NUlRsIp4C+xCBpqPLenA
         ROiM7QyfA4ufN3HfLmt3NSs2p7fyyXTi6ySTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yXq7WaIA5/1C1bQUQgfHQgg2s7mL6W/0vj3Vq7W3wrc=;
        b=NMs9yaT7jFQdK+D2vU25026GmJYs3RqzO9B0TPVRduXl0wmRDKAMs4fo3M64mqyZ5A
         mJsHyjy8pffT93GGWCneyoCGcL4k6eGuDyeMIRvGei31RB3aQhnm5fyQuxVY37P/gNKA
         1BbmeyvyzisNAcZyFiVAcdsI4z7+fw1QF5GvO9ctrraTXoyqewm2LAdZ0rEHTM+7lCx/
         gDwjpmBrAmg1eKTSnTXbCO3B7UZnPhVEB1MURX9iXKDyZlaC25hhp/3/fV4M9JRdwps9
         xtDorTL0iNewT22UQTMs5RTor3QT0EN01gR7iLaq213kZfLvbwJFgOMfPrkp4HRDe52P
         DE9A==
X-Gm-Message-State: ABuFfoh2Hia7GLwWiZRzn7P5aIeP/2wRUFcqK6FZS+jh0YpS7TB1u9/O
        ImiEu5wwuPfOhJPk4WtJd6XS7SqzVkJgOg==
X-Google-Smtp-Source: ACcGV61QgF4M58cFOSIzHb4IDvA6G81eweJIKFzmsG0cwHr8Lar5mcaeS+g/cGeEuGRMYsVnL6D4EA==
X-Received: by 2002:aa7:80cd:: with SMTP id a13-v6mr4116338pfn.86.1538614019003;
        Wed, 03 Oct 2018 17:46:59 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 25-v6sm7904785pfm.36.2018.10.03.17.46.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 17:46:58 -0700 (PDT)
Date:   Wed, 3 Oct 2018 17:46:56 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arun Kumar Neelakantam <aneela@codeaurora.org>
Cc:     ohad@wizery.com, clew@codeaurora.org, sricharan@codeaurora.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] rpmsg: glink: Add GLINK signal support for RPMSG
Message-ID: <20181004004655.GW2523@minitux>
References: <1538566463-24627-1-git-send-email-aneela@codeaurora.org>
 <1538566463-24627-2-git-send-email-aneela@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538566463-24627-2-git-send-email-aneela@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03 Oct 04:34 PDT 2018, Arun Kumar Neelakantam wrote:

> Add support to handle SMD signals to RPMSG over GLINK. SMD signals
> mimic serial protocol signals to notify of ports opening and closing.
> This change affects the rpmsg core, rpmsg char and glink drivers.
> 
> Signed-off-by: Chris Lew <clew@codeaurora.org>
> Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
> ---
>  drivers/rpmsg/qcom_glink_native.c | 80 +++++++++++++++++++++++++++++++++++++++
>  drivers/rpmsg/rpmsg_core.c        | 41 ++++++++++++++++++++
>  drivers/rpmsg/rpmsg_internal.h    |  5 +++
>  include/linux/rpmsg.h             | 25 ++++++++++++

Please split this patch in one for rpmsg and one for GLINK, and
incorporate the translation from patch 5 in the latter.

>  4 files changed, 151 insertions(+)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
[..]
> @@ -954,6 +961,52 @@ static int qcom_glink_rx_open_ack(struct qcom_glink *glink, unsigned int lcid)
>  	return 0;
>  }
>  
> +/**
> + * qcom_glink_send_signals() - convert a signal  cmd to wire format and transmit
> + * @glink:	The transport to transmit on.
> + * @channel:	The glink channel
> + * @sigs:	The signals to encode.
> + *
> + * Return: 0 on success or standard Linux error code.
> + */
> +static int qcom_glink_send_signals(struct qcom_glink *glink,
> +				   struct glink_channel *channel,
> +				   u32 sigs)
> +{

As this deals with TIOCM_* flags the individual bits are defined as
having "local" or "remote" status. So I believe you should be able to
just pass around one set of bits and extract the ones that makes sense
to send here.


> +	struct glink_msg msg;
> +
> +	msg.cmd = cpu_to_le16(RPM_CMD_SIGNALS);
> +	msg.param1 = cpu_to_le16(channel->lcid);
> +	msg.param2 = cpu_to_le32(sigs);
> +
> +	return qcom_glink_tx(glink, &msg, sizeof(msg), NULL, 0, true);
> +}
> +
> +static int qcom_glink_handle_signals(struct qcom_glink *glink,
> +				     unsigned int rcid, unsigned int signals)
> +{
> +	struct glink_channel *channel;
> +	unsigned long flags;
> +	u32 old;

As with send above you should be able to parse out the bits that makes
sense for the remote to set and update the one set of status bits for
the channel here.

> +
> +	spin_lock_irqsave(&glink->idr_lock, flags);
> +	channel = idr_find(&glink->rcids, rcid);
> +	spin_unlock_irqrestore(&glink->idr_lock, flags);
> +	if (!channel) {
> +		dev_err(glink->dev, "signal for non-existing channel\n");
> +		return -EINVAL;
> +	}
> +
> +	old = channel->rsigs;
> +	channel->rsigs = signals;
> +
> +	if (channel->ept.sig_cb)
> +		channel->ept.sig_cb(channel->ept.rpdev, channel->ept.priv,
> +				    old, channel->rsigs);

Add {} when block is multiline.

> +
> +	return 0;
> +}
[..]
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
[..]
> +/**
> + * rpmsg_get_sigs() - get the signals for this endpoint
> + * @ept: the rpmsg endpoint
> + * @sigs: serial signals bitmask
> + *
> + * Returns 0 on success and an appropriate error value on failure.
> + */
> +int rpmsg_get_sigs(struct rpmsg_endpoint *ept, u32 *lsigs, u32 *rsigs)

> +{
> +	if (WARN_ON(!ept))
> +		return -EINVAL;
> +	if (!ept->ops->get_sigs)
> +		return -ENXIO;

I think EOPNOTSUPP would be better here.

> +
> +	return ept->ops->get_sigs(ept, lsigs, rsigs);
> +}
> +EXPORT_SYMBOL(rpmsg_get_sigs);
> +
> +/**
> + * rpmsg_set_sigs() - set the remote signals for this endpoint
> + * @ept: the rpmsg endpoint
> + * @sigs: serial signals bitmask
> + *
> + * Returns 0 on success and an appropriate error value on failure.
> + */
> +int rpmsg_set_sigs(struct rpmsg_endpoint *ept, u32 sigs)
> +{
> +	if (WARN_ON(!ept))
> +		return -EINVAL;
> +	if (!ept->ops->set_sigs)
> +		return -ENXIO;

Ditto

> +
> +	return ept->ops->set_sigs(ept, sigs);
> +}
> +EXPORT_SYMBOL(rpmsg_set_sigs);
> +

Regards,
Bjorn
