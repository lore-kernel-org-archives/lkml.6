Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E33C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B76E214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cenpffuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B76E214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeJIRMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:12:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37932 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIRMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:12:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id 193-v6so1240476wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 02:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=I89TKi6GBPj/5x0cN5kty7TOmv36AriL0sdgeWDj5Tg=;
        b=cenpffuR7vFvUNMqSmIc+DnMKnTm1StOa+8tLeB9Sr63VCoohUzxGMVBIAsJ6l3Gvf
         SDkXRJ3HtEwFqMA3olULI/FaCgtGLI74vka1hEClOCpMh9nMXWEdoyY1tywJzwfhEvsi
         byiMiobS7m2L9PwGtW/JQ/ySrJ2WmLVxFOMx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=I89TKi6GBPj/5x0cN5kty7TOmv36AriL0sdgeWDj5Tg=;
        b=QPrQ58CA9yBPrunOl95NkcADlX7+RQfb/sMgPEpT1QaY6n49Q9MQyXS0UbNGvdGGC4
         RAVQgmQOXo1sq/N1HLI13q39gO3lok+MA2IHM/6ehSQihjCR0cW1bcKi5Iahaan/ZVlL
         WXl9+ufmp+cLT355f5g/hbPhllNgMKEQ7KUNbbtn2k64xtMHBtKWZPS3lKISnRXz5PwC
         6Pls0pOW7XuRwvUwgdG0Gw44ZIc91h1L66PMwaNrh0xVP7S24ayK3QcVFA85FjYMsaxO
         czUOncAFep6pMgy2dLTH9TPZ1OXbV/V0PCkPdpYISEuTEwIawNpQ3WrvISnBSVCxtkxh
         j30A==
X-Gm-Message-State: ABuFfogNab/c03bPoRWDiAhaIM8C7Qnkk7U6oEcIdPokpWrgPwM/od+X
        NmDmWVdGbsBaYP/c/8plEFNUsw==
X-Google-Smtp-Source: ACcGV63BgHRHilAaZSeV2XSKvt/3mtiAVFA1Sb4c+2wCqa4HigUPoMfzIZfnmg7X0YlDXu708h4juQ==
X-Received: by 2002:a1c:83d2:: with SMTP id f201-v6mr1276385wmd.107.1539078984974;
        Tue, 09 Oct 2018 02:56:24 -0700 (PDT)
Received: from dell ([2.27.167.111])
        by smtp.gmail.com with ESMTPSA id m143-v6sm10061902wmd.29.2018.10.09.02.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 02:56:24 -0700 (PDT)
Date:   Tue, 9 Oct 2018 02:56:22 -0700
From:   Lee Jones <lee.jones@linaro.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 1/7] dt-bindings: mfd: Add ST Multi-Function eXpander
 (STMFX) core bindings
Message-ID: <20181009095622.GH4939@dell>
References: <1538048404-9041-1-git-send-email-amelie.delaunay@st.com>
 <1538048404-9041-2-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1538048404-9041-2-git-send-email-amelie.delaunay@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018, Amelie Delaunay wrote:

> This patch adds documentation of device tree bindings for the
> STMicroelectronics Multi-Function eXpander (STMFX) MFD core.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/stmfx.txt | 28 +++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/stmfx.txt

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
