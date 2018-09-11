Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB5CC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EECB920839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AbQG4DCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECB920839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeIKU6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:58:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44546 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeIKU57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:57:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id v16-v6so26575836wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 08:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zQLdpiOP+mH0F7Z2KhmFeKfWxuzjehojwnyawA1Ms04=;
        b=AbQG4DCFkMWXYOVKLd5qa/DXarZF3znO4I9u4e529ExvUEQ947bt2v5FTER3I3I/EB
         qnvi6qjGN1dL5z6TstuzG3L6QCIO155Snq3C6+PosJ0JWQIEwQqSCSkcvTz9+PZC4u2n
         R9xour43tetFXD8587+PJLauE4bhGOuVN33sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zQLdpiOP+mH0F7Z2KhmFeKfWxuzjehojwnyawA1Ms04=;
        b=pKzsaIwYntJOOY0WUjp3nfPe1ovvQUcX/1eYAi2D61X6psoWWuZ6Zl5F7lh/MrJOTX
         C0fHwLwNT6xfcgiinb0dQeKF3lDhpfDvjBf60r8pDz/cDlS2EFtNHb/pkyDofaT//yry
         feWmJJrt3hGu6k8/lpj03BC7Hfyiq/D8E6fkd1R9Tz4/ilShWcZzCpPpPvZffAipk/ZN
         Ofa0wne+2jz36MMLeeUe67wVkp/b+2S8g6t4N9TKfX5DyVRh2wXcjaUcZohdEuXoMw+T
         UdoPnOYIGDu9dpmKIadQgxjNr8L9h7St36XbAi1FPVI9T3FEUOKse0tn6dF388UM0Tok
         9RAg==
X-Gm-Message-State: APzg51A5hnYiCoRYtRBcQDcwkqW8krI1raA+1TkhR1vHpovPg035h5K7
        aTLRIxyZnbQmcDHLi5YxXcG9OQ==
X-Google-Smtp-Source: ANB0VdZGjVVNMtDORnVvLMs04H/M4bEWJ3fTQsIGosY0yQx56GVNZH9RKLW8I59o2WLS2SOtr37+Kg==
X-Received: by 2002:a5d:4a87:: with SMTP id o7-v6mr17729035wrq.132.1536681482489;
        Tue, 11 Sep 2018 08:58:02 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id g129-v6sm1975501wmf.42.2018.09.11.08.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 08:58:01 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:57:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: [PATCH] mfd: ti-lmu: constify mfd_cell tables
Message-ID: <20180911155759.GE4185@dell>
References: <20180829093108.GB22065@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180829093108.GB22065@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018, Pavel Machek wrote:

> From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> 
> mfd: ti-lmu: constify mfd_cell tables
>     
> Add const attribute to all mfd_cell structures.
>     
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
