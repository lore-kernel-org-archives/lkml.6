Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB164C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967D52098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CO/oR+99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967D52098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeJDAgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:36:01 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:42787 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbeJDAgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:36:01 -0400
Received: by mail-vk1-f195.google.com with SMTP id t202-v6so1507988vke.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=glgXK0xu+6a0iIPxySYgWE8CMWz/x5MpU32tfjGc0eg=;
        b=CO/oR+99oopcuRffaMTA89sGBNjSL8IWE2U8SzT7e5WDnSdLqzB7BKxWa+ua67IN/r
         mmr328eZTvP5WxS/lkKSFb3PJpCehPZin/3djKKrTE684wznHogiXU4nUdWzmorXymA0
         ax+EqR783a01yFjJN5GaGwIUviBCg+5kh4wPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=glgXK0xu+6a0iIPxySYgWE8CMWz/x5MpU32tfjGc0eg=;
        b=LXJayM6gIoPuFL2zYfGeL8vFr77vPyT+R1Vl67bZdqbkJ5aqJQIFhcUu46xbPZAsM2
         PARASAi5mPiMu4N0ypK03KoYkUDUC5ln3dZujldpfVkjruNr5vCfuKSQQztDDR15pQMz
         yYjwAfJn2yfuiwLKxrkC+Befy5IFUUtukpM1KLrDEPKrAQZVC60R9OWzvcueByaJ6Ql1
         T3I3VUh4iYX2msp3MQgTUyG/JFhWZVBYlL9CUlhzfDP0u7hoDIURt7lqEQNv/76Lr42C
         cujhu8TkTKK9T7++bFBV4g6pipSkcq1fdl3By2ndWO7wC4wrt5sqE4vmLGgag+s6SrtX
         xrjw==
X-Gm-Message-State: ABuFfogL4Eqhwm4TGx7KOxnaiqALy9Ur0nmFDpKqqge4gPYGb/vKF45J
        YPX7yXe/XRew0HGzegt8ESLQbDCcNdo=
X-Google-Smtp-Source: ACcGV61UGkSzUMRa2QAYsqjdg0Tg9gVV9e39UZGxpKfURyPrD8UyLpaTdKogmm5DFTjTg0mTAf/oNQ==
X-Received: by 2002:a1f:4514:: with SMTP id s20-v6mr1004608vka.63.1538588796788;
        Wed, 03 Oct 2018 10:46:36 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id d133-v6sm507608vkf.43.2018.10.03.10.46.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 10:46:35 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id c10so881086uao.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:46:35 -0700 (PDT)
X-Received: by 2002:a9f:344d:: with SMTP id s13mr1054572uab.27.1538588795380;
 Wed, 03 Oct 2018 10:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <1538574265-30235-1-git-send-email-alokc@codeaurora.org> <1538574265-30235-4-git-send-email-alokc@codeaurora.org>
In-Reply-To: <1538574265-30235-4-git-send-email-alokc@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 3 Oct 2018 10:46:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WqO7tpvX59DuvFi2AUnnAL+=BnV5MtgNbNVKUZfvh7TQ@mail.gmail.com>
Message-ID: <CAD=FV=WqO7tpvX59DuvFi2AUnnAL+=BnV5MtgNbNVKUZfvh7TQ@mail.gmail.com>
Subject: Re: [PATCH V5 3/3] spi: spi-geni-qcom: Add SPI driver support for
 GENI based QUP
To:     alokc@codeaurora.org
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 3, 2018 at 6:45 AM Alok Chauhan <alokc@codeaurora.org> wrote:
> +static irqreturn_t geni_spi_isr(int irq, void *data)
> +{
> +       struct spi_master *spi = data;
> +       struct spi_geni_master *mas = spi_master_get_devdata(spi);
> +       struct geni_se *se = &mas->se;
> +       u32 m_irq;
> +       unsigned long flags;
> +       irqreturn_t ret = IRQ_HANDLED;
> +
> +       if (mas->cur_mcmd == CMD_NONE)
> +               return IRQ_NONE;
> +
> +       spin_lock_irqsave(&mas->lock, flags);
> +       m_irq = readl(se->base + SE_GENI_M_IRQ_STATUS);
> +
> +       if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & M_RX_FIFO_LAST_EN))
> +               geni_spi_handle_rx(mas);
> +
> +       if (m_irq & M_TX_FIFO_WATERMARK_EN)
> +               geni_spi_handle_tx(mas);
> +
> +       if (m_irq & M_CMD_DONE_EN) {
> +               if (mas->cur_mcmd == CMD_XFER)
> +                       spi_finalize_current_transfer(spi);
> +               else if (mas->cur_mcmd == CMD_CS)
> +                       complete(&mas->xfer_done);
> +               mas->cur_mcmd = CMD_NONE;
> +               /*
> +                * If this happens, then a CMD_DONE came before all the Tx
> +                * buffer bytes were sent out. This is unusual, log this
> +                * condition and disable the WM interrupt to prevent the
> +                * system from stalling due an interrupt storm.
> +                * If this happens when all Rx bytes haven't been received, log
> +                * the condition.
> +                * The only known time this can happen is if bits_per_word != 8
> +                * and some registers that expect xfer lengths in num spi_words
> +                * weren't written correctly.
> +                */
> +               if (mas->tx_rem_bytes) {
> +                       writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
> +                       dev_err(mas->dev, "Premature done. tx_rem = %d bpw%d\n",
> +                               mas->tx_rem_bytes, mas->cur_bits_per_word);
> +               }
> +               if (mas->rx_rem_bytes)
> +                       dev_err(mas->dev, "Premature done. rx_rem = %d bpw%d\n",
> +                               mas->rx_rem_bytes, mas->cur_bits_per_word);
> +       }
> +
> +       if ((m_irq & M_CMD_CANCEL_EN) || (m_irq & M_CMD_ABORT_EN)) {
> +               mas->cur_mcmd = CMD_NONE;
> +               complete(&mas->xfer_done);
> +       }
> +
> +       writel(m_irq, se->base + SE_GENI_M_IRQ_CLEAR);
> +       spin_unlock_irqrestore(&mas->lock, flags);
> +       return ret;

nit: you no longer need the "ret" variable.  Just return IRQ_HANDLED
here and remove the "ret" local variable from this function.  It'd be
nice if you put a blank line before the return too.


I'm not convinced it's worth spinning the patch to fix that one nit,
but if you spin it for some other reason please fix it.  I believe
this fixes all outstanding feedback that I'm aware of.  Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

-Doug
