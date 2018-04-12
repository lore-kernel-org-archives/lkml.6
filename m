Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeDLA6F (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 20:58:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33774 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbeDLA6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 20:58:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Apr 2018 08:57:30 +0800
From: cang@codeaurora.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: subhashj@codeaurora.org, asutoshd@codeaurora.org,
        mgautam@codeaurora.org, kishon@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] phy: Add QMP phy based UFS phy support for sdm845
In-Reply-To: <b05ea9ac-302e-9381-94dd-00abd2099b60@codeaurora.org>
References: <20180327071838.11168-1-cang@codeaurora.org>
 <20180327071838.11168-2-cang@codeaurora.org>
 <b05ea9ac-302e-9381-94dd-00abd2099b60@codeaurora.org>
Message-ID: <a92068db7eb4ec090490a16b75a164aa@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-09 19:28, Vivek Gautam wrote:
> Hi Can,
> 
> 
> On 3/27/2018 12:48 PM, Can Guo wrote:
>> Add UFS PHY support to make SDM845 UFS work with common PHY framework.
>> 
>> Signed-off-by: Can Guo <cang@codeaurora.org>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp.c | 130 
>> +++++++++++++++++++++++++++++++++---
>>   drivers/phy/qualcomm/phy-qcom-qmp.h |   8 +++
>>   2 files changed, 127 insertions(+), 11 deletions(-)
>> 
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c 
>> b/drivers/phy/qualcomm/phy-qcom-qmp.c
>> index 5cf2c3c..0b58030 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
>> @@ -156,6 +156,11 @@ enum qphy_reg_layout {
>>   	[QPHY_PCS_LFPS_RXTERM_IRQ_STATUS] = 0x170,
>>   };
>>   +static const unsigned int sdm845_ufsphy_regs_layout[] = {
>> +	[QPHY_START_CTRL]		= 0x00,
>> +	[QPHY_PCS_READY_STATUS]		= 0x168,
>> +};
>> +
>>   static const struct qmp_phy_init_tbl msm8996_pcie_serdes_tbl[] = {
>>   	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x1c),
>>   	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_ENABLE1, 0x10),
>> @@ -601,6 +606,73 @@ enum qphy_reg_layout {
>>   	QMP_PHY_INIT_CFG(QPHY_V3_PCS_REFGEN_REQ_CONFIG2, 0x60),
>>   };
>>   +static const struct qmp_phy_init_tbl sdm845_ufsphy_serdes_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYS_CLK_CTRL, 0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BG_TIMER, 0x0a),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_IVCO, 0x0f),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CMN_CONFIG, 0x06),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYSCLK_EN_SEL, 0xd5),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_RESETSM_CNTRL, 0x20),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_HSCLK_SEL, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP_EN, 0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_CTRL, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CORE_CLK_EN, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_MAP, 0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SVS_MODE_CLK_SEL, 0x05),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_INITVAL1, 0xff),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_INITVAL2, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DEC_START_MODE0, 0x82),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CP_CTRL_MODE0, 0x06),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_RCTRL_MODE0, 0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_CCTRL_MODE0, 0x36),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN0_MODE0, 0x3f),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE1_MODE0, 0xda),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE2_MODE0, 0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP1_MODE0, 0xff),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP2_MODE0, 0x0c),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DEC_START_MODE1, 0x98),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CP_CTRL_MODE1, 0x06),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_RCTRL_MODE1, 0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_CCTRL_MODE1, 0x36),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN0_MODE1, 0x3f),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN1_MODE1, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE1_MODE1, 0xc1),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE2_MODE1, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP1_MODE1, 0x32),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP2_MODE1, 0x0f),
>> +
>> +	/* Rate B */
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_MAP, 0x44),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl sdm845_ufsphy_tx_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_LANE_MODE_1, 0x06),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl sdm845_ufsphy_rx_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_LVL, 0x24),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_CNTRL, 0x0f),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_INTERFACE_MODE, 0x40),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_TERM_BW, 0x5b),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2, 0x06),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL3, 0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL4, 0x1d),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN_HALF, 0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN_QUARTER, 0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN, 0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x4b),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_PI_CONTROLS, 0x81),
>> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_LOW, 0x80),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl sdm845_ufsphy_pcs_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_POWER_DOWN_CONTROL, 0x01),
>> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_MULTI_LANE_CTRL1, 0x02),
>> +};
>>     /* struct qmp_phy_cfg - per-PHY initialization config */
>>   struct qmp_phy_cfg {
>> @@ -652,6 +724,9 @@ struct qmp_phy_cfg {
>>   	/* Register offset of secondary tx/rx lanes for USB DP combo PHY */
>>   	unsigned int tx_b_lane_offset;
>>   	unsigned int rx_b_lane_offset;
>> +
>> +	/* true, if PCS block has no separate SW_RESET register */
>> +	bool skip_sw_rst;
>>   };
>>     /**
>> @@ -748,6 +823,10 @@ static inline void qphy_clrbits(void __iomem 
>> *base, u32 offset, u32 val)
>>   	"aux", "cfg_ahb", "ref", "com_aux",
>>   };
>>   +static const char * const sdm845_ufs_phy_clk_l[] = {
>> +	"ref",
> 
> did you miss adding 'ref_aux' clock here as in the v2 version?
> Rest looks good. After this change, you can add my reviewed-by
> Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> 
> Thanks
> Vivek

Thank you Vivek. I removed 'ref_aux' as it was from the old UFS PHY 
driver.
And I have tested the new patch on MTP845 V2, it worked fine. Do you 
have
any concerns about it?

Thanks
Can

>> +};
>> +
>>   /* list of resets */
>>   static const char * const msm8996_pciephy_reset_l[] = {
>>   	"phy", "common", "cfg",
>> @@ -758,7 +837,7 @@ static inline void qphy_clrbits(void __iomem 
>> *base, u32 offset, u32 val)
>>   };
>>     /* list of regulators */
>> -static const char * const msm8996_phy_vreg_l[] = {
>> +static const char * const qmp_phy_vreg_l[] = {
>>   	"vdda-phy", "vdda-pll",
>>   };
>>   @@ -778,8 +857,8 @@ static inline void qphy_clrbits(void __iomem 
>> *base, u32 offset, u32 val)
>>   	.num_clks		= ARRAY_SIZE(msm8996_phy_clk_l),
>>   	.reset_list		= msm8996_pciephy_reset_l,
>>   	.num_resets		= ARRAY_SIZE(msm8996_pciephy_reset_l),
>> -	.vreg_list		= msm8996_phy_vreg_l,
>> -	.num_vregs		= ARRAY_SIZE(msm8996_phy_vreg_l),
>> +	.vreg_list		= qmp_phy_vreg_l,
>> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>>   	.regs			= pciephy_regs_layout,
>>     	.start_ctrl		= PCS_START | PLL_READY_GATE_EN,
>> @@ -809,8 +888,8 @@ static inline void qphy_clrbits(void __iomem 
>> *base, u32 offset, u32 val)
>>   	.num_clks		= ARRAY_SIZE(msm8996_phy_clk_l),
>>   	.reset_list		= msm8996_usb3phy_reset_l,
>>   	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
>> -	.vreg_list		= msm8996_phy_vreg_l,
>> -	.num_vregs		= ARRAY_SIZE(msm8996_phy_vreg_l),
>> +	.vreg_list		= qmp_phy_vreg_l,
>> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>>   	.regs			= usb3phy_regs_layout,
>>     	.start_ctrl		= SERDES_START | PCS_START,
>> @@ -870,8 +949,8 @@ static inline void qphy_clrbits(void __iomem 
>> *base, u32 offset, u32 val)
>>   	.num_clks		= ARRAY_SIZE(qmp_v3_phy_clk_l),
>>   	.reset_list		= msm8996_usb3phy_reset_l,
>>   	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
>> -	.vreg_list		= msm8996_phy_vreg_l,
>> -	.num_vregs		= ARRAY_SIZE(msm8996_phy_vreg_l),
>> +	.vreg_list		= qmp_phy_vreg_l,
>> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>>   	.regs			= qmp_v3_usb3phy_regs_layout,
>>     	.start_ctrl		= SERDES_START | PCS_START,
>> @@ -903,8 +982,8 @@ static inline void qphy_clrbits(void __iomem 
>> *base, u32 offset, u32 val)
>>   	.num_clks		= ARRAY_SIZE(qmp_v3_phy_clk_l),
>>   	.reset_list		= msm8996_usb3phy_reset_l,
>>   	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
>> -	.vreg_list		= msm8996_phy_vreg_l,
>> -	.num_vregs		= ARRAY_SIZE(msm8996_phy_vreg_l),
>> +	.vreg_list		= qmp_phy_vreg_l,
>> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>>   	.regs			= qmp_v3_usb3phy_regs_layout,
>>     	.start_ctrl		= SERDES_START | PCS_START,
>> @@ -916,6 +995,30 @@ static inline void qphy_clrbits(void __iomem 
>> *base, u32 offset, u32 val)
>>   	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
>>   };
>>   +static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
>> +	.type			= PHY_TYPE_UFS,
>> +	.nlanes			= 2,
>> +
>> +	.serdes_tbl		= sdm845_ufsphy_serdes_tbl,
>> +	.serdes_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_serdes_tbl),
>> +	.tx_tbl			= sdm845_ufsphy_tx_tbl,
>> +	.tx_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_tx_tbl),
>> +	.rx_tbl			= sdm845_ufsphy_rx_tbl,
>> +	.rx_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_rx_tbl),
>> +	.pcs_tbl		= sdm845_ufsphy_pcs_tbl,
>> +	.pcs_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_pcs_tbl),
>> +	.clk_list		= sdm845_ufs_phy_clk_l,
>> +	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
>> +	.vreg_list		= qmp_phy_vreg_l,
>> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>> +	.regs			= sdm845_ufsphy_regs_layout,
>> +
>> +	.start_ctrl		= SERDES_START,
>> +	.pwrdn_ctrl		= SW_PWRDN,
>> +	.mask_pcs_ready		= PCS_READY,
>> +	.skip_sw_rst		= true,
>> +};
>> +
>>   static void qcom_qmp_phy_configure(void __iomem *base,
>>   				   const unsigned int *regs,
>>   				   const struct qmp_phy_init_tbl tbl[],
>> @@ -1140,7 +1243,8 @@ static int qcom_qmp_phy_init(struct phy *phy)
>>   		usleep_range(cfg->pwrdn_delay_min, cfg->pwrdn_delay_max);
>>     	/* Pull PHY out of reset state */
>> -	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
>> +	if (!cfg->skip_sw_rst)
>> +		qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
>>   	if (cfg->has_phy_dp_com_ctrl)
>>   		qphy_clrbits(dp_com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
>>   @@ -1178,7 +1282,8 @@ static int qcom_qmp_phy_exit(struct phy *phy)
>>   	clk_disable_unprepare(qphy->pipe_clk);
>>     	/* PHY reset */
>> -	qphy_setbits(qphy->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
>> +	if (!cfg->skip_sw_rst)
>> +		qphy_setbits(qphy->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
>>     	/* stop SerDes and Phy-Coding-Sublayer */
>>   	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL], 
>> cfg->start_ctrl);
>> @@ -1531,6 +1636,9 @@ int qcom_qmp_phy_create(struct device *dev, 
>> struct device_node *np, int id)
>>   	}, {
>>   		.compatible = "qcom,sdm845-qmp-usb3-uni-phy",
>>   		.data = &qmp_v3_usb3_uniphy_cfg,
>> +	}, {
>> +		.compatible = "qcom,sdm845-qmp-ufs-phy",
>> +		.data = &sdm845_ufsphy_cfg,
>>   	},
>>   	{ },
>>   };
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h 
>> b/drivers/phy/qualcomm/phy-qcom-qmp.h
>> index 5d78d43..3cbcfe1 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp.h
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
>> @@ -184,6 +184,8 @@
>>   #define QSERDES_V3_COM_VCO_TUNE2_MODE0			0x0f8
>>   #define QSERDES_V3_COM_VCO_TUNE1_MODE1			0x0fc
>>   #define QSERDES_V3_COM_VCO_TUNE2_MODE1			0x100
>> +#define QSERDES_V3_COM_VCO_TUNE_INITVAL1		0x104
>> +#define QSERDES_V3_COM_VCO_TUNE_INITVAL2		0x108
>>   #define QSERDES_V3_COM_VCO_TUNE_TIMER1			0x11c
>>   #define QSERDES_V3_COM_VCO_TUNE_TIMER2			0x120
>>   #define QSERDES_V3_COM_CLK_SELECT			0x138
>> @@ -211,8 +213,13 @@
>>   /* Only for QMP V3 PHY - RX registers */
>>   #define QSERDES_V3_RX_UCDR_SO_GAIN_HALF			0x00c
>>   #define QSERDES_V3_RX_UCDR_SO_GAIN			0x014
>> +#define QSERDES_V3_RX_UCDR_SVS_SO_GAIN_HALF		0x024
>> +#define QSERDES_V3_RX_UCDR_SVS_SO_GAIN_QUARTER		0x028
>> +#define QSERDES_V3_RX_UCDR_SVS_SO_GAIN			0x02c
>>   #define QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN		0x030
>>   #define QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE	0x034
>> +#define QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_LOW		0x03c
>> +#define QSERDES_V3_RX_UCDR_PI_CONTROLS			0x044
>>   #define QSERDES_V3_RX_RX_TERM_BW			0x07c
>>   #define QSERDES_V3_RX_VGA_CAL_CNTRL1			0x0bc
>>   #define QSERDES_V3_RX_VGA_CAL_CNTRL2			0x0c0
>> @@ -275,6 +282,7 @@
>>   #define QPHY_V3_PCS_FLL_CNT_VAL_L			0x0cc
>>   #define QPHY_V3_PCS_FLL_CNT_VAL_H_TOL			0x0d0
>>   #define QPHY_V3_PCS_FLL_MAN_CODE			0x0d4
>> +#define QPHY_V3_PCS_MULTI_LANE_CTRL1			0x1c4
>>   #define QPHY_V3_PCS_RX_SIGDET_LVL			0x1d8
>>   #define QPHY_V3_PCS_REFGEN_REQ_CONFIG1			0x20c
>>   #define QPHY_V3_PCS_REFGEN_REQ_CONFIG2			0x210
