Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7CCC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03DA20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ra623z5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E03DA20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeKHQUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:20:15 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41354 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeKHQUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:20:15 -0500
Received: by mail-pf1-f195.google.com with SMTP id e22-v6so8863682pfn.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 22:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2py9g/WxCC/8+NYN6GcLnzqYLoq8C594WmwkFNfAQOg=;
        b=Ra623z5Bk7IL9kh0bt+B3BsbbDNxTm6OBdLwV4wAOmejB+25m/BNMaMc73uWXl+Cni
         TTuKkPpCBy8PFx+vEmn7bbyO3nHAaCdhoL483+q24qBZKdOVMZyfTBk4/w3+NzKDBA0+
         1n5gGnPXShtax+8lEAJERfULRW73FB2BTur/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2py9g/WxCC/8+NYN6GcLnzqYLoq8C594WmwkFNfAQOg=;
        b=rjg66/TtDbykzkbCMxasuSPV9eGoUN3hZ2Bqe6crfJZTJ6gj9I0ZqiMfjpmhRYewjq
         e3VaFoDBAR9sMxaNUh/52v6ubJjIIiU7vCt8ajq8qVC9RvDsPPGlD9Uzxf3LENmkoY0r
         8W5tb/Cd3oeVi+MLW7QWYSfeEBUUqng1E2H0hshDljcVzM/2de0n+QmJbc0KQYUdwr7a
         Lin8xQIsMojgUBsgSdcWb9SCslaAojjV2q6dy6vKeCAhhBdE72PkiBlyDGeC9jiB6v/8
         aMczA4yJfvOicM4p0ApgJuRWWuEqdxXukq+yPx42Ge3E2s7Wz3WJbYyCpgIAh3sXwXYZ
         a9aA==
X-Gm-Message-State: AGRZ1gJnhH57BjEkKgSQt2w49LiqAaYkVe5DRH4JQjjAfk2QTYgPgfwx
        EK4lrcOdG2EOOJU0YyPtZN3Cuw==
X-Google-Smtp-Source: AJdET5e6QSTM4HlrGZ+F6F8p5VgpUslRV+U4NSrt+5AJGQ1WdbdYarVgiRDIcZMmAO9oiSiY7TOdeg==
X-Received: by 2002:a62:1896:: with SMTP id 144-v6mr3527816pfy.88.1541659575207;
        Wed, 07 Nov 2018 22:46:15 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m5-v6sm4513204pfc.188.2018.11.07.22.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 22:46:14 -0800 (PST)
Date:   Wed, 7 Nov 2018 22:49:59 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     ohad@wizery.com, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 1/5] dt-bindings: hwlock: Document STM32 hwspinlock
 bindings
Message-ID: <20181108064959.GC12063@builder>
References: <20181031093032.20386-1-benjamin.gaignard@st.com>
 <20181031093032.20386-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031093032.20386-2-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31 Oct 02:30 PDT 2018, Benjamin Gaignard wrote:

> Add bindings for STM32 hardware spinlock device
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../bindings/hwlock/st,stm32-hwspinlock.txt        | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
> new file mode 100644
> index 000000000000..7a999479d802
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
> @@ -0,0 +1,23 @@
> +STM32 Hardware Spinlock Device Binding
> +-------------------------------------
> +
> +Required properties :
> +- compatible : should be "st,stm32-hwspinlock".
> +- reg : the register address of hwspinlock.
> +- #hwlock-cells : hwlock users only use the hwlock id to represent a specific
> +	hwlock, so the number of cells should be <1> here.
> +- clock-names : Must contain "hwspinlock".

This is supposed to be the name of the clock signal of this hardware
block, is it really named "hwspinlock"? Note that you can probably omit
the clock-names property, as you only have a single clock...

Apart from that, I think the binding looks good.

Regards,
Bjorn

> +- clocks : Must contain a phandle entry for the clock in clock-names, see the
> +	common clock bindings.
> +
> +Please look at the generic hwlock binding for usage information for consumers,
> +"Documentation/devicetree/bindings/hwlock/hwlock.txt"
> +
> +Example of hwlock provider:
> +	hwspinlock@4c000000 {
> +		compatible = "st,stm32-hwspinlock";
> +		#hwlock-cells = <1>;
> +		reg = <0x4c000000 0x400>;
> +		clocks = <&rcc HSEM>;
> +		clock-names = "hwspinlock";
> +	};
> -- 
> 2.15.0
> 
