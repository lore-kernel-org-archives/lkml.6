Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D64C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678E52152E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678E52152E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389317AbeHGTGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:06:17 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37003 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731069AbeHGTGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:06:16 -0400
Received: by mail-it0-f65.google.com with SMTP id h20-v6so23879877itf.2;
        Tue, 07 Aug 2018 09:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=plDgoxaB+lEX3W+zGUZN7QiyYQ/fic77TAjL0dwoKHQ=;
        b=rblMPgk3FZWe+0AvZICW1qqhLwTJB4ZsOZ8yJ8+bDAbUe9qfospYVi8wVJKreXJ78B
         cODme6Nc+gHpQHi9Mxf9IiAmB7V8fcqn5hs/HxXJOTHNBWg0tAcsesG9/9ymuL72Vuwd
         apLlvlqokJAauW/e+efKz7WEE1EwouibUC7cpFfiTU9b4DUnIWWDZf2hGElbzusX1WjT
         yYnFCplx99WoU4NWqLk7iURzCPRSOJqDalaS5uEWV7hPv2685PgFP3+Z11RvQp2Wqduy
         2PsjPQZbhgoVysfhy8dH/MGOWsNDyjvD23Fu5Hq2qXUkJcBJ6mebBVxZPzcCjywWPNP3
         U2dw==
X-Gm-Message-State: AOUpUlHDHFvchY3xUMiHOazVoLAxiS8r5tlHxvhXSTuhLNhBGR9odKdC
        4QDL/NR+g915FDheS5TNDQ==
X-Google-Smtp-Source: AA+uWPxAPslkfpdkKayOGl0v5sx1UhKpjaD217NhHkeMJ2v2ZPg7F9fU6FJutahfVawo3I1JoPurjA==
X-Received: by 2002:a24:ed84:: with SMTP id r126-v6mr2668830ith.58.1533660665031;
        Tue, 07 Aug 2018 09:51:05 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id y14-v6sm496241iol.60.2018.08.07.09.51.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 09:51:04 -0700 (PDT)
Date:   Tue, 7 Aug 2018 10:51:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <skannan@codeaurora.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>, georgi.djakov@linaro.org,
        vincent.guittot@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PM / devfreq: Add devfreq driver for interconnect
 bandwidth voting
Message-ID: <20180807165103.GA23354@rob-hp-laptop>
References: <1533171465-25508-2-git-send-email-skannan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533171465-25508-2-git-send-email-skannan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 05:57:42PM -0700, Saravana Kannan wrote:
> This driver registers itself as a devfreq device that allows devfreq
> governors to make bandwidth votes for an interconnect path. This allows
> applying various policies for different interconnect paths using devfreq
> governors.
> 
> Example uses:
> * Use the devfreq performance governor to set the CPU to DDR interconnect
>   path for maximum performance.
> * Use the devfreq performance governor to set the GPU to DDR interconnect
>   path for maximum performance.
> * Use the CPU frequency to device frequency mapping governor to scale the
>   DDR frequency based on the needs of the CPUs' current frequency.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/devfreq/icbw.txt |  21 ++++

Please make bindings separate a patch.

>  drivers/devfreq/Kconfig                            |  13 +++
>  drivers/devfreq/Makefile                           |   1 +
>  drivers/devfreq/devfreq_icbw.c                     | 116 +++++++++++++++++++++
>  4 files changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/icbw.txt
>  create mode 100644 drivers/devfreq/devfreq_icbw.c
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/icbw.txt b/Documentation/devicetree/bindings/devfreq/icbw.txt
> new file mode 100644
> index 0000000..36cf045
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/icbw.txt
> @@ -0,0 +1,21 @@
> +Interconnect bandwidth device
> +
> +icbw is a device that represents an interconnect path that connects two
> +devices. This device is typically used to vote for BW requirements between
> +two devices. Eg: CPU to DDR, GPU to DDR, etc

I'm pretty sure this doesn't represent a h/w device. This usage doesn't 
encourage me to accept the interconnects binding either.

> +
> +Required properties:
> +- compatible:		Must be "devfreq-icbw"
> +- interconnects:	Pairs of phandles and interconnect provider specifier
> +			to denote the edge source and destination ports of
> +			the interconnect path. See also:
> +		Documentation/devicetree/bindings/interconnect/interconnect.txt
> +- interconnect-names:	Must have one entry with the name "path".

That's pretty useless...

> +
> +Example:
> +
> +	qcom,cpubw {

Someone in QCom please broadcast to stop using qcom,foo for node names. 
It is amazing how consistent you all are. If only folks were as 
consistent in reading 
Documentation/devicetree/bindings/submitting-patches.txt.

Rob
