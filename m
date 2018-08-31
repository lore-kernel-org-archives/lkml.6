Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C19C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51512083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PGRkirnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51512083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeIADLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:11:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32895 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbeIADLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:11:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so6160594pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/EEXhp/4lHoSvJI99oo5cfpKy1KptkbE/+jO6iThNjI=;
        b=PGRkirnp07DrGBBlYlHrxcOvHq5PBZM21m6IjPFITTWK0onE4PMQohI0kwan1/kxVj
         8ikS2ayEFXy8w7XMRCdj2EJ18y2raplrUGArzWvu29jvSV1HTFksuSaj4eIJkawFokr7
         Fu0Li6K9Q4nO0P5VDVh3E4nwmxXp7lCmHKgyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/EEXhp/4lHoSvJI99oo5cfpKy1KptkbE/+jO6iThNjI=;
        b=uOj9Kl+potPLT3g4iyANAnzprfE3cVIzCEV+qkiDB3F3hFrY/hQN91JMvUkuKEChfB
         2T8us5EUMPFHEdHANzyeUm1oVVX7jreYLOvRDK5yLBotXT8JE7rq0htXLfLXQC83ih8E
         hQEnVsRVq1DsXOgFRUqakMSseCwF6J9VIG3ZvKmA6L4ML30vm0X5pGg88PIG/JEEzysK
         mZ2EIp6X80DJfJjhxCtzY996pqDcYQ4IsOxiXmN7QzwFN3nNzDPPBVyjBzThPlarQfOQ
         w5xAPMgI4WByATREsvZ01zZHo8hFJYRe/z0GL+GwKjm0qsMlc8+O3L2uLMxABa4sJfT4
         gC9Q==
X-Gm-Message-State: APzg51AW3Jbnv7h50Ory5oypxUSCE6AqsEP24FrMw+Pv7r4vBszKeXyZ
        wpAS+T8Y8YwpHeDVK68xxdZDRA==
X-Google-Smtp-Source: ANB0VdYSIAUmYkWjtDvw5HZqAcECAzptImymkeDHA6W5PKGJokVHDtpwxpIDJ5JGa3mbQh6xrY5s2g==
X-Received: by 2002:a63:5ec1:: with SMTP id s184-v6mr16613165pgb.26.1535756488010;
        Fri, 31 Aug 2018 16:01:28 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 16-v6sm19232261pfo.164.2018.08.31.16.01.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 16:01:27 -0700 (PDT)
Date:   Fri, 31 Aug 2018 16:01:25 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     "Ivan T. Ivanov" <iivanov@mm-sol.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Russell King <linux@arm.linux.org.uk>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: dts: qcom: Add SPMI PMIC Arbiter nodes for
 APQ8084 and MSM8974
Message-ID: <20180831230125.GU2523@minitux>
References: <1422965880-11047-1-git-send-email-iivanov@mm-sol.com>
 <1422965880-11047-2-git-send-email-iivanov@mm-sol.com>
 <550311ad-8f93-3e80-9706-1321482b8c19@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <550311ad-8f93-3e80-9706-1321482b8c19@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 31 Aug 15:46 PDT 2018, Frank Rowand wrote:
> > +		spmi_bus: spmi@fc4cf000 {
> > +			compatible = "qcom,spmi-pmic-arb";
> > +			reg-names = "core", "intr", "cnfg";
> > +			reg = <0xfc4cf000 0x1000>,
> > +			      <0xfc4cb000 0x1000>,
> > +			      <0xfc4ca000 0x1000>;
> > +			interrupt-names = "periph_irq";
> 
> > +			interrupts = <0 190 0>;
> 
> The final value in this interrupts property means IRQ_TYPE_NONE.
> 
> A WARN_ON() was added early this year to complain about use of
> IRQ_TYPE_NONE: 83a86fbb5b56 "irqchip/gic: Loudly complain about
> the use of IRQ_TYPE_NONE", resulting in many warnings spewing
> forth when I boot an APQ8074 Dragonboard.  I am trying to
> determine whether the warning is overly aggressive, or whether
> the IRQ TYPE is incorrectly specified for the spmi node.
> 
> The interrupt-parent for the spmi node is intc: interrupt-controller@f9000000,
> which has compatible = "qcom,msm-qgic2".  I do not know the architecture
> or implementation of this interrupt controller.  Is an IRQ_TYPE_NONE
> valid in this case, or should a specific type be provided?
> 

No, IRQ_TYPE_NONE isn't valid and the WARN_ON() is reasonable.

Please change it to IRQ_TYPE_LEVEL_HIGH. And while you're at it, replace
the first 0 with GIC_SPI.


If you have more of these warnings you can most likely look at e.g.
msm8916 (arm64) to find the right flags.

Regards,
Bjorn
