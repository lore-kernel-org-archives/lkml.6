Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFCFC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 03:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C2A20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 03:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C2A20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbeKSOVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 09:21:37 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:31184 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727123AbeKSOVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 09:21:37 -0500
X-UUID: 9aec0b29179548d4893180fdde1497b8-20181119
X-UUID: 9aec0b29179548d4893180fdde1497b8-20181119
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 355430312; Mon, 19 Nov 2018 11:59:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 19 Nov 2018 11:59:00 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 19 Nov 2018 11:59:00 +0800
Message-ID: <1542599940.688.1.camel@mtksdaap41>
Subject: Re: [PATCH v1 11/11] soc: mediatek: Add MT8183 scpsys support
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>, <sboyd@codeaurora.org>,
        "Rob Herring" <robh@kernel.org>, <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Date:   Mon, 19 Nov 2018 11:59:00 +0800
In-Reply-To: <CANMq1KBoCScwixLoB0oEtbavLW8b_NjufAjbPKJLcLgj=vHC9A@mail.gmail.com>
References: <20181106064206.17535-1-weiyi.lu@mediatek.com>
         <20181106064206.17535-13-weiyi.lu@mediatek.com>
         <CANMq1KBoCScwixLoB0oEtbavLW8b_NjufAjbPKJLcLgj=vHC9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-13 at 11:35 -0800, Nicolas Boichat wrote:
