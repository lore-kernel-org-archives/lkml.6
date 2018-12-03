Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C83C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAFC20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKDlzuMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAFC20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbeLCLIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:08:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43713 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeLCLIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:08:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so11651256wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 03:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KMZBDmMTrpSwjZTAF35NCj3pLd4zaPc19uNelerRsnw=;
        b=YKDlzuMyJDlVtsRRrb0Mmf70iu2RX75GOX/3Bcgk6FGmtSM6JW3oEAl4ycLSKn09ra
         x3vks01/dtzckaNTs06ch6a5/M9LacKzKt3e7e+MSS9PpR30vXtOU9Wp+1NW0nqIRDiy
         07+Cn2Fp3+7s47fpZYYUstKrrRLL2AX/Q0BP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KMZBDmMTrpSwjZTAF35NCj3pLd4zaPc19uNelerRsnw=;
        b=CgQniTBYm/CEJL9bhkps8gkKzcsOUkNpH7279q01KzVwEiD2TE1D5reQEymQIAkqtT
         3Y7x7QKCg1me1fisuQe6u4MIYKoT/mJ9jYMGdx2ZoeKhPCT+TOexTaaA35tUjenf7G3Z
         5OrHnQVpeBoiRSDVKLLyu8lBr5nxcCNuYbhz8k6Q4y/2+CI39vS7mSTwlESVTrM7rOLG
         Os1qLA8IZBstvcrRSCyFPWmWib97vOue9Gf8svh/CxsTwOuF0tuSUVXEpPjLycn9GLdA
         ILeMo2L7ELVhn6r98mkhmBhkNxC3T9ApOyhOjCvBGOh76K3vgZUaRBMGuGlYLVi+dGi3
         ZGMg==
X-Gm-Message-State: AA+aEWaBRsnjwjuX+66FT9YOPhvc3iSINi7mti8eeXubKKwB9zlyrzca
        dL4YtZ/adgHKMKUCU6bsRDByow==
X-Google-Smtp-Source: AFSGD/VZxxd/OSMWmz0cgnikgBjwOK3SiM7/Fs1wdTHRDr306zgct+2048jHbfl11AOBII/yQw55AA==
X-Received: by 2002:adf:f449:: with SMTP id f9mr13998747wrp.40.1543835292510;
        Mon, 03 Dec 2018 03:08:12 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id l15sm11214066wrw.4.2018.12.03.03.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 03:08:11 -0800 (PST)
Date:   Mon, 3 Dec 2018 11:08:10 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     egranata@google.com
Cc:     Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@google.com>,
        Brian Norris <briannorris@google.com>,
        Enrico Granata <egranata@chromium.org>
Subject: Re: [PATCH] mfd: cros_ec: Add support for MKBP more event flags
Message-ID: <20181203110810.GI26661@dell>
References: <20181129195548.204153-1-egranata@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181129195548.204153-1-egranata@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018, egranata@google.com wrote:

> From: Enrico Granata <egranata@chromium.org>
> 
> The ChromeOS EC has support for signaling to the host that
> a single IRQ can serve multiple MKBP events.
> 
> Doing this serves an optimization purpose, as it minimizes the
> number of round-trips into the interrupt handling machinery, and
> it proves beneficial to sensor timestamping as it keeps the desired
> synchronization of event times between the two processors.
> 
> This patch adds kernel support for this EC feature, allowing the
> ec_irq to loop until all events have been served.
> 
> Signed-off-by: Enrico Granata <egranata@chromium.org>
> ---
>  drivers/mfd/cros_ec.c                   | 20 +++++++++++++--

Looks fine, in principle:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
