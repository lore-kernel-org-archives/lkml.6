Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DC7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837A020870
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dDYS2V4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837A020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbeKZSqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:46:17 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49338 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbeKZSqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:46:17 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ7qsjk115623;
        Mon, 26 Nov 2018 01:52:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543218774;
        bh=BlfdRNLRUoRRGzUTjKWxFMdd3DR/JrQWVWuJlxZk7Q4=;
        h=From:To:CC:Subject:Date;
        b=dDYS2V4il7OSBu3Y/vqON8wh5Nh93W6hABGQw0oYcjQPOck9YrFN5MCoir4xpv3bA
         jM85+SnrVJ+WFJ3i33s/dq+/3mUITvCO/wNlGlWN5p71UMuVHG3iHSKrHBkpgB3rT7
         LhgeeFUrIHmqBAYWpXBWRNv9w4Df2DP/iQ733f5A=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ7qsQO083218
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 01:52:54 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 26
 Nov 2018 01:52:54 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 26 Nov 2018 01:52:54 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7qsxv006555;
        Mon, 26 Nov 2018 01:52:54 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.237.3])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7qn1E024490;
        Mon, 26 Nov 2018 01:52:50 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <tony@atomide.com>, <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH 00/16] remoteproc: Add support for TI PRU
Date:   Mon, 26 Nov 2018 09:52:33 +0200
Message-ID: <1543218769-5507-1-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the second part of the series [1] and depends on it.

It adds remoteproc support for the PRU processor cores
present in the PRU-ICSS subsystem on TI SoCs.

The PRU remoteproc driver uses the standard remoteproc core ELF
loader. However, the PRUs do not have a unified address space,
(has an Instruction RAM and a primary Data RAM at both 0x0) and
leverage an added .da_to_va ops to use the standard ELF loader.
This remoteproc driver does not have support for error recovery
and system suspend/resume features. Different compatibles are
used to allow providing scalability for instance-specific device
data if needed. The driver uses a default firmware-name retrieved
from device-tree, and the firmwares are expected to be present
in the standard Linux firmware search paths. They can also be
adjusted by userspace if required through the sysfs interface
provided by the remoteproc core.

The PRU remoteproc driver uses a client-driven boot methodology
- it does _not_ support auto-boot so that the PRU load and boot
is dictated by the corresponding client drivers for achieving
various usecases. This allows flexibility for the client drivers
or applications to set a firmware name (if needed) based on their
desired functionality and boot the PRU.

Finally it adds some helper APIs for client drivers to set
PRU specific settings .e.g Constant Table, GPI mode, etc.

Testing:
To test the code with example firmware you can try the LAB5 tutorial
http://processors.wiki.ti.com/index.php/PRU_Training:_Hands-on_Labs#LAB_5:_RPMsg_Communication_between_ARM_and_PRU
with the pru-software-support package at [2] and the sample rpmsg-client driver.
NOTE: you no longer need to build and run PRU_Halt example as shown in the tutorial.

cheers,
-roger

[1] https://lkml.org/lkml/2018/11/22/948
[2] https://github.com/rogerq/pru-software-support-package/commits/upstream/pruss

Roger Quadros (2):
  remoteproc/pru: Add pru_rproc_set_ctable() function
  remoteproc/pru: Add support for INTC Interrupt map resource

Suman Anna (9):
  remoteproc: Extend rproc_da_to_va() API with a flags parameter
  remoteproc: Add a rproc_set_firmware() API
  remoteproc: Add support to handle device specific resource types
  remoteproc/pru: Add PRU remoteproc driver
  remoteproc/pru: Add pru-specific debugfs support
  dt-bindings: remoteproc: ti-pruss: Update bindings for supporting
    rpmsg
  remoteproc/pru: Add support for virtio rpmsg stack
  remoteproc/pru: add pru_rproc_get_id() API to retrieve the PRU id
  soc: ti: pruss: add helper functions to set GPI mode, MII_RT_event and
    XFR

Tero Kristo (5):
  remoteproc/pru: add APIs to get and put the PRU cores
  dt-bindings: remoteproc: ti-pruss: Document application node bindings
  remoteproc/pru: add support for configuring GPMUX based on client
    setup
  remoteproc/pru: configure firmware based on client setup
  remoteproc/pru: add support for parsing pru interrupt mapping from DT

 .../devicetree/bindings/soc/ti/ti,pruss.txt        |   82 ++
 drivers/remoteproc/Kconfig                         |   16 +
 drivers/remoteproc/Makefile                        |    1 +
 drivers/remoteproc/imx_rproc.c                     |    2 +-
 drivers/remoteproc/keystone_remoteproc.c           |    3 +-
 drivers/remoteproc/pru_rproc.c                     | 1138 ++++++++++++++++++++
 drivers/remoteproc/pru_rproc.h                     |   55 +
 drivers/remoteproc/qcom_q6v5_mss.c                 |    5 +-
 drivers/remoteproc/qcom_q6v5_pas.c                 |    2 +-
 drivers/remoteproc/qcom_q6v5_wcss.c                |    2 +-
 drivers/remoteproc/qcom_wcnss.c                    |    2 +-
 drivers/remoteproc/remoteproc_core.c               |  112 +-
 drivers/remoteproc/remoteproc_debugfs.c            |    3 +
 drivers/remoteproc/remoteproc_elf_loader.c         |    6 +-
 drivers/remoteproc/remoteproc_internal.h           |    2 +-
 drivers/remoteproc/remoteproc_sysfs.c              |   33 +-
 drivers/remoteproc/st_slim_rproc.c                 |    3 +-
 drivers/remoteproc/wkup_m3_rproc.c                 |    3 +-
 include/linux/pruss.h                              |  168 +++
 include/linux/remoteproc.h                         |   32 +-
 20 files changed, 1620 insertions(+), 50 deletions(-)
 create mode 100644 drivers/remoteproc/pru_rproc.c
 create mode 100644 drivers/remoteproc/pru_rproc.h

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

