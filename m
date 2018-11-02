Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF664C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A920D2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A920D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeKCEcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:32:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52480 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbeKCEcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:32:23 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA2JNiD9077269;
        Fri, 2 Nov 2018 14:23:44 -0500
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA2JNib2045062
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Nov 2018 14:23:44 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 2 Nov
 2018 14:23:44 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 2 Nov 2018 14:23:44 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA2JNfvU000522;
        Fri, 2 Nov 2018 14:23:41 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-can@vger.kernel.org>
CC:     <wg@grandegger.com>, <mkl@pengutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <kishon@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH 0/6] Add Support for MCAN transceivers in AM65x-evm
Date:   Sat, 3 Nov 2018 00:56:10 +0530
Message-ID: <20181102192616.28291-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add support for CAN transceivers in the AM65x-evm.

The legacy transceiver implementation has a transceiver node as a child of the
m_can node with a max-bitrate property which is read directly by the 
of_can_transceiver() API. The transceivers on the present platform however,
require some configuration (pulling the gpio connected to the stb line of
the transceiver low) before they can start sending messages.

The new implementation models the transceiver as a phy and implements the
max-bitrate as a phy attribute.

patch 1 adds the max_bitrate attribute to the phy core. It also implements the API
to be used by the consumer to get the attribute.

patches 2 & 3 implement a generic phy driver for simple implementations.

patches 4,5 & 6 implement the transceiver as a phy to the m_can driver.

Note: Pinmux and GPIO support for am65x-evm are not yet implemented in upstream.
So I tested this implementation with some out of tree patches on top of linux-next.
dts patches will be posted as soon as the above frameworks are available.

Faiz Abbas (6):
  phy: Add max_bitrate attribute & phy_get_max_bitrate()
  dt-bindings: phy: phy-of-simple: Document new binding
  phy: phy-of-simple: Add support for simple generic phy driver
  dt-bindings: can: m_can: Document transceiver implementation as a phy
  dt-bindings: can: can-transceiver: Remove legacy binding documentation
  can: m_can: Add support for transceiver as phy

 .../bindings/net/can/can-transceiver.txt      | 24 -----
 .../devicetree/bindings/net/can/m_can.txt     | 24 +++--
 .../devicetree/bindings/phy/phy-of-simple.txt | 29 ++++++
 drivers/net/can/m_can/m_can.c                 | 23 ++++-
 drivers/phy/Kconfig                           |  7 ++
 drivers/phy/Makefile                          |  1 +
 drivers/phy/phy-of-simple.c                   | 90 +++++++++++++++++++
 include/linux/phy/phy.h                       |  5 ++
 8 files changed, 170 insertions(+), 33 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/can/can-transceiver.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-of-simple.txt
 create mode 100644 drivers/phy/phy-of-simple.c

-- 
2.18.0

