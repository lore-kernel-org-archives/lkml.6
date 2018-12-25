Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B68C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 11:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C83721848
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 11:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M4pP0QIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbeLYLt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 06:49:58 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34432 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeLYLt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 06:49:57 -0500
Received: by mail-qt1-f193.google.com with SMTP id r14so14983304qtp.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 03:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WiVihOi93OQUqXo3fc+vlEJ1vAm/qgiPC9qC4IJD4Wk=;
        b=M4pP0QIfDjVCFodrHwVxLfly7XY02UJmFnQMUzYK03ckQHt3ht/8kaGmlDQy4kZJmi
         B8LrNEU/9z/OvJswOMc7Lhk8gU7kpuKTXsc0AlOTzh0xcTp5IDfMnabhybLLk6sOy/G+
         YoTg7uXEnby4L2IHAL8KOSWvM5n0sw1cxrYaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WiVihOi93OQUqXo3fc+vlEJ1vAm/qgiPC9qC4IJD4Wk=;
        b=cF46aIbgtS1BccODxcWHH1xOMpJ6i6VYqq+07CkiBk+N/ZPZJhDk8cSH0N0sM37nFA
         p6HwnP3RpkS2xRz+FM1tknmQEzL04Va6BjHSIEYtGdEGTgW1Hpko2jbH5i23ewSChQjV
         q/6DFJd8gHWqPe4mhtnuFGOKeVN8+S0/+k6pmywLRqx3ZD2SUf7XZs1GGjJ5YAkMwqVl
         xuWmFpx5En58SHn83xVmXgH6GS1UIH8vTWGPLiSvnhOgvwiO1uQRWFChtvnMmVIw0fk4
         FztX4ud881GEd8GVCV+zk93Fl8DK/GiwJRyYWlvndIYpr2/D2gSztZ2AeMB59ZsR67DE
         L9zw==
X-Gm-Message-State: AA+aEWYniJ73Iu81ljVCndNqW7yMozQTEB6HnbSprlda+IpvAA3whOhD
        73oGARSRqvqZzTaSzJW0x6F5034QRWKkip1sO5VzzQ==
X-Google-Smtp-Source: AFSGD/XMD3fuMfAoWNRTAR5OdXP7egjWLMbxFAfNlM8coaGAIvy4B73/inrBhmExa8xfJpA/ItIxa14FQmjLpsiJg08=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr15302538qts.144.1545738595288;
 Tue, 25 Dec 2018 03:49:55 -0800 (PST)
