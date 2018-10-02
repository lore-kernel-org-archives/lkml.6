Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0895AC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF986205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ntPXUH6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF986205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeJCF0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:26:07 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38872 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbeJCF0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:26:07 -0400
Received: by mail-ua1-f65.google.com with SMTP id j17-v6so1371783uan.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 15:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x1PqXJs+2hkgAdVucsJ12u8HlFRDFlmQ+URe1mG8Q9M=;
        b=ntPXUH6MCILk0cAotbxjHAZ0EwHPPEP8VR66FNUQaN2WMwUXQntAyG7c8ceu/3jSr/
         xXXkS9MYKts6uphQkKfWYdNhnecCy2KvWeJ8IR7jsLhUhnjS+agSGYt0v1YPQHVPwj04
         BQpEKP5D1vo19r8MyBL0KdgikjTVw5m6/Ijic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x1PqXJs+2hkgAdVucsJ12u8HlFRDFlmQ+URe1mG8Q9M=;
        b=sqTbDRZC8vhQo5W4yc6kyVH7zV/5W9l9Ma2YlueeImukz6npXuuJwDiuUoprGFOXyX
         rhhQRTYqkwAOMEeJiKLZjVXqbyMhd0R6ykA3E6xsENwCpJ+ujfmFf+87oHXKj4Ecs2fF
         YCxnoqzJDMjMox2N9Ikm5FJzTIXbq5aJW2SJabFIZYySg0UivVcsSskONf2kXl2GfjUs
         E0oANfGJOb7j/oDCr9NfWl7XzjP+50MDhVeE2KhkqhLy6z+Sii0Q/Ud2a+D0waPs9CIQ
         ba8gHhqLLH1kyXnjn/XR2C1GGafD5/CIXwp/GfVSkEoO7feGubBtWcPiRs/tdWfFK8op
         PLMA==
X-Gm-Message-State: ABuFfoh5GZjhAEewfBzOZns3SvpT5yPxegnVklWbbyGZPf6fGf9xp1c2
        m0KDIO/9MLuQ2mXwFOKbF8xSvJc4nF0=
X-Google-Smtp-Source: ACcGV61k4bBvXT8dp+++CeyScnZho3idiL2JxRLur6qrVZEsKEl0GvikrIInu69X7maLUEkeig38Ew==
X-Received: by 2002:ab0:7055:: with SMTP id v21-v6mr408690ual.44.1538520026668;
        Tue, 02 Oct 2018 15:40:26 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id e63-v6sm9717895vka.22.2018.10.02.15.40.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 15:40:25 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id i10so2074807vsm.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 15:40:25 -0700 (PDT)
X-Received: by 2002:a67:1141:: with SMTP id 62-v6mr6612198vsr.213.1538520025078;
 Tue, 02 Oct 2018 15:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20181002214709.162330-1-ryandcase@chromium.org> <20181002214709.162330-2-ryandcase@chromium.org>
In-Reply-To: <20181002214709.162330-2-ryandcase@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 2 Oct 2018 15:40:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WiMbuVmimp9dQoW0MErm=Pw-w7N-mMTOStgtuLg7Vz8A@mail.gmail.com>
Message-ID: <CAD=FV=WiMbuVmimp9dQoW0MErm=Pw-w7N-mMTOStgtuLg7Vz8A@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] spi: Introduce new driver for Qualcomm QuadSPI controller
To:     ryandcase@chromium.org
Cc:     Mark Brown <broonie@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Trent Piepho <tpiepho@impinj.com>, boris.brezillon@bootlin.com,
        Girish Mahadevan <girishm@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 2, 2018 at 2:48 PM Ryan Case <ryandcase@chromium.org> wrote:
> +#define RD_FIFO_STATUS 0x002c
> +#define FIFO_EMPTY     BIT(11)
> +#define WR_CNTS_MSK    0x7f0
> +#define WR_CNTS_SHFT   4
> +#define RDY_64BYTE     BIT(3)
> +#define RDY_32BYTE     BIT(2)
> +#define RDY_16BYTE     BIT(1)
> +#define FIFO_RDY       BIT(0)
> +
> +#define RD_FIFO_CFG            0x0028
> +#define CONTINUOUS_MODE                BIT(0)

You missed the above when re-sorting.  The section for 0x0028 should
be above the section for 0x002c.

IMO there's been enough spins of this patch and it's a pretty minor
change.  Mark: maybe you'd be OK with applying the current patch and
either fixing up the sort order as you apply or letting us know to
post a followup patch?  ...or if you'd like a v7 then please yell.


> +static int __maybe_unused qcom_qspi_suspend(struct device *dev)
> +{
> +       struct spi_master *master = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = spi_master_suspend(master);
> +       if (ret)
> +               return ret;
> +
> +       ret = pm_runtime_force_suspend(dev);
> +       if (ret)
> +               spi_master_resume(master);
> +
> +       return ret;
> +}
> +
> +static int __maybe_unused qcom_qspi_resume(struct device *dev)
> +{
> +       struct spi_master *master = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = pm_runtime_force_resume(dev);
> +       if (ret)
> +               return ret;
> +
> +       ret = spi_master_resume(master);
> +       if (ret)
> +               pm_runtime_force_suspend(dev);
> +
> +       return ret;
> +}

As per my new understanding (now that I've been educated by Rafael)
[1] possibly the error handling here could be revamped to handle the
case where suspend() may be called again after a failed resume().  I'd
rather not block this patch based on that discussion though, so this
feels like something to address by a follow-up patch.  Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>


[1] https://lkml.kernel.org/r/CAJZ5v0hSohUZvJcVcQzy_DdSyPVppOABk0HELsa3dpvf12LMPQ@mail.gmail.com
