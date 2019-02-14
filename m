Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76523C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FF9222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437236AbfBNH0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:26:08 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60218 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391612AbfBNH0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:26:08 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C44133D8BBC644916AB8;
        Thu, 14 Feb 2019 15:26:03 +0800 (CST)
Received: from [127.0.0.1] (10.65.91.35) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Thu, 14 Feb 2019
 15:25:55 +0800
Subject: Re: [PATCH net-next 2/2] net: hns3: add fixup handle for hns3 driver
To:     Florian Fainelli <f.fainelli@gmail.com>, <andrew@lunn.ch>,
        <hkallweit1@gmail.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1550118667-119947-1-git-send-email-shenjian15@huawei.com>
 <1550118667-119947-3-git-send-email-shenjian15@huawei.com>
 <a9086c2f-9d15-b3d0-9809-44385d6281ff@gmail.com>
From:   "shenjian (K)" <shenjian15@huawei.com>
Message-ID: <41b2df10-2e74-b4c6-e87c-f50c647967c3@huawei.com>
Date:   Thu, 14 Feb 2019 15:25:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <a9086c2f-9d15-b3d0-9809-44385d6281ff@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.65.91.35]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2019/2/14 12:08, Florian Fainelli 写道:
> 
> 
> On 2/13/2019 8:31 PM, Jian Shen wrote:
>> The default led configuration of marvell 88E1510 is not fit
>> for hns3 driver, this patch fixes it.
>>
>> Signed-off-by: Jian Shen <shenjian15@huawei.com>
>> ---
>>  .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c   | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
>> index 84f2878..4c8346e 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
>> @@ -2,6 +2,7 @@
>>  // Copyright (c) 2016-2017 Hisilicon Limited.
>>  
>>  #include <linux/etherdevice.h>
>> +#include <linux/marvell_phy.h>
>>  #include <linux/kernel.h>
>>  
>>  #include "hclge_cmd.h"
>> @@ -125,6 +126,13 @@ static int hclge_mdio_read(struct mii_bus *bus, int phyid, int regnum)
>>  	return le16_to_cpu(mdio_cmd->data_rd);
>>  }
>>  
>> +static int hclge_phy_marvell_fixup(struct phy_device *phydev)
>> +{
>> +	phydev->dev_flags |= MARVELL_PHY_M1510_HNS3_LEDS;
>> +
>> +	return 0;
>> +}
>> +
>>  int hclge_mac_mdio_config(struct hclge_dev *hdev)
>>  {
>>  	struct hclge_mac *mac = &hdev->hw.mac;
>> @@ -168,6 +176,15 @@ int hclge_mac_mdio_config(struct hclge_dev *hdev)
>>  	mac->phydev = phydev;
>>  	mac->mdio_bus = mdio_bus;
>>  
>> +	/* register the PHY board fixup (for Marvell 88E1510) */
>> +	ret = phy_register_fixup_for_uid(MARVELL_PHY_ID_88E1510,
>> +					 MARVELL_PHY_ID_MASK,
>> +					 hclge_phy_marvell_fixup);
>> +	/* we can live without it, so just issue a warning */
>> +	if (ret)
>> +		dev_warn(&hdev->pdev->dev,
>> +			 "Cannot register PHY board fixup\n");
> 
> You don't need to register a fixup for passing your flags, you can do
> that at the time you attach to the PHY:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/phy.h#n945
> 
> 
Thanks, will fix it in next version.
>> +
>>  	return 0;
>>  }
>>  
>> @@ -240,6 +257,8 @@ void hclge_mac_disconnect_phy(struct hnae3_handle *handle)
>>  	if (!phydev)
>>  		return;
>>  
>> +	phy_unregister_fixup_for_uid(MARVELL_PHY_ID_88E1510,
>> +				     MARVELL_PHY_ID_MASK);
>>  	phy_disconnect(phydev);
>>  }
>>  
>>
> 

