Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeDLGXC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 02:23:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45884 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752041AbeDLGXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 02:23:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Thu, 12 Apr 2018 14:22:59 +0800
From: cang@codeaurora.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: subhashj@codeaurora.org, asutoshd@codeaurora.org,
        mgautam@codeaurora.org, kishon@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] phy: Add QMP phy based UFS phy support for sdm845
In-Reply-To: <ee4fefdd-0714-fcb4-ee58-59c0cde2386a@codeaurora.org>
References: <20180327071838.11168-1-cang@codeaurora.org>
 <20180327071838.11168-2-cang@codeaurora.org>
 <b05ea9ac-302e-9381-94dd-00abd2099b60@codeaurora.org>
 <a92068db7eb4ec090490a16b75a164aa@codeaurora.org>
 <ee4fefdd-0714-fcb4-ee58-59c0cde2386a@codeaurora.org>
Message-ID: <e4f4f5ac650e770a77dfb1788520b0c9@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-12 13:13, Vivek Gautam wrote:
> On 4/12/2018 6:27 AM, cang@codeaurora.org wrote:
>> On 2018-04-09 19:28, Vivek Gautam wrote:
>>> Hi Can,
>>> 
>>> 
>>> On 3/27/2018 12:48 PM, Can Guo wrote:
>>>> Add UFS PHY support to make SDM845 UFS work with common PHY 
>>>> framework.
>>>> 
>>>> Signed-off-by: Can Guo <cang@codeaurora.org>
>>>> ---
>>>>   drivers/phy/qualcomm/phy-qcom-qmp.c | 130 
>>>> +++++++++++++++++++++++++++++++++---
>>>>   drivers/phy/qualcomm/phy-qcom-qmp.h |   8 +++
>>>>   2 files changed, 127 insertions(+), 11 deletions(-)
>>>> 
>>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c 
>>>> b/drivers/phy/qualcomm/phy-qcom-qmp.c
>>>> index 5cf2c3c..0b58030 100644
>>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
>>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
>>>> @@ -156,6 +156,11 @@ enum qphy_reg_layout {
>>>>       [QPHY_PCS_LFPS_RXTERM_IRQ_STATUS] = 0x170,
>>>>   };
>>>>   +static const unsigned int sdm845_ufsphy_regs_layout[] = {
>>>> +    [QPHY_START_CTRL]        = 0x00,
>>>> +    [QPHY_PCS_READY_STATUS]        = 0x168,
>>>> +};
>>>> +
>>>>   static const struct qmp_phy_init_tbl msm8996_pcie_serdes_tbl[] = {
>>>>       QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x1c),
>>>>       QMP_PHY_INIT_CFG(QSERDES_COM_CLK_ENABLE1, 0x10),
>>>> @@ -601,6 +606,73 @@ enum qphy_reg_layout {
>>>>       QMP_PHY_INIT_CFG(QPHY_V3_PCS_REFGEN_REQ_CONFIG2, 0x60),
>>>>   };
>>>>   +static const struct qmp_phy_init_tbl sdm845_ufsphy_serdes_tbl[] = 
>>>> {
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYS_CLK_CTRL, 0x02),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_BG_TIMER, 0x0a),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_IVCO, 0x0f),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_CMN_CONFIG, 0x06),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYSCLK_EN_SEL, 0xd5),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_RESETSM_CNTRL, 0x20),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_HSCLK_SEL, 0x00),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP_EN, 0x01),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_CTRL, 0x00),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_CORE_CLK_EN, 0x00),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_MAP, 0x04),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_SVS_MODE_CLK_SEL, 0x05),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_INITVAL1, 0xff),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_INITVAL2, 0x00),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_DEC_START_MODE0, 0x82),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_CP_CTRL_MODE0, 0x06),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_RCTRL_MODE0, 0x16),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_CCTRL_MODE0, 0x36),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN0_MODE0, 0x3f),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE1_MODE0, 0xda),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE2_MODE0, 0x01),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP1_MODE0, 0xff),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP2_MODE0, 0x0c),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_DEC_START_MODE1, 0x98),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_CP_CTRL_MODE1, 0x06),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_RCTRL_MODE1, 0x16),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_CCTRL_MODE1, 0x36),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN0_MODE1, 0x3f),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN1_MODE1, 0x00),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE1_MODE1, 0xc1),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE2_MODE1, 0x00),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP1_MODE1, 0x32),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP2_MODE1, 0x0f),
>>>> +
>>>> +    /* Rate B */
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_MAP, 0x44),
>>>> +};
>>>> +
>>>> +static const struct qmp_phy_init_tbl sdm845_ufsphy_tx_tbl[] = {
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_TX_LANE_MODE_1, 0x06),
>>>> +};
>>>> +
>>>> +static const struct qmp_phy_init_tbl sdm845_ufsphy_rx_tbl[] = {
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_LVL, 0x24),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_CNTRL, 0x0f),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_INTERFACE_MODE, 0x40),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_TERM_BW, 0x5b),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2, 0x06),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL3, 0x04),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL4, 0x1d),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN_HALF, 0x04),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN_QUARTER, 0x04),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN, 0x04),
>>>> + QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE, 
>>>> 0x4b),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_PI_CONTROLS, 0x81),
>>>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_LOW, 0x80),
>>>> +};
>>>> +
>>>> +static const struct qmp_phy_init_tbl sdm845_ufsphy_pcs_tbl[] = {
>>>> +    QMP_PHY_INIT_CFG(QPHY_V3_PCS_POWER_DOWN_CONTROL, 0x01),
>>>> +    QMP_PHY_INIT_CFG(QPHY_V3_PCS_MULTI_LANE_CTRL1, 0x02),
>>>> +};
>>>>     /* struct qmp_phy_cfg - per-PHY initialization config */
>>>>   struct qmp_phy_cfg {
>>>> @@ -652,6 +724,9 @@ struct qmp_phy_cfg {
>>>>       /* Register offset of secondary tx/rx lanes for USB DP combo 
>>>> PHY */
>>>>       unsigned int tx_b_lane_offset;
>>>>       unsigned int rx_b_lane_offset;
>>>> +
>>>> +    /* true, if PCS block has no separate SW_RESET register */
>>>> +    bool skip_sw_rst;
>>>>   };
>>>>     /**
>>>> @@ -748,6 +823,10 @@ static inline void qphy_clrbits(void __iomem 
>>>> *base, u32 offset, u32 val)
>>>>       "aux", "cfg_ahb", "ref", "com_aux",
>>>>   };
>>>>   +static const char * const sdm845_ufs_phy_clk_l[] = {
>>>> +    "ref",
>>> 
>>> did you miss adding 'ref_aux' clock here as in the v2 version?
>>> Rest looks good. After this change, you can add my reviewed-by
>>> Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>> 
>>> Thanks
>>> Vivek
>> 
>> Thank you Vivek. I removed 'ref_aux' as it was from the old UFS PHY 
>> driver.
>> And I have tested the new patch on MTP845 V2, it worked fine. Do you 
>> have
>> any concerns about it?
>> 
> 
> I see in the downstream there's a ref_aux clock, so can you check from 
> the phy's
> hardware docs if this is required for phy's functionality. Working on 
> the MTP is
> one thing as some of the clocks may be kept enabled by the bootloader
> too sometimes.
> 
> Thanks
> Vivek

You are right Vivek, I checked the HPG,'ref_aux' is needed for 845 
indeed. I will add it back.
BTW, is it OK that I use 'aux' instead? As clk name 'aux' in the 
documentation seems to serve the same
purpose for UFS PHY.

Thanks
Can

>> Thanks
>> Can
> [snip]