> On Mon, Nov 5, 2018 at 10:43 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
> >
> > Add scpsys driver for MT8183
> >
> > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > ---
> >  drivers/soc/mediatek/mtk-scpsys.c | 226 ++++++++++++++++++++++++++++++
> >  1 file changed, 226 insertions(+)
> >
> > diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> > index 80be2e05e4e0..57b9f04a69de 100644
> > --- a/drivers/soc/mediatek/mtk-scpsys.c
> > +++ b/drivers/soc/mediatek/mtk-scpsys.c
> > @@ -29,6 +29,7 @@
> >  #include <dt-bindings/power/mt7622-power.h>
> >  #include <dt-bindings/power/mt7623a-power.h>
> >  #include <dt-bindings/power/mt8173-power.h>
> > +#include <dt-bindings/power/mt8183-power.h>
> >
> >  #define MTK_POLL_DELAY_US   10
> >  #define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
> > @@ -1179,6 +1180,217 @@ static const struct scp_subdomain scp_subdomain_mt8173[] = {
> >         {MT8173_POWER_DOMAIN_MFG_2D, MT8173_POWER_DOMAIN_MFG},
> >  };
> >
> > +/*
> > + * MT8183 power domain support
> > + */
> > +
> > +static const struct scp_domain_data scp_domain_data_mt8183[] = {
> > +       [MT8183_POWER_DOMAIN_AUDIO] = {
> > +               .name = "audio",
> > +               .sta_mask = PWR_STATUS_AUDIO,
> > +               .ctl_offs = 0x0314,
> > +               .sram_pdn_bits = GENMASK(11, 8),
> > +               .sram_pdn_ack_bits = GENMASK(15, 12),
> > +               .basic_clk_name = {"audio"},
> > +       },
> > +       [MT8183_POWER_DOMAIN_CONN] = {
> > +               .name = "conn",
> > +               .sta_mask = PWR_STATUS_CONN,
> > +               .ctl_offs = 0x032c,
> > +               .sram_pdn_bits = 0,
> > +               .sram_pdn_ack_bits = 0,
> > +               .bp_table = {
> > +                       [0] = BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
> > +                               BIT(13) | BIT(14), BIT(13) | BIT(14)),
> > +               },
> > +       },
> > +       [MT8183_POWER_DOMAIN_MFG_ASYNC] = {
> > +               .name = "mfg_async",
> > +               .sta_mask = PWR_STATUS_MFG_ASYNC,
> > +               .ctl_offs = 0x0334,
> > +               .sram_pdn_bits = 0,
> > +               .sram_pdn_ack_bits = 0,
> > +               .basic_clk_name = {"mfg"},
> > +       },
> > +       [MT8183_POWER_DOMAIN_MFG] = {
> > +               .name = "mfg",
> > +               .sta_mask = PWR_STATUS_MFG,
> > +               .ctl_offs = 0x0338,
> > +               .sram_pdn_bits = GENMASK(8, 8),
> > +               .sram_pdn_ack_bits = GENMASK(12, 12),
> > +       },
> > +       [MT8183_POWER_DOMAIN_MFG_CORE0] = {
> > +               .name = "mfg_core0",
> > +               .sta_mask = BIT(7),
> > +               .ctl_offs = 0x034c,
> > +               .sram_pdn_bits = GENMASK(8, 8),
> > +               .sram_pdn_ack_bits = GENMASK(12, 12),
> > +       },
> > +       [MT8183_POWER_DOMAIN_MFG_CORE1] = {
> > +               .name = "mfg_core1",
> > +               .sta_mask = BIT(20),
> > +               .ctl_offs = 0x0310,
> > +               .sram_pdn_bits = GENMASK(8, 8),
> > +               .sram_pdn_ack_bits = GENMASK(12, 12),
> > +       },
> > +       [MT8183_POWER_DOMAIN_MFG_2D] = {
> > +               .name = "mfg_2d",
> > +               .sta_mask = PWR_STATUS_MFG_2D,
> > +               .ctl_offs = 0x0348,
> > +               .sram_pdn_bits = GENMASK(8, 8),
> > +               .sram_pdn_ack_bits = GENMASK(12, 12),
> > +               .bp_table = {
> > +                       [0] = BUS_PROT(IFR_TYPE, 0x2a8, 0x2ac, 0, 0x258,
> > +                               BIT(19) | BIT(20) | BIT(21),
> > +                               BIT(19) | BIT(20) | BIT(21)),
> > +                       [1] = BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
> > +                               BIT(21) | BIT(22), BIT(21) | BIT(22)),
> > +               },
> > +       },
> > +       [MT8183_POWER_DOMAIN_DISP] = {
> > +               .name = "disp",
> > +               .sta_mask = PWR_STATUS_DISP,
> > +               .ctl_offs = 0x030c,
> > +               .sram_pdn_bits = GENMASK(8, 8),
> > +               .sram_pdn_ack_bits = GENMASK(12, 12),
> > +               .basic_clk_name = {"mm"},
> > +               .subsys_clk_prefix = "mm",
> > +               .bp_table = {
> > +                       [0] = BUS_PROT(IFR_TYPE, 0x2a8, 0x2ac, 0, 0x258,
> > +                               BIT(16) | BIT(17), BIT(16) | BIT(17)),
> > +                       [1] = BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
> > +                               BIT(10) | BIT(11), BIT(10) | BIT(11)),
> > +                       [2] = BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
> > +                               GENMASK(7, 0), GENMASK(7, 0)),
> > +               },
> > +       },
> > +       [MT8183_POWER_DOMAIN_CAM] = {
> > +               .name = "cam",
> > +               .sta_mask = BIT(25),
> > +               .ctl_offs = 0x0344,
> > +               .sram_pdn_bits = GENMASK(9, 8),
> > +               .sram_pdn_ack_bits = GENMASK(13, 12),
> > +               .basic_clk_name = {"cam"},
> > +               .subsys_clk_prefix = "cam",
> > +               .bp_table = {
> > +                       [0] = BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> > +                               BIT(4) | BIT(5) | BIT(9) | BIT(13),
> > +                               BIT(4) | BIT(5) | BIT(9) | BIT(13)),
> > +                       [1] = BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
> > +                               BIT(28), BIT(28)),
> > +                       [2] = BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> > +                               BIT(11), 0),
> > +                       [3] = BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
> > +                               BIT(3) | BIT(4), BIT(3) | BIT(4)),
> 
> Why do you need to specify the indexes ([0], [1], ...)? Can you just
> use automatic indexes? (especially considering that your code assumes
> there is no gap in the bp_table entries.
> 
Indeed, there's no gap in the bp_table. I'll fix it up in next version
and resend. Thanks.
> > +               },
> > +       },
> > +       [MT8183_POWER_DOMAIN_ISP] = {
> > +               .name = "isp",
> > +               .sta_mask = PWR_STATUS_ISP,
> > +               .ctl_offs = 0x0308,
> > +               .sram_pdn_bits = GENMASK(9, 8),
> > +               .sram_pdn_ack_bits = GENMASK(13, 12),
> > +               .basic_clk_name = {"isp"},
> > +               .subsys_clk_prefix = "isp",
> > +               .bp_table = {
> > +                       [0] = BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> > +                               BIT(3) | BIT(8), BIT(3) | BIT(8)),
> > +                       [1] = BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> > +                               BIT(10), 0),
> > +                       [2] = BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
> > +                               BIT(2), BIT(2)),
> > +               },
> > +       },
> > +       [MT8183_POWER_DOMAIN_VDEC] = {
> > +               .name = "vdec",
> > +               .sta_mask = BIT(31),
> > +               .ctl_offs = 0x0300,
> > +               .sram_pdn_bits = GENMASK(8, 8),
> > +               .sram_pdn_ack_bits = GENMASK(12, 12),
> > +               .bp_table = {
> > +                       [0] = BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
> > +                               BIT(7), BIT(7)),
> > +               },
> > +       },
> > +       [MT8183_POWER_DOMAIN_VENC] = {
> > +               .name = "venc",
> > +               .sta_mask = PWR_STATUS_VENC,
> > +               .ctl_offs = 0x0304,
> > +               .sram_pdn_bits = GENMASK(11, 8),
> > +               .sram_pdn_ack_bits = GENMASK(15, 12),
> > +               .bp_table = {
> > +                       [0] = BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
> > +                               BIT(1), BIT(1)),
> > +               },
> > +       },
> > +       [MT8183_POWER_DOMAIN_VPU_TOP] = {
> > +               .name = "vpu_top",
> > +               .sta_mask = BIT(26),
> > +               .ctl_offs = 0x0324,
> > +               .sram_pdn_bits = GENMASK(8, 8),
> > +               .sram_pdn_ack_bits = GENMASK(12, 12),
> > +               .basic_clk_name = {"vpu", "vpu1"},
> > +               .subsys_clk_prefix = "vpu",
> > +               .bp_table = {
> > +                       [0] = BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> > +                               GENMASK(9, 6) | BIT(12),
> > +                               GENMASK(9, 6) | BIT(12)),
> > +                       [1] = BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
> > +                               BIT(27), BIT(27)),
> > +                       [2] = BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
> > +                               BIT(10) | BIT(11), BIT(10) | BIT(11)),
> > +                       [3] = BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
> > +                               BIT(5) | BIT(6), BIT(5) | BIT(6)),
> > +               },
> > +       },
> > +       [MT8183_POWER_DOMAIN_VPU_CORE0] = {
> > +               .name = "vpu_core0",
> > +               .sta_mask = BIT(27),
> > +               .ctl_offs = 0x33c,
> > +               .sram_iso_ctrl = true,
> > +               .sram_pdn_bits = GENMASK(11, 8),
> > +               .sram_pdn_ack_bits = GENMASK(13, 12),
> > +               .basic_clk_name = {"vpu2"},
> > +               .bp_table = {
> > +                       [0] = BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
> > +                               BIT(6), BIT(6)),
> > +                       [1] = BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
> > +                               BIT(0) | BIT(2) | BIT(4),
> > +                               BIT(0) | BIT(2) | BIT(4)),
> > +               },
> > +       },
> > +       [MT8183_POWER_DOMAIN_VPU_CORE1] = {
> > +               .name = "vpu_core1",
> > +               .sta_mask = BIT(28),
> > +               .ctl_offs = 0x0340,
> > +               .sram_iso_ctrl = true,
> > +               .sram_pdn_bits = GENMASK(11, 8),
> > +               .sram_pdn_ack_bits = GENMASK(13, 12),
> > +               .basic_clk_name = {"vpu3"},
> > +               .bp_table = {
> > +                       [0] = BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
> > +                               BIT(7), BIT(7)),
> > +                       [1] = BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
> > +                               BIT(1) | BIT(3) | BIT(5),
> > +                               BIT(1) | BIT(3) | BIT(5)),
> > +               },
> > +       },
> > +};
> > +
> > +static const struct scp_subdomain scp_subdomain_mt8183[] = {
> > +       {MT8183_POWER_DOMAIN_MFG_ASYNC, MT8183_POWER_DOMAIN_MFG},
> > +       {MT8183_POWER_DOMAIN_MFG, MT8183_POWER_DOMAIN_MFG_2D},
> > +       {MT8183_POWER_DOMAIN_MFG, MT8183_POWER_DOMAIN_MFG_CORE0},
> > +       {MT8183_POWER_DOMAIN_MFG, MT8183_POWER_DOMAIN_MFG_CORE1},
> > +       {MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_CAM},
> > +       {MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_ISP},
> > +       {MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_VDEC},
> > +       {MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_VENC},
> > +       {MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_VPU_TOP},
> > +       {MT8183_POWER_DOMAIN_VPU_TOP, MT8183_POWER_DOMAIN_VPU_CORE0},
> > +       {MT8183_POWER_DOMAIN_VPU_TOP, MT8183_POWER_DOMAIN_VPU_CORE1},
> > +};
> > +
> >  static const struct scp_soc_data mt2701_data = {
> >         .domains = scp_domain_data_mt2701,
> >         .num_domains = ARRAY_SIZE(scp_domain_data_mt2701),
> > @@ -1245,6 +1457,17 @@ static const struct scp_soc_data mt8173_data = {
> >         .bus_prot_reg_update = true,
> >  };
> >
> > +static const struct scp_soc_data mt8183_data = {
> > +       .domains = scp_domain_data_mt8183,
> > +       .num_domains = ARRAY_SIZE(scp_domain_data_mt8183),
> > +       .subdomains = scp_subdomain_mt8183,
> > +       .num_subdomains = ARRAY_SIZE(scp_subdomain_mt8183),
> > +       .regs = {
> > +               .pwr_sta_offs = 0x0180,
> > +               .pwr_sta2nd_offs = 0x0184
> > +       }
> > +};
> > +
> >  /*
> >   * scpsys driver init
> >   */
> > @@ -1268,6 +1491,9 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
> >         }, {
> >                 .compatible = "mediatek,mt8173-scpsys",
> >                 .data = &mt8173_data,
> > +       }, {
> > +               .compatible = "mediatek,mt8183-scpsys",
> > +               .data = &mt8183_data,
> >         }, {
> >                 /* sentinel */
> >         }
> > --
> > 2.18.0
> >


