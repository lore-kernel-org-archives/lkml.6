Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EC0C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9862156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g1Xw/n0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9862156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeI0M75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 08:59:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41514 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeI0M75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 08:59:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3-v6so1163993pgv.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 23:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=15UuesG53PG74xaIA3nnL0KeBcJRXF9PPu1oUDbn1RE=;
        b=g1Xw/n0lVEA+dpkW8ZA+O0rNZ4mMbqRpEuJp8eZZXcPAiSLbRW56iNDi/v+roVAofO
         6B/KggD85oUTtysc10HPV4h9JGPc7ZcVI4iVxme/D04TMqsAW5dQUiKIQv7OIWYUtGUW
         riAsGCzZVusJynAXosriIbkW709B+DOwqTtM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=15UuesG53PG74xaIA3nnL0KeBcJRXF9PPu1oUDbn1RE=;
        b=jP+4Q5rx6R07SUbN/vXZ1z3YKyewkXotq1dfNOyNv8WavYNSJ0IPBlcrTTTF/ZRrrV
         YNbxVaTGKIwzcUYF3DP0idP2vInAKn21UB4UyL9aUvWJcZt8VHDYZHL02egIgVlTdOrG
         BWrhe5PzWm0+8KG8Fpxa0tG42FaPMIOXmCFAbkITdgPFB/mFzskefqpyVgmnSElp11hM
         J+cH//TdLabfAlDGf0MNg0QoB92GEsZoHC5BtwxwPQbssSPrvsHghNdj7lmGTkLY5+Dk
         wvlzjECr5/ae9v2CV7gvlGwc1pUnIP5Qu+VYQE9kp3grZSJgDv1FyDoZV+dEtYfiuj+M
         hciw==
X-Gm-Message-State: ABuFfog1dJEo++frPu10T9ZxVzkwGgtrsleucIg5VqwzV0ma0IztzfRx
        KVXtr8k1BZNaIB+vlAspZ/NeNw==
X-Google-Smtp-Source: ACcGV63ZaDhfqCkJImlW9Qi8Q0qPvSp/szT3C/E/r426bfYMd0LPVbMZkijzH1bLvALujpwUXG4b8g==
X-Received: by 2002:a63:1b0b:: with SMTP id b11-v6mr8655725pgb.66.1538030595816;
        Wed, 26 Sep 2018 23:43:15 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id s13-v6sm1634358pfj.105.2018.09.26.23.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 23:43:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mark Brown <broonie@kernel.org>, Ryan Case <ryandcase@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180926205204.184898-2-ryandcase@chromium.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Trent Piepho <tpiepho@impinj.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Ryan Case <ryandcase@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20180926205204.184898-1-ryandcase@chromium.org>
 <20180926205204.184898-2-ryandcase@chromium.org>
Message-ID: <153803059441.119890.891880266219521584@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 2/2] spi: Introduce new driver for Qualcomm QuadSPI controller
Date:   Wed, 26 Sep 2018 23:43:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryan Case (2018-09-26 13:52:04)
> From: Girish Mahadevan <girishm@codeaurora.org>
> =

> New driver for Qualcomm QuadSPI(QSPI) controller that is used to
> communicate with slaves such flash memory devices. The QSPI controller

s/such/such as/?

> can operate in 2 or 4 wire mode but only supports SPI Mode 0. The
> controller can also operate in Single or Dual data rate modes.
> =

> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 876f8690fc47..f997c49255a6 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -112,3 +112,4 @@ obj-$(CONFIG_SPI_ZYNQMP_GQSPI)              +=3D spi-=
zynqmp-gqspi.o
>  # SPI slave protocol handlers
>  obj-$(CONFIG_SPI_SLAVE_TIME)           +=3D spi-slave-time.o
>  obj-$(CONFIG_SPI_SLAVE_SYSTEM_CONTROL) +=3D spi-slave-system-control.o
> +obj-$(CONFIG_SPI_QCOM_QSPI)            +=3D spi-qcom-qspi.o

Move this to alphabetical in the SPI master controller list of this
file please.

> diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
> new file mode 100644
> index 000000000000..0ad2ef003068
> --- /dev/null
> +++ b/drivers/spi/spi-qcom-qspi.c
> @@ -0,0 +1,598 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi-mem.h>
> +
> +#include <asm/unaligned.h>
> +
> +#define AHB_MIN_HZ             9600000UL

