Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433C0ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC516214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U3/CACLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC516214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbeIXWvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:51:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42893 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732402AbeIXWvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:51:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so9403946pgp.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 09:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=e+Mjk72/P31k6jgvuzjx1FruCoLBNvWPBbXsC3zv7yY=;
        b=U3/CACLLtmIIdtyHBiazH+j/WIHLxdoOq+UocZd7WCJZgFcRzJM0x8iuHHQfNL/wzN
         Q/+rMruU8vHUshaocgUyFtd3jy7Xn+vqK4aEdHD5wg+DHCAURksbPozHnW2Ua8hAgcMe
         dIqo+3LOJOD/80Jc5iiA0U62P05RDWbDWQDcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=e+Mjk72/P31k6jgvuzjx1FruCoLBNvWPBbXsC3zv7yY=;
        b=dpkQyXE7n+gzbJA67HicO5JkURtmwqQcOA+pKm3MF9A+k9Q8m4rjyfAhBjii3MFtlu
         5LOV6eQwmUSS6R4Or9LP0wWzU/b13kzqAWjaSr3eqpGfkrhCD5GeEyRrg6l7MMXRahs6
         e4h5Ni5mVYsqpb+5XEaeCq+F1dI4GTpmya6zqH0Pvh/xwpYZY/atxkujbcuepx2jn3bc
         icBOCHaUPU8q/oTxWrXrGqtTTIaOUQ93V8vZk4BXUI/cS6qHnoQ841dWMkO/8wnLPDtL
         kelr1Yb7pQ0Ic5Zvp9R60mased2/vJ7sy9a++Ki21iRRnLsbGiMn85eQvnhF3b+QrUIq
         NLvA==
X-Gm-Message-State: ABuFfojeH7p1VSCXERBxes6JCJoUrgUm7GbMlqRIW6ZCum++eE8b6k7U
        ZQPCwGQJoMx42c3sRGovzVVHZg==
X-Google-Smtp-Source: ACcGV61YkpVMPiEQ59+pl5D4omTC3w+t9p10qn1DRlCUQszNhDJ5cTy9tvpeixD4b6Xe6EbgNgBt1A==
X-Received: by 2002:a63:7044:: with SMTP id a4-v6mr7866230pgn.63.1537807677233;
        Mon, 24 Sep 2018 09:47:57 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id q2-v6sm863171pfc.17.2018.09.24.09.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 09:47:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Dilip Kota <dkota@codeaurora.org>, broonie@kernel.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, mka@chromium.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1537294047-12093-4-git-send-email-dkota@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
 <1537294047-12093-4-git-send-email-dkota@codeaurora.org>
Message-ID: <153780767551.119890.9339380838620508307@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V4 3/4] spi: spi-geni-qcom: Add SPI driver support for GENI based
 QUP
Date:   Mon, 24 Sep 2018 09:47:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dilip Kota (2018-09-18 11:07:25)
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> new file mode 100644
> index 0000000..949b853
> --- /dev/null
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -0,0 +1,653 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/log2.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/qcom-geni-se.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spinlock.h>
> +
> +/* SPI SE specific registers and respective register fields */
> +#define SE_SPI_CPHA            0x224
> +#define CPHA                   BIT(0)
> +
> +#define SE_SPI_LOOPBACK                0x22c
> +#define LOOPBACK_ENABLE                0x1
> +#define NORMAL_MODE            0x0
> +#define LOOPBACK_MSK           GENMASK(1, 0)
> +
> +#define SE_SPI_CPOL            0x230
> +#define CPOL                   BIT(2)
> +
> +#define SE_SPI_DEMUX_OUTPUT_INV        0x24c
> +#define CS_DEMUX_OUTPUT_INV_MSK        GENMASK(3, 0)
> +
> +#define SE_SPI_DEMUX_SEL       0x250
> +#define CS_DEMUX_OUTPUT_SEL    GENMASK(3, 0)
> +
> +#define SE_SPI_TRANS_CFG       0x25c
> +#define CS_TOGGLE              BIT(0)
> +
> +#define SE_SPI_WORD_LEN                0x268
> +#define WORD_LEN_MSK           GENMASK(9, 0)
> +#define MIN_WORD_LEN           4
> +
> +#define SE_SPI_TX_TRANS_LEN    0x26c
> +#define SE_SPI_RX_TRANS_LEN    0x270
> +#define TRANS_LEN_MSK          GENMASK(23, 0)
> +
> +#define SE_SPI_PRE_POST_CMD_DLY        0x274
> +
> +#define SE_SPI_DELAY_COUNTERS  0x278
> +#define SPI_INTER_WORDS_DELAY_MSK      GENMASK(9, 0)
> +#define SPI_CS_CLK_DELAY_MSK           GENMASK(19, 10)
> +#define SPI_CS_CLK_DELAY_SHFT          10
> +
> +/* M_CMD OP codes for SPI */
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
> +static irqreturn_t geni_spi_isr(int irq, void *data);

