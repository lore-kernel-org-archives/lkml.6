Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0A5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192B4213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RL5dq+kJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192B4213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeK2KYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:24:21 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46246 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeK2KYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:24:21 -0500
Received: by mail-ot1-f68.google.com with SMTP id w25so25205862otm.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 15:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sXVEtbcIKUqBFe0bTQaydVl92UiqZehF6o4+5+ritFM=;
        b=RL5dq+kJlo7+zSdBQaPhqKKnHmUAJ6ttCZ44lVSeqpsaF3m/kn8AnZ5JF1DM96LG/a
         LqhDo7urvcSJHeEo9cRiX4MlrKAzycOn8/253n20dyAdEJKu4r4UKg+kpVS+vAM9A5J3
         xBnSIZU6PScE+TsCoBxdBxJJYIIxSNwttTQXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sXVEtbcIKUqBFe0bTQaydVl92UiqZehF6o4+5+ritFM=;
        b=mxaqtmIxBvVu+Kc0z1yB8Fvg/D2xmK02QA7wJbJfBtOlgjU12GN2aywjAlniBVcGgr
         3Cwffy9KjzUTinFsNP10Xb0f8QUeCDDc1DGUuHq/8HUzPZmGaalVHjGCEbtuoBO7gwkh
         IBu4L9XpdPBUq5sKf1ZKYIqmzE/MdR7OqVuvzBSXgEwj+5zt6PtRLCIHn00FpjY4zbyd
         vNGEP9/ZLqlcSK8uxq7SEZzih4cJQC/y/99jnnAJUBN6sF0xBLfuovSo/5cWQ1k9f5Zq
         IsHf6ET6G5GRenkYmyrcWtXOUf03ySThHIKW7w3PohkSIAOTKELI3PP+JWH40zCMKiZ2
         hs+Q==
X-Gm-Message-State: AA+aEWaZ93ptl0rGG+xINCDiOZTcGhlSIE/FJcqF8OSkcMsLoso5IMtm
        oAlQ6+Q44xU/VGy543M+04cCCw==
X-Google-Smtp-Source: AFSGD/X+6EPmfTpQrLajlsyoWW6UPUz9xvA/nMZ91b8ObPZU4uHXFs49X5+tqxhK1WwuioyVYjsipg==
X-Received: by 2002:a9d:5090:: with SMTP id b16mr20590969oth.96.1543447264117;
        Wed, 28 Nov 2018 15:21:04 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:ac95:205:d1d8:4dc9])
        by smtp.gmail.com with ESMTPSA id u19sm23500oia.31.2018.11.28.15.21.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 15:21:03 -0800 (PST)
Date:   Wed, 28 Nov 2018 17:21:02 -0600
From:   Andy Gross <andy.gross@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: msm8974-hammerhead: correct gpios
 property on magnetometer
Message-ID: <20181128232102.GA32306@hector.attlocal.net>
References: <20181128095335.5538-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128095335.5538-1-masneyb@onstation.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 04:53:35AM -0500, Brian Masney wrote:
> This patch correctly sets the gpios property for the ak8963
> magnetometer's DRDY pin so that interrupts work properly.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---

Queued.  Thanks for the patch.


Andy
