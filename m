Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE79AC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 09:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A69270C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 09:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AvG8n7iw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A69270C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935850AbeF3JcT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 05:32:19 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36796 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934002AbeF3JcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 05:32:13 -0400
Received: by mail-pl0-f65.google.com with SMTP id a7-v6so5611566plp.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 02:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ak8Horqh/SC2lR32o0OarH6maH7bWUMZY5fgtUN+b8A=;
        b=AvG8n7iwryfN8xOJAnmgp+jiuUdTjbS6oUY7tdp+EUAdZSb4nfM9FuOyy/dbG7C5Z6
         n3Yh1QKSUEdsviOsuY9w1KsRUjxP0VLxzBH+XJ35X+dZO0mu0pfLlscvocDSqre0gVFv
         Es19r/UX6d55SJVPWgmHcspRDbYYMyMhGpMTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ak8Horqh/SC2lR32o0OarH6maH7bWUMZY5fgtUN+b8A=;
        b=Ne0lIl5dFrmR/fWvwDwAtaFL7Kk4Fqe3Ispudz2SvDYfp0tdgQgSZxaZnywOTNzVNB
         TtVCIRaH1MyU98LoEgFA7w6xRBICh+q3TJEG5f6pPHM67RCqzNDLXEyyIMi48q419phS
         dr9aHVtbSo6EHuxuD49Y5vcFcN7Txioqv4mSWPmSDcUH/X9JRR7pGrT6XjZSY1bsUfg1
         a/HxujFGTYyzMFT9mySevj2usxkzvAyCyhKmeSjjZ4aN4vWj6DzznnG4lhJ0w7jspi0+
         SiSfbzin525rVtAG/de274/EV+5g2DnpWMzpEiIhI+uPrx+ZKa2rWqgYf6MpAc7IrNLR
         bKaQ==
X-Gm-Message-State: APt69E0IYzpsNEHrcgDgviH0jB2SS5+02IvDalbwLhNsYMQEg/jgH7TB
        McdBY1wDjfcppWF9idfg3rh774QPtQ==
X-Google-Smtp-Source: ADUXVKKvbJwXvoS5dfMdFoJCS2ToxaroxeriuNaGPmKqld1wIPsUiUjwuA4WGLcR1UqNw4+8eK0pLQ==
X-Received: by 2002:a17:902:981:: with SMTP id 1-v6mr18380395pln.11.1530351133302;
        Sat, 30 Jun 2018 02:32:13 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:73ca:b257:2c06:3367:1893:796])
        by smtp.gmail.com with ESMTPSA id 86-v6sm30268643pfp.17.2018.06.30.02.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 02:32:12 -0700 (PDT)
Date:   Sat, 30 Jun 2018 15:02:02 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     afaerber@suse.de, sboyd@kernel.org, pn@denx.de,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: clock: Modify Actions Soc clock
 bindings
Message-ID: <20180630093202.GB7320@Mani-XPS-13-9360>
References: <20180626192820.28237-3-sravanhome@gmail.com>
 <20180628191805.3722-1-sravanhome@gmail.com>
 <20180628191805.3722-4-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628191805.3722-4-sravanhome@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravanan,

I agree with modifying the existing binding to accomodate other
SoC's of the same family. But the binding should be
"actions,owl-cmu.txt" since it reflects the family name.

Andreas, what do you think?

On Thu, Jun 28, 2018 at 09:18:05PM +0200, Saravanan Sekar wrote:
> Modify clock bindings common Actions Semi Soc family S700/S900.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  ...tions,s900-cmu.txt => actions,sx00-cmu.txt} | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>  rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,sx00-cmu.txt} (71%)
> 
> diff --git a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt b/Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
> similarity index 71%
> rename from Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
> rename to Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
> index 93e4fb827cd6..8dc7edb4d198 100644
> --- a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
> +++ b/Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
> @@ -1,12 +1,14 @@
> -* Actions S900 Clock Management Unit (CMU)
> +* Actions S900/S700 Clock Management Unit (CMU)
>  

Same as above. Should be Actions OWL SoC's Clock Management Unit (CMU).

> -The Actions S900 clock management unit generates and supplies clock to various
> -controllers within the SoC. The clock binding described here is applicable to
> -S900 SoC.
> +The Actions S900/S700 clock management unit generates and supplies clock to
> +various controllers within the SoC. The clock binding described here is
> +applicable to S900/S700 SoC.
>  
>  Required Properties:
>  
> -- compatible: should be "actions,s900-cmu"
> +- compatible: should be one of this

Change to: compatible: should be one of the following:

Thanks,
Mani

> +	"actions,s900-cmu"
> +	"actions,s700-cmu"
>  - reg: physical base address of the controller and length of memory mapped
>    region.
>  - clocks: Reference to the parent clocks ("hosc", "losc")
> @@ -15,9 +17,9 @@ Required Properties:
>  Each clock is assigned an identifier, and client nodes can use this identifier
>  to specify the clock which they consume.
>  
> -All available clocks are defined as preprocessor macros in
> -dt-bindings/clock/actions,s900-cmu.h header and can be used in device
> -tree sources.
> +All available clocks are defined as preprocessor macros in corresponding
> +dt-bindings/clock/actions,s900-cmu.h or s700-cmu.h header and can be used in
> +device tree sources.
>  
>  External clocks:
>  
> -- 
> 2.18.0
> 
