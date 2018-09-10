Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65425C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7E62086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="USX3dUjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7E62086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbeIJTwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:52:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55156 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbeIJTwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:52:36 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so21890561wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 07:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/ukGdzWBtmk9gFQRW/6WB5IqCbFh+0N+fAEU1vMF1NY=;
        b=USX3dUjf5QsXsBXI2uBd31nCaUmQdNs1dE/F3nPDWwYMUTLDJDrifKethzB1BBgLBR
         1g/Jo3AOQMLR4TLmCLUnh7b5FutI3Y6fmyM2+6d4OqZtvtDmV1lsRLgFB+i2/Db28R3q
         RT7h0hMuQNRoSb8CjV8WUvbeI3xsXdDFd5l3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/ukGdzWBtmk9gFQRW/6WB5IqCbFh+0N+fAEU1vMF1NY=;
        b=lNiWfnHS9hpZhdKSTfU+PI1W6vjIl0NnCslt0rbON5DDQj0bnW4pDQw2CAOH4u+PiT
         t7hCB3BF1OcYCK3I9uQjj+jB/9Lput6uF8KTtM15c9qRPeTAeKbPrtWjhOgIZG9Xg3Yg
         dxDGH54a0J80pe/i8dlof+4lJNZzOtba5qdH2ujSuiLPVRZm0PUEdsREJSUFhErucR0i
         3igDKlh5u+yyzo356WD9YAeLu/g/lI1FpjXjOMIror6Tg1TgTMyB0h1B+d60vq1ls0n9
         3tm3Z2lHfYQD8L6Pov8mvHFXsDCZckXajfEk7OCTG2051tzGoq9bn8KQfBdy2nXprJ2o
         VzoQ==
X-Gm-Message-State: APzg51D/EJFJCnUNyorYcdULlVaZoD5zvlVZwECZ8BcCAVLvmKgHi1FR
        2/sgoxglinaF/nFl6eP8IIBkOw==
X-Google-Smtp-Source: ANB0VdYFjzw5WkrTJs+z6MQD/olrZZ/rGzuV4XFyqXiMb3WmeMGpdG6Rp2Xybtj0iJGCGp25gPVGFw==
X-Received: by 2002:a1c:c019:: with SMTP id q25-v6mr979592wmf.148.1536591486658;
        Mon, 10 Sep 2018 07:58:06 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id t132-v6sm23582069wmf.24.2018.09.10.07.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 07:58:05 -0700 (PDT)
Date:   Mon, 10 Sep 2018 15:58:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 01/24] mfd: Add ingenic-tcu.h header
Message-ID: <20180910145802.GV28860@dell>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180821171635.22740-2-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018, Paul Cercueil wrote:

> This header contains macros for the registers that are present in the
> regmap shared by all the drivers related to the TCU (Timer Counter Unit)
> of the Ingenic JZ47xx SoCs.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> Notes:
>      v2: Use SPDX identifier for the license
>     
>      v3: - Use macros instead of enum
>          - Add 'TCU_' at the beginning of each macro
>     	 - Remove useless include <linux/regmap.h>
>     
>      v4: No change
>     
>      v5: No change
>     
>      v6: Rename barrier macro from __LINUX_CLK_INGENIC_TCU_H__ to
>          __LINUX_MFD_INGENIC_TCU_H__
>     
>      v7: No change
> 
>  include/linux/mfd/ingenic-tcu.h | 56 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 include/linux/mfd/ingenic-tcu.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
