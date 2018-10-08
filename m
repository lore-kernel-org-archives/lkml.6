Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA8EC67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4B420C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VvemE/qg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4B420C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeJIG52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:57:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36675 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbeJIG51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:57:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id y11-v6so7591752plt.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 16:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=sqAcQz0JmfOQkehZoXMdLoFZLAjlyTWBR9nniUFRAdU=;
        b=VvemE/qgjeblrBJTkRumi5gJuYZKiFIPwubtjzdCu32HaXYIbBfrqa9NY/eo0XCI+X
         7j0cbtMj73ygTyWjeg8sDWLaj1prFKY6iS9ac5WUcbvU4+sWU7faLiu2EQpb83PhO5oL
         AwN6oxUM8rSm6oO+L71LssoVZGUBpkUo9rmtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=sqAcQz0JmfOQkehZoXMdLoFZLAjlyTWBR9nniUFRAdU=;
        b=huoVK8D4V2ahTbAx16+imVm1y13eQhAJBxeYhnOb6jVh4D9P1bgKPnQomJXAyLjJLL
         2waU0dZ9brEjZ/o/8nS5At18t01xVD4hGyyJQ+VIAbkuKHnVaKTl4ECAioBT6Dn0M1X9
         5GCUZtJbD/yzXX+7VozxMEkNZMItq7AuUfv4E24/eDxUHbZcOEDSkTT7VsjtWmzTAi5u
         KSlmnBcv8+CKsxOi8vytnbRTirF9SHNH3vMwH2tXmJPJ5a5EpNhflXGiPzJ1MGYibmH3
         oIT/wPY2bmIj+lY4GsHBnDzOzwClTmY0KKKMUIxauf/d1vEe5PvJnbU20ea4Jgp6rjYU
         oGVA==
X-Gm-Message-State: ABuFfoiu+b4bwz6tkg6C+lfTvCohFcygPr6wOgPXDzUrzYXrpe5mMq10
        T2+YDa0K7Bg2q+kanIMR9fKorw==
X-Google-Smtp-Source: ACcGV61Dehi3MzGXR0/0fOC2lQVLtdTelqEDJOC6D5cPFCvoCm67EPceyVKaAG34wj5yWViGT3EsDQ==
X-Received: by 2002:a17:902:a618:: with SMTP id u24-v6mr25882444plq.77.1539042198451;
        Mon, 08 Oct 2018 16:43:18 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id q76-v6sm30287449pfa.18.2018.10.08.16.43.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 16:43:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Alok Chauhan <alokc@codeaurora.org>, broonie@kernel.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, mka@chromium.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1538574265-30235-4-git-send-email-alokc@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>
References: <1538574265-30235-1-git-send-email-alokc@codeaurora.org>
 <1538574265-30235-4-git-send-email-alokc@codeaurora.org>
Message-ID: <153904219713.119890.7463642233895152532@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V5 3/3] spi: spi-geni-qcom: Add SPI driver support for GENI based
 QUP
Date:   Mon, 08 Oct 2018 16:43:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alok Chauhan (2018-10-03 06:44:25)
>

I just have a handful of nitpicks which can be fixed later in
follow-ups. Otherwise:

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> new file mode 100644
> index 0000000..6432ecc
> --- /dev/null
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -0,0 +1,703 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
> +
[...]
> +#define SPI_TX_ONLY            1
> +#define SPI_RX_ONLY            2
> +#define SPI_FULL_DUPLEX                3
> +#define SPI_TX_RX              7
> +#define SPI_CS_ASSERT          8
> +#define SPI_CS_DEASSERT                9
> +#define SPI_SCK_ONLY           10
> +/* M_CMD params for SPI */
> +#define SPI_PRE_CMD_DELAY      BIT(0)
> +#define TIMESTAMP_BEFORE       BIT(1)
> +#define FRAGMENTATION          BIT(2)
> +#define TIMESTAMP_AFTER                BIT(3)
> +#define POST_CMD_DELAY         BIT(4)
> +
> +/* SPI M_COMMAND OPCODE */
> +enum spi_mcmd_code {

Nitpick: rename spi_m_cmd_opcode and drop the comment?

> +       CMD_NONE,
> +       CMD_XFER,
> +       CMD_CS,
> +       CMD_CANCEL,
> +};
> +
> +

Nitpick: Drop double newline.

