Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39E1C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7FC20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544568370;
	bh=0ac/iWK9abO/kmwnL1acfeYRdvwXmEOPcgKtpWRGZLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Up+Vw4BH8b9XQCacCzIJ58/wk/R6U9ytg/ckCs+4VJNbj4UgmRlo6e6Y5wRu3O+6g
	 ygoMDR3aZnuV0VRUNzga5eEgxWYhe8UPbiHOKBOsQ2yegbM5T2S2cgNsO5YCw1GAQu
	 sTp33vKKcnuP1css8Yu5yMtCEuXU1e+Rq1Sqc32Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7FC20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeLKWnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:43:53 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44453 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbeLKWnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:43:51 -0500
Received: by mail-ot1-f65.google.com with SMTP id f18so15729105otl.11;
        Tue, 11 Dec 2018 14:43:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r6UDmpXPkRar1OXJqQs+UpFXCk7geFte4T5MJecLED4=;
        b=R522hQAUxzN5dCsY1iTQRWptBw2JZdns93hybAHaQcQ2IjTRqKS5dIHDgOVgeuuoxK
         UYj4o/hGZ0Nb9evxPyC9qZ3toG0R2EFWxBEgytojaFMwM4zD1zmssQE35FcEjf6UiI1u
         3uXLdLcMnB2KP4nPyr50iClTBGgoiniiMM8oCMFktEsy+B35CHKy4umjq/tlc67iUC47
         G4yv9w+iIgCzArMD+k13+FWTD49DmppWoQlOxuP8bydHEJ1JnlnVEAzotrPPVSQLuw0K
         3j0YaftZwspQE2dLHdJJB6D+5vclkd7k4mjFvwzhqqTkgdJcetpTrmPdwxeWN+gIyugp
         BcKw==
X-Gm-Message-State: AA+aEWa0mJOM45r4DuMh5kw022W/N1wPPSeLLDgRxh8N8YGKW0xxcxec
        vbI8d+pAnQWKeSium//BSA==
X-Google-Smtp-Source: AFSGD/X7EZ4yij7EiDpQCj3IRqYplM/BN1inzMbIONTln+zA/M6MV+xhsBRPYapP3kuD9jMloIjK1w==
X-Received: by 2002:a9d:6197:: with SMTP id g23mr12193917otk.324.1544568230718;
        Tue, 11 Dec 2018 14:43:50 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i22sm6633807otp.7.2018.12.11.14.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 14:43:50 -0800 (PST)
Date:   Tue, 11 Dec 2018 16:43:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, devicetree@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] reset: imx7: Add support for i.MX8MQ IP block
 variant
Message-ID: <20181211224349.GA30397@bogus>
References: <20181128043738.12714-1-andrew.smirnov@gmail.com>
 <20181128043738.12714-3-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128043738.12714-3-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 08:37:37PM -0800, Andrey Smirnov wrote:
> Add bits and pieces needed to support IP block variant found on
> i.MX8MQ SoCs.
> 
> Cc: p.zabel@pengutronix.de
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: cphealy@gmail.com
> Cc: l.stach@pengutronix.de
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/reset/Kconfig                    |   2 +-
>  drivers/reset/reset-imx7.c               | 106 +++++++++++++++++++++++
>  include/dt-bindings/reset/imx8mq-reset.h |  64 ++++++++++++++

This goes in the binding patch.

>  3 files changed, 171 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/reset/imx8mq-reset.h