Is this used?

> +#define QSPI_NUM_CS            2
> +#define QSPI_BYTES_PER_WORD    4
> +#define MSTR_CONFIG            0x0000
> +#define AHB_MASTER_CFG         0x0004
> +#define MSTR_INT_EN            0x000C
> +#define MSTR_INT_STATUS                0x0010
> +#define PIO_XFER_CTRL          0x0014
> +#define PIO_XFER_CFG           0x0018
> +#define PIO_XFER_STATUS                0x001c
> +#define PIO_DATAOUT_1B         0x0020
> +#define PIO_DATAOUT_4B         0x0024
> +#define RD_FIFO_CFG            0x0028
> +#define RD_FIFO_STATUS         0x002c
> +#define RD_FIFO_RESET          0x0030
> +#define CUR_MEM_ADDR           0x0048
> +#define HW_VERSION             0x004c
> +#define RD_FIFO                        0x0050
> +#define SAMPLING_CLK_CFG       0x0090
> +#define SAMPLING_CLK_STATUS    0x0094
> +
> +/* Macros to help set/get fields in MSTR_CONFIG register */
> +#define        FULL_CYCLE_MODE         BIT(3)
> +#define        FB_CLK_EN               BIT(4)
> +#define        PIN_HOLDN               BIT(6)
> +#define        PIN_WPN                 BIT(7)
> +#define        DMA_ENABLE              BIT(8)
> +#define        BIG_ENDIAN_MODE         BIT(9)
> +#define        SPI_MODE_MSK            0xc00
> +#define        SPI_MODE_SHFT           10
> +#define        CHIP_SELECT_NUM         BIT(12)
> +#define        SBL_EN                  BIT(13)
> +#define        LPA_BASE_MSK            0x3c000
> +#define        LPA_BASE_SHFT           14
> +#define        TX_DATA_DELAY_MSK       0xc0000
> +#define        TX_DATA_DELAY_SHFT      18
> +#define        TX_CLK_DELAY_MSK        0x300000
> +#define        TX_CLK_DELAY_SHFT       20
> +#define        TX_CS_N_DELAY_MSK       0xc00000
> +#define        TX_CS_N_DELAY_SHFT      22
> +#define        TX_DATA_OE_DELAY_MSK    0x3000000
> +#define        TX_DATA_OE_DELAY_SHFT   24
> +
> +/* Macros to help set/get fields in AHB_MSTR_CFG register */
> +#define        HMEM_TYPE_START_MID_TRANS_MSK           0x7
> +#define        HMEM_TYPE_START_MID_TRANS_SHFT          0
> +#define        HMEM_TYPE_LAST_TRANS_MSK                0x38
> +#define        HMEM_TYPE_LAST_TRANS_SHFT               3
> +#define        USE_HMEMTYPE_LAST_ON_DESC_OR_CHAIN_MSK  0xc0
> +#define        USE_HMEMTYPE_LAST_ON_DESC_OR_CHAIN_SHFT 6
> +#define        HMEMTYPE_READ_TRANS_MSK                 0x700
> +#define        HMEMTYPE_READ_TRANS_SHFT                8
> +#define        HSHARED                                 BIT(11)
> +#define        HINNERSHARED                            BIT(12)
> +
> +/* Macros to help set/get fields in MSTR_INT_EN/MSTR_INT_STATUS register=
s */
> +#define        RESP_FIFO_UNDERRUN      BIT(0)
> +#define        RESP_FIFO_NOT_EMPTY     BIT(1)
> +#define        RESP_FIFO_RDY           BIT(2)
> +#define        HRESP_FROM_NOC_ERR      BIT(3)
> +#define        WR_FIFO_EMPTY           BIT(9)
> +#define        WR_FIFO_FULL            BIT(10)
> +#define        WR_FIFO_OVERRUN         BIT(11)
> +#define        TRANSACTION_DONE        BIT(16)
> +#define QSPI_ERR_IRQS          (RESP_FIFO_UNDERRUN | HRESP_FROM_NOC_ERR =
| \
> +                                WR_FIFO_OVERRUN)
> +#define        QSPI_ALL_IRQS           (QSPI_ERR_IRQS | RESP_FIFO_RDY | \
> +                                WR_FIFO_EMPTY | WR_FIFO_FULL | \
> +                                TRANSACTION_DONE)
> +
> +/* Macros to help set/get fields in RD_FIFO_CONFIG register */
> +#define        CONTINUOUS_MODE         BIT(0)
> +
> +/* Macros to help set/get fields in RD_FIFO_RESET register */
> +#define        RESET_FIFO              BIT(0)
> +
> +/* Macros to help set/get fields in PIO_TRANSFER_CONFIG register */
> +#define        TRANSFER_DIRECTION      BIT(0)
> +#define        MULTI_IO_MODE_MSK       0xe
> +#define        MULTI_IO_MODE_SHFT      1
> +#define        TRANSFER_FRAGMENT       BIT(8)
> +
> +/* Macros to help set/get fields in PIO_TRANSFER_CONTROL register */
> +#define        REQUEST_COUNT_MSK       0xffff
> +
> +/* Macros to help set/get fields in PIO_TRANSFER_STATUS register */
> +#define        WR_FIFO_BYTES_MSK       0xffff0000
> +#define        WR_FIFO_BYTES_SHFT      16
> +
> +/* Macros to help set/get fields in RD_FIFO_STATUS register */

