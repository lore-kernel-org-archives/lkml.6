Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972114AbeEYBci (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 21:32:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54334 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965152AbeEYBcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 21:32:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 25 May 2018 09:32:34 +0800
From: cang@codeaurora.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: subhashj@codeaurora.org, asutoshd@codeaurora.org,
        mgautam@codeaurora.org, kishon@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/3] phy: Power on PHY before start Serdes
 configuration
In-Reply-To: <dd6b1e3d-e894-e40f-452a-2dec2421b1c7@codeaurora.org>
References: <20180523034712.3420-1-cang@codeaurora.org>
 <20180523034712.3420-2-cang@codeaurora.org>
 <dd6b1e3d-e894-e40f-452a-2dec2421b1c7@codeaurora.org>
Message-ID: <7d45dbec17a9bbf48159c6857f89a65a@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-24 16:17, Vivek Gautam wrote:
> Hi Can,
> 
> 
> On 5/23/2018 9:17 AM, Can Guo wrote:
>> PHYs should be powered on before register configuration starts.
>> 
>> Signed-off-by: Can Guo <cang@codeaurora.org>
>> ---
> 
> Thanks for fixing this.
> 
>>   drivers/phy/qualcomm/phy-qcom-qmp.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>> 
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c 
>> b/drivers/phy/qualcomm/phy-qcom-qmp.c
>> index 97ef942..9bfdba1 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
>> @@ -1000,6 +1000,12 @@ static int qcom_qmp_phy_com_init(struct 
>> qcom_qmp *qmp)
>>   			     SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
>>   	}
>>   +	/*
>> +	 * Pull out PHY from POWER DOWN state.
>> +	 * This is active low enable signal to power-down PHY.
>> +	 */
>> +	qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
>> +
> 
> Thanks. This is in sync with the requirements of USB and UFS phys
> across platforms
> using this qmp phy driver, viz. 8996 and 845.
> However, as discussed with you offline the PCIe phy has different 
> requirement.
> PCIe phy on 8996 doesn't need the QPHY_POWER_DOWN_CONTROL (pcs level 
> power down)
> before configuring the phys. Rather COM_POWER_DOWN_CONTROL is enough.
> It needs the QPHY_POWER_DOWN_CONTROL after programming the
> serdes, tx, rx, and pcs blocks, and right before doing SW_RESET, and
> START_CONTROL.
> 
> So we should just do the above QPHY_POWER_DOWN_CONTROL in
> qcom_qmp_phy_com_init() only for non-PCIe phys at the moment, and
> skip the QPHY_POWER_DOWN_CONTROL in qcom_qmp_phy_init()
> for these non-PCIe phys.
> 
> Thanks
> Vivek
> 

Sure Vivek, I shall make the change per we talked.

Thanks
Can

>>   	/* Serdes configuration */
>>   	qcom_qmp_phy_configure(serdes, cfg->regs, cfg->serdes_tbl,
>>   			       cfg->serdes_tbl_num);
