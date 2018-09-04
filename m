Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4D3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F8C2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmhhwYpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F8C2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeIEBti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 21:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbeIEBti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 21:49:38 -0400
Received: from localhost.localdomain (unknown [136.62.81.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49A2920659;
        Tue,  4 Sep 2018 21:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536096162;
        bh=cW+xMBR03HDeieIP4VQsrA3RL1JrMwr8iU9uDPS8iKU=;
        h=From:To:Cc:Subject:Date:From;
        b=SmhhwYpxgVAm6QQbswPPZ15wemplDXYDRiEnIVQqvVoUaadmkdSkBLzsLdPK1vNUt
         AObKJw0+65E5t2MHgEcRUxMsfHs5OPYRH5Yjv0gmfeAY/9j1DqcLUQd+p4/DvPEsQt
         2iLeYtfO19VPUx3ODphOhI1cv+3pgRrsqi5w7e1g=
From:   Alan Tull <atull@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Tull <atull@kernel.org>
Subject: [PATCH v2 0/8] fpga: add devm managed create APIs
Date:   Tue,  4 Sep 2018 16:22:29 -0500
Message-Id: <20180904212237.3078-1-atull@kernel.org>
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

v2: Add Suggested-by
    Documentation changes from review comments

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
 Documentation/driver-api/fpga/fpga-programming.rst | 107 ++++++++++++++++++
 Documentation/driver-api/fpga/fpga-region.rst      |  91 ++++++++--------
 Documentation/driver-api/fpga/index.rst            |   2 +
 Documentation/driver-api/fpga/intro.rst            |   2 +-
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
 include/linux/fpga/fpga-mgr.h                      |  24 +++-
 include/linux/fpga/fpga-region.h                   |   4 +
 32 files changed, 444 insertions(+), 332 deletions(-)
 create mode 100644 Documentation/driver-api/fpga/fpga-programming.rst

-- 
2.7.4

