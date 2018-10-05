Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B35EC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3922084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IA+Czyd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3922084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbeJEVWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:22:19 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37846 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbeJEVWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:22:19 -0400
Received: by mail-oi1-f194.google.com with SMTP id e17-v6so10528596oib.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9B8xhUSOm0v2qYzAvfmnDc07vYGf7y4kGmYUisvKrQs=;
        b=IA+Czyd8hJak0ruZSWYAE2ArqzJ1m/SYFyAR2CMFTwAcAsPpj1wuIrJU1+1lT/CnxL
         5bFuQFgMIOX+pjhqjHwuIi/NkKhJ3WT0EjOo4faCUH2LVirkKoM5y8B2CgpULdw4Zqtt
         ZzEs7EVampcZ/Xfljs+OOuaqc/kfbGaGRV184=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9B8xhUSOm0v2qYzAvfmnDc07vYGf7y4kGmYUisvKrQs=;
        b=ro8dFmFEOgTqa0FQ4SLRcTLEDuGzguzICcpPQfdNwEvk5eDO7GbroGMtOvcDVlFT5u
         sMDohx0pkR0eRmxfgdIkrjrCa1eUffNvWayb0zhxGzI6QJ0O2Y9+ODXG5bdDlvk/RLSD
         ip/ASl61br7zc0FH6j0fvsppJLJuhz4WXIxrMdc+x5m/hsAXTKj0x2AxOj51GccrfW72
         Moxd4LcxEbYqSHgFSJc1NCAkMZRNVPsLe7X7DpnqdXCgeEfkvhQKopsnGv+DafQ2i0dp
         sdDGaM2C1TvqVBzYswIB0WBJNySCU3eIJn4BHSm4Yw6aP9IMH3Ya6k4ffhpdYuu9z9Du
         0ddQ==
X-Gm-Message-State: ABuFfoidqZq71D9x8QcMlhDdDhMjngv34Mz16WFU40qHNTXneA+JYXy7
        6UM07wQSW3+fck839X4pIV7GpQ==
X-Google-Smtp-Source: ACcGV61pqh/7G6v0eP0sx6J/CyA3TTtYayGv0Nz/yiCV/R6Jkz23G0FojKRtsqRmb4gBTNH24p86sg==
X-Received: by 2002:aca:ccd2:: with SMTP id c201-v6mr4150298oig.357.1538749401207;
        Fri, 05 Oct 2018 07:23:21 -0700 (PDT)
Received: from localhost ([64.157.242.222])
        by smtp.gmail.com with ESMTPSA id m11-v6sm2606798oif.27.2018.10.05.07.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 07:23:19 -0700 (PDT)
Date:   Fri, 5 Oct 2018 09:23:18 -0500
From:   Andy Gross <andy.gross@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] i2c: qup: use core to detect 'no zero length' quirk
Message-ID: <20181005142318.GA15665@hector.nxp.com>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-7-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723202617.15230-7-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 10:26:10PM +0200, Wolfram Sang wrote:
> And don't reimplement in the driver.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Reviewed-by: Andy Gross <andy.gross@linaro.org>
