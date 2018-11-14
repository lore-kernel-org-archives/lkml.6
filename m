Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042B1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C5A22419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kuwbks+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C5A22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733191AbeKOEY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:24:56 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33532 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbeKOEY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:24:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id w22-v6so8176360plk.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 10:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vt3PSsiDeieTUCtXMysYz5NGAiltr0StiBxSwHnQJWY=;
        b=kuwbks+3MEHeeoXV13scL0wYS3LeRuAcU+Qujy3SGCK5N59E4gpwr37NQc4zavRINj
         Yp4iYNgRCWFfiK0qLd4bNQKOFnaaHD6qZ1OHrLD/aVlHtnACsFaZrQHjBKVSj0oxZr3F
         CX3lcoAhRkxqxnonkEhtc0RjO8pcmjAidpmeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vt3PSsiDeieTUCtXMysYz5NGAiltr0StiBxSwHnQJWY=;
        b=VnHo9PSGA/q0N6PM0aAD1rokgnq00rP4tPqMXK53KFHOQrNih3yAGZDQVTtQ1yKWKk
         VVQsgEeBfBtrLCkN1db3Bq1eXMPwHM8jXjQr33NNSgE8r3pDNZ57Np4Hf7Y50uWIyeQP
         p3NnP/+7gm48CIdLBYMnnlYzi0eBLQoiv5FxyH4lHpENhCrAqvR4cPi5EBqUa0h5KZzr
         Jc76LisBHx4XZTPJ4qkQ8QL/ICge6IdMM+Mnvl0LabCSO9m6GDBLFkxD3+CvJCmVJ8j4
         Fr6lm98jAqsJv3kPONZs1cQsSSfEnF9FjdKTbCGwAnFyISwVpf1mYa4WwGAM9sSpO40K
         V4zw==
X-Gm-Message-State: AGRZ1gLW4/metCdZbKt07GvH5/V9JhoKrKFwr3lmx4qEYg6vO1y/A2QN
        HT+/0chKAGnkK1nzaAuVJbu9zA==
X-Google-Smtp-Source: AJdET5eBILVn05C0RlYXS1UhjSvUs2LtjqPACASvfaQazhbrNLGtUYdloTDbRCaOcddW9XlMnUiz+g==
X-Received: by 2002:a17:902:4583:: with SMTP id n3-v6mr2950118pld.53.1542219639106;
        Wed, 14 Nov 2018 10:20:39 -0800 (PST)
Received: from localhost ([64.114.255.97])
        by smtp.gmail.com with ESMTPSA id 127-v6sm26596951pfx.91.2018.11.14.10.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 10:20:38 -0800 (PST)
Date:   Wed, 14 Nov 2018 10:20:37 -0800
From:   Andy Gross <andy.gross@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v6 0/2] arm64: dts: qcom: pm8998: Add die temperature
 channel node to the ADC
Message-ID: <20181114182037.GF14703@hector>
References: <20181112221126.27142-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112221126.27142-1-mka@chromium.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 02:11:24PM -0800, Matthias Kaehlcke wrote:
> This series adds a channel for the die temperature to the QCOM SPMI
> PMIC5 ADC. It also fixes an example in the DT documentation.
> 
> Matthias Kaehlcke (2):
>   dt-bindings: iio: vadc: Add unit address to ADC channel node in
>     example
>   arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC
> 

I queued both of these.  Thanks for updating these.

Andy
