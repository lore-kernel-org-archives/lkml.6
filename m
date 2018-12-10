Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C985EC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6432084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544480382;
	bh=S+ZMK3B/n27i5IYsrm31Y3c2tBXTSzBrCIYKG5RnlH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vaDUEIMEZGB2DDvII9eJxdvdKWi3rcFL8oTDkaM0fZCHmbBfqr1KnFUR+rTfzjXyj
	 bHCU/eBSKoejnPbQKGYtix7PlnZmuq26AegysYJ0ysMqYTnJYxSq34seIoPgP3Tn2h
	 INUT3nbwiFhiiMhfXKs8KfjtqLSy60+ahlQVpNFg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6432084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbeLJWTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:19:41 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40320 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJWTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:19:41 -0500
Received: by mail-oi1-f196.google.com with SMTP id t204so10381080oie.7;
        Mon, 10 Dec 2018 14:19:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a1TZgF4eoPVIf9O6WeqgQfR9mY4/0yJAC/h/RasKVcc=;
        b=XxGrEh+K7V+cEry8Cj6VTy27NrvVCbgYw8n/9LaWSlYPTS4HNdNV45sLYRPRRFPHO+
         EejNMlLW9B09zITQn/lhrhtnFfqNjAree++V+1h5i720al0zJ3WuP1nzvqu5sICovf/Z
         QQONGaUYqzwnVO3d3l0hWvuxOPaZR5l2L0II75Hd1eA60avHdQJ/gLBk3V1Vq1SV/qSp
         a+5TR/JwW0xJkHkVOD36K+dPMFtM6E2zVY4TsCkpJwRX4MWCLQFkOOrPHzrFSy5N42D7
         Bs/P1TX00XF19j/2jCJyLGoZf3LorNTmgNa/oLDRv5Elw+2kHFm9vI1wPBuDJccPvRRZ
         06WQ==
X-Gm-Message-State: AA+aEWbGG7BeAI31FiVf7cBylqEPm5SBrf6o4al9cEVe/oqMpce2PXA0
        QQwNxlMknKgxaB+big29wA==
X-Google-Smtp-Source: AFSGD/W9YB+u/ZsySUzVJUYO14AO92Rv2ZXMKugzqSR6WuidGD7c6Z7VVd4nujxaRBE1Qyy591NZAw==
X-Received: by 2002:aca:2ecf:: with SMTP id u198mr8931864oiu.338.1544480380196;
        Mon, 10 Dec 2018 14:19:40 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o8sm6894791oia.53.2018.12.10.14.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 14:19:39 -0800 (PST)
Date:   Mon, 10 Dec 2018 16:19:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     marc.zyngier@arm.com, sudeep.holla@arm.com, tglx@linutronix.de,
        jason@lakedaemon.net, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        sboyd@kernel.org, bjorn.andersson@linaro.org,
        nicolas.dechesne@linaro.org, ctatlor97@gmail.com, vkoul@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v5 1/4] dt-bindings/gic-v3: Add msm8996 compatible string
Message-ID: <20181210221938.GA23517@bogus>
References: <20181210135633.30283-1-srinivas.kandagatla@linaro.org>
 <20181210135633.30283-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210135633.30283-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 13:56:30 +0000, Srinivas Kandagatla wrote:
> Access to GICR_WAKER is restricted on msm8996 SoC in Hypervisor.
> There are many devices out there with this restriction in place
> and there has been no update to this firmware since last few years,
> making those devices totally unusable for upstream development.
> 
> IIDR register value conflicts with other SoCs, using compatible seems
> to be the only way to apply quirks required for msm8996 based SoCs.
> 
> Without this quirk many qcom SoCs (atleast 3 that I know) are
> unable to boot mainline.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/interrupt-controller/arm,gic-v3.txt   | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
