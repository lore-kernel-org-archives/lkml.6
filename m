Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25CBC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA27D2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WuHwQVm1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA27D2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeJFCUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 22:20:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33303 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbeJFCUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 22:20:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id s4-v6so7269915plp.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 12:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dU9c8JHPYR2/663AtMNEdXCx5pLw15C9VAUGkLHPUnM=;
        b=WuHwQVm1L2Ebbml/5Zzpbxoyc+mTpORPr6OMs1VFLxdVkZ9mVZN53noxH/lnXWkYP1
         LZCsQmhioXlE90WCKrU9EQFGF3tgz4OT6sSDak3vHzz79Av7BMqD3f4fcrgK0jxQbE4P
         8Oobrd8baih8BWS8zWMyHoFrxGbcuJuzENm4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dU9c8JHPYR2/663AtMNEdXCx5pLw15C9VAUGkLHPUnM=;
        b=pJotYrlnpjT4AKNbWC3IwzZa0sYMSqNCfsWBiyyEU1j9Q+lVjoPugZLIIVZ85o+DLb
         gyzT+pAY/sZZFrAzm1lnmxIiYKkPJ4QNTjKn7UWMSom5opiYJQYMFbcpYcWiLtfvPOl+
         shB5dkijY1A1LTlYNrVqHKLAS0NmmmR5KSAesnhzeFi3mWKlQnIqI46yyXMbee7gFW78
         Qhfs+6uvyhZ1qwVyJSv4sXGDOSaiDv4MY+Mod5/06GeYivRLTtIIGRs0f+hgubfViakT
         LI3PNqAYLNSrXh1sdWvXk3NGIIP34vIXZW9XbCo7EywdKANSlp1LXXxvWH92xoiJI3s0
         K1lw==
X-Gm-Message-State: ABuFfoiCL3bHMZM7P97a4JiQt6+UT8+YAAX20K4vqaUx3qP7TMzIMFIe
        9mAdemcxBW+jjPMwd7n8b5oJRA==
X-Google-Smtp-Source: ACcGV62Cuw/HsPdoatSSC7NoASvqCVi//1nmUxPV6ulczkkLcTlm7fHCOcXKhcxXRcV76+NvJi8ZLg==
X-Received: by 2002:a17:902:33c3:: with SMTP id b61-v6mr10005950plc.52.1538767213030;
        Fri, 05 Oct 2018 12:20:13 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d10-v6sm9498762pgo.2.2018.10.05.12.20.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 12:20:12 -0700 (PDT)
Date:   Fri, 5 Oct 2018 12:22:57 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arun Kumar Neelakantam <aneela@codeaurora.org>
Cc:     ohad@wizery.com, clew@codeaurora.org, sricharan@codeaurora.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/4] rpmsg: core: Add signal API support
Message-ID: <20181005192257.GB12063@builder>
References: <1538722776-13648-1-git-send-email-aneela@codeaurora.org>
 <1538722776-13648-2-git-send-email-aneela@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538722776-13648-2-git-send-email-aneela@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04 Oct 23:59 PDT 2018, Arun Kumar Neelakantam wrote:
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
[..]
> +/**
> + * rpmsg_get_signals() - get the signals for this endpoint
> + * @ept:	the rpmsg endpoint
> + *
> + * Returns 0 on success and an appropriate error value on failure.

I like the fact that you're using the return value to pass the bits, but
the comment doesn't reflect this - and you don't handle this properly in
the TIOCMGET case in patch 3.

> + */
> +int rpmsg_get_signals(struct rpmsg_endpoint *ept)
> +{
> +	if (WARN_ON(!ept))
> +		return -EINVAL;
> +	if (!ept->ops->get_signals)
> +		return -EOPNOTSUPP;
> +
> +	return ept->ops->get_signals(ept);
> +}
> +EXPORT_SYMBOL(rpmsg_get_signals);

Apart from that the series looks good.

Regards,
Bjorn
