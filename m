Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AF0C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE4F20870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y9CSHlUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE4F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeJJVnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:43:35 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49498 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeJJVnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:43:33 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9AEKwaE040849;
        Wed, 10 Oct 2018 09:20:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539181258;
        bh=At5xssb5PLPYf8oMrAyyajQD1xZlFZKccX7Uu2FAURY=;
        h=From:To:CC:Subject:Date;
        b=Y9CSHlUrZAu9HFWJXaQ366BXDdLttJKFGCM7OkCrhoh52W8Wm04xSkqa0Q3MVLYD2
         ydzk5lISknYhPlMVyILGUbndObKc4b19VFzQgCtgBfdQhPrJwj4/EXDXZfIpBPiO/N
         an/uiZMXIhoTaVIt5BKUuPu9MAXvRZOLfmPIubwQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9AEKwGb028437;
        Wed, 10 Oct 2018 09:20:58 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 10
 Oct 2018 09:20:58 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 10 Oct 2018 09:20:57 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9AEKv71021342;
        Wed, 10 Oct 2018 09:20:57 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.138.183])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w9AEKvx06334;
        Wed, 10 Oct 2018 09:20:57 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH 0/3] M_CAN Framework rework
Date:   Wed, 10 Oct 2018 09:20:52 -0500
Message-ID: <20181010142055.25271-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All

This patch series creates a m_can core framework that devices can register
to.  The m_can core manages the Bosch IP and CAN frames.  Each device that
is registered is responsible for managing device specific functions.

This rewrite was suggested in a device driver submission for the TCAN4x5x
device
Reference upstream post:
https://lore.kernel.org/patchwork/patch/984163/

For instance the TCAN device is a SPI device that uses a specific data payload to
determine writes and reads.  In addition the device has a reset input as well
as a wakeup pin.  The register offset of the m_can registers differs and must
be set by the device attached to the core.

The m_can core will use iomapped writes and reads as the default mechanism for
writing and reading.  The device driver can provide over rides for this.

This patch series is not complete as it does not handle the CAN interrupts
nor can perform a CAN write.  If this patch series is deemed acceptable I will
finish debugging the driver and post a non RFC series.

Finally I did attempt to reduce the first patch with various git format patch
directives but none seemed to reduce the patch.

Dan

Dan Murphy (3):
  can: m_can: Create m_can core to leverage common code
  dt-bindings: can: tcan4x5x: Add DT bindings for TCAN4x5X driver
  can: tcan4x5x: Add tcan4x5x driver to the kernel

 .../devicetree/bindings/net/can/tcan4x5x.txt  |   34 +
 drivers/net/can/m_can/Kconfig                 |   18 +
 drivers/net/can/m_can/Makefile                |    4 +-
 drivers/net/can/m_can/m_can.c                 | 1683 +----------------
 .../net/can/m_can/{m_can.c => m_can_core.c}   |  479 +++--
 drivers/net/can/m_can/m_can_core.h            |  100 +
 drivers/net/can/m_can/tcan4x5x.c              |  321 ++++
 7 files changed, 722 insertions(+), 1917 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
 copy drivers/net/can/m_can/{m_can.c => m_can_core.c} (83%)
 create mode 100644 drivers/net/can/m_can/m_can_core.h
 create mode 100644 drivers/net/can/m_can/tcan4x5x.c

-- 
2.19.0

