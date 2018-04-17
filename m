Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752831AbeDQV2W (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 17:28:22 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:54220 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752310AbeDQV2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 17:28:20 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <ssantosh@kernel.org>,
        <malat@debian.org>, <w-kwok2@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
Subject: [net-next PATCH v4 00/13] Add support for netcp driver on K2G SoC
Date: Tue, 17 Apr 2018 17:30:29 -0400
Message-ID: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K2G SoC is another variant of Keystone family of SoCs. This patch
series add support for NetCP driver on this SoC. The QMSS found on
K2G SoC is a cut down version of the QMSS found on other keystone
devices with less number of queues, internal link ram etc. The patch
series has 2 patch sets that goes into the drivers/soc and the
rest has to be applied to net sub system. Please review and merge
if this looks good.

K2G TRM is located at http://www.ti.com/lit/ug/spruhy8g/spruhy8g.pdf
Thanks

The boot logs on K2G ICE board (tftp boot over Ethernet and from mmc)
https://pastebin.ubuntu.com/p/yvZ6drFhkW/


The boot logs on K2G GP board (tftp boot over Ethernet and from mmc)
https://pastebin.ubuntu.com/p/QTr6K7s4Zp/

Also regressed boot on K2HK and K2L EVMs as we have modified GBE
version detection logic (K2E uses same version of NetCP as in K2L.
So regression on one of them is needed).

Boot log on K2L and K2HK EVMs are at
https://pastebin.ubuntu.com/p/N9DBdPjbvR/ 

This series applies to net-next master branch.

Change history:
  v4 - ready for merge to net-next
       Folded the series "Add promiscous mode support in k2g network driver"
       into this.
       Fixed a typo in 5/11 (sgmii to rgmii) based on TI internal comment
       Reworked 4/11 and title changed to reflect additional changes to
       exclude sgmii configuration code for 2U cpsw. Use IS_SS_ID_2U()
       macro for customization.
       Added Reviewed-by from Rob Herring against 1/13
  v3 - Addressed comments from Andrew Lunn and Grygorii Strashko
       against v2. 
  v2 - Addressed following comments on initial version
       - split patch 3/5 to multiple patches from Andrew Lunn

Murali Karicheri (11):
  soc: ti: K2G: enhancement to support QMSS in K2G NAVSS
  soc: ti: K2G: provide APIs to support driver probe deferral
  net: netcp: ethss: use macro for checking ss_version consistently
  net: netcp: ethss: make sgmii configuration conditional
  net: netcp: ethss: add support for handling rgmii link interface
  net: netcp: ethss: use rgmii link status for 2u cpsw hardware
  net: netcp: ethss: map vlan priorities to zero flow
  net: netcp: ethss: re-use stats handling code for 2u hardware
  net: netcp: ethss: use of_get_phy_mode() to support different RGMII
    modes
  Revert "net: netcp: remove dead code from the driver"
  net: netcp: support probe deferral

WingMan Kwok (2):
  net: netcp: add api to support set rx mode in netcp modules
  net: netcp: ethss: k2g: add promiscuous mode support

 .../bindings/soc/ti/keystone-navigator-qmss.txt    |   9 +-
 drivers/net/ethernet/ti/netcp.h                    |   3 +
 drivers/net/ethernet/ti/netcp_core.c               |  32 ++++
 drivers/net/ethernet/ti/netcp_ethss.c              | 181 +++++++++++++++++----
 drivers/soc/ti/knav_dma.c                          |   8 +
 drivers/soc/ti/knav_qmss.h                         |   6 +
 drivers/soc/ti/knav_qmss_queue.c                   |  98 ++++++++---
 include/linux/soc/ti/knav_dma.h                    |  12 ++
 include/linux/soc/ti/knav_qmss.h                   |   1 +
 9 files changed, 297 insertions(+), 53 deletions(-)

-- 
1.9.1
