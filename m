Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C745C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DE32081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Im1m/+df"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DE32081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeK1UTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:19:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38693 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbeK1UTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:19:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so22025156wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 01:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fbXR8KePKS/cptrasl/TEP0Y21ycc5UmMC0HPKaMDwI=;
        b=Im1m/+dfgPxcMWXAvcQMoiF6IA325AUqhEUYZ6NbOWN2MqrTYk7djY/1WDSv6QlGeK
         H0zEI59NRdT4Ii7h0kZmI2YLWAd7AqrfdOkMqY6TJR0/vBBNie35XnwpyEd7s5TLbkZb
         y17vvEhU6atHosyMo/uGZwg99jb8RgECMUS20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fbXR8KePKS/cptrasl/TEP0Y21ycc5UmMC0HPKaMDwI=;
        b=TTTcuwmn7YeMtBTT/O9t2yGkFg1zTRmoeUOaPGDHcVLLyyg6p9iDv849mHuON29LyM
         iVp3MIGncE3+6erAUGYuWu72JqFGmx1TfxZOyjhSO7qPxRQ13xxHA1EQLSX1fhEADxxB
         R20H6FL//Ha/V3YfN92GXZLhTHZljgmRWDV7YLBex2ofzTg/Twf5D7z+i0WdKsFVbtvH
         5qUf1DBycGQ4ihsRo14W0uo79zCdab7yw1R7XgojLaooUmyVq0w5+ecxQ4AnZfejeWZb
         rwRw+K0ur7m4TRmf4Rs3RXCDNDQpjXZ0qRfYkgTCFvY73mUZYNfem8cpS2Ll65fD9bkL
         NKdg==
X-Gm-Message-State: AA+aEWZvbF7nE/Skcy8N8n7u/JFjrdfN0EirCRoBIUIgsRuJnMP4XepD
        VVle7Ch9uJWJ8/RubOlznUxF2w==
X-Google-Smtp-Source: AFSGD/VZj4j90Qba1d4awPiSsJRV65kjQ4rtR+M786zfiFoS3WMGW8rCt2obw75yzaVMxdenCrDNwg==
X-Received: by 2002:a5d:4e82:: with SMTP id e2mr29707651wru.291.1543396725630;
        Wed, 28 Nov 2018 01:18:45 -0800 (PST)
Received: from dell ([2.31.167.233])
        by smtp.gmail.com with ESMTPSA id a17sm9763731wrs.58.2018.11.28.01.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 01:18:44 -0800 (PST)
Date:   Wed, 28 Nov 2018 09:18:43 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, broonie@kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 2/8] mfd: lochnagar: Add initial binding documentation
Message-ID: <20181128091843.GV4272@dell>
References: <20181120141631.18949-1-ckeepax@opensource.cirrus.com>
 <20181120141631.18949-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181120141631.18949-2-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018, Charles Keepax wrote:

> Lochnagar is an evaluation and development board for Cirrus
> Logic Smart CODEC and Amp devices. It allows the connection of
> most Cirrus Logic devices on mini-cards, as well as allowing
> connection of various application processor systems to provide a
> full evaluation platform. This driver supports the board
> controller chip on the Lochnagar board.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Changes since v4:
>  - Move sub-bindings into separate documents
> 
> Again incase Rob missed v4 I have dropped his ack due to the large
> changes introduced in v4, see:
> 
>  https://patchwork.kernel.org/patch/10673891/
> 
> Thanks,
> Charles
> 
>  .../devicetree/bindings/mfd/cirrus,lochnagar.txt   |  71 +++++++++++

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
