Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC41BC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7534221729
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oqb7+WuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7534221729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbeHNWEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 18:04:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727755AbeHNWEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 18:04:09 -0400
Received: from localhost.localdomain (unknown [192.55.54.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92BFB21728;
        Tue, 14 Aug 2018 19:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534274132;
        bh=Rxg8jjDPFGr/FWvE2notugq1IlsYKbV2wefZKAKXDq0=;
        h=From:To:Cc:Subject:Date:From;
        b=Oqb7+WuLfZIvRFT1pAS8WiytXT/CAYzZLSXqDzJa6/zr0T//Su7p5L2ZjPnXL6cRQ
         6LZr9tjvw4g8QYYmVB93mc5ZBBltftrWe4CsGZGJhloZugWfjrtgKaSzqMrw/7IB0f
         QK8MI4CDieA8sfnyaV9CZzHQdp4heI38JGMpAtnM=
From:   Alan Tull <atull@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Tull <atull@kernel.org>
Subject: [PATCH 0/8] fpga: Add managed create in FPGA API
Date:   Tue, 14 Aug 2018 14:15:18 -0500
Message-Id: <20180814191526.3247-1-atull@kernel.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix one functional FPGA bug.

Implement managed devm_fpga_(mgr|bridge|region)_create() functions.

More documentation cleanup to make the documentation more helpful
and to emphasize the use of FPGA regions for FPGA programming.

Fix a few minor documentation corrections.

Alan Tull (8):
  fpga: do not access region struct after fpga_region_unregister
  fpga: mgr: add devm_fpga_mgr_create
  fpga: bridge: add devm_fpga_bridge_create
  fpga: add devm_fpga_region_create
  dt-bindings: fpga: fix freeze controller compatible in region doc
  fpga: bridge: fix obvious function documentation error
  docs: fpga: document fpga manager flags
  docs: fpga: document programming fpgas using regions

 .../devicetree/bindings/fpga/fpga-region.txt       |   4 +-
 Documentation/driver-api/fpga/fpga-bridge.rst      |  37 ++-----
 Documentation/driver-api/fpga/fpga-mgr.rst         | 121 +++------------------
 Documentation/driver-api/fpga/fpga-programming.rst | 103 ++++++++++++++++++
 Documentation/driver-api/fpga/fpga-region.rst      |  91 ++++++++--------
 Documentation/driver-api/fpga/index.rst            |   2 +
 drivers/fpga/altera-cvp.c                          |   8 +-
 drivers/fpga/altera-fpga2sdram.c                   |   8 +-
 drivers/fpga/altera-freeze-bridge.c                |  13 +--
 drivers/fpga/altera-hps2fpga.c                     |   7 +-
 drivers/fpga/altera-pr-ip-core.c                   |   9 +-
 drivers/fpga/altera-ps-spi.c                       |  11 +-
 drivers/fpga/dfl-fme-br.c                          |  11 +-
 drivers/fpga/dfl-fme-mgr.c                         |  11 +-
 drivers/fpga/dfl-fme-region.c                      |  10 +-
 drivers/fpga/dfl.c                                 |   6 +-
 drivers/fpga/fpga-bridge.c                         |  74 +++++++++++--
 drivers/fpga/fpga-mgr.c                            |  67 ++++++++++--
 drivers/fpga/fpga-region.c                         |  68 ++++++++++--
 drivers/fpga/ice40-spi.c                           |  10 +-
 drivers/fpga/machxo2-spi.c                         |  11 +-
 drivers/fpga/of-fpga-region.c                      |   9 +-
 drivers/fpga/socfpga-a10.c                         |   5 +-
 drivers/fpga/socfpga.c                             |  10 +-
 drivers/fpga/ts73xx-fpga.c                         |  11 +-
 drivers/fpga/xilinx-pr-decoupler.c                 |   4 +-
 drivers/fpga/xilinx-spi.c                          |  12 +-
 drivers/fpga/zynq-fpga.c                           |   5 +-
 include/linux/fpga/fpga-bridge.h                   |   4 +
 include/linux/fpga/fpga-mgr.h                      |  22 +++-
 include/linux/fpga/fpga-region.h                   |   4 +
 31 files changed, 437 insertions(+), 331 deletions(-)
 create mode 100644 Documentation/driver-api/fpga/fpga-programming.rst

-- 
2.7.4

