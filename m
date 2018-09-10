Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8598DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE912087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FF08makX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE912087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbeIJUp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:45:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34312 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeIJUp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:45:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id g33-v6so22532795wrd.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8KzjxhxZDNvPKQ8C8Mqvnuj9TvJjWBRXfieOwudehBk=;
        b=FF08makXttZk0utyho2qJQJK7hhova2FuEq9rl6999a4x/qpSmyFZ67gzQtryGKvI9
         /UrwBGB42+yAV7Mi5CGd3SE35s/H1sn/KaV4jrn5WL3bYR7eTQ/RIRvcMbvyBLa73AS4
         tC2b4R0fPh2P97y0bjtFg69pTRbxQAh6Xx2Mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8KzjxhxZDNvPKQ8C8Mqvnuj9TvJjWBRXfieOwudehBk=;
        b=MkdFSYixC8KUyzq2nXaiFxfZedmuAeiHXAvHhcRcbfikjmYcXxq+cHuMEZHpKUzHI1
         2xeTQ+6kgegrn+qUDnvj222i+dZdKfG71Y+raLHz7fV8h7Ny0TA5HZru7lswddk88YUA
         S7g8HlCmqhkzKK/W9x8v1bB8Fz/8mgN/bzm7gNwgjBfZP/1LuICe+De8qIA49cDOOOlD
         XOvZnZ7BgtmYU6/YYId8AcKWoXTyB2LOyNaDHMKDwGwxtgXJd7c3oVfr6y4zyWFo0ng7
         i717UsqnoyFfRrdj6FebbLuGN7+5E1VPMj8lNsE19yAJsLumr29+yPo7fNhUS/pNoNX9
         f03Q==
X-Gm-Message-State: APzg51Az90VypRBBP/AqJmDLJzf82UVELLLktZp1hbDm7g6yMV+P+Vr2
        wqvNPwAQNte4qZbx1E+YwJOPBw==
X-Google-Smtp-Source: ANB0VdYBKkr4O8/D3np0LCyAuSAwi8KGtmpIpxFhzii1RA8nF+99LJO5YVHXPu3RGpQrboC2AAe/VQ==
X-Received: by 2002:adf:f24e:: with SMTP id b14-v6mr14303505wrp.184.1536594675390;
        Mon, 10 Sep 2018 08:51:15 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id u1-v6sm12387421wrt.59.2018.09.10.08.51.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 08:51:14 -0700 (PDT)
Date:   Mon, 10 Sep 2018 16:51:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 2/7] mfd: intel_soc_pmic_crc: Use
 DEFINE_RES_IRQ_NAMED() macro
Message-ID: <20180910155113.GH28860@dell>
References: <20180830165255.43114-1-andriy.shevchenko@linux.intel.com>
 <20180830165255.43114-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180830165255.43114-2-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018, Andy Shevchenko wrote:

> Instead of open coding each data structure with IRQ resources,
> use dedicated macro.
> 
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_crc.c | 35 +++++---------------------------
>  1 file changed, 5 insertions(+), 30 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
