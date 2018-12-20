Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854B5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544FF218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545336357;
	bh=zW1Bo5Yn+fWs+Fa2QDsSJadnLhEk9ZTG/rBfYjj3ChQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WUB3sYtbIcXjOTxqicKyVGJR2d+0pXzWsqNb1X84xZBmOJC/kuxN2I6Yy0GrM8QB2
	 GN9rtsS11LC//2h4xKUKLn+uRkoO8lh6cJrbtQNnyOM3iXxZybqxfLPNZa92ASSxJ/
	 xbhpnFWx0gxZs8XNDF188CgRzCOplC11ruOm61f4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389537AbeLTUF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:05:56 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33403 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389117AbeLTUFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:05:55 -0500
Received: by mail-ot1-f67.google.com with SMTP id i20so3105458otl.0;
        Thu, 20 Dec 2018 12:05:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4QMY38lcT2DOZsCegYUwqK1+4Md7FtyuEkcUG+niPk4=;
        b=UHPKuFTDEZFZNHdrQdErB/oRKgtBBA2WXSk6fQoFHObkuQ+yDivpF8oJmSoqTxqELA
         OZrg/ba7u2ylUt1RUUEIpEgS7BMePNhmPh+z7QgcczvOD0g2a+f+7mase6qJ5Ns1oNFk
         lHYP3T9rTpbZZUGlePiAluqeuasjkMGK4QIoZltjjWwSQu+ntjm2UauzWM7pPRg5NBfd
         Auf+QHkvSF+Hal8TOWdjH38L7AVwnb3O/+Mq/7fbhq/rHQZ3ixO0adQz7+3IwtboCUuJ
         RNq9LDGqnYO2eyvoX63BHR7Zt3OJcFtuOs1o42VaqqvBVmuu/ET7lL1IMK6LbH5LIk9t
         TsJQ==
X-Gm-Message-State: AA+aEWalZf3VyO9Chss7dJ3767EyiK9r8KtPv+Vd3G8V4YLyNrwaU93D
        JleNO25Xs45CwM5ElwXvEQ==
X-Google-Smtp-Source: AFSGD/WUxK8np9r7pV/2ZConG6qIb3hQNWI6Eijm8P116BQAjo6zw8QpGclLb/nEChiEY0X4yG3IHA==
X-Received: by 2002:a9d:775a:: with SMTP id t26mr18215635otl.32.1545336354966;
        Thu, 20 Dec 2018 12:05:54 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id f18sm11096744otl.18.2018.12.20.12.05.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:05:54 -0800 (PST)
Date:   Thu, 20 Dec 2018 14:05:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        mka@chromium.org, khasim.mohammed@linaro.org,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: Add binding for ADC on
 pms405 PMIC
Message-ID: <20181220200553.GA8681@bogus>
References: <cover.1544599950.git.amit.kucheria@linaro.org>
 <3aac8c4cd7648589d0eef994376357509e284030.1544599950.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aac8c4cd7648589d0eef994376357509e284030.1544599950.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018 15:47:54 +0530, Amit Kucheria wrote:
> PMS405 contains a variant of the spmi-adc-rev2 ADC. Create a new
> compatible inorder to handle any differences.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