Does this need to be forward declared?

> +
> +struct spi_geni_master {
> +       struct geni_se se;
> +       struct device *dev;
> +       u32 rx_fifo_depth;

Is this used?

> +       u32 tx_fifo_depth;
> +       u32 fifo_width_bits;
> +       u32 tx_wm;
> +       unsigned int cur_speed_hz;

unsigned long for Hz? The clk framework uses that type.

> +       unsigned int cur_bits_per_word;
> +       unsigned int tx_rem_bytes;
> +       unsigned int rx_rem_bytes;
> +       struct spi_transfer *cur_xfer;

const?

> +       struct completion xfer_done;
> +       unsigned int oversampling;
> +       spinlock_t lock;
> +};
> +
[...]
> +
> +static int spi_geni_prepare_message(struct spi_master *spi,
> +                                       struct spi_message *spi_msg)
> +{
> +       int ret;
> +       struct spi_geni_master *mas =3D spi_master_get_devdata(spi);
> +       struct geni_se *se =3D &mas->se;
> +
> +       geni_se_select_mode(se, GENI_SE_FIFO);
> +       reinit_completion(&mas->xfer_done);
> +       ret =3D setup_fifo_params(spi_msg->spi, spi);
> +       if (ret)
> +               dev_err(mas->dev, "Couldn't select mode %d", ret);

Missing newline on error print.

> +       return ret;
> +}
> +
[...]
> +
> +static void setup_fifo_xfer(struct spi_transfer *xfer,
> +                               struct spi_geni_master *mas,
> +                               u16 mode, struct spi_master *spi)
> +{
> +       u32 m_cmd =3D 0, m_param =3D 0;
> +       u32 spi_tx_cfg, trans_len;
> +       struct geni_se *se =3D &mas->se;
> +
> +       spi_tx_cfg =3D readl(se->base + SE_SPI_TRANS_CFG);
> +       if (xfer->bits_per_word !=3D mas->cur_bits_per_word) {
> +               spi_setup_word_len(mas, mode, xfer->bits_per_word);
> +               mas->cur_bits_per_word =3D xfer->bits_per_word;
> +       }
> +
> +       /* Speed and bits per word can be overridden per transfer */
> +       if (xfer->speed_hz !=3D mas->cur_speed_hz) {
> +               int ret;
> +               u32 clk_sel, m_clk_cfg;
> +               unsigned int idx, div;
> +
> +               ret =3D get_spi_clk_cfg(xfer->speed_hz, mas, &idx, &div);
> +               if (ret) {
> +                       dev_err(mas->dev, "Err setting clks:%d\n", ret);
> +                       return;
> +               }
> +               /*
> +                * SPI core clock gets configured with the requested freq=
uency
> +                * or the frequency closer to the requested frequency.
> +                * For that reason requested frequency is stored in the
> +                * cur_speed_hz and referred in the consicutive transfer =
instead

s/consicutive/consecutive/

> +                * of calling clk_get_rate() API.
> +                */
> +               mas->cur_speed_hz =3D xfer->speed_hz;
> +               clk_sel =3D idx & CLK_SEL_MSK;
> +               m_clk_cfg =3D (div << CLK_DIV_SHFT) | SER_CLK_EN;
> +               writel(clk_sel, se->base + SE_GENI_CLK_SEL);
> +               writel(m_clk_cfg, se->base + GENI_SER_M_CLK_CFG);
> +       }
> +
> +       mas->tx_rem_bytes =3D 0;
> +       mas->rx_rem_bytes =3D 0;
> +       if (xfer->tx_buf && xfer->rx_buf)
> +               m_cmd =3D SPI_FULL_DUPLEX;
> +       else if (xfer->tx_buf)
> +               m_cmd =3D SPI_TX_ONLY;
> +       else if (xfer->rx_buf)
> +               m_cmd =3D SPI_RX_ONLY;
> +
> +       spi_tx_cfg &=3D ~CS_TOGGLE;
> +       if (!(mas->cur_bits_per_word % MIN_WORD_LEN)) {
> +               trans_len =3D
> +                       (xfer->len * BITS_PER_BYTE /
> +                                       mas->cur_bits_per_word) & TRANS_L=
EN_MSK;
> +       } else {
> +               unsigned int bytes_per_word =3D
> +                       mas->cur_bits_per_word / BITS_PER_BYTE + 1;
> +
> +               trans_len =3D (xfer->len / bytes_per_word) & TRANS_LEN_MS=
K;
> +       }

Rename 'trans_len' to 'len' and shorten some lines by taking out the
mask to get:

       if (!(mas->cur_bits_per_word % MIN_WORD_LEN))
               len =3D xfer->len * BITS_PER_BYTE / mas->cur_bits_per_word
       else =

               len =3D xfer->len / (mas->cur_bits_per_word / BITS_PER_BYTE =
+ 1);
       len &=3D TRANS_LEN_MSK;

> +
> +       /*
> +        * If CS change flag is set, then toggle the CS line in between
> +        * transfers and keep CS asserted after the last transfer.
> +        * Else if keep CS flag asserted in between transfers and de-asse=
rt
> +        * CS after the last message.
> +        */
> +       if (xfer->cs_change) {
> +               if (list_is_last(&xfer->transfer_list,
> +                               &spi->cur_msg->transfers))
> +                       m_param =3D FRAGMENTATION;
> +       } else {
> +               if (!list_is_last(&xfer->transfer_list,
> +                               &spi->cur_msg->transfers))
> +                       m_param =3D FRAGMENTATION;
> +       }
> +
> +       mas->cur_xfer =3D xfer;
> +       if (m_cmd & SPI_TX_ONLY) {
> +               mas->tx_rem_bytes =3D xfer->len;
> +               writel(trans_len, se->base + SE_SPI_TX_TRANS_LEN);
> +       }
> +
> +       if (m_cmd & SPI_RX_ONLY) {
> +               writel(trans_len, se->base + SE_SPI_RX_TRANS_LEN);
> +               mas->rx_rem_bytes =3D xfer->len;
> +       }
> +       writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
> +       geni_se_setup_m_cmd(se, m_cmd, m_param);
> +
> +       /*
> +        * TX_WATERMARK_REG should be set after SPI configuration and
> +        * setting up GENI SE engine, as driver starts data transfer
> +        * for the watermark interrupt.
> +        */
> +       if (m_cmd & SPI_TX_ONLY)
> +               writel(mas->tx_wm, se->base + SE_GENI_TX_WATERMARK_REG);
> +}
> +
> +static void handle_fifo_timeout(struct spi_master *spi,
> +                               struct spi_message *msg)
> +{
> +       struct spi_geni_master *mas =3D spi_master_get_devdata(spi);
> +       unsigned long timeout, flags;
> +       struct geni_se *se =3D &mas->se;
> +
> +       spin_lock_irqsave(&mas->lock, flags);
> +       reinit_completion(&mas->xfer_done);
> +       geni_se_cancel_m_cmd(se);
> +       writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
> +       spin_unlock_irqrestore(&mas->lock, flags);
> +       timeout =3D wait_for_completion_timeout(&mas->xfer_done, HZ);

Can you rename this time_left or completed? Then the if condition reads
properly as "if not time left" or "if not completed". And then invert
that logic so things aren't so indented?

	time_left =3D wait_for_completion_timeout(..)
	if (time_left)
		return;

	spin_lock_irqsave(&mas->lock, flags);
	reinit_completion(..)
	...

> +       if (!timeout) {
> +               spin_lock_irqsave(&mas->lock, flags);
> +               reinit_completion(&mas->xfer_done);
> +               geni_se_abort_m_cmd(se);
> +               spin_unlock_irqrestore(&mas->lock, flags);
> +               timeout =3D wait_for_completion_timeout(&mas->xfer_done,
> +                                                               HZ);
> +               if (!timeout)
> +                       dev_err(mas->dev,
> +                               "Failed to cancel/abort m_cmd\n");
> +       }
> +}
> +
> +static int spi_geni_transfer_one(struct spi_master *spi,
> +                               struct spi_device *slv,
> +                               struct spi_transfer *xfer)
> +{
> +       struct spi_geni_master *mas =3D spi_master_get_devdata(spi);
> +
> +       setup_fifo_xfer(xfer, mas, slv->mode, spi);
> +       return 1;
> +}
> +
> +static unsigned int geni_byte_per_fifo_word(struct spi_geni_master *mas)
> +{
> +       /*
> +        * Calculate how many bytes we'll put in each FIFO word.  If the
> +        * transfer words don't pack cleanly into a FIFO word we'll just =
put
> +        * one transfer word in each FIFO word.  If they do pack we'll pa=
ck 'em.
> +        */
> +       if (mas->fifo_width_bits % mas->cur_bits_per_word)
> +               return roundup_pow_of_two(DIV_ROUND_UP(mas->cur_bits_per_=
word,
> +                                                      BITS_PER_BYTE));
> +       else
> +               return mas->fifo_width_bits / BITS_PER_BYTE;

Just do a return. No else please.

> +}
> +
> +static irqreturn_t geni_spi_handle_tx(struct spi_geni_master *mas)
> +{
> +       struct geni_se *se =3D &mas->se;
> +       unsigned int max_bytes;
> +       const u8 *tx_buf;
> +       unsigned int bytes_per_fifo_word =3D geni_byte_per_fifo_word(mas);
> +       unsigned int i =3D 0;
> +
> +       if (!mas->cur_xfer)
> +               return IRQ_NONE;
> +
> +       max_bytes =3D (mas->tx_fifo_depth - mas->tx_wm) * bytes_per_fifo_=
word;
> +       if (mas->tx_rem_bytes < max_bytes)
> +               max_bytes =3D mas->tx_rem_bytes;
> +
> +       tx_buf =3D mas->cur_xfer->tx_buf + mas->cur_xfer->len - mas->tx_r=
em_bytes;
> +       while (i < max_bytes) {
> +               unsigned int j;
> +               unsigned int bytes_to_write;
> +               u32 fifo_word =3D 0;
> +               u8 *fifo_byte =3D (u8 *)&fifo_word;
> +
> +               bytes_to_write =3D min(bytes_per_fifo_word, max_bytes - i=
);
> +               for (j =3D 0; j < bytes_to_write; j++)
> +                       fifo_byte[j] =3D tx_buf[i++];
> +               iowrite32_rep(se->base + SE_GENI_TX_FIFOn, &fifo_word, 1);
> +       }
> +       mas->tx_rem_bytes -=3D max_bytes;
> +       if (!mas->tx_rem_bytes)
> +               writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t geni_spi_handle_rx(struct spi_geni_master *mas)
> +{
> +       struct geni_se *se =3D &mas->se;
> +       u32 rx_fifo_status;
> +       unsigned int rx_bytes;
> +       u8 *rx_buf;
> +       unsigned int bytes_per_fifo_word =3D geni_byte_per_fifo_word(mas);
> +       unsigned int i =3D 0;
> +
> +       if (!mas->cur_xfer)
> +               return IRQ_NONE;
> +
> +       rx_fifo_status =3D readl(se->base + SE_GENI_RX_FIFO_STATUS);

Rename to 'status'? rx_fifo is implicit in the register macro.

> +       rx_bytes =3D (rx_fifo_status & RX_FIFO_WC_MSK) * bytes_per_fifo_w=
ord;
> +       if (rx_fifo_status & RX_LAST) {
> +               unsigned int rx_last_byte_valid =3D
> +                       (rx_fifo_status & RX_LAST_BYTE_VALID_MSK)
> +                               >> RX_LAST_BYTE_VALID_SHFT;

Hoist this variable into function scope? So then the line is:

		last_valid =3D status & RX_LAST_BYTE_VALID_MSK;
		last_valid >>=3D RX_LAST_BYTE_VALID_SHFT;

> +               if (rx_last_byte_valid && (rx_last_byte_valid < 4))

Drop useless parenthesis please.

> +                       rx_bytes -=3D bytes_per_fifo_word - rx_last_byte_=
valid;
> +       }
> +       if (mas->rx_rem_bytes < rx_bytes)
> +               rx_bytes =3D mas->rx_rem_bytes;
> +
> +       rx_buf =3D mas->cur_xfer->rx_buf + mas->cur_xfer->len - mas->rx_r=
em_bytes;
> +       while (i < rx_bytes) {
> +               u32 fifo_word =3D 0;
> +               u8 *fifo_byte =3D (u8 *)&fifo_word;
> +               unsigned int bytes_to_read;
> +               unsigned int j;
> +
> +               bytes_to_read =3D min(bytes_per_fifo_word, rx_bytes - i);
> +               ioread32_rep(se->base + SE_GENI_RX_FIFOn, &fifo_word, 1);
> +               for (j =3D 0; j < bytes_to_read; j++)
> +                       rx_buf[i++] =3D fifo_byte[j];
> +       }
> +       mas->rx_rem_bytes -=3D rx_bytes;
> +
> +       return IRQ_HANDLED;
> +}
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
> +       if (pm_runtime_status_suspended(mas->dev))
> +               return IRQ_NONE;
> +
> +       spin_lock_irqsave(&mas->lock, flags);
> +       m_irq =3D readl(se->base + SE_GENI_M_IRQ_STATUS);
> +       if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & M_RX_FIFO_LAST_E=
N))
> +               ret =3D geni_spi_handle_rx(mas);
> +
> +       if (m_irq & M_TX_FIFO_WATERMARK_EN)
> +               ret =3D geni_spi_handle_tx(mas);