> +struct spi_geni_master {
> +       struct geni_se se;
> +       struct device *dev;
> +       u32 tx_fifo_depth;
> +       u32 fifo_width_bits;
> +       u32 tx_wm;
> +       unsigned long cur_speed_hz;
> +       unsigned int cur_bits_per_word;
> +       unsigned int tx_rem_bytes;
> +       unsigned int rx_rem_bytes;
> +       const struct spi_transfer *cur_xfer;
> +       struct completion xfer_done;
> +       unsigned int oversampling;
> +       spinlock_t lock;
> +       unsigned int cur_mcmd;

Niptick: Use the enum?

> +       int irq;
> +};
> +
> +static void handle_fifo_timeout(struct spi_master *spi,
> +                               struct spi_message *msg);
> +
> +static int get_spi_clk_cfg(unsigned int speed_hz,
> +                       struct spi_geni_master *mas,
> +                       unsigned int *clk_idx,
> +                       unsigned int *clk_div)
> +{
> +       unsigned long sclk_freq;
> +       unsigned int actual_hz;
> +       struct geni_se *se =3D &mas->se;
> +       int ret;
> +
> +       ret =3D geni_se_clk_freq_match(&mas->se,
> +                               speed_hz * mas->oversampling,
> +                               clk_idx, &sclk_freq, false);
> +       if (ret) {
> +               dev_err(mas->dev, "Failed(%d) to find src clk for %dHz\n",
> +                                                       ret, speed_hz);
> +               return ret;
> +       }
> +
> +       *clk_div =3D DIV_ROUND_UP(sclk_freq, mas->oversampling * speed_hz=
);
> +       actual_hz =3D sclk_freq / (mas->oversampling * *clk_div);
> +
> +       dev_dbg(mas->dev, "req %u=3D>%u sclk %lu, idx %d, div %d\n", spee=
d_hz,
> +                               actual_hz, sclk_freq, *clk_idx, *clk_div);
> +       ret =3D clk_set_rate(se->clk, sclk_freq);
> +       if (ret)
> +               dev_err(mas->dev, "clk_set_rate failed %d\n", ret);
> +       return ret;
> +}
> +
> +static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
> +{
> +       struct spi_geni_master *mas =3D spi_master_get_devdata(slv->maste=
r);
> +       struct spi_master *spi =3D dev_get_drvdata(mas->dev);
> +       struct geni_se *se =3D &mas->se;
> +       unsigned long timeout;
> +
> +       reinit_completion(&mas->xfer_done);
> +       pm_runtime_get_sync(mas->dev);
> +       if (!(slv->mode & SPI_CS_HIGH))
> +               set_flag =3D !set_flag;
> +
> +       mas->cur_mcmd =3D CMD_CS;
> +       if (set_flag)
> +               geni_se_setup_m_cmd(se, SPI_CS_ASSERT, 0);
> +       else
> +               geni_se_setup_m_cmd(se, SPI_CS_DEASSERT, 0);
> +
> +       timeout =3D wait_for_completion_timeout(&mas->xfer_done, HZ);

Nitpick: s/timeout/time_left/

> +       if (!timeout)
> +               handle_fifo_timeout(spi, NULL);
> +
> +       pm_runtime_put(mas->dev);
> +}
> +
[...]
> +
> +static irqreturn_t geni_spi_isr(int irq, void *data)
> +{
> +       struct spi_master *spi =3D data;
> +       struct spi_geni_master *mas =3D spi_master_get_devdata(spi);
> +       struct geni_se *se =3D &mas->se;
> +       u32 m_irq;
> +       unsigned long flags;
> +       irqreturn_t ret =3D IRQ_HANDLED;
> +
> +       if (mas->cur_mcmd =3D=3D CMD_NONE)
> +               return IRQ_NONE;
> +
> +       spin_lock_irqsave(&mas->lock, flags);
> +       m_irq =3D readl(se->base + SE_GENI_M_IRQ_STATUS);
> +
> +       if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & M_RX_FIFO_LAST_E=
N))
> +               geni_spi_handle_rx(mas);
> +
> +       if (m_irq & M_TX_FIFO_WATERMARK_EN)
> +               geni_spi_handle_tx(mas);
> +
> +       if (m_irq & M_CMD_DONE_EN) {
> +               if (mas->cur_mcmd =3D=3D CMD_XFER)
> +                       spi_finalize_current_transfer(spi);
> +               else if (mas->cur_mcmd =3D=3D CMD_CS)
> +                       complete(&mas->xfer_done);
> +               mas->cur_mcmd =3D CMD_NONE;
> +               /*
> +                * If this happens, then a CMD_DONE came before all the Tx
> +                * buffer bytes were sent out. This is unusual, log this
> +                * condition and disable the WM interrupt to prevent the
> +                * system from stalling due an interrupt storm.
> +                * If this happens when all Rx bytes haven't been receive=
d, log
> +                * the condition.
> +                * The only known time this can happen is if bits_per_wor=
d !=3D 8
> +                * and some registers that expect xfer lengths in num spi=
_words
> +                * weren't written correctly.
> +                */
> +               if (mas->tx_rem_bytes) {
> +                       writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
> +                       dev_err(mas->dev, "Premature done. tx_rem =3D %d =
bpw%d\n",
> +                               mas->tx_rem_bytes, mas->cur_bits_per_word=
);
> +               }
> +               if (mas->rx_rem_bytes)
> +                       dev_err(mas->dev, "Premature done. rx_rem =3D %d =
bpw%d\n",
> +                               mas->rx_rem_bytes, mas->cur_bits_per_word=
);
> +       }
> +
> +       if ((m_irq & M_CMD_CANCEL_EN) || (m_irq & M_CMD_ABORT_EN)) {
> +               mas->cur_mcmd =3D CMD_NONE;
> +               complete(&mas->xfer_done);
> +       }
> +
> +       writel(m_irq, se->base + SE_GENI_M_IRQ_CLEAR);
> +       spin_unlock_irqrestore(&mas->lock, flags);
> +       return ret;

