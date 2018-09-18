Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A702ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165A920867
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hL62dVpb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165A920867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbeISBqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:46:31 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36971 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729859AbeISBqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:46:30 -0400
Received: by mail-io1-f66.google.com with SMTP id v14-v6so2647346iob.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 13:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Vcu+k05xsaSqoSC4RQzKbNc6+lR9/LYik9Nar7hIWE=;
        b=hL62dVpbEEmQ5RXEFPpAVrQWkhKCho+2MlzmLShcJmRZOvxThsC/HQxCYOvdRUpHvh
         7mVhFgw9TO+r5Xu26ZLzrMqeXRNHXiTbu5QQjRKQbw1SUMvIKoOPRvvZIK278vW94Fvo
         W3tpLpH32FLmSMcJp+1fI3g4zhAn7JvNoQ+V0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Vcu+k05xsaSqoSC4RQzKbNc6+lR9/LYik9Nar7hIWE=;
        b=LYZOz1jEJVHOOzvpxKq5ZnjvRXYLxJzyE+cbipBOZ8O62dD/8TDsmVNVJ8rykcmf2D
         4vL8rCz/H3cPZDdlqSnULKsqTNRzfyOqI2ra5xlkYwEJeN8YdA6On97XSieoCBExO9WN
         CFR9Hw+TGXrcmJhpUatsNUm1+v+sf4giHFVG2DUHYJGazXZugv31hJQFQc/hLj8q1BrA
         E4JR8kSELYgsnArHA8ahxzQDerVzNCOw8F34tirKW74iRbrMNcROXLqXQM77MtVu4Zjr
         6gz70Elaf1DFykwM/rkNNn4rk6FyMZFB/EBR/qaxNBmpHshGR0TGMw9IwrZvUF6L3xmP
         u+kQ==
X-Gm-Message-State: APzg51APeylae+voVbCp7GHOG0F/yyhHT6kRG1Y0ZzXsk+qCuJEfI3NH
        mAQMUsyXCuvjcBEQm3GFsrgE9F/pPWE=
X-Google-Smtp-Source: ANB0VdbUeZaNf2iLrX8LEaYxrOJ+v6YKQtn7xeVpCcs6QN7hkafnaStHH0q9uprv6lSnhkjv8vPfqQ==
X-Received: by 2002:a6b:3954:: with SMTP id g81-v6mr25462726ioa.225.1537301538364;
        Tue, 18 Sep 2018 13:12:18 -0700 (PDT)
Received: from mail-it0-f42.google.com (mail-it0-f42.google.com. [209.85.214.42])
        by smtp.gmail.com with ESMTPSA id a14-v6sm6626515ioh.45.2018.09.18.13.12.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 13:12:17 -0700 (PDT)
Received: by mail-it0-f42.google.com with SMTP id x79-v6so15187644ita.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 13:12:17 -0700 (PDT)
X-Received: by 2002:a02:ab8e:: with SMTP id t14-v6mr22811566jan.102.1537301536912;
 Tue, 18 Sep 2018 13:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org> <1537294047-12093-4-git-send-email-dkota@codeaurora.org>
In-Reply-To: <1537294047-12093-4-git-send-email-dkota@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 18 Sep 2018 13:12:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UJo0yL-MiQyJrS85p-RFs3TqWdagVpjCdtZfEkgYCYbg@mail.gmail.com>
Message-ID: <CAD=FV=UJo0yL-MiQyJrS85p-RFs3TqWdagVpjCdtZfEkgYCYbg@mail.gmail.com>
Subject: Re: [PATCH V4 3/4] spi: spi-geni-qcom: Add SPI driver support for
 GENI based QUP
To:     Dilip Kota <dkota@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 18, 2018 at 11:09 AM Dilip Kota <dkota@codeaurora.org> wrote:
>
> From: Girish Mahadevan <girishm@codeaurora.org>
>
> This driver supports GENI based SPI Controller in the Qualcomm SOCs. The
> Qualcomm Generic Interface (GENI) is a programmable module supporting a
> wide range of serial interfaces including SPI. This driver supports SPI
> operations using FIFO mode of transfer.
>
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Dilip Kota <dkota@codeaurora.org>
> ---
> Addressing all the reviewer commets given in Patchset1.
> Summerizing the chages below:
>
>         Move prepare_transfer_hardware to probe
>         Fix the unbind failure
>         Add Spinlock
>         Use readl/writel() instead of _relaxed()
>         Remove __func__ in dev_err
>         Declare register variables as u32
>         Don't initialize variables and then overwrite them
>         Remove unused step
>         Remove IRQ entry in geni struct
>         Remove extra paranthesis
>         Reframe probe errors
>         Change the tx_fifo_width naming in handle_rx and handle_tx
>         Declare spi_geni_master as 'mas' in complete driver.
>         Correcting the punctuation in the comments.
>         Adding comments in the code while setting Tx WaterMark Register.
>         get_spi_clk_cfg() fixes
>         Rewrite the geni_spi_handle_tx() and geni_spi_handle_rx()
>
> Regarding the suspend/resume and loopback failures, i am working to update in next patch series
> drivers/spi/Kconfig               |  12 +
>  drivers/spi/Makefile              |   1 +
>  drivers/spi/spi-geni-qcom.c       | 653 ++++++++++++++++++++++++++++++++++++++
>  include/linux/spi/spi-geni-qcom.h |  14 +
>  4 files changed, 680 insertions(+)

I've confirmed that all the feedback I'm aware of from previous
versions of this patch has now been addressed, except as noted above:

* suspend callback still looks a little wonky.
* loopback doesn't actually work

IMO it would be OK to land this patch and address the suspend callback
/ loopback issues in later patches, but obviously that's for Mark to
decide.

NOTE: for this patch to land it must be based on a tree that includes
the patch ("soc: qcom: geni: Make version macros simpler") [1] in
order to compile.  It would also be nice if it was also based upon the
patches ("soc: qcom: geni: Don't ignore clk_round_rate() errors in
geni_se_clk_tbl_get()") [2] and ("soc: qcom: geni:
geni_se_clk_freq_match() should always accept multiples") [3].  Those
aren't needed for things to compile but are technically needed for
correctness.  +Andy Gross has said he'll put that the above 3 patches
in his tree in a way that it would be easy to pull in

Mark: it would be super if you had a chance to take a look at this
patch now and see what you think.

[1] https://lkml.kernel.org/r/20180518224750.232742-1-swboyd@chromium.org
[2] https://lkml.kernel.org/r/20180906224906.93752-1-dianders@chromium.org
[3] https://lkml.kernel.org/r/20180906224906.93752-2-dianders@chromium.org

With all that said, I'm happy adding:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>


-Doug
