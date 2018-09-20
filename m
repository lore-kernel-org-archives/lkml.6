Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AFAECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985DD2152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R+cOJjBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985DD2152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbeIUAmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:42:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35238 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeIUAmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:42:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id g2-v6so4773625plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 11:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9k3xjjB502uhqgywHXJFqyOr0NA9fQ2JneKwN770Lzo=;
        b=R+cOJjBVoW9f4ymBeYEA9FyjF4iXuGUUKFr/TwuyoQVSJ2SXtbO5zFfaZrwS/pzZ5e
         lCmvrXYWZund34IuBpc55ya8YmJIVZYnJVA7PuolvuSIXkCOACC5wt5pVPs0pcmLLAc8
         brE4H0K1LEwhvyWdjcpgnC3sheCRkiizKspXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9k3xjjB502uhqgywHXJFqyOr0NA9fQ2JneKwN770Lzo=;
        b=JwgjQeZqJtWQ/kWNOqov9ahpX5bU8BHXHtgYHfiuE5lfmsV6L5HrL6+n6WN7SCUX3L
         2NxkjsA0yxSduCJ0ki2SKJqSI2NHPwdw5A9kP6jlsLQ6PIt4R3hjsDmRJxVH1GOQi5Ln
         M0o7A74HhxRwz59F60CZaCpRxKabGzZ5f+hYVcmLObE5Ujm9EzufyN44kQ43QlPjsxYn
         kill6UFvKCAuvLhhTESAhOCxHhlx3qjgu+rxJo0dRNUFeNdx97Pk32b6iEirOpu5aEyu
         TgREmk2CVbWINHZi05jgLlNIaCiyeFdkA3NytQ/hPwxWvCiC/MeGSGi7xn4DOleBzOZH
         8xiQ==
X-Gm-Message-State: APzg51AwUyyxXeNbkjyOrMs/sTlhwkpJzIkDl2ngUhztEudlWCN+g+JT
        dEv6uuR3pd4/izXPH5fm1oeCHw==
X-Google-Smtp-Source: ANB0Vdat44+NFPO+JDFP+k6UVaGIgBafvYr/ANgI53bgPY7S5N0ya/ozT8wPqYqze4S/0kqaibQGDQ==
X-Received: by 2002:a17:902:f205:: with SMTP id gn5mr40387038plb.41.1537469871367;
        Thu, 20 Sep 2018 11:57:51 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id t123-v6sm31145264pfd.51.2018.09.20.11.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 11:57:50 -0700 (PDT)
Date:   Thu, 20 Sep 2018 11:57:49 -0700
From:   Andy Gross <andy.gross@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 10/16] arm64: dts: msm8916: thermal: split address
 space into two
Message-ID: <20180920185749.GB28458@hector.localdomain>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
 <226a3b61f23f27d54b4dad390d6796b429fad837.1536744310.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <226a3b61f23f27d54b4dad390d6796b429fad837.1536744310.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 03:22:55PM +0530, Amit Kucheria wrote:
> We've earlier added support to split the register address space into TM
> and SROT regions. Split up the regmap address space into two for msm8916
> that has a similar register layout.
> 
> Since tsens-common.c/init_common() currently only registers one address
> space, the order is important (TM before SROT).  This is OK since the
> code doesn't really use the SROT functionality yet.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Acked-by: Andy Gross <andy.gross@linaro.org>
