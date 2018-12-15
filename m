Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB408C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61422080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbeLOIHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 03:07:55 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46772 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbeLOIHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 03:07:54 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BB8939FD954B6;
        Sat, 15 Dec 2018 16:07:51 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Sat, 15 Dec 2018
 16:07:43 +0800
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <linux@armlinux.org.uk>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Weiwei Deng <dengweiwei@huawei.com>,
        "Yisen.Zhuang@huawei.com" <Yisen.Zhuang@huawei.com>,
        "huangdaode@hisilicon.com" <huangdaode@hisilicon.com>,
        "lipeng321@huawei.com" <lipeng321@huawei.com>,
        "salil.mehta@huawei.com" <salil.mehta@huawei.com>,
        lijianhua 00216010 <lijianhua@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Subject: Question: pause mode disabled for marvell 88e151x phy
Message-ID: <04b323d7-2a30-eaa5-8268-a7d3f30d989c@huawei.com>
Date:   Sat, 15 Dec 2018 16:07:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all
	When using the marvel 88e151x phy driver, the pause mode is disabled
by commit 6623c0fba10e when phy is inited as below:

 	if (phydev->interface == PHY_INTERFACE_MODE_SGMII) {
+		u32 pause;
+
 		/* Select page 18 */
 		err = marvell_set_page(phydev, 18);
 		if (err < 0)
@@ -902,6 +904,16 @@ static int m88e1510_config_init(struct phy_device *phydev)
 		err = marvell_set_page(phydev, MII_MARVELL_COPPER_PAGE);
 		if (err < 0)
 			return err;
+
+		/* There appears to be a bug in the 88e1512 when used in
+		 * SGMII to copper mode, where the AN advertisment register
+		 * clears the pause bits each time a negotiation occurs.
+		 * This means we can never be truely sure what was advertised,
+		 * so disable Pause support.
+		 */
+		pause = SUPPORTED_Pause | SUPPORTED_Asym_Pause;
+		phydev->supported &= ~pause;
+		phydev->advertising &= ~pause;
 	}


According to the commit log:
"Observed on the 88e1512 in SGMII-to-Copper mode, negotiating pause
is unreliable.  While the pause bits can be set in the advertisment
register, they clear shortly after negotiation with a link partner
commences irrespective of the cause of the negotiation."

There seems to be some problem with pause subsequent negotiation.
We reverted the above patch and tried to reproduce the above problem
by triggering another negotiation by reconnection of the cable, using
ethtool -a cmd shows both still have tx and rx pause enable.

Some doubt about the above problem:
According to 88e151x datasheet and marvel phy driver in linux, the
88e1512 and 88e1514 support SGMII-to-Copper mode, so commit above
disables the pause support for all 88e151x phy using SGMII-to-Copper
mode.

1. Does all the 88e151x supporting SGMII-to-Copper have the above problem?

2. If not, can we use revision id field in phydev->phy_id to only disable
   the pause support for specific 88e151x phy? We can not find some useful
   revision info in datasheet, and by printing the phy id when phy init, we
   are able to find that the phy we are using has a phy id as 0x1d10dd1,
   which has revision id as 0x1.

3. Does this problem only happen marvel 88e1512 phy with some specific partner
   phy? We are unable to reproduce this problem, so any suggestion to reproduce
   this would be very helpful to us too.

4. Also the commit disables the pause support completely, if using revision id
   can not aviod this problem, can we only disable pause support when negotiation
   by only clearing pause support in phydev->advertising, but not phydev->supported?

If there are any better info or suggestion regarding this problem, it would be very
helpful, thanks in advance.

reference:
[1] https://lists.openwall.net/netdev/2017/12/15/174
[2] https://web.pa.msu.edu/hep/atlas/l1calo/htm/hardware/components/Enet_Phy/marvell_alaska_phy_88e151x_datasheet_jan18.pdf

