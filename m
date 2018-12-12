Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D829C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E4F20879
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E4F20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeLLHSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:18:49 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:56688 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726242AbeLLHSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 02:18:49 -0500
X-UUID: 2891aadb149f4aceb784e24f85f22ae2-20181212
X-UUID: 2891aadb149f4aceb784e24f85f22ae2-20181212
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 372185536; Wed, 12 Dec 2018 15:18:20 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 12 Dec
 2018 15:18:19 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 12 Dec 2018 15:18:18 +0800
Message-ID: <1544599098.11699.24.camel@mhfsdcap03>
Subject: Re: [PATCH 5/5] i2c: mediatek: Add i2c compatible for MediaTek
 MT8183
From:   Qii Wang <qii.wang@mediatek.com>
To:     Sean Wang <sean.wang@kernel.org>
CC:     <wsa@the-dreams.de>, <devicetree@vger.kernel.org>,
        <ryder.lee@mediatek.com>, <srv_heupstream@mediatek.com>,
        <leilk.liu@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 12 Dec 2018 15:18:18 +0800
In-Reply-To: <CAGp9LzqsnF-mvyggw3XMxcNnjvTVgAbiK29413cS0-fF8n57og@mail.gmail.com>
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
         <1543843974-4054-6-git-send-email-qii.wang@mediatek.com>
         <CAGp9LzqsnF-mvyggw3XMxcNnjvTVgAbiK29413cS0-fF8n57og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-03 at 21:49 -0800, Sean Wang wrote:
> <qii.wang@mediatek.com> 於 2018年12月3日 週一 上午5:34寫道：
> >
> > From: qii wang <qii.wang@mediatek.com>
> >
> > Add i2c compatible for MT8183. Compare to 2712 i2c controller, MT8183 has
> > different registers, offsets, clock, and multi-user function.
> >
> > Signed-off-by: qii wang <qii.wang@mediatek.com>
> > ---
> >  drivers/i2c/busses/i2c-mt65xx.c |  136 +++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 130 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> > index 428ac99..6b979ab 100644
> > --- a/drivers/i2c/busses/i2c-mt65xx.c
> > +++ b/drivers/i2c/busses/i2c-mt65xx.c
> > @@ -35,17 +35,23 @@
> >  #include <linux/slab.h>
> >
> >  #define I2C_RS_TRANSFER                        (1 << 4)
> > +#define I2C_ARB_LOST                   (1 << 3)
> 
> it seems no one refers to the macro in the patch so it should be
> better to be removed
> 

ok, I miss it, I will use it in the next patch.

