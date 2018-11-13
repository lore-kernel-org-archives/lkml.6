Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFF9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 07:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDF1223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 07:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T0juWq8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDF1223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbeKMR0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 12:26:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46487 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730124AbeKMR0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 12:26:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id 74-v6so12018744wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 23:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=exzNAeHCsBzK37B8k6fVwJOtNDPkYbY+cHMlTntNtMk=;
        b=T0juWq8wVpt8iYAJhwDFNk/FzM3GsZv3Ljqs8JibSKllb6YiNuMGfUoqzlGo+9RiJm
         m3d+2xLTzrFCL4bFXz/Zp0my7prp/eNLQgDxGQoiz2IZKDX2RuQ5KRK1luXxn623HxDX
         jYgDcq84yzjgkadvzsBqAn+jTyl27Eex7U2Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=exzNAeHCsBzK37B8k6fVwJOtNDPkYbY+cHMlTntNtMk=;
        b=fCbGGQq9dQEmXg6QwB1+cAkhdD0i/HqffpYIh+doIFWW+fYLrY/GNT+vAJhVNivcTG
         U9PeooXeeoJsL8cnLCYIZYbiTfbGCoE7+z0zPy+DFNLtmNjQhpBYeN8/GnuZpH/eQK8d
         YYB9hNrGbT7/gqDNc2MOiOHSaqcP0xsJFpqF7JSpiYV91dYO/oU3hpdiFQtHc0gUadyD
         CYIJBsx9pjaa/vFODtU92KzYB0PGHi13uua0TwjPNfj1Vc4Wb0qAQfxgaolGXFg1lbIC
         q4cAz85OvOoywNnOJQc0eA5alDxFKjOCPvEHAENPG4T/rNVb0sAZkj7t4di/vd+87HQR
         vTOw==
X-Gm-Message-State: AGRZ1gLBEetQQYYCreoE8weO6iawykqmZxQCAFC9LT1JWwnfOj8KKa6q
        k4pbYiEDY26/ZDw485B/n97Avg==
X-Google-Smtp-Source: AJdET5c07S62IzAnnoBhLwYvT+m09roUiys7UjiJXNwnhtKIQ1BWKFgYC5AeHI+WzgjcXL7iJ6c0TQ==
X-Received: by 2002:adf:80ab:: with SMTP id 40-v6mr3702181wrl.158.1542094181451;
        Mon, 12 Nov 2018 23:29:41 -0800 (PST)
Received: from dell ([2.31.167.205])
        by smtp.gmail.com with ESMTPSA id x16-v6sm13168267wro.28.2018.11.12.23.29.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 23:29:40 -0800 (PST)
Date:   Tue, 13 Nov 2018 07:29:38 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
Subject: Re: [PATCH v5 1/8] dt-bindings: mfd: document stpmic1
Message-ID: <20181113072938.GB29388@dell>
References: <1540830122-2577-1-git-send-email-p.paillet@st.com>
 <1540830122-2577-2-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1540830122-2577-2-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2018, Pascal PAILLET-LME wrote:

> stpmic1 is a pmic from STMicroelectronics. The STPMIC1 integrates 10

Nit: "STPMIC1 is a PMIC".

Once corrected, please apply my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
