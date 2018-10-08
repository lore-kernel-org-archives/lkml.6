Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9483C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A99D2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GbCWY8TM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A99D2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeJHNw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:52:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44644 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeJHNw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:52:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id p25-v6so9599076pli.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 23:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yC+M3usDt/mHK2hn/addpuhfpMQTmS1trvMsOZ6MdRs=;
        b=GbCWY8TMaPKGF08qRJfZClgTW72pPxs1J4qjB+gwnFIbg7XuU6MJrqNjpOwXsy1AZA
         z/pMjWk40OC0wE9jrkF8CSp7xtUN0sB7NvDTY/ESWvOvxfEt3dw4vhq0LV5BCmqd5Y9V
         4/osAID6hTuHVlWmN5AHMbMKReFLfv2U/1Zpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yC+M3usDt/mHK2hn/addpuhfpMQTmS1trvMsOZ6MdRs=;
        b=cneE7qzITtmjiPAwO619vlTwcevfwTXLLe047w342E9i/zmCLe4S28biBAXG5hAmUn
         auy6BlhZfelj2yB5NX21LSNJ9Tf/aOM6Ai9JA1Cir4YAXggRyxPV25iekJTgp0Hd6yJv
         Z0m3h8HFNJJFh2BKSiHgg9xFqFGWbrwKveY/QysgQr0g9ZpOAO5nyBFWv7eerVRMygqO
         V9C0ERbWm27w861qXAi2CliYJoc4jCSjC79zeIkv8L26aTlZfpBy7EtGUTzaRCw9xh5n
         t+EPlz8/l1dDeoa0fMLWS8uACu5AhXZQD22+0+Im2RucQXFnivIZKbCVfPM2R87O0aEZ
         30Gw==
X-Gm-Message-State: ABuFfoiAka2SdlBBtSvccFixdlvO7ia/Y1mrnz9X4HK+G/FeEajfumpY
        UNk4Qt+ECW2Dl4/lDJNpa093lw==
X-Google-Smtp-Source: ACcGV61NLvya0kueXB/p6kjK3tsRYu6a8pKcfQIX6nWs6I6f5Ej3TjSkpagW/2+OMFY/V49ZsHUIjw==
X-Received: by 2002:a17:902:5e3:: with SMTP id f90-v6mr23295960plf.286.1538980936300;
        Sun, 07 Oct 2018 23:42:16 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d126-v6sm13923319pgc.32.2018.10.07.23.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 23:42:15 -0700 (PDT)
Date:   Sun, 7 Oct 2018 23:45:05 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ohad@wizery.com, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH v3 4/6] remoteproc: qcom: q6v5-pil: Add custom dump
 function for modem
Message-ID: <20181008064505.GO12063@builder>
References: <20180727152003.11663-1-sibis@codeaurora.org>
 <20180727152003.11663-5-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727152003.11663-5-sibis@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 27 Jul 08:20 PDT 2018, Sibi Sankar wrote:
> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
[..]
> +static void qcom_q6v5_dump_segment(struct rproc *rproc, void *ptr, size_t len,
> +								   void *priv)
> +{
> +	int ret = 0;
> +	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
> +	static u32 pending_mask;

I dislike that this is a static variable. And it tracks the segments
that has already been dumped, i.e. the !pending.

> +
> +	/* Unlock mba before copying segments */
> +	if (!qproc->mba_loaded)
> +		ret = q6v5_mba_load(qproc);
> +
> +	if (!ptr || ret)
> +		memset(priv, 0xff, len);
> +	else
> +		memcpy(priv, ptr, len);
> +
> +	pending_mask++;

This is a "count" and not a "mask".

I can see a few different cases where one would like to be able to pass
custom data/information from the segment-registration to the dump
function. So how about adding a "void *priv" to the dump segment.

For this particular case we could typecast segment->priv to an unsigned
long (as this is always the same size) and use that as a bitmask, which
we use to update pending_mask.

> +	if (pending_mask == qproc->valid_mask) {
> +		if (qproc->mba_loaded)
> +			q6v5_mba_reclaim(qproc);
> +		pending_mask = 0;
> +	}

I think it would be cleaner to reset pending_mask in the start function,
and then return early in this function when we have dumped all the
segments.

If so can pending_mask == 0 and pending_mask == all be the triggers for
loading and reclaiming the mba? So we don't have two different trackers
for this?

> +}
> +

Regards,
Bjorn
