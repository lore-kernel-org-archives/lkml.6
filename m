Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFF9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 03:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35792087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 03:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jXDG/Bwq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35792087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeJJLIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 07:08:40 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:31879 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeJJLIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 07:08:39 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w9A3mBxn012041;
        Wed, 10 Oct 2018 12:48:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w9A3mBxn012041
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539143292;
        bh=ZhScGXNCodU+TJxTn4n5idv96xoLk+mW7w0v+wcYa3w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jXDG/BwqgJkETK0h0tF2MWJpNzA/TqReOJ8ayznD6uoljxvvBQ7HgCPZk89uLryTO
         AdbYAShnASLjQ+ZFuobzWi/PaV7eNzGaLYXDwTsEDBFh5GksrcpbxdDuZT7VUn7/aF
         S5C7XpEwnvGORSAG1bZgkpEMijZFRCWwnfSevA7z1IBYy/QkTDAjPCvwFqQ9ZIi1Ka
         oNrmo0kLAuIEIkLMnW0DtzfNoqit7OTbu+D9rmw7kl3uvhHXa6YNn/+Nz5BwtTjuHL
         IdugKcR6EHxz2wT5kVWfftH0LBaaCrnLTStDmzx1r924w18vpYjCydAyiie3rrbwwk
         ox/HeMBynyJZw==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id i10so3688883vsm.13;
        Tue, 09 Oct 2018 20:48:11 -0700 (PDT)
X-Gm-Message-State: ABuFfojxqIY0lorUwIwL+ZFerzYLtmGCoATtWjlV22ALho/NNUHUpOIh
        WGEmJpNxPeOd4qS/IQr+TxumNh3lWQPmc8OGr84=
X-Google-Smtp-Source: ACcGV62t2SQpnznUO7fyx16ep74yP/uA/ypdrPdxtE/PHe7B2eZubQyL/J0p9iywsyDXdlO7A2C/xqiIx+DnqtnuTPI=
X-Received: by 2002:a67:5fc7:: with SMTP id t190mr9890635vsb.155.1539143290762;
 Tue, 09 Oct 2018 20:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <1538566587-29452-1-git-send-email-yamada.masahiro@socionext.com>
 <1538566587-29452-2-git-send-email-yamada.masahiro@socionext.com> <20181009234830.v7yzhnrtqcfwmm45@katana>
In-Reply-To: <20181009234830.v7yzhnrtqcfwmm45@katana>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 10 Oct 2018 12:47:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ7RfwTKS=_KZPKC568h8mUMVhijecLWYY38wsJ6uwNEQ@mail.gmail.com>
Message-ID: <CAK7LNAQ7RfwTKS=_KZPKC568h8mUMVhijecLWYY38wsJ6uwNEQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: tmio: move MFD variant reset to a platform hook
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 8:49 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
>
> > +static void tmio_mmc_reset(struct tmio_mmc_host *host)
> > +{
> > +     /* FIXME - should we set stop clock reg here */
> > +     sd_ctrl_write16(host, CTL_RESET_SD, 0x0000);
> > +     sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
> > +     usleep_range(10000, 11000);
> > +     sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
> > +     sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0001);
> > +     usleep_range(10000, 11000);
> > +
> > +     if (host->pdata->flags & TMIO_MMC_SDIO_IRQ) {
> > +             sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
> > +             sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
> > +     }
> > +}
>
> Yes, looks much safer now.
>
> > +     host->reset = tmio_mmc_reset;
>
> So, you populate the new pointer here...
>
> > +     if (!_host->reset)
> > +             _host->reset = tmio_mmc_reset;
>
> ... and here. But it seems never used anywhere? Or am I missing
> something?
>

Bummer. I am totally screwed up.

V3 is right away.


Thanks!


-- 
Best Regards
Masahiro Yamada