> >  #define I2C_HS_NACKERR                 (1 << 2)
> >  #define I2C_ACKERR                     (1 << 1)
> >  #define I2C_TRANSAC_COMP               (1 << 0)
> >  #define I2C_TRANSAC_START              (1 << 0)
> > +#define I2C_RESUME_ARBIT               (1 << 1)
> >  #define I2C_RS_MUL_CNFG                        (1 << 15)
> >  #define I2C_RS_MUL_TRIG                        (1 << 14)
> > +#define I2C_HS_TIME_EN                 (1 << 7)
> >  #define I2C_DCM_DISABLE                        0x0000
> >  #define I2C_IO_CONFIG_OPEN_DRAIN       0x0003
> >  #define I2C_IO_CONFIG_PUSH_PULL                0x0000
> >  #define I2C_SOFT_RST                   0x0001
> >  #define I2C_FIFO_ADDR_CLR              0x0001
> > +#define I2C_FIFO_ADDR_CLRH             0x0002
> > +#define I2C_FIFO_ADDR_CLR_MCH          0x0004
> > +#define I2C_HFIFO_DATA                 0x8208
> >  #define I2C_DELAY_LEN                  0x0002
> >  #define I2C_ST_START_CON               0x8001
> >  #define I2C_FS_START_CON               0x1800
> > @@ -76,6 +82,8 @@
> >  #define I2C_CONTROL_DIR_CHANGE          (0x1 << 4)
> >  #define I2C_CONTROL_ACKERR_DET_EN       (0x1 << 5)
> >  #define I2C_CONTROL_TRANSFER_LEN_CHANGE (0x1 << 6)
> > +#define I2C_CONTROL_DMAACK_EN           (0x1 << 8)
> > +#define I2C_CONTROL_ASYNC_MODE          (0x1 << 9)
> >  #define I2C_CONTROL_WRAPPER             (0x1 << 0)
> >
> >  #define I2C_DRV_NAME           "i2c-mt65xx"
> > @@ -130,6 +138,15 @@ enum I2C_REGS_OFFSET {
> >         OFFSET_DEBUGCTRL,
> >         OFFSET_TRANSFER_LEN_AUX,
> >         OFFSET_CLOCK_DIV,
> > +       /* MT8183 only regs */
> > +       OFFSET_LTIMING,
> > +       OFFSET_DATA_TIMING,
> > +       OFFSET_MCU_INTR,
> > +       OFFSET_HW_TIMEOUT,
> > +       OFFSET_HFIFO_DATA,
> > +       OFFSET_HFIFO_STAT,
> > +       OFFSET_MULTI_DMA,
> > +       OFFSET_ROLLBACK,
> >  };
> >
> >  static const u16 mt_i2c_regs_v1[] = {
> > @@ -159,6 +176,39 @@ enum I2C_REGS_OFFSET {
> >         [OFFSET_CLOCK_DIV] = 0x70,
> >  };
> >
> > +static const u16 mt_i2c_regs_v2[] = {
> > +       [OFFSET_DATA_PORT] = 0x0,
> > +       [OFFSET_SLAVE_ADDR] = 0x4,
> > +       [OFFSET_INTR_MASK] = 0x8,
> > +       [OFFSET_INTR_STAT] = 0xc,
> > +       [OFFSET_CONTROL] = 0x10,
> > +       [OFFSET_TRANSFER_LEN] = 0x14,
> > +       [OFFSET_TRANSAC_LEN] = 0x18,
> > +       [OFFSET_DELAY_LEN] = 0x1c,
> > +       [OFFSET_TIMING] = 0x20,
> > +       [OFFSET_START] = 0x24,
> > +       [OFFSET_EXT_CONF] = 0x28,
> > +       [OFFSET_LTIMING] = 0x2c,
> > +       [OFFSET_HS] = 0x30,
> > +       [OFFSET_IO_CONFIG] = 0x34,
> > +       [OFFSET_FIFO_ADDR_CLR] = 0x38,
> > +       [OFFSET_DATA_TIMING] = 0x3c,
> > +       [OFFSET_MCU_INTR] = 0x40,
> > +       [OFFSET_TRANSFER_LEN_AUX] = 0x44,
> > +       [OFFSET_CLOCK_DIV] = 0x48,
> > +       [OFFSET_HW_TIMEOUT] = 0x4c,
> > +       [OFFSET_SOFTRESET] = 0x50,
> > +       [OFFSET_HFIFO_DATA] = 0x70,
> > +       [OFFSET_DEBUGSTAT] = 0xe0,
> > +       [OFFSET_DEBUGCTRL] = 0xe8,
> > +       [OFFSET_FIFO_STAT] = 0xf4,
> > +       [OFFSET_FIFO_THRESH] = 0xf8,
> > +       [OFFSET_HFIFO_STAT] = 0xfc,
> > +       [OFFSET_DCM_EN] = 0xf88,
> > +       [OFFSET_MULTI_DMA] = 0xf8c,
> > +       [OFFSET_ROLLBACK] = 0xf98,
> > +};
> > +
> >  struct mtk_i2c_compatible {
> >         const struct i2c_adapter_quirks *quirks;
> >         const u16 *regs;
> > @@ -168,6 +218,7 @@ struct mtk_i2c_compatible {
> >         unsigned char aux_len_reg: 1;
> >         unsigned char support_33bits: 1;
> >         unsigned char timing_adjust: 1;
> > +       unsigned char dma_sync: 1;
> >  };
> >
> >  struct mtk_i2c {
> > @@ -181,8 +232,11 @@ struct mtk_i2c {
> >         struct clk *clk_main;           /* main clock for i2c bus */
> >         struct clk *clk_dma;            /* DMA clock for i2c via DMA */
> >         struct clk *clk_pmic;           /* PMIC clock for i2c from PMIC */
> > +       struct clk *clk_arb;            /* Arbitrator clock for i2c */
> >         bool have_pmic;                 /* can use i2c pins from PMIC */
> >         bool use_push_pull;             /* IO config push-pull mode */
> > +       bool share_i3c;                 /* share i3c IP*/
> > +       u32 ch_offset;                  /* i2c multi-user channel offset */
> >
> >         u16 irq_stat;                   /* interrupt status */
> >         unsigned int clk_src_div;
> > @@ -190,6 +244,7 @@ struct mtk_i2c {
> >         enum mtk_trans_op op;
> >         u16 timing_reg;
> >         u16 high_speed_reg;
> > +       u16 ltiming_reg;
> >         unsigned char auto_restart;
> >         bool ignore_restart_irq;
> >         const struct mtk_i2c_compatible *dev_comp;
> > @@ -216,6 +271,7 @@ struct mtk_i2c {
> >         .aux_len_reg = 1,
> >         .support_33bits = 1,
> >         .timing_adjust = 1,
> > +       .dma_sync = 0,
> >  };
> >
> >  static const struct mtk_i2c_compatible mt6577_compat = {
> > @@ -227,6 +283,7 @@ struct mtk_i2c {
> >         .aux_len_reg = 0,
> >         .support_33bits = 0,
> >         .timing_adjust = 0,
> > +       .dma_sync = 0,
> >  };
> >
> >  static const struct mtk_i2c_compatible mt6589_compat = {
> > @@ -238,6 +295,7 @@ struct mtk_i2c {
> >         .aux_len_reg = 0,
> >         .support_33bits = 0,
> >         .timing_adjust = 0,
> > +       .dma_sync = 0,
> >  };
> >
> >  static const struct mtk_i2c_compatible mt7622_compat = {
> > @@ -249,6 +307,7 @@ struct mtk_i2c {
> >         .aux_len_reg = 1,
> >         .support_33bits = 0,
> >         .timing_adjust = 0,
> > +       .dma_sync = 0,
> >  };
> >
> >  static const struct mtk_i2c_compatible mt8173_compat = {
> > @@ -259,6 +318,18 @@ struct mtk_i2c {
> >         .aux_len_reg = 1,
> >         .support_33bits = 1,
> >         .timing_adjust = 0,
> > +       .dma_sync = 0,
> > +};
> > +
> > +static const struct mtk_i2c_compatible mt8183_compat = {
> > +       .regs = mt_i2c_regs_v2,
> > +       .pmic_i2c = 0,
> > +       .dcm = 0,
> > +       .auto_restart = 1,
> > +       .aux_len_reg = 1,
> > +       .support_33bits = 1,
> > +       .timing_adjust = 1,
> > +       .dma_sync = 1,
> >  };
> >
> >  static const struct of_device_id mtk_i2c_of_match[] = {
> > @@ -267,19 +338,20 @@ struct mtk_i2c {
> >         { .compatible = "mediatek,mt6589-i2c", .data = &mt6589_compat },
> >         { .compatible = "mediatek,mt7622-i2c", .data = &mt7622_compat },
> >         { .compatible = "mediatek,mt8173-i2c", .data = &mt8173_compat },
> > +       { .compatible = "mediatek,mt8183-i2c", .data = &mt8183_compat },
> >         {}
> >  };
> >  MODULE_DEVICE_TABLE(of, mtk_i2c_of_match);
> >
> >  static u16 mtk_i2c_readw(struct mtk_i2c *i2c, enum I2C_REGS_OFFSET reg)
> >  {
> > -       return readw(i2c->base + i2c->dev_comp->regs[reg]);
> > +       return readw(i2c->base + i2c->ch_offset + i2c->dev_comp->regs[reg]);
> >  }
> >
> >  static void mtk_i2c_writew(struct mtk_i2c *i2c, u16 val,
> >                            enum I2C_REGS_OFFSET reg)
> >  {
> > -       writew(val, i2c->base + i2c->dev_comp->regs[reg]);
> > +       writew(val, i2c->base + i2c->ch_offset + i2c->dev_comp->regs[reg]);
> >  }
> >
> >  static int mtk_i2c_clock_enable(struct mtk_i2c *i2c)
> > @@ -299,8 +371,18 @@ static int mtk_i2c_clock_enable(struct mtk_i2c *i2c)
> >                 if (ret)
> >                         goto err_pmic;
> >         }
> > +
> > +       if (i2c->clk_arb) {
> > +               ret = clk_prepare_enable(i2c->clk_arb);
> > +               if (ret)
> > +                       goto err_arb;
> > +       }
> > +
> >         return 0;
> >
> > +err_arb:
> > +       if (i2c->have_pmic)
> > +               clk_disable_unprepare(i2c->clk_pmic);
> >  err_pmic:
> >         clk_disable_unprepare(i2c->clk_main);
> >  err_main:
> > @@ -311,6 +393,9 @@ static int mtk_i2c_clock_enable(struct mtk_i2c *i2c)
> >
> >  static void mtk_i2c_clock_disable(struct mtk_i2c *i2c)
> >  {
> > +       if (i2c->clk_arb)
> > +               clk_disable_unprepare(i2c->clk_arb);
> > +
> >         if (i2c->have_pmic)
> >                 clk_disable_unprepare(i2c->clk_pmic);
> >
> > @@ -333,11 +418,23 @@ static void mtk_i2c_init_hw(struct mtk_i2c *i2c)
> >         if (i2c->dev_comp->dcm)
> >                 mtk_i2c_writew(i2c, I2C_DCM_DISABLE, OFFSET_DCM_EN);
> >
> > -       if (i2c->dev_comp->timing_adjust)
> > +       if (i2c->ch_offset)
> > +               writew(I2C_RESUME_ARBIT, i2c->base +
> > +                                        i2c->dev_comp->regs[OFFSET_START]);
> > +
> > +       if (i2c->dev_comp->timing_adjust && i2c->share_i3c) {
> > +               mtk_i2c_writew(i2c, (I2C_DEFAULT_CLK_DIV - 1) |
> > +                                   (I2C_DEFAULT_CLK_DIV - 1) << 8,
> > +                                   OFFSET_CLOCK_DIV);
> > +               i2c->high_speed_reg |= I2C_HS_TIME_EN;
> > +       } else {
> >                 mtk_i2c_writew(i2c, I2C_DEFAULT_CLK_DIV - 1, OFFSET_CLOCK_DIV);
> > +       }
> >
> >         mtk_i2c_writew(i2c, i2c->timing_reg, OFFSET_TIMING);
> >         mtk_i2c_writew(i2c, i2c->high_speed_reg, OFFSET_HS);
> > +       if (i2c->dev_comp->regs == mt_i2c_regs_v2)
> > +               mtk_i2c_writew(i2c, i2c->ltiming_reg, OFFSET_LTIMING);
> >
> >         /* If use i2c pin from PMIC mt6397 side, need set PATH_DIR first */
> >         if (i2c->have_pmic)
> > @@ -345,6 +442,9 @@ static void mtk_i2c_init_hw(struct mtk_i2c *i2c)
> >
> >         control_reg = I2C_CONTROL_ACKERR_DET_EN |
> >                       I2C_CONTROL_CLK_EXT_EN | I2C_CONTROL_DMA_EN;
> > +       if (i2c->dev_comp->dma_sync)
> > +               control_reg |= I2C_CONTROL_DMAACK_EN | I2C_CONTROL_ASYNC_MODE;
> > +
> >         mtk_i2c_writew(i2c, control_reg, OFFSET_CONTROL);
> >         mtk_i2c_writew(i2c, I2C_DELAY_LEN, OFFSET_DELAY_LEN);
> >
> > @@ -434,6 +534,8 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
> >         unsigned int clk_src;
> >         unsigned int step_cnt;
> >         unsigned int sample_cnt;
> > +       unsigned int l_step_cnt;
> > +       unsigned int l_sample_cnt;
> >         unsigned int target_speed;
> >         int ret;
> >
> > @@ -443,11 +545,11 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
> >         if (target_speed > MAX_FS_MODE_SPEED) {
> >                 /* Set master code speed register */
> >                 ret = mtk_i2c_calculate_speed(i2c, clk_src, MAX_FS_MODE_SPEED,
> > -                                             &step_cnt, &sample_cnt);
> > +                                             &l_step_cnt, &l_sample_cnt);
> >                 if (ret < 0)
> >                         return ret;
> >
> > -               i2c->timing_reg = (sample_cnt << 8) | step_cnt;
> > +               i2c->timing_reg = (l_sample_cnt << 8) | l_step_cnt;
> >
> >                 /* Set the high speed mode register */
> >                 ret = mtk_i2c_calculate_speed(i2c, clk_src, target_speed,
> > @@ -457,6 +559,8 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
> >
> >                 i2c->high_speed_reg = I2C_TIME_DEFAULT_VALUE |
> >                         (sample_cnt << 12) | (step_cnt << 8);
> > +               i2c->ltiming_reg = (l_sample_cnt << 6) | l_step_cnt |
> > +                                  (sample_cnt << 12) | (step_cnt << 9);
> >         } else {
> >                 ret = mtk_i2c_calculate_speed(i2c, clk_src, target_speed,
> >                                               &step_cnt, &sample_cnt);
> > @@ -467,6 +571,8 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
> >
> >                 /* Disable the high speed transaction */
> >                 i2c->high_speed_reg = I2C_TIME_CLR_VALUE;
> > +
> > +               i2c->ltiming_reg = (sample_cnt << 6) | step_cnt;
> >         }
> >
> >         return 0;
> > @@ -483,6 +589,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
> >         u16 addr_reg;
> >         u16 start_reg;
> >         u16 control_reg;
> > +       u16 fifo_clr_reg;
> >         u16 restart_flag = 0;
> >         u32 reg_4g_mode;
> >         u8 *dma_rd_buf = NULL;
> > @@ -521,7 +628,15 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
> >         mtk_i2c_writew(i2c, restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> >                I2C_TRANSAC_COMP, OFFSET_INTR_STAT);
> >
> > -       mtk_i2c_writew(i2c, I2C_FIFO_ADDR_CLR, OFFSET_FIFO_ADDR_CLR);
> 
> There's a missing initialization to fifo_clr_reg here, I guess
> fifo_clr_reg = I2C_FIFO_ADDR_CLR should be necessarily made here;
> 
> > +       if (i2c->share_i3c)
> > +               fifo_clr_reg = I2C_FIFO_ADDR_CLR | I2C_FIFO_ADDR_CLRH;
> 
> fifo_clr_reg |= I2C_FIFO_ADDR_CLRH baed on initialized value
> 
> > +       if (i2c->ch_offset)
> > +               fifo_clr_reg = I2C_FIFO_ADDR_CLR | I2C_FIFO_ADDR_CLR_MCH;
> 
> and then fifo_clr_reg |= I2C_FIFO_ADDR_CLR_MCH;
> 

ok, I will modify it. Thanks for your patient review.

> > +
> > +       mtk_i2c_writew(i2c, fifo_clr_reg, OFFSET_FIFO_ADDR_CLR);
> > +
> > +       if ((i2c->speed_hz > MAX_FS_MODE_SPEED) && i2c->share_i3c)
> > +               mtk_i2c_writew(i2c, I2C_HFIFO_DATA, OFFSET_HFIFO_DATA);
> >
> >         /* Enable interrupt */
> >         mtk_i2c_writew(i2c, restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> > @@ -817,6 +932,11 @@ static int mtk_i2c_parse_dt(struct device_node *np, struct mtk_i2c *i2c)
> >         if (i2c->clk_src_div == 0)
> >                 return -EINVAL;
> >
> > +       ret = of_property_read_u32(np, "ch-offset", &i2c->ch_offset);
> 
> if ch-offset is a vendor-specific property, it should be better to add
> a vendor prefix
> 

ok, I will add a vendor-specific property if we need the ch-offset.

> > +       if (ret < 0)
> > +               i2c->ch_offset = 0;
> > +
> > +       i2c->share_i3c = of_property_read_bool(np, "mediatek,share-i3c");
> >         i2c->have_pmic = of_property_read_bool(np, "mediatek,have-pmic");
> >         i2c->use_push_pull =
> >                 of_property_read_bool(np, "mediatek,use-push-pull");
> > @@ -884,6 +1004,10 @@ static int mtk_i2c_probe(struct platform_device *pdev)
> >                 return PTR_ERR(i2c->clk_dma);
> >         }
> >
> > +       i2c->clk_arb = devm_clk_get(&pdev->dev, "arb");
> > +       if (IS_ERR(i2c->clk_arb))
> > +               i2c->clk_arb = NULL;
> > +
> >         clk = i2c->clk_main;
> >         if (i2c->have_pmic) {
> >                 i2c->clk_pmic = devm_clk_get(&pdev->dev, "pmic");
> > --
> > 1.7.9.5
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek


