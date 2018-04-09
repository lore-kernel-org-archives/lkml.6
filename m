Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753454AbeDIRiq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 13:38:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60128 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbeDIRio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 13:38:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 13CED60807
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH 1/1] scsi/ufs: qcom: Don't enable PHY_QCOM_UFS by default
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: martin.petersen@oracle.com, kishon@ti.com, jejb@linux.vnet.ibm.com,
        subhashj@codeaurora.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20180409132404.20876-1-vivek.gautam@codeaurora.org>
 <20180409165127.GK453@tuxbook-pro>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <2588cd12-081a-5fad-7ef5-af78b18168eb@codeaurora.org>
Date: Mon, 9 Apr 2018 23:08:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180409165127.GK453@tuxbook-pro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,


On 4/9/2018 10:21 PM, Bjorn Andersson wrote:
> On Mon 09 Apr 06:24 PDT 2018, Vivek Gautam wrote:
>
>> While we try to transition from a separate ufs phy driver to a
>> more integrated qmp phy driver, don't let SCSI_UFS_QCOM to
>> enable PHY_QCOM_UFS config by default.
>> The users should enable this in their defconfigs.
>> Also add inline definitions for couple of functions -
>> a) ufs_qcom_phy_set_tx_lane_enable()
>> b) void ufs_qcom_phy_save_controller_version()
>> to enable clean build for SCSI_UFS_QCOM.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> ---
>>   drivers/scsi/ufs/Kconfig         |  1 -
>>   include/linux/phy/phy-qcom-ufs.h | 15 ++++++++++++++-
>>   2 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
>> index e27b4d4e6ae2..7e8898b6eb67 100644
>> --- a/drivers/scsi/ufs/Kconfig
>> +++ b/drivers/scsi/ufs/Kconfig
>> @@ -91,7 +91,6 @@ config SCSI_UFS_DWC_TC_PLATFORM
>>   config SCSI_UFS_QCOM
>>   	tristate "QCOM specific hooks to UFS controller platform driver"
>>   	depends on SCSI_UFSHCD_PLATFORM && ARCH_QCOM
>> -	select PHY_QCOM_UFS
> As you're depending on function in the UFS phy, which can be compiled as
> a module you might end up in a configuration where UFS_QCOM is builtin
> and the PHY_QCOM_UFS is module, which will fail to link.
>
> So you need to make this:
>
> 	depends on PHY_QCOM_UFS || PHY_QCOM_UFS=n
>
> In which case we say that if PHY_QCOM_UFS is a module UFS_QCOM must be a
> module and if PHY_QCOM_UFS is not compiled in UFS_QCOM can be either
> builtin or a module.

Thanks for reviewing. You are right. I was trying to test all possible
cases for the PHY_QCOM_UFS, and SCSI_UFS_QCOM configs, but clearly i missed
this case.
Will modify as suggested.

>>   	help
>>   	  This selects the QCOM specific additions to UFSHCD platform driver.
>>   	  UFS host on QCOM needs some vendor specific configuration before
>> diff --git a/include/linux/phy/phy-qcom-ufs.h b/include/linux/phy/phy-qcom-ufs.h
>> index 0a2c18a9771d..1388c2a2965e 100644
>> --- a/include/linux/phy/phy-qcom-ufs.h
>> +++ b/include/linux/phy/phy-qcom-ufs.h
>> @@ -31,8 +31,21 @@ void ufs_qcom_phy_enable_dev_ref_clk(struct phy *phy);
>>    */
>>   void ufs_qcom_phy_disable_dev_ref_clk(struct phy *phy);
>>   
>> +#if IS_ENABLED(CONFIG_PHY_QCOM_UFS)
>>   int ufs_qcom_phy_set_tx_lane_enable(struct phy *phy, u32 tx_lanes);
>>   void ufs_qcom_phy_save_controller_version(struct phy *phy,
>> -			u8 major, u16 minor, u16 step);
>> +					  u8 major, u16 minor, u16 step);
>> +#else
>> +static inline int ufs_qcom_phy_set_tx_lane_enable(struct phy *phy, u32 tx_lanes)
>> +{
>> +	return -ENOSYS;
>> +}
>> +
>> +static inline void ufs_qcom_phy_save_controller_version(struct phy *phy,
>> +							u8 major, u16 minor,
>> +							u16 step)
>> +{
>> +}
>> +#endif /* PHY_QCOM_UFS */
> What's the timeline for getting rid of the references to these
> functions? I presume that code depending on these being here will
> compile but won't actually work?

Yes, these inline definitions are just to keep ufs-qcom happy with the 
direct
calls that it makes to these functions.
As you would know these couple of functions are just used by the 20nm phy.
However, we don't have any platform yet in the upstream that enables 
this phy.
I am hoping that we will eventually get rid of these functions when we 
further
clean up ufs-qcom driver.

Best regards
Vivek
>
> Regards,
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