MIME-Version: 1.0
References: <1545397111-24183-1-git-send-email-qii.wang@mediatek.com> <1545397111-24183-5-git-send-email-qii.wang@mediatek.com>
In-Reply-To: <1545397111-24183-5-git-send-email-qii.wang@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 25 Dec 2018 19:49:43 +0800
Message-ID: <CANMq1KBbYcn90j4MX2B9qu4Uon1pesGs_jki+snFfDkn9r+5UA@mail.gmail.com>
Subject: Re: [PATCH 4/6] i2c: mediatek: Add offsets array for new i2c registers
To:     qii wang <qii.wang@mediatek.com>
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Leilk Liu <leilk.liu@mediatek.com>, ryder.lee@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 8:59 PM qii wang <qii.wang@mediatek.com> wrote:
>
> New i2c registers would have different offsets, so we use different
> offsets array to distinguish different i2c registers version.
>
> Signed-off-by: qii wang <qii.wang@mediatek.com>

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/i2c/busses/i2c-mt65xx.c |  163 +++++++++++++++++++++++++--------------
>  1 file changed, 104 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> index 660de1e..428ac99 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -106,34 +106,62 @@ enum mtk_trans_op {
>  };
>
>  enum I2C_REGS_OFFSET {
> -       OFFSET_DATA_PORT = 0x0,
> -       OFFSET_SLAVE_ADDR = 0x04,
> -       OFFSET_INTR_MASK = 0x08,
> -       OFFSET_INTR_STAT = 0x0c,
> -       OFFSET_CONTROL = 0x10,
> -       OFFSET_TRANSFER_LEN = 0x14,
> -       OFFSET_TRANSAC_LEN = 0x18,
> -       OFFSET_DELAY_LEN = 0x1c,
> -       OFFSET_TIMING = 0x20,
> -       OFFSET_START = 0x24,
> -       OFFSET_EXT_CONF = 0x28,
> -       OFFSET_FIFO_STAT = 0x30,
> -       OFFSET_FIFO_THRESH = 0x34,
> -       OFFSET_FIFO_ADDR_CLR = 0x38,
> -       OFFSET_IO_CONFIG = 0x40,
> -       OFFSET_RSV_DEBUG = 0x44,
> -       OFFSET_HS = 0x48,
> -       OFFSET_SOFTRESET = 0x50,
> -       OFFSET_DCM_EN = 0x54,
> -       OFFSET_PATH_DIR = 0x60,
> -       OFFSET_DEBUGSTAT = 0x64,
> -       OFFSET_DEBUGCTRL = 0x68,
> -       OFFSET_TRANSFER_LEN_AUX = 0x6c,
> -       OFFSET_CLOCK_DIV = 0x70,
> +       OFFSET_DATA_PORT,
> +       OFFSET_SLAVE_ADDR,
> +       OFFSET_INTR_MASK,
> +       OFFSET_INTR_STAT,
> +       OFFSET_CONTROL,
> +       OFFSET_TRANSFER_LEN,
> +       OFFSET_TRANSAC_LEN,
> +       OFFSET_DELAY_LEN,
> +       OFFSET_TIMING,
> +       OFFSET_START,
> +       OFFSET_EXT_CONF,
> +       OFFSET_FIFO_STAT,
> +       OFFSET_FIFO_THRESH,
> +       OFFSET_FIFO_ADDR_CLR,
> +       OFFSET_IO_CONFIG,
> +       OFFSET_RSV_DEBUG,
> +       OFFSET_HS,
> +       OFFSET_SOFTRESET,
> +       OFFSET_DCM_EN,
> +       OFFSET_PATH_DIR,
> +       OFFSET_DEBUGSTAT,
> +       OFFSET_DEBUGCTRL,
> +       OFFSET_TRANSFER_LEN_AUX,
> +       OFFSET_CLOCK_DIV,
> +};
> +
> +static const u16 mt_i2c_regs_v1[] = {
> +       [OFFSET_DATA_PORT] = 0x0,
> +       [OFFSET_SLAVE_ADDR] = 0x4,
> +       [OFFSET_INTR_MASK] = 0x8,
> +       [OFFSET_INTR_STAT] = 0xc,
> +       [OFFSET_CONTROL] = 0x10,
> +       [OFFSET_TRANSFER_LEN] = 0x14,
> +       [OFFSET_TRANSAC_LEN] = 0x18,
> +       [OFFSET_DELAY_LEN] = 0x1c,
> +       [OFFSET_TIMING] = 0x20,
> +       [OFFSET_START] = 0x24,
> +       [OFFSET_EXT_CONF] = 0x28,
> +       [OFFSET_FIFO_STAT] = 0x30,
> +       [OFFSET_FIFO_THRESH] = 0x34,
> +       [OFFSET_FIFO_ADDR_CLR] = 0x38,
> +       [OFFSET_IO_CONFIG] = 0x40,
> +       [OFFSET_RSV_DEBUG] = 0x44,
> +       [OFFSET_HS] = 0x48,
> +       [OFFSET_SOFTRESET] = 0x50,
> +       [OFFSET_DCM_EN] = 0x54,
> +       [OFFSET_PATH_DIR] = 0x60,
> +       [OFFSET_DEBUGSTAT] = 0x64,
> +       [OFFSET_DEBUGCTRL] = 0x68,
> +       [OFFSET_TRANSFER_LEN_AUX] = 0x6c,
> +       [OFFSET_CLOCK_DIV] = 0x70,
>  };
>
>  struct mtk_i2c_compatible {
>         const struct i2c_adapter_quirks *quirks;
> +       const u16 *regs;
>         unsigned char pmic_i2c: 1;
>         unsigned char dcm: 1;
>         unsigned char auto_restart: 1;
> @@ -181,6 +209,7 @@ struct mtk_i2c {
>  };
>
>  static const struct mtk_i2c_compatible mt2712_compat = {
> +       .regs = mt_i2c_regs_v1,
>         .pmic_i2c = 0,
>         .dcm = 1,
>         .auto_restart = 1,
> @@ -191,6 +220,7 @@ struct mtk_i2c {
>
>  static const struct mtk_i2c_compatible mt6577_compat = {
>         .quirks = &mt6577_i2c_quirks,
> +       .regs = mt_i2c_regs_v1,
>         .pmic_i2c = 0,
>         .dcm = 1,
>         .auto_restart = 0,
> @@ -201,6 +231,7 @@ struct mtk_i2c {
>
>  static const struct mtk_i2c_compatible mt6589_compat = {
>         .quirks = &mt6577_i2c_quirks,
> +       .regs = mt_i2c_regs_v1,
>         .pmic_i2c = 1,
>         .dcm = 0,
>         .auto_restart = 0,
> @@ -211,6 +242,7 @@ struct mtk_i2c {
>
>  static const struct mtk_i2c_compatible mt7622_compat = {
>         .quirks = &mt7622_i2c_quirks,
> +       .regs = mt_i2c_regs_v1,
>         .pmic_i2c = 0,
>         .dcm = 1,
>         .auto_restart = 1,
> @@ -220,6 +252,7 @@ struct mtk_i2c {
>  };
>
>  static const struct mtk_i2c_compatible mt8173_compat = {
> +       .regs = mt_i2c_regs_v1,
>         .pmic_i2c = 0,
>         .dcm = 1,
>         .auto_restart = 1,
> @@ -238,6 +271,17 @@ struct mtk_i2c {
>  };
>  MODULE_DEVICE_TABLE(of, mtk_i2c_of_match);
>
> +static u16 mtk_i2c_readw(struct mtk_i2c *i2c, enum I2C_REGS_OFFSET reg)
> +{
> +       return readw(i2c->base + i2c->dev_comp->regs[reg]);
> +}
> +
> +static void mtk_i2c_writew(struct mtk_i2c *i2c, u16 val,
> +                          enum I2C_REGS_OFFSET reg)
> +{
> +       writew(val, i2c->base + i2c->dev_comp->regs[reg]);
> +}
> +
>  static int mtk_i2c_clock_enable(struct mtk_i2c *i2c)
>  {
>         int ret;
> @@ -278,31 +322,31 @@ static void mtk_i2c_init_hw(struct mtk_i2c *i2c)
>  {
>         u16 control_reg;
>
> -       writew(I2C_SOFT_RST, i2c->base + OFFSET_SOFTRESET);
> +       mtk_i2c_writew(i2c, I2C_SOFT_RST, OFFSET_SOFTRESET);
>
>         /* Set ioconfig */
>         if (i2c->use_push_pull)
> -               writew(I2C_IO_CONFIG_PUSH_PULL, i2c->base + OFFSET_IO_CONFIG);
> +               mtk_i2c_writew(i2c, I2C_IO_CONFIG_PUSH_PULL, OFFSET_IO_CONFIG);
>         else
> -               writew(I2C_IO_CONFIG_OPEN_DRAIN, i2c->base + OFFSET_IO_CONFIG);
> +               mtk_i2c_writew(i2c, I2C_IO_CONFIG_OPEN_DRAIN, OFFSET_IO_CONFIG);
>
>         if (i2c->dev_comp->dcm)
> -               writew(I2C_DCM_DISABLE, i2c->base + OFFSET_DCM_EN);
> +               mtk_i2c_writew(i2c, I2C_DCM_DISABLE, OFFSET_DCM_EN);
>
>         if (i2c->dev_comp->timing_adjust)
> -               writew(I2C_DEFAULT_CLK_DIV - 1, i2c->base + OFFSET_CLOCK_DIV);
> +               mtk_i2c_writew(i2c, I2C_DEFAULT_CLK_DIV - 1, OFFSET_CLOCK_DIV);
>
> -       writew(i2c->timing_reg, i2c->base + OFFSET_TIMING);
> -       writew(i2c->high_speed_reg, i2c->base + OFFSET_HS);
> +       mtk_i2c_writew(i2c, i2c->timing_reg, OFFSET_TIMING);
> +       mtk_i2c_writew(i2c, i2c->high_speed_reg, OFFSET_HS);
>
>         /* If use i2c pin from PMIC mt6397 side, need set PATH_DIR first */
>         if (i2c->have_pmic)
> -               writew(I2C_CONTROL_WRAPPER, i2c->base + OFFSET_PATH_DIR);
> +               mtk_i2c_writew(i2c, I2C_CONTROL_WRAPPER, OFFSET_PATH_DIR);
>
>         control_reg = I2C_CONTROL_ACKERR_DET_EN |
>                       I2C_CONTROL_CLK_EXT_EN | I2C_CONTROL_DMA_EN;
> -       writew(control_reg, i2c->base + OFFSET_CONTROL);
> -       writew(I2C_DELAY_LEN, i2c->base + OFFSET_DELAY_LEN);
> +       mtk_i2c_writew(i2c, control_reg, OFFSET_CONTROL);
> +       mtk_i2c_writew(i2c, I2C_DELAY_LEN, OFFSET_DELAY_LEN);
>
>         writel(I2C_DMA_HARD_RST, i2c->pdmabase + OFFSET_RST);
>         udelay(50);
> @@ -454,7 +498,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>
>         reinit_completion(&i2c->msg_complete);
>
> -       control_reg = readw(i2c->base + OFFSET_CONTROL) &
> +       control_reg = mtk_i2c_readw(i2c, OFFSET_CONTROL) &
>                         ~(I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS);
>         if ((i2c->speed_hz > MAX_FS_MODE_SPEED) || (left_num >= 1))
>                 control_reg |= I2C_CONTROL_RS;
> @@ -462,40 +506,41 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>         if (i2c->op == I2C_MASTER_WRRD)
>                 control_reg |= I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS;
>
> -       writew(control_reg, i2c->base + OFFSET_CONTROL);
> +       mtk_i2c_writew(i2c, control_reg, OFFSET_CONTROL);
>
>         /* set start condition */
>         if (i2c->speed_hz <= I2C_DEFAULT_SPEED)
> -               writew(I2C_ST_START_CON, i2c->base + OFFSET_EXT_CONF);
> +               mtk_i2c_writew(i2c, I2C_ST_START_CON, OFFSET_EXT_CONF);
>         else
> -               writew(I2C_FS_START_CON, i2c->base + OFFSET_EXT_CONF);
> +               mtk_i2c_writew(i2c, I2C_FS_START_CON, OFFSET_EXT_CONF);
>
>         addr_reg = i2c_8bit_addr_from_msg(msgs);
> -       writew(addr_reg, i2c->base + OFFSET_SLAVE_ADDR);
> +       mtk_i2c_writew(i2c, addr_reg, OFFSET_SLAVE_ADDR);
>
>         /* Clear interrupt status */
> -       writew(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> -              I2C_TRANSAC_COMP, i2c->base + OFFSET_INTR_STAT);
> -       writew(I2C_FIFO_ADDR_CLR, i2c->base + OFFSET_FIFO_ADDR_CLR);
> +       mtk_i2c_writew(i2c, restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> +              I2C_TRANSAC_COMP, OFFSET_INTR_STAT);
> +
> +       mtk_i2c_writew(i2c, I2C_FIFO_ADDR_CLR, OFFSET_FIFO_ADDR_CLR);
>
>         /* Enable interrupt */
> -       writew(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> -              I2C_TRANSAC_COMP, i2c->base + OFFSET_INTR_MASK);
> +       mtk_i2c_writew(i2c, restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> +              I2C_TRANSAC_COMP, OFFSET_INTR_MASK);
>
>         /* Set transfer and transaction len */
>         if (i2c->op == I2C_MASTER_WRRD) {
>                 if (i2c->dev_comp->aux_len_reg) {
> -                       writew(msgs->len, i2c->base + OFFSET_TRANSFER_LEN);
> -                       writew((msgs + 1)->len, i2c->base +
> -                              OFFSET_TRANSFER_LEN_AUX);
> +                       mtk_i2c_writew(i2c, msgs->len, OFFSET_TRANSFER_LEN);
> +                       mtk_i2c_writew(i2c, (msgs + 1)->len,
> +                                           OFFSET_TRANSFER_LEN_AUX);
>                 } else {
> -                       writew(msgs->len | ((msgs + 1)->len) << 8,
> -                              i2c->base + OFFSET_TRANSFER_LEN);
> +                       mtk_i2c_writew(i2c, msgs->len | ((msgs + 1)->len) << 8,
> +                                           OFFSET_TRANSFER_LEN);
>                 }
> -               writew(I2C_WRRD_TRANAC_VALUE, i2c->base + OFFSET_TRANSAC_LEN);
> +               mtk_i2c_writew(i2c, I2C_WRRD_TRANAC_VALUE, OFFSET_TRANSAC_LEN);
>         } else {
> -               writew(msgs->len, i2c->base + OFFSET_TRANSFER_LEN);
> -               writew(num, i2c->base + OFFSET_TRANSAC_LEN);
> +               mtk_i2c_writew(i2c, msgs->len, OFFSET_TRANSFER_LEN);
> +               mtk_i2c_writew(i2c, num, OFFSET_TRANSAC_LEN);
>         }
>
>         /* Prepare buffer data to start transfer */
> @@ -607,14 +652,14 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>                 if (left_num >= 1)
>                         start_reg |= I2C_RS_MUL_CNFG;
>         }
> -       writew(start_reg, i2c->base + OFFSET_START);
> +       mtk_i2c_writew(i2c, start_reg, OFFSET_START);
>
>         ret = wait_for_completion_timeout(&i2c->msg_complete,
>                                           i2c->adap.timeout);
>
>         /* Clear interrupt mask */
> -       writew(~(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> -              I2C_TRANSAC_COMP), i2c->base + OFFSET_INTR_MASK);
> +       mtk_i2c_writew(i2c, ~(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> +              I2C_TRANSAC_COMP), OFFSET_INTR_MASK);
>
>         if (i2c->op == I2C_MASTER_WR) {
>                 dma_unmap_single(i2c->dev, wpaddr,
> @@ -724,8 +769,8 @@ static irqreturn_t mtk_i2c_irq(int irqno, void *dev_id)
>         if (i2c->auto_restart)
>                 restart_flag = I2C_RS_TRANSFER;
>
> -       intr_stat = readw(i2c->base + OFFSET_INTR_STAT);
> -       writew(intr_stat, i2c->base + OFFSET_INTR_STAT);
> +       intr_stat = mtk_i2c_readw(i2c, OFFSET_INTR_STAT);
> +       mtk_i2c_writew(i2c, intr_stat, OFFSET_INTR_STAT);
>
>         /*
>          * when occurs ack error, i2c controller generate two interrupts
> @@ -737,8 +782,8 @@ static irqreturn_t mtk_i2c_irq(int irqno, void *dev_id)
>         if (i2c->ignore_restart_irq && (i2c->irq_stat & restart_flag)) {
>                 i2c->ignore_restart_irq = false;
>                 i2c->irq_stat = 0;
> -               writew(I2C_RS_MUL_CNFG | I2C_RS_MUL_TRIG | I2C_TRANSAC_START,
> -                      i2c->base + OFFSET_START);
> +               mtk_i2c_writew(i2c, I2C_RS_MUL_CNFG | I2C_RS_MUL_TRIG |
> +                                   I2C_TRANSAC_START, OFFSET_START);
>         } else {
>                 if (i2c->irq_stat & (I2C_TRANSAC_COMP | restart_flag))
>                         complete(&i2c->msg_complete);
> --
> 1.7.9.5
>
