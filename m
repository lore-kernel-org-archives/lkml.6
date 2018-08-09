Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF4BC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2697021F45
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wx3soGxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2697021F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbeHIU36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:29:58 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35338 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbeHIU36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:29:58 -0400
Received: by mail-yw1-f67.google.com with SMTP id s68-v6so5667510ywg.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 11:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kTi+9WjL5FM2ZsAgZnRf5nezxJ99nuCN4eCUjHhxwNo=;
        b=Wx3soGxrSnGse9KURgTxpDJ86xMdV4rwg8cBcNQMUINV9io6yYJwb6Lv0gvILw8n6j
         0/wlPJ4D4ADmXexnxfYb3fkSOrvPyNiH9blDdCQzYj4CigLvYXHoqaCjB3FAC84juVnw
         EsfNjGT3YYJbZ84yR9mNXre7grsEZuHUKf694=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kTi+9WjL5FM2ZsAgZnRf5nezxJ99nuCN4eCUjHhxwNo=;
        b=q8oIv+b+4LofGMJcqJzf6irkIo6Eixv6dA6wYhSZ+N8h3nByeXyeaBkv+NJuQExPSG
         8gjFjMaf0P+FsLxIFejJPccva6ww8gXShT4shqp2sKsFxFO+q7lAnWNfMiIeVSZyVMg+
         vUrjJhUf09sW8Pe5EJoF/ev3VdtTsokhJxTrYDt75+3kdV3AkXmvVfR9VwjuaJCfnJb+
         5FlsjGO8Ogel9czkokybL6KQnv7QXALyQcgBuXzryWanx9BbygxNZTNAceeonHvpc6wd
         4P2oyN1l5sQgruoBNfYO1CjLhmHEmrz1P7GO+puv9HXdcc0ATiVvytne4NpiEgMDRv1X
         i86w==
X-Gm-Message-State: AOUpUlGvcKhLba7ub7i2eEU828+X5iJFbNSYkjxD5h7Dt8w3qsbsCZLp
        h4hMbci/cVQZYu4gbNAY+0bFEv73spI=
X-Google-Smtp-Source: AA+uWPyB3csMgGgG96d/3OckQCqJkD5vuPrXQ0Ao9AH6qvc+UFCpUEdfKkubM1yAVDkd9x4mC9yYzg==
X-Received: by 2002:a81:c87:: with SMTP id 129-v6mr1676931ywm.247.1533837839367;
        Thu, 09 Aug 2018 11:03:59 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id z186-v6sm4279178ywa.101.2018.08.09.11.03.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:03:58 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id 139-v6so5646371ywg.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 11:03:58 -0700 (PDT)
X-Received: by 2002:a1f:ebc7:: with SMTP id j190-v6mr2063413vkh.114.1533837837679;
 Thu, 09 Aug 2018 11:03:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 11:03:55 -0700 (PDT)
In-Reply-To: <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
References: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
 <152607782792.34267.8023817955251139395@swboyd.mtv.corp.google.com>
 <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org> <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
 <20180522173000.GG24776@sirena.org.uk> <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
 <20180524162940.GA4828@sirena.org.uk> <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
 <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 9 Aug 2018 11:03:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
Message-ID: <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based QUP
To:     Dilip Kota <dkota@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Mahadevan, Girish" <girishm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 3, 2018 at 5:18 AM,  <dkota@codeaurora.org> wrote:
>>> +       if (of_property_read_u32(pdev->dev.of_node, "spi-max-frequency",
>>> +                               &spi->max_speed_hz)) {
>
>
>> Why does this need to come from DT?
>
>
> This is required to set the SPI controller max frequency.
> As it is specific to the controller, so looks meaningful to specify it in
> dtsi.
> Also, spi core framework will set the transfer speed to controller max
> frequency
> if transfer frequency is greater than controller max frequency.
> Please mention if you have a other opinion.

Here are my thoughts:

1. It sure seems like the clock framework could be enforcing the max
speed here.  SPI can just ask for the speed and the clock framework
will pick the highest speed it can if you ask for one too high.  Isn't
that the whole point of the "struct freq_tbl" in the clock driver?


2. The device tree writer already provides a max clock speed for each
SPI slave in the device tree.  ...shouldn't the device tree writer
already be taking into account the max of the SPI port when setting
this value?


3. If you really truly need code in the SPI driver then make sure you
include a compatible string for the SoC and have a table in the driver
that's found with of_device_get_match_data().  AKA:

  compatible = "qcom,geni-spi-sdm845", "qcom,geni-spi";

...as per #1 and #2 I don't think this is useful


-Doug