Typically we put these definitions immediately after the register offset
that uses them so we don't need these comments to tell us what registers
they apply to.

> +#define        FIFO_EMPTY      BIT(11)
> +#define        WR_CNTS_MSK     0x7f0
> +#define        WR_CNTS_SHFT    4
> +#define        RDY_64BYTE      BIT(3)
> +#define        RDY_32BYTE      BIT(2)
> +#define        RDY_16BYTE      BIT(1)
> +#define        FIFO_RDY        BIT(0)
> +
> +/*
> + * The Mode transfer macros, the values are programmed to the HW registe=
rs
> + * when doing PIO mode of transfers.
> + */
> +#define        SDR_1BIT        1
> +#define        SDR_2BIT        2
> +#define        SDR_4BIT        3
> +#define        DDR_1BIT        5
> +#define        DDR_2BIT        6
> +#define        DDR_4BIT        7
> +
> +/* The Mode transfer macros when setting up DMA descriptors */
> +#define        DMA_DESC_SINGLE_SPI     1
> +#define        DMA_DESC_DUAL_SPI       2
> +#define        DMA_DESC_QUAD_SPI       3
> +
> +enum qspi_dir {
> +       QSPI_READ,
> +       QSPI_WRITE,
> +};
> +
> +struct qspi_xfer {
> +       union {
> +               const void *tx_buf;
> +               void *rx_buf;
> +       };
> +       unsigned int rem_bytes;
> +       int buswidth;

unsigned int?

> +       enum qspi_dir dir;
> +       bool is_last;
> +};
> +
> +enum qspi_clocks {
> +       QSPI_CLK_CORE,
> +       QSPI_CLK_IFACE,
> +       QSPI_NUM_CLKS
> +};
> +
> +struct qcom_qspi {
> +       void __iomem *base;
> +       struct device *dev;
> +       struct clk_bulk_data clks[QSPI_NUM_CLKS];
> +       struct qspi_xfer xfer;
> +       spinlock_t lock;

What is the lock protecting? Hardware interrupt state? Maybe add a small
comment to help the reader know what needs protecting.

> +};
> +
> +static int qspi_buswidth_to_iomode(struct qcom_qspi *ctrl, int buswidth)
> +{
> +       switch (buswidth) {
> +       case 1:
> +               return SDR_1BIT;
> +       case 2:
> +               return SDR_2BIT;
> +       case 4:
> +               return SDR_4BIT;
> +       default:
> +               dev_warn_once(ctrl->dev,
> +                               "Unexpected bus width: %d\n", buswidth);
> +               return SDR_1BIT;
> +       }
> +}
> +
> +static void qcom_qspi_pio_xfer_cfg(struct qcom_qspi *ctrl)
> +{
> +       u32 pio_xfer_cfg =3D 0;

Please remove useless initial assignment.

> +       struct qspi_xfer *xfer;

const?

> +
> +       xfer =3D &ctrl->xfer;
> +       pio_xfer_cfg =3D readl(ctrl->base + PIO_XFER_CFG);
> +       pio_xfer_cfg &=3D ~TRANSFER_DIRECTION;
> +       pio_xfer_cfg |=3D xfer->dir;
> +       if (xfer->is_last)
> +               pio_xfer_cfg &=3D ~TRANSFER_FRAGMENT;
> +       else
> +               pio_xfer_cfg |=3D TRANSFER_FRAGMENT;
> +       pio_xfer_cfg &=3D ~MULTI_IO_MODE_MSK;
> +       pio_xfer_cfg |=3D qspi_buswidth_to_iomode(ctrl, xfer->buswidth) <<
> +                       MULTI_IO_MODE_SHFT;

Style nitpick, this looks very odd split across two lines. Probably
better to make qspi_buswidth_to_iomode() return the shifted value
because this is the only call-site and then everything fits on one line.
Could also rename 'pio_xfer_cfg' to just 'cfg' and probably everything
would be short too.

> +
> +       writel(pio_xfer_cfg, ctrl->base + PIO_XFER_CFG);
> +}
> +
> +static void qcom_qspi_pio_xfer_ctrl(struct qcom_qspi *ctrl)
> +{
> +       u32 pio_xfer_ctrl;
> +
> +       pio_xfer_ctrl =3D readl(ctrl->base + PIO_XFER_CTRL);
> +       pio_xfer_ctrl &=3D ~REQUEST_COUNT_MSK;
> +       pio_xfer_ctrl |=3D ctrl->xfer.rem_bytes;
> +       writel(pio_xfer_ctrl, ctrl->base + PIO_XFER_CTRL);
> +}
> +
> +static void qcom_qspi_pio_xfer(struct qcom_qspi *ctrl)
> +{
> +       u32 ints;
> +
> +       qcom_qspi_pio_xfer_cfg(ctrl);
> +
> +       /* Ack any previous interrupts that might be hanging around */
> +       writel(QSPI_ALL_IRQS, ctrl->base + MSTR_INT_STATUS);
> +
> +       /* Setup new interrupts */
> +       if (ctrl->xfer.dir =3D=3D QSPI_WRITE)
> +               ints =3D QSPI_ERR_IRQS | WR_FIFO_EMPTY;
> +       else
> +               ints =3D QSPI_ERR_IRQS | RESP_FIFO_RDY;
> +       writel(ints, ctrl->base + MSTR_INT_EN);
> +
> +       /* Kick off the transfer */
> +       qcom_qspi_pio_xfer_ctrl(ctrl);
> +}
> +
> +static void qcom_qspi_handle_err(struct spi_master *master,
> +                                struct spi_message *msg)
> +{
> +       struct qcom_qspi *ctrl =3D spi_master_get_devdata(master);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&ctrl->lock, flags);
> +       writel(0, ctrl->base + MSTR_INT_EN);
> +       ctrl->xfer.rem_bytes =3D 0;
> +       spin_unlock_irqrestore(&ctrl->lock, flags);
> +}
> +
> +static int qcom_qspi_transfer_one(struct spi_master *master,
> +                                 struct spi_device *slv,
> +                                 struct spi_transfer *xfer)
> +{
> +       struct qcom_qspi *ctrl =3D spi_master_get_devdata(master);
> +       int ret;
> +       unsigned long speed_hz;
> +       unsigned long flags;
> +
> +       speed_hz =3D slv->max_speed_hz;
> +       if (xfer->speed_hz)
> +               speed_hz =3D xfer->speed_hz;
> +
> +       ret =3D clk_set_rate(ctrl->clks[QSPI_CLK_CORE].clk, speed_hz * 4);

Why 4? Is that related to the number of wires?

> +       if (ret) {
> +               dev_err(ctrl->dev, "Failed to set core clk %d\n", ret);
> +               return ret;
> +       }
> +
> +       spin_lock_irqsave(&ctrl->lock, flags);
> +
> +       /* We are half duplex, so either rx or tx will be set */
> +       if (xfer->rx_buf) {
> +               ctrl->xfer.dir =3D QSPI_READ;
> +               ctrl->xfer.buswidth =3D xfer->rx_nbits;
> +               ctrl->xfer.rx_buf =3D xfer->rx_buf;
> +       } else {
> +               ctrl->xfer.dir =3D QSPI_WRITE;
> +               ctrl->xfer.buswidth =3D xfer->tx_nbits;
> +               ctrl->xfer.tx_buf =3D xfer->tx_buf;
> +       }
> +       ctrl->xfer.is_last =3D list_is_last(&xfer->transfer_list,
> +                                         &master->cur_msg->transfers);
> +       ctrl->xfer.rem_bytes =3D xfer->len;
> +       qcom_qspi_pio_xfer(ctrl);
> +
> +       spin_unlock_irqrestore(&ctrl->lock, flags);
> +
> +       /* We'll call spi_finalize_current_transfer() when done */
> +       return 1;
> +}
> +
> +static int qcom_qspi_prepare_message(struct spi_master *master,
> +                                    struct spi_message *message)
> +{
> +       u32 mstr_cfg;
> +       struct qcom_qspi *ctrl;
> +       int tx_data_oe_delay =3D 1;
> +       int tx_data_delay =3D 1;
> +       unsigned long flags;
> +
> +       ctrl =3D spi_master_get_devdata(master);
> +       spin_lock_irqsave(&ctrl->lock, flags);
> +
> +       mstr_cfg =3D readl(ctrl->base + MSTR_CONFIG);
> +       mstr_cfg &=3D ~CHIP_SELECT_NUM;
> +       if (message->spi->chip_select)
> +               mstr_cfg |=3D CHIP_SELECT_NUM;
> +
> +       mstr_cfg =3D (mstr_cfg & ~SPI_MODE_MSK) |
> +                               (message->spi->mode << SPI_MODE_SHFT);
> +       mstr_cfg |=3D FB_CLK_EN | PIN_WPN | PIN_HOLDN | SBL_EN | FULL_CYC=
LE_MODE;
> +       mstr_cfg |=3D (mstr_cfg & ~TX_DATA_OE_DELAY_MSK) |
> +                               (tx_data_oe_delay << TX_DATA_OE_DELAY_SHF=
T);
> +       mstr_cfg |=3D (mstr_cfg & ~TX_DATA_DELAY_MSK) |
> +                               (tx_data_delay << TX_DATA_DELAY_SHFT);

Maybe just write them all on one line with mstr_cfg |=3D? Then it's not
indendented like that:

       mstr_cfg &=3D ~(SPI_MODE_MSK | TX_DATA_OE_DELAY_MSK | TX_DATA_DELAY_=
MSK);
       mstr_cfg |=3D message->spi->mode << SPI_MODE_SHFT;
       mstr_cfg |=3D FB_CLK_EN | PIN_WPN | PIN_HOLDN | SBL_EN | FULL_CYCLE_=
MODE;
       mstr_cfg |=3D tx_data_oe_delay << TX_DATA_OE_DELAY_SHFT;
       mstr_cfg |=3D tx_data_delay << TX_DATA_DELAY_SHFT;

> +       mstr_cfg &=3D ~DMA_ENABLE;
> +
> +       writel(mstr_cfg, ctrl->base + MSTR_CONFIG);
> +       spin_unlock_irqrestore(&ctrl->lock, flags);
> +
> +       return 0;
> +}
> +
> +static irqreturn_t pio_read(struct qcom_qspi *ctrl)
> +{
> +       u32 rd_fifo_status;
> +       u32 rd_fifo;
> +       unsigned int wr_cnts;
> +       unsigned int bytes_to_read;
> +       unsigned int words_to_read;
> +       u32 *word_buf;
> +       u8 *byte_buf;
> +       int i;
> +
> +       rd_fifo_status =3D readl(ctrl->base + RD_FIFO_STATUS);
> +
> +       if (!(rd_fifo_status & FIFO_RDY)) {
> +               dev_dbg(ctrl->dev, "Spurious IRQ %#x\n", rd_fifo_status);
> +               return IRQ_NONE;
> +       }
> +
> +       wr_cnts =3D (rd_fifo_status & WR_CNTS_MSK) >> WR_CNTS_SHFT;
> +
> +       if (wr_cnts > ctrl->xfer.rem_bytes)
> +               wr_cnts =3D ctrl->xfer.rem_bytes;

Could be

	wr_cnts =3D min(wr_cnts, ctrl->xfer.rem_bytes)

> +
> +       words_to_read =3D wr_cnts / QSPI_BYTES_PER_WORD;
> +       bytes_to_read =3D wr_cnts % QSPI_BYTES_PER_WORD;
> +
> +       if (words_to_read) {
> +               word_buf =3D ctrl->xfer.rx_buf;
> +               ctrl->xfer.rem_bytes -=3D words_to_read * QSPI_BYTES_PER_=
WORD;
> +               for (i =3D 0; i < words_to_read; i++) {
> +                       rd_fifo =3D readl(ctrl->base + RD_FIFO);

This will mess things up on big endian CPUs and make the CPU buffer byte
swapped. Use readsl() or ioread32_rep().

> +                       put_unaligned(rd_fifo, word_buf++);
> +               }
> +               ctrl->xfer.rx_buf =3D word_buf;
> +       }
> +
> +       if (bytes_to_read) {
> +               byte_buf =3D ctrl->xfer.rx_buf;

Does this need to move forward by words_to_read bytes so that the left
over bytes are tacked onto the end? Or this should be an else if
statement?

> +               rd_fifo =3D readl(ctrl->base + RD_FIFO);
> +               ctrl->xfer.rem_bytes -=3D bytes_to_read;
> +               for (i =3D 0; i < bytes_to_read; i++)
> +                       *byte_buf++ =3D rd_fifo >> (i * BITS_PER_BYTE);
> +               ctrl->xfer.rx_buf =3D byte_buf;
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t pio_write(struct qcom_qspi *ctrl)
> +{
> +       const void *xfer_buf =3D ctrl->xfer.tx_buf;
> +       const int *word_buf;
> +       const char *byte_buf;
> +       unsigned int wr_fifo_bytes;
> +       unsigned int wr_fifo_words;
> +       unsigned int wr_size;
> +       unsigned int rem_words;
> +
> +       wr_fifo_bytes =3D readl(ctrl->base + pio_xfer_status)
> +                               >> wr_fifo_bytes_shft;

Just write this as:

       wr_fifo_bytes =3D readl(ctrl->base + pio_xfer_status);
       wr_fifo_bytes >>=3D WR_FIFO_BYTES_SHFT;

and is that supposed to be uppercase but it's lower case? Or did I
somehow mess that up when replying?

> +
> +       if (ctrl->xfer.rem_bytes < QSPI_BYTES_PER_WORD) {
> +               /* Process the last 1-3 bytes */
> +               wr_size =3D min(wr_fifo_bytes, ctrl->xfer.rem_bytes);
> +               ctrl->xfer.rem_bytes -=3D wr_size;
> +
> +               byte_buf =3D xfer_buf;
> +               while (wr_size--)
> +                       writel(*byte_buf++,
> +                              ctrl->base + PIO_DATAOUT_1B);
> +               ctrl->xfer.tx_buf =3D byte_buf;
> +       } else {
> +               /*
> +                * Process all the whole words; to keep things simple we'=
ll
> +                * just wait for the next interrupt to handle the last 1-3
> +                * bytes if we don't have an even number of words.
> +                */
> +               rem_words =3D ctrl->xfer.rem_bytes / QSPI_BYTES_PER_WORD;
> +               wr_fifo_words =3D wr_fifo_bytes / QSPI_BYTES_PER_WORD;
> +
> +               wr_size =3D min(rem_words, wr_fifo_words);
> +               ctrl->xfer.rem_bytes -=3D wr_size * QSPI_BYTES_PER_WORD;
> +
> +               word_buf =3D xfer_buf;
> +               while (wr_size--)
> +                       writel(get_unaligned(word_buf++),
> +                              ctrl->base + PIO_DATAOUT_4B);

Is this a FIFO? Should use writesl() or iowrite32_rep() then when
throwing words at a time into the FIFO so that it works on any CPU
endianess for a little endian device.

> +               ctrl->xfer.tx_buf =3D word_buf;
> +
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t qcom_qspi_irq(int irq, void *dev_id)
> +{
> +       u32 int_status;
> +       struct qcom_qspi *ctrl =3D dev_id;
> +       irqreturn_t ret;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&ctrl->lock, flags);
> +
> +       int_status =3D readl(ctrl->base + MSTR_INT_STATUS);
> +       writel(int_status, ctrl->base + MSTR_INT_STATUS);
> +
> +       if (ctrl->xfer.dir =3D=3D QSPI_WRITE) {
> +               if (int_status & WR_FIFO_EMPTY)
> +                       ret =3D pio_write(ctrl);
> +       } else {
> +               if (int_status & RESP_FIFO_RDY)
> +                       ret =3D pio_read(ctrl);

What if int_status & RESP_FIFO_RDY isn't set? Then 'ret' is never
assigned? Should have ret =3D IRQ_NONE up above I guess.

> +       }

And should the error interrupt bits be checked and printed if they
happen? We seem to unmask them, but then we don't really do anything
with them if they happen.

> +
> +       if (!ctrl->xfer.rem_bytes) {
> +               writel(0, ctrl->base + MSTR_INT_EN);
> +               spi_finalize_current_transfer(dev_get_drvdata(ctrl->dev));
> +       }
> +
> +       spin_unlock_irqrestore(&ctrl->lock, flags);
> +       return ret;
> +}
> +
> +static int qcom_qspi_probe(struct platform_device *pdev)
> +{
> +       int ret =3D 0;

Should be able to drop the assignment here. Hopefully compiler doesn't
complain.

> +       struct device *dev;
> +       struct resource *res;
> +       struct spi_master *master;
> +       struct qcom_qspi *ctrl;
> +
> +       dev =3D &pdev->dev;
> +
> +       master =3D spi_alloc_master(dev, sizeof(struct qcom_qspi));

sizeof(*ctrl) so we know what is being stored inside?

> +       if (!master) {
> +               dev_err(dev, "Failed to alloc spi master\n");

We don't need allocation error messages. Just return -ENOMEM here.

> +               return -ENOMEM;
> +       }
> +       platform_set_drvdata(pdev, master);
> +
> +       ctrl =3D spi_master_get_devdata(master);
> +
> +       spin_lock_init(&ctrl->lock);
> +       ctrl->dev =3D dev;
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       ctrl->base =3D devm_ioremap(dev, res->start, resource_size(res));
> +       if (IS_ERR(ctrl->base)) {
> +               ret =3D PTR_ERR(ctrl->base);
> +               dev_err(dev, "Failed to get base addr %d\n", ret);

Use devm_ioremap_resource()? And then drop this error print?

> +               goto exit_probe_master_put;
> +       }
> +
> +       ctrl->clks[QSPI_CLK_CORE].id =3D "core";
> +       ctrl->clks[QSPI_CLK_IFACE].id =3D "iface";
> +       ret =3D devm_clk_bulk_get(dev, QSPI_NUM_CLKS, ctrl->clks);
> +       if (ret)
> +               goto exit_probe_master_put;
> +
> +       ret =3D platform_get_irq(pdev, 0);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to get irq %d\n", ret);
> +               goto exit_probe_master_put;
> +       }
> +       ret =3D devm_request_irq(dev, ret, qcom_qspi_irq,
> +                       IRQF_TRIGGER_HIGH, dev_name(dev), ctrl);
> +       if (ret) {
> +               dev_err(dev, "Failed to request irq %d\n", ret);
> +               goto exit_probe_master_put;
> +       }
> +
> +       master->max_speed_hz =3D 300000000;
> +       master->num_chipselect =3D QSPI_NUM_CS;
> +       master->bus_num =3D pdev->id;

Can this come from DT aliases? I've never thought about qspi and
"regular" spi being in the same spi bus numbering system, but I suppose
that will happen now and we need to make sure that qspi numbers start
after the regular ones?

> +       master->dev.of_node =3D pdev->dev.of_node;
> +       master->mode_bits =3D SPI_MODE_0 |
> +                           SPI_TX_DUAL | SPI_RX_DUAL |
> +                           SPI_TX_QUAD | SPI_RX_QUAD;
> +       master->flags =3D SPI_MASTER_HALF_DUPLEX;
> +       master->prepare_message =3D qcom_qspi_prepare_message;
> +       master->transfer_one =3D qcom_qspi_transfer_one;
> +       master->handle_err =3D qcom_qspi_handle_err;
> +       master->auto_runtime_pm =3D true;
> +
> +       pm_runtime_enable(dev);
> +
> +       ret =3D spi_register_master(master);
> +       if (ret)
> +               goto exit_probe_runtime_disable;
> +
> +       return 0;

Or =


	if (!ret)
		return 0;
	=

> +
> +exit_probe_runtime_disable:

And then drop this label.

> +       pm_runtime_disable(dev);
> +
> +exit_probe_master_put:
> +       spi_master_put(master);
> +
> +       return ret;
> +}