Nitpick: Now this always returns IRQ_HANDLED, and we assign ret just to
do that. Perhaps only return IRQ_HANDLED if one of the above if
conditions is taken?

> +}
> +
> +static int spi_geni_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       struct spi_master *spi;
> +       struct spi_geni_master *mas;
> +       struct resource *res;
> +       struct geni_se *se;
> +
> +       spi =3D spi_alloc_master(&pdev->dev, sizeof(*mas));
> +       if (!spi)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, spi);
> +       mas =3D spi_master_get_devdata(spi);
> +       mas->dev =3D &pdev->dev;
> +       mas->se.dev =3D &pdev->dev;
> +       mas->se.wrapper =3D dev_get_drvdata(pdev->dev.parent);
> +       se =3D &mas->se;
> +
> +       spi->bus_num =3D -1;
> +       spi->dev.of_node =3D pdev->dev.of_node;
> +       mas->se.clk =3D devm_clk_get(&pdev->dev, "se");
> +       if (IS_ERR(mas->se.clk)) {
> +               ret =3D PTR_ERR(mas->se.clk);
> +               dev_err(&pdev->dev, "Err getting SE Core clk %d\n", ret);
> +               goto spi_geni_probe_err;
> +       }
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       se->base =3D devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(se->base)) {
> +               ret =3D PTR_ERR(se->base);
> +               goto spi_geni_probe_err;
> +       }
> +
> +       spi->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_CS_HIGH;
> +       spi->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(4, 32);
> +       spi->num_chipselect =3D 4;
> +       spi->max_speed_hz =3D 50000000;
> +       spi->prepare_message =3D spi_geni_prepare_message;
> +       spi->transfer_one =3D spi_geni_transfer_one;
> +       spi->auto_runtime_pm =3D true;
> +       spi->handle_err =3D handle_fifo_timeout;
> +       spi->set_cs =3D spi_geni_set_cs;
> +
> +       init_completion(&mas->xfer_done);
> +       spin_lock_init(&mas->lock);
> +       pm_runtime_enable(&pdev->dev);
> +
> +       ret =3D spi_geni_init(mas);
> +       if (ret)
> +               goto spi_geni_probe_runtime_disable;
> +
> +       mas->irq =3D platform_get_irq(pdev, 0);
> +       if (mas->irq < 0) {
> +               ret =3D mas->irq;
> +               dev_err(&pdev->dev, "Err getting IRQ %d\n", ret);
> +               goto spi_geni_probe_runtime_disable;
> +       }

Nitpick: If you got the irq earlier before allocating anything then nothing=
 has
to be put on failure path.

> +
> +       ret =3D request_irq(mas->irq, geni_spi_isr,
> +                       IRQF_TRIGGER_HIGH, "spi_geni", spi);
> +       if (ret)
> +               goto spi_geni_probe_runtime_disable;
> +
> +       ret =3D spi_register_master(spi);
> +       if (ret)
> +               goto spi_geni_probe_free_irq;
> +
> +       return 0;
> +spi_geni_probe_free_irq:
> +       free_irq(mas->irq, spi);
> +spi_geni_probe_runtime_disable:
> +       pm_runtime_disable(&pdev->dev);
> +spi_geni_probe_err:
> +       spi_master_put(spi);
> +       return ret;
> +}