Is it possible for all three conditions above to happen in one
interrupt? I ask because 'ret' is overwritten and so what may have been
IRQ_HANDLED may become IRQ_NONE which will lead to confusion in the irq
layer. Maybe the handle tx/rx functions can return a bool, that gets
orred together each time so that we know if something handled an
interrupt?

> +
> +       if (m_irq & M_CMD_DONE_EN) {
> +               spi_finalize_current_transfer(spi);
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
> +                       dev_err(mas->dev, "Premature Done.tx_rem%d bpw%d\=
n",

Why isn't there a space after "Done."? And why is 'done' capitalized?
Should 'tx_rem' be 'tx_rem=3D'?

> +                               mas->tx_rem_bytes, mas->cur_bits_per_word=
);
> +               }
> +               if (mas->rx_rem_bytes)
> +                       dev_err(mas->dev, "Premature Done.rx_rem%d bpw%d\=
n",
> +                               mas->rx_rem_bytes, mas->cur_bits_per_word=
);
> +       }
> +
> +       if ((m_irq & M_CMD_CANCEL_EN) || (m_irq & M_CMD_ABORT_EN))
> +               complete(&mas->xfer_done);
> +
> +       writel(m_irq, se->base + SE_GENI_M_IRQ_CLEAR);
> +       spin_unlock_irqrestore(&mas->lock, flags);
> +       return ret;
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
> +       spi =3D spi_alloc_master(&pdev->dev, sizeof(struct spi_geni_maste=
r));

