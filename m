Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0039BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A861D21564
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A861D21564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbeI1DAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:00:20 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45715 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeI1DAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:00:20 -0400
Received: by mail-oi1-f196.google.com with SMTP id d63-v6so3365317oic.12;
        Thu, 27 Sep 2018 13:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3zTeC/MJaauzd4mSf0+BIfFt5YjNbvGuNNI8ioJKPqQ=;
        b=UoJ8YZ2ae+NgcmxLmk0z53mEJ0JDQOEGR+F3My1R2HOKCx9G2NrdNe792uNp3y76vp
         0GTiON8uLec30s6WYj1HRxHQXSdZNjb4zS1jshMDbs0GNBNYETVDKJImlXEI1wGpxrgt
         CvKSE/EWAnidZdMLH+NjSJaxpZQVI1Qo5chX23X7vSOO8tIid/uvuynUf2t4G3lJIRjW
         0FtQU4OJnLkreC1AHq7aWvs78zLqdZMSArJFaG04227GOmwKBz4CvS5eRKSz95dCp1Jz
         BS3hB28rgq6KP3gJKW+OsiJyS2UIESHHLuU/jwdss0UTN9gGvOgQGfoEV8v70q1sol8B
         oXjA==
X-Gm-Message-State: ABuFfoinGFqlMA6riv70ziQV+iLYAk2QklvQ9WQNp1O6g1htvRX192f5
        9HV0Vy62PcWcOqUVACSpUKLkVB5Z744=
X-Google-Smtp-Source: ACcGV61kZbBw8iUL1xZ0SzXm7dqLcM7dE676+IoQUrIjmEfoJ9608hjzQz8Y0X12mRDvr8XB2tB69Q==
X-Received: by 2002:aca:4e09:: with SMTP id c9-v6mr4211796oib.254.1538080813876;
        Thu, 27 Sep 2018 13:40:13 -0700 (PDT)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id s133-v6sm1031483oie.4.2018.09.27.13.40.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 13:40:13 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id c12-v6so3908458otl.6;
        Thu, 27 Sep 2018 13:40:13 -0700 (PDT)
X-Received: by 2002:a9d:1d2a:: with SMTP id m39-v6mr1808899otm.168.1538080813247;
 Thu, 27 Sep 2018 13:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180926132247.10971-1-laurentiu.tudor@nxp.com> <20180926132247.10971-8-laurentiu.tudor@nxp.com>
In-Reply-To: <20180926132247.10971-8-laurentiu.tudor@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 27 Sep 2018 15:40:02 -0500
X-Gmail-Original-Message-ID: <CADRPPNQyp=zC7Bo441gRQL61GMNdL-EMo4BA_NYV+CErOaM6tg@mail.gmail.com>
Message-ID: <CADRPPNQyp=zC7Bo441gRQL61GMNdL-EMo4BA_NYV+CErOaM6tg@mail.gmail.com>
Subject: Re: [PATCH v2 07/22] soc/fsl/bman_portals: defer probe after bman's probe
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Roy Pledge <roy.pledge@nxp.com>, madalin.bucur@nxp.com,
        David Miller <davem@davemloft.net>,
        Shawn Guo <shawnguo@kernel.org>, robin.murphy@arm.com,
        bharat.bhushan@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 8:26 AM <laurentiu.tudor@nxp.com> wrote:
>
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> A crash in bman portal probing could not be triggered (as is the case
> with qman portals) but it does make calls [1] into the bman driver so
> lets make sure the bman portal probing happens after bman's.
>
> [1]  bman_p_irqsource_add() (in bman) called by:
>        init_pcfg() called by:
>          bman_portal_probe()
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

As this is part of a bug fix for v4.19, applied on soc/fsl for fix.

> ---
>  drivers/soc/fsl/qbman/bman_portal.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
> index 2f71f7df3465..f9edd28894fd 100644
> --- a/drivers/soc/fsl/qbman/bman_portal.c
> +++ b/drivers/soc/fsl/qbman/bman_portal.c
> @@ -91,7 +91,15 @@ static int bman_portal_probe(struct platform_device *pdev)
>         struct device_node *node = dev->of_node;
>         struct bm_portal_config *pcfg;
>         struct resource *addr_phys[2];
> -       int irq, cpu;
> +       int irq, cpu, err;
> +
> +       err = bman_is_probed();
> +       if (!err)
> +               return -EPROBE_DEFER;
> +       if (err < 0) {
> +               dev_err(&pdev->dev, "failing probe due to bman probe error\n");
> +               return -ENODEV;
> +       }
>
>         pcfg = devm_kmalloc(dev, sizeof(*pcfg), GFP_KERNEL);
>         if (!pcfg)
> --
> 2.17.1
>
