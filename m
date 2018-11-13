Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ECCC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4674A2243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bw1+j1F/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4674A2243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbeKMR5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 12:57:48 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38771 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730421AbeKMR5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 12:57:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id f2-v6so10400471wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 00:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0WjcOcEF2tILUG9n0zvqfEgXSFmMixTe1bOTcLLE5PU=;
        b=bw1+j1F/fjMSxFVaFVcxauff5wBRYGk6zrpY/mTpZvy+FKkpDdatXfop9oN6WPPe0c
         O/Aw9J9yRtAx6qsael/SRo6SlzGUUkJtFO+s3U1xtu62/beemq11jztxNaiHUOjtOZqm
         QnFP6WrBvMMNnMMLs69TkkAsvnmmoHRL+wXRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0WjcOcEF2tILUG9n0zvqfEgXSFmMixTe1bOTcLLE5PU=;
        b=Y/zdTX6t2qCbJzi5v3Fm6FHzZJhUbR57wbKLGQVsvx4LVQzQTAAQCca0u2APS/VkOB
         0MkrSlGA4G+8BgecUiXB+tBMy7w7DyUvGb7tDyy1HlOcvrbMQDQ9tb3Yp+Fdb726kSa1
         p7nBy8yLkLziAEGmIiTjDdzkevhC81Jkz1PNGhYYcAspR2KDKMrZ6Mmyuay8bvejLvvq
         ce7AXb+sEcyE36CAWeviwiY4jgFiDiMz8E6x74VacboX/a+RXzCbHqL4wiiMXH6mFfW8
         P1BOhO+1hozOueMAY9KF3m4PLbyl25lcvgr6GvU/zMN1KUysAayiIENCxQZ059YH5Pdv
         Q9bg==
X-Gm-Message-State: AGRZ1gJUTHkw5lVJi0nzrvjJ1cdfGcOHPL9AJ+33kYJxqJT2D9qCxw2n
        03fOWXtj/F9y2e/jFCpLvdhExpeS3q0=
X-Google-Smtp-Source: AJdET5dEkbANOXOuhJDy2zFAHjMQF0jqFORNBiybku7OvXkLHCd2sMHmA8ohwnjyMA/9rBX7NGNG1w==
X-Received: by 2002:a1c:8d0b:: with SMTP id p11-v6mr2323272wmd.49.1542096051294;
        Tue, 13 Nov 2018 00:00:51 -0800 (PST)
Received: from dell ([2.31.167.205])
        by smtp.gmail.com with ESMTPSA id c14-v6sm12036311wmh.44.2018.11.13.00.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 00:00:50 -0800 (PST)
Date:   Tue, 13 Nov 2018 08:00:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Dien Pham <dien.pham.ry@renesas.com>
Subject: Re: [PATCH] mfd: bd9571mwv: add volatile register to make DVFS work
Message-ID: <20181113080048.GG29388@dell>
References: <20181003135841.4984-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181003135841.4984-1-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Oct 2018, Wolfram Sang wrote:

> From: Dien Pham <dien.pham.ry@renesas.com>
> 
> Because BD9571MWV_DVFS_MONIVDAC is not defined in the volatile table,
> the physical register value is not updated by regmap and DVFS doesn't
> work as expected. Fix it!
> 
> Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
> [wsa: rebase, add 'Fixes', reword commit message]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Fixes: d3ea21272094 ("mfd: Add ROHM BD9571MWV-M MFD PMIC driver")
> ---
> 
> Grabbed from the BSP and confirmed by the datasheet. The register is RO
> and reflecting states depending on other registers.
> 
>  drivers/mfd/bd9571mwv.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
