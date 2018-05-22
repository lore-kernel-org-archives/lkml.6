Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeEVQqs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:46:48 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37169 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEVQql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:46:41 -0400
X-Google-Smtp-Source: AB8JxZqEurzv/y1itKuXSwUxxzjDWGjdyRPIGrk80dLCR/P3oIowrtkQktlbw73dQjzv+865nWavBw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: "Mahadevan, Girish" <girishm@codeaurora.org>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org>
Cc: sdharia@codeaurora.org, kramasub@codeaurora.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org
References: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
 <152607782792.34267.8023817955251139395@swboyd.mtv.corp.google.com>
 <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org>
Message-ID: <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based QUP
Date: Tue, 22 May 2018 09:46:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4MGkqc5016066

Quoting Mahadevan, Girish (2018-05-21 08:52:47)
> Hi Stephen
> 
> On 5/11/2018 4:30 PM, Stephen Boyd wrote:
> 
> >> +       if (mode & SPI_CPHA)
> >> +               cpha |= CPHA;
> >> +
> >> +       if (spi_slv->mode & SPI_CS_HIGH)
> >> +               demux_output_inv |= BIT(spi_slv->chip_select);
> >> +
> >> +       if (spi_slv->controller_data) {
> >> +               u32 cs_clk_delay = 0;
> >> +               u32 inter_words_delay = 0;
> >> +
> >> +               delay_params =
> >> +               (struct spi_geni_qcom_ctrl_data *) spi_slv->controller_data;
> >> +               cs_clk_delay =
> >> +               (delay_params->spi_cs_clk_delay << SPI_CS_CLK_DELAY_SHFT)
> >> +                                                       & SPI_CS_CLK_DELAY_MSK;
> >> +               inter_words_delay =
> >> +                       delay_params->spi_inter_words_delay &
> >> +                                               SPI_INTER_WORDS_DELAY_MSK;
> >> +               spi_delay_params =
> >> +               (inter_words_delay | cs_clk_delay);
> >> +       }
> >> +
> >> +       demux_sel = spi_slv->chip_select;
> >> +       mas->cur_speed_hz = spi_slv->max_speed_hz;
> > 
> > Why can't you use clk_get_rate() instead? Or call clk_set_rate() with
> > the rate you want the master clk to run at and then divide that down
> > from there?
> 
> Not sure I follow, the intention is to run the controller clock based on
> the slave's max frequency.

That's good. The problem I see is that we have to specify the max
frequency in the controller/bus node, and also in the child/slave node.
It should only need to be specified in the slave node, so making the
cur_speed_hz equal the max_speed_hz is problematic. The current speed of
the master should be determined by calling clk_get_rate().

> > 
> >> +       }
> >> +
> >> +       if (unlikely(!mas->setup)) {
> >> +               int proto = geni_se_read_proto(se);
> >> +               unsigned int major;
> >> +               unsigned int minor;
> >> +               unsigned int step;
> >> +
> >> +               if (unlikely(proto != GENI_SE_SPI)) {
> >> +                       dev_err(mas->dev, "Invalid proto %d\n", proto);
> >> +                       return -ENXIO;
> >> +               }
> >> +               mas->tx_fifo_depth = geni_se_get_tx_fifo_depth(se);
> >> +               mas->rx_fifo_depth = geni_se_get_rx_fifo_depth(se);
> >> +               mas->tx_fifo_width = geni_se_get_tx_fifo_width(se);
> >> +               geni_se_init(se, 0x0, (mas->tx_fifo_depth - 2));
> > 
> > Why 2? Drop extra parenthesis please.
> 
> This is what the hardware programming doc recommends, the parameter is
> actually the rx_rfr_watermark, something that doesn't apply to non-UART
> protocols.
> (I will add a detailed comment)

Thanks. Just wanted to make sure we don't forget what the magic number
means.

>  an else if.
> > 
> >> +                       m_param |= FRAGMENTATION;
> >> +       }
> >> +
> >> +       mas->cur_xfer = xfer;
> >> +       if (m_cmd & SPI_TX_ONLY) {
> >> +               mas->tx_rem_bytes = xfer->len;
> >> +               writel_relaxed(trans_len, se->base + SE_SPI_TX_TRANS_LEN);
> >> +       }
> >> +
> >> +       if (m_cmd & SPI_RX_ONLY) {
> >> +               writel_relaxed(trans_len, se->base + SE_SPI_RX_TRANS_LEN);
> >> +               mas->rx_rem_bytes = xfer->len;
> >> +       }
> >> +       writel_relaxed(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
> >> +       geni_se_setup_m_cmd(se, m_cmd, m_param);
> >> +       if (m_cmd & SPI_TX_ONLY)
> >> +               writel_relaxed(mas->tx_wm, se->base + SE_GENI_TX_WATERMARK_REG);
> > 
> > This can't be combined with above m_cmd & SPI_TX_ONLY statement?
> 
> No, writing to this register should be done after we enqueue the command
> to the GENI engine(the geni_se_setup_m_cmd), but some of the transaction
> properties (length etc) should be setup before we enqueue the GENI command.

Ok.

> 
> > 
> > More things can be unsigned?
> > 
> >> +               fifo_byte = (u8 *)&fifo_word;
> >> +               for (j = 0; j < bytes_to_write; j++)
> >> +                       fifo_byte[j] = tx_buf[i++];
> > 
> > Why are we doing all this work to fill in a fifo byte at a time? tx_buf
> > should be a buffer of bytes that we can iowrite32_rep() with directly.
> > And then we could just run iowrite32_rep() with some count of bytes to
> > write? I suppose we may run into problems with unaligned size buffers,
> > but it sounds like that doesn't happen?
> 
> I did this for 2 reasons.
> 1.The core can handle different byte order transmissions (e.g MSB
> first), I am quite honestly not sure how the client's will setup the
> data buffer in these cases.(for bigger word sizes , 16/32)
> [we plan to support these]
> 2. For non-byte aligned word sizes (e,g 9), I am not enabling FIFO word
> packing (meaning 1 SPI-WORD/FIFO-WORD in these cases).

Alright. I'm not certain how the incoming buffer looks when clients
request certain modes. Have you tested out non-byte aligned word size
transfers?

> 
> 
> >> +++ b/include/linux/spi/spi-geni-qcom.h
> >> @@ -0,0 +1,14 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > 
> > Why?
> > 
> >> +/*
> >> + * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> >> + */
> >> +
> >> +#ifndef __SPI_GENI_QCOM_HEADER___
> >> +#define __SPI_GENI_QCOM_HEADER___
> >> +
> >> +struct spi_geni_qcom_ctrl_data {
> > 
> > What's the point of this header file and structure? This driver supports
> > board files? Isn't everything DT now?
> 
> The intention was to allow a client to specify slave specific timing
> requirements, e.g CS-CLK delay (based on the slave's data sheet).
> So that the client drivers could setup these delays and pass it in part
> of the controller_data member of the spi_device data structure.
> The header file was meant to expose these timing params that the client
> could specify. I honestly didn't know how else a client could specify
> these to the controller driver.

Do you mean spi-rx-delay-us and spi-tx-delay-us properties? Those are
documented but don't seem to be used. There's also the delay_usecs part
of the spi_transfer structure, which may be what you're talking about.
