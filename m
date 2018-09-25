Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E82C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D925A206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D925A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbeIYWxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:53:03 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46460 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbeIYWxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:53:03 -0400
Received: by mail-ot1-f65.google.com with SMTP id q4-v6so11976823otf.13;
        Tue, 25 Sep 2018 09:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K7cHRrYP/FGwBwYIsBTkszpijD1c3e47dIokFkm/j6w=;
        b=A20nxcjkgLxADJwF7nuWqeMQbMsmUevFl5TcOpCjbx+DUg5FPZ86seQ2wZWbKgO9EK
         vPfZzFXkbhSOosRFjFi07fWdH+Kcd/voXZJXcSZoqmiNxrmy6YmLOK4nD4JtV7hSVC+U
         3KCdTInZPahAVJXYs50/X0phy/ubh+jwKSktY7n/mnUC7byFiJQ7GQVsQck8mrHaI2Xm
         2H20FHN1LD6fn+nj53s/d7SV7IsQs6sY1vnLDIUbVwhtATF4lR9YyjG1BKGn/xh1KV7c
         Zu/jEFUdRjNlRGmRD9BA4oLKlohmP50PP15psiM3UrLxSZ4L7izGsleZN1Zbbh3+uC1X
         xTlg==
X-Gm-Message-State: ABuFfohlGQQq6ZcDp8mf13U+ArFlUQvJ6uRLKzYt5tXj2LXsAiyHqGp8
        m7/XGXVspzzo2KD7CM/LuA==
X-Google-Smtp-Source: ACcGV614uXH5qWFvW3GFnYqoEKgUkEtuRnGEKbkVUkJ52O8RSFV366K60iQGp3CZIVMygKSqQZzTkw==
X-Received: by 2002:a9d:663:: with SMTP id 90-v6mr1272955otn.28.1537893882907;
        Tue, 25 Sep 2018 09:44:42 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o125-v6sm897425oig.44.2018.09.25.09.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 09:44:42 -0700 (PDT)
Date:   Tue, 25 Sep 2018 11:44:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        punit.agrawal@arm.com, edubezval@gmail.com,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] dt-binding: arm/cpus.txt: fix
 dynamic-power-coefficient unit
Message-ID: <20180925164441.GA21659@bogus>
References: <1535526518-29022-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535526518-29022-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 09:08:38AM +0200, Vincent Guittot wrote:
> The unit of dynamic-power-coefficient is described as mW/MHz/uV^2 whereas
> its usage in the code assumes that unit is uW/MHz/V^2
> 
> In drivers/thermal/cpu_cooling.c, the code is :
> 
> power = (u64)capacitance * freq_mhz * voltage_mv * voltage_mv;
> do_div(power, 1000000000);
> 
> which can be summarized as :
> power (mW) = capacitance * freq_mhz/1000 * (voltage_mv/1000)^2
> or
> power (mW) = (capacitance * freq_mhz * (voltage_mv/1000)^2) / 1000
> then
> power (mW) = power (uW) / 1000
> so
> power (uW) = capacitance * freq_mhz * (voltage_mv/1000)^2
> 
> Furthermore, if we test basic values like :
> voltage_mv = 1000mV = 1V
> freq_mhz = 1000Mhz
> 
> The minimum possible power, when dynamic-power-coefficient equals 1, will
> be with current unit:
> min power = 1 * 1000  * (1000000)^2 = 10^15 mW
> which is not realistic
> 
> With the unit used by the code, the min power is
> min power =  1 * 1000 * 1^2 = 1000uW = 1mW which is far more realistic
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Rob
