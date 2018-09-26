Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650B7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6242151D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jBlQsLgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6242151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbeIZW5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:57:15 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42534 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbeIZW5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:57:14 -0400
Received: by mail-yb1-f193.google.com with SMTP id p74-v6so11011028ybc.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 09:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vslhqfuy9bXUpo2othKBtMswKSx1LHYnoUm+JeWbEuU=;
        b=jBlQsLgmmSzjEodZgdqnpuPZ0pHWifzo2op8tevS3PFA/mddelb0daA3HKzygs0sv1
         hKVqejHWVb3SaMoiwIhx97rXlWrGN9oV+Dnq3Up/nMbQKtgILtmHz8E2NIIyNecloJE0
         CrRKA9uAbYD3KG6xq5nPZSRAN5k5BfZOqS0X0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vslhqfuy9bXUpo2othKBtMswKSx1LHYnoUm+JeWbEuU=;
        b=tnlnbqpjYmDQZnUNDQveUlqMq93wcBpi6ugfTiVCwYGlXiiSXWy/AQYg62Lk4DD5cO
         pv89a4/E8vx9LoPOBO/9CcRhjUqaxMDKLkWOJK4JoZ01Z4CnDWLxuFX59PDYsXQJaQnG
         5cNsptAeEc6P5/WQm115bTH075ZaAAUDvva2+UY+vZnHQ3GuurBM9kZTvU0nUgyXxsh0
         MucxjKFMpD1xGvb9Tkp8/clPTT1oSjQY7faFr+9HvCd1Shtg7Zvz7USbSOIBRppiOyMp
         InbOhC08kAF+XbY7lF4MjUFkz3DGAODrzabbtUkqycJ5j0uDs6FYsbRfBrRR+HcZZWIy
         MxvA==
X-Gm-Message-State: ABuFfojwQ/tw/r4Zy94PNIYW98hrNM9XMKj6X5LWQpdS6gPFrkK+/F2t
        zglEanVdtMQzlZa72wUpzbLOLEp5FuY=
X-Google-Smtp-Source: ACcGV62wTs9F4F3FV/PhKZ38hZz3Il15dZFzrDINtBmtll7EVEjmbU3tU7vhLH8lp0DViM8cQiWQeQ==
X-Received: by 2002:a25:c201:: with SMTP id s1-v6mr3547667ybf.251.1537980206320;
        Wed, 26 Sep 2018 09:43:26 -0700 (PDT)
Received: from localhost ([2600:1700:141:4960:34b7:8b25:9255:6ce0])
        by smtp.gmail.com with ESMTPSA id z186-v6sm2145970ywa.101.2018.09.26.09.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 09:43:25 -0700 (PDT)
Date:   Wed, 26 Sep 2018 11:43:24 -0500
From:   Andy Gross <andy.gross@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     linux-arm-msm@vger.kernel.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, frank.rowand@sony.com
Subject: Re: [PATCH ARM-next] ARM: dts: qcom-msm8974: change invalid flag IRQ
 NONE to valid value
Message-ID: <20180926164324.GA20233@hector.attlocal.net>
References: <20180925104651.16596-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925104651.16596-1-masneyb@onstation.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 06:46:51AM -0400, Brian Masney wrote:
> The following commits used IRQ_TYPE_NONE since that matched what was
> already in the file and I do not have access to the datasheets for
> these devices. After these patches were submitted, commit dcf145011400
> ("ARM: dts: qcom-msm8974: change invalid flag IRQ NONE to valid value")
> changed all of these values to IRQ_TYPE_LEVEL_HIGH. This patch corrects
> the IRQ type for these two commits:
> 
> commit bd9392507588 ("ARM: dts: qcom: msm8974-hammerhead: add device
> tree bindings for ALS / proximity")
> 
> commit fe8d81fe7d9a ("ARM: dts: qcom: msm8974-hammerhead: add device
> tree bindings for mpu6515") 
> 
> Prior to these patches, I was having issues with the bmp280 sensor
> returning temperature / pressure skipped errors, however these errors
> have gone away with these patches.
> 
> Patches were tested on a LG Nexus 5 (hammerhead) phone.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---

Thanks for submitting this fix.  I added it and it will be part of the pull
request.

Thanks,

Andy
