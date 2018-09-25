Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F54C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D704020685
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eKfV4osm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D704020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbeIZD60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:58:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45897 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbeIZD6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:58:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id a23-v6so4444929pfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 14:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oqMUnMwvDhGLNGadprF41SpS9dKxwBxYjGIuBpToTRc=;
        b=eKfV4osmVp29papuSZ8QclsHBBWLPHCsyqXKWWe0CH2JfVvaPocdATrZ0vYcmS4CNC
         vYG+p0kBmv/Ym/2plDODT9KhibUm97qbXr+FD5Ga06NiojZN9UT9own9md5Lh8Ax/vN+
         aS8/4MFuT+4R19hHRXTzISHiK4liDGzq/8IGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oqMUnMwvDhGLNGadprF41SpS9dKxwBxYjGIuBpToTRc=;
        b=J4J4jIy7owaqo1EtTYDR2R0oRgQOPDW7poCwou9BplEFtIetGBsjIR0sed71rJ6WUD
         U2I7FEL1jp+MtfIgfZ9ZneVTZM2dGyhUaKfJZPut37YpT/aHg63Ht+75a+UcjpNU+aAv
         98Mk7OE99idEBYxIymjN8mvtTKOKrTGzQTk6En+QJsshOuOZ4sHUMzq2MgyL/ucxcmsE
         7E3H56vgzDeqYa6CR8hePtQKWaEa5jJOmkniawKkWNYBsWqcXtflV7sVd+7j4JtjvT/z
         WUUQguhRqGIDKmM3tyMvuC9WhpAbSQHNx69P+jc4JxreRi+THk9af5Gfy/FIdYKurSuG
         oLFA==
X-Gm-Message-State: ABuFfoi1nQwJNXail7ioiCxUbHRUCAT64btzuoHHsJd/jOoeltLRFN0x
        v/tAI0DTiP9zibnfoaKaPpJBAg==
X-Google-Smtp-Source: ACcGV60PdcpRzLfMNUX5Ou+o2ejyk5ii6DiOh+GtJhJFJbIv5eewgmRrFjS7NrWLn70iAxI/kLT4qg==
X-Received: by 2002:a63:f501:: with SMTP id w1-v6mr73688pgh.336.1537912129340;
        Tue, 25 Sep 2018 14:48:49 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j7-v6sm4385924pgn.38.2018.09.25.14.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 14:48:48 -0700 (PDT)
Date:   Tue, 25 Sep 2018 14:48:46 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: pinctrl: qcom: Add SDM660 pinctrl
 binding
Message-ID: <20180925214846.GK2523@minitux>
References: <20180812142413.20856-1-ctatlor97@gmail.com>
 <20180925173801.3835-1-ctatlor97@gmail.com>
 <20180925173801.3835-2-ctatlor97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925173801.3835-2-ctatlor97@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25 Sep 10:38 PDT 2018, Craig Tatlor wrote:
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt
[..]
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: the base address and size of the TLMM register space.

This should mention that we're expecting address and size of the three
tiles. And the proposed patches depends on reg-names for the lookup.

> +
[..]
> +Example:
> +
> +	tlmm: pinctrl@1010000 {
> +		compatible = "qcom,sdm660-pinctrl";
> +		reg = <0x1010000 0x300000>;

reg (and the node address) needs to be updated.

> +		interrupts = <0 208 0>;

		interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;

> +		gpio-controller;
> +		gpio-ranges = <&tlmm 0 0 114>;
> +		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};

Regards,
Bjorn