sizeof(*mas) for code clarity?

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
> +               ret =3D -ENOMEM;

		ret =3D PTR_ERR(se->base);

so we don't lose the error value.

> +               goto spi_geni_probe_err;
> +       }
> +
> +       ret =3D platform_get_irq(pdev, 0);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "Err getting IRQ %d\n", ret);
> +               goto spi_geni_probe_err;
> +       }
> +       ret =3D devm_request_irq(&pdev->dev, ret, geni_spi_isr,
> +                               IRQF_TRIGGER_HIGH, "spi_geni", spi);
> +       if (ret)
> +               goto spi_geni_probe_err;

Can you request this irq as late as possible in the probe function? I
worry there may be some pending irq line set and then this will cause an
interrupt storm with IRQ_NONE returned because the device is runtime
suspended.

> +
> +       spi->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_CS_HIGH;
> +       spi->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(4, 32);
> +       spi->num_chipselect =3D 4;
> +       spi->max_speed_hz =3D 50000000;
> +       spi->prepare_message =3D spi_geni_prepare_message;
> +       spi->transfer_one =3D spi_geni_transfer_one;
> +       spi->auto_runtime_pm =3D true;
> +       spi->handle_err =3D handle_fifo_timeout;
> +
> +       init_completion(&mas->xfer_done);
> +       spin_lock_init(&mas->lock);
> +       pm_runtime_enable(&pdev->dev);
> +
> +       ret =3D spi_geni_init(mas);
> +       if (ret)
> +               goto spi_geni_probe_runtime_disable;
> +
> +       ret =3D spi_register_master(spi);
> +       if (ret)
> +               goto spi_geni_probe_runtime_disable;
> +
> +       return 0;
> +spi_geni_probe_runtime_disable:
> +       pm_runtime_disable(&pdev->dev);
> +spi_geni_probe_err:
> +       spi_master_put(spi);
> +       return ret;
> +}
> +
> +static int spi_geni_remove(struct platform_device *pdev)
> +{
> +       struct spi_master *spi =3D platform_get_drvdata(pdev);
> +
> +       /* Unregister _before_ disabling pm_runtime() so we stop transfer=
s */
> +       spi_unregister_master(spi);
> +
> +       pm_runtime_disable(&pdev->dev);
> +       return 0;
> +}
> +
> +static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
> +{
> +       struct spi_master *spi =3D dev_get_drvdata(dev);
> +       struct spi_geni_master *mas =3D spi_master_get_devdata(spi);
> +
> +       return geni_se_resources_off(&mas->se);
> +}
> +
> +static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
> +{
> +       struct spi_master *spi =3D dev_get_drvdata(dev);
> +       struct spi_geni_master *mas =3D spi_master_get_devdata(spi);
> +
> +       return geni_se_resources_on(&mas->se);
> +}
> +
> +static int __maybe_unused spi_geni_suspend(struct device *dev)
> +{
> +       if (!pm_runtime_status_suspended(dev))
> +               return -EBUSY;
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops spi_geni_pm_ops =3D {
> +       SET_RUNTIME_PM_OPS(spi_geni_runtime_suspend,
> +                                       spi_geni_runtime_resume, NULL)
> +       SET_SYSTEM_SLEEP_PM_OPS(spi_geni_suspend, NULL)
> +};
> +
> +static const struct of_device_id spi_geni_dt_match[] =3D {
> +       { .compatible =3D "qcom,geni-spi" },
> +       {}
> +};

Please add a MODULE_DEVICE_TABLE(of, spi_geni_dt_match) here.

> +
> +static struct platform_driver spi_geni_driver =3D {
> +       .probe  =3D spi_geni_probe,
> +       .remove =3D spi_geni_remove,
> +       .driver =3D {
> +               .name =3D "geni_spi",
> +               .pm =3D &spi_geni_pm_ops,
> +               .of_match_table =3D spi_geni_dt_match,
> +       },
> +};
> +module_platform_driver(spi_geni_driver);
> +
> +MODULE_DESCRIPTION("SPI driver for GENI based QUP cores");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/spi/spi-geni-qcom.h b/include/linux/spi/spi-ge=
ni-qcom.h
> new file mode 100644
> index 0000000..dc95764
> --- /dev/null
> +++ b/include/linux/spi/spi-geni-qcom.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef __SPI_GENI_QCOM_HEADER___
> +#define __SPI_GENI_QCOM_HEADER___
> +
> +struct spi_geni_qcom_ctrl_data {
> +       u32 spi_cs_clk_delay;
> +       u32 spi_inter_words_delay;

It was decided we still needed this? I don't see it in v3 so please
remove this file unless it's needed.

