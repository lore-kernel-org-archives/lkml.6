Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73062C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39769214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QfI5WaT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39769214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404259AbeKTDye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:54:34 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181]:46338 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390844AbeKTDyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:54:33 -0500
Received: by mail-pg1-f181.google.com with SMTP id w7so14111094pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xlHQJUfODRtlXvq4AYIgWzKHZNDRHkjrGNYBkzUOB6w=;
        b=QfI5WaT9mg29wds8VILOHGtMRCy1GYan+M6x+jzXsqX7yVjfARi6ie5tC+ec3DAIsu
         KnYS7BVEjUqbh30vdF6ZCsIQeZ3fTAlxDbLeffO1ks1sP+S3drDH+OsAms3TShNILI8s
         g4hEDr2+iHMkYK0mxZU8cs/6QWSTVw1fXTkm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xlHQJUfODRtlXvq4AYIgWzKHZNDRHkjrGNYBkzUOB6w=;
        b=Wz/zwmNokNx0f2LnVnxpGT1O6pdZoegO2LDfbJfp1pkwEm69Z5XBi+6+1CLjXf7byj
         MuxxQczn1ix0hpwbkBt8yrF5lxW3sGcUT1LZB7odm9+hNoNVHN2EeOt2fgyn+8+gtC+4
         tw+T4LEb8/DH9oxG4JOslQPBYCuxf0QRp5LVgkWsXssT5vauJz67DtWsXrS+YnVuNCsG
         AUf/FPsOmHG9odBaWRhC31HaLAfkBhtJIUD1xkuUF03ljbGh1VGeH64BspcivxcuErZQ
         pxP9t8b7tJ3XSbd4rAvK7StGNJ5e2sLOtCwIz3Kr2+ieLCiJu9IY04Al72e5pMLRJd2n
         XE4g==
X-Gm-Message-State: AGRZ1gKOv4RM6uywf43BeZWNaOJ9aofqZUSpYkelthnKc6BohD7pYS5m
        RA+tn+7TSGrUiGRKoXzm7SEE
X-Google-Smtp-Source: AJdET5e2JDb50S3wDUhRcdXLhB85n3ktquf2ICX9VUjb7Ub2Lw2orahpCaVSqUxQor9pT3nt6QZpoA==
X-Received: by 2002:a62:2606:: with SMTP id m6mr7896028pfm.133.1542648608312;
        Mon, 19 Nov 2018 09:30:08 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:631b:44eb:3905:6402:e2fb:2d7])
        by smtp.gmail.com with ESMTPSA id h128-v6sm46514134pfb.52.2018.11.19.09.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 09:30:07 -0800 (PST)
Date:   Mon, 19 Nov 2018 22:59:58 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net, service@rdamicro.com
Subject: Re: [PATCH 01/16] dt-bindings: Add RDA Micro vendor prefix
Message-ID: <20181119172958.GA20692@Mani-XPS-13-9360>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
 <20181119170939.19153-2-manivannan.sadhasivam@linaro.org>
 <e8749128-00e1-551c-8285-fcaef8029484@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8749128-00e1-551c-8285-fcaef8029484@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 06:22:02PM +0100, Andreas Färber wrote:
> Am 19.11.18 um 18:09 schrieb Manivannan Sadhasivam:
> > From: Andreas Färber <afaerber@suse.de>
> > 
> > RDA Microelectronics is a Chinese SoC manufacturer.
> > 
> > Cc: service@rdamicro.com
> > Signed-off-by: Andreas Färber <afaerber@suse.de>
> 
> This one is lacking your Signed-off-by, all others that I was CC'ed on
> had it.
>

Yeah. I thought I have to only Sign off the commits which I have
modified. Will fix it in next revision.

Thanks,
Mani

> Cheers,
> Andreas
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer, Jane Smithard, Graham Norton
> HRB 21284 (AG Nürnberg)
