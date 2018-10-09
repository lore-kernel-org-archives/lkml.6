Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF52C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BA321479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ecJ3Eg17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BA321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbeJIRrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:47:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41928 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJIRrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:47:48 -0400
Received: by mail-ed1-f68.google.com with SMTP id x31-v6so1192339edd.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 03:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FbBwNrlrZdUosaHWkJjbg9i4yACyLJRcp5zv/VcV8K4=;
        b=ecJ3Eg17FCtxK5a+FML9M0x9br1AyndCAb1cuGDbHHb1QzQxTU6mUTj3qtyNUNn3tU
         tbiiMPl0Ra0BWL0bAv0rlerElgodPm24LUvheElD1Sk942fd9MRAzcYZ9FbCplUCjMCm
         rbMeOF/FxkGi/qam6v54Ple9uRiptiEvPZezc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FbBwNrlrZdUosaHWkJjbg9i4yACyLJRcp5zv/VcV8K4=;
        b=DQneP6Kxy7erB7AiEUi77aGnnwGirRSMS6rcIQAmqEzwCxdJhrAA3zz/505hbYef4w
         WCaDCz232jNF9Zl2d72asL54joIt4/aBIhir/YhcnXvAl+IwfpOvt2A0Jc9E4p826zmZ
         lV9yDw3vJXt1EKuCTVje1wCxhGcQU//f/zaGBqPY2rAFtVHCUViQ4PHwhEhv26QOsCvE
         OqoHJ+VRJs8Lpb9FZPH/fMlGONkLESDIAuZNzV4sIlAhfeELRHc3I6YEDsqsZChKlJ07
         FUaFarF5t4dIsxoQP76trABButDjo+MGKYx1wIrNU5yImLVLF0albMaqpScLOp+fSxld
         qxfw==
X-Gm-Message-State: ABuFfohRnUSWEkHpX88NNmdP6wzNL9KmtGGDAknnDPVuokwjApA27SLI
        Q3Misf9qI1uPJ49+ecXf+Lhw1LL8BfOJXW7o7V3W6w==
X-Google-Smtp-Source: ACcGV60ZwCVxR+QmVgdb9DJvx+CKZ5ygd2TC3NvNUPdfc99a4OELYKZRQmLwOCjHHmn2cM2xOnmJRucWh2Jxuh3kQQU=
X-Received: by 2002:a50:a45b:: with SMTP id v27-v6mr7272322edb.237.1539081091543;
 Tue, 09 Oct 2018 03:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181008222417.11739-1-colin.king@canonical.com>
In-Reply-To: <20181008222417.11739-1-colin.king@canonical.com>
From:   Shawn Guo <shawn.guo@linaro.org>
Date:   Tue, 9 Oct 2018 18:31:15 +0800
Message-ID: <CAAQ0ZWTOo8xr22f+kmeY+mrhGKgacCfCTaqO=zEewLuWGWvDYw@mail.gmail.com>
Subject: Re: [PATCH] phy: inno-usb2-phy: fix off-by-one comparison on port number
To:     Colin King <colin.king@canonical.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 6:24 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently the range check on the port index is off-by-one and a potential
> out of bounds write can occur on priv->ports[i]. Fix this by checking the
> maximum port using >= INNO_PHY_PORT_NUM rather than > INNO_PHY_PORT_NUM.
>
> Detected by CoverityScan, CID#1466118 ("Out-of-bounds write")
>
> Fixes: ba8b0ee81fbb ("phy: add inno-usb2-phy driver for hi3798cv200 SoC")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
