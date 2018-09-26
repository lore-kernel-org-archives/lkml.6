Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB747C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BF421531
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lM5EReX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BF421531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbeIZW0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:26:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbeIZW0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:26:07 -0400
Received: from localhost.localdomain (user-0ccsrjt.cable.mindspring.com [24.206.110.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F52B2151C;
        Wed, 26 Sep 2018 16:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537978348;
        bh=33TV/+XaIUDpufwMbFUhy2R1V/Z01HcvA1T6OInGDRc=;
        h=From:To:Cc:Subject:Date:From;
        b=lM5EReX1JX8MwDD2YeJBNChjlxz1dk0N2c4tf7MGqT+kQyJwzeVcKz6BDyZhkWnoM
         m26Ry9O20/crjeEROgVmsx82javTC+KuPfSHDZMmkbGzDGaUCvU0Q1CkfaxnO3BSvB
         H0PwHIPgRGN0PlcPZFkBxt9zjlsQH1EGRBGili70=
From:   Alan Tull <atull@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Federico Vaga <federico.vaga@cern.ch>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, Alan Tull <atull@kernel.org>
Subject: [PATCH v3 0/4] fpga: add devm managed create APIs
Date:   Wed, 26 Sep 2018 11:12:18 -0500
Message-Id: <1537978342-17697-1-git-send-email-atull@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement managed devm_fpga_(mgr|bridge|region)_create() functions.

Patchset is dependent on the patches that were acked/sent upstream:
   https://lkml.org/lkml/2018/9/12/639

v3 changes:
* take out unclear explanation fpga_(mgr|br|region)_unregister
* Add acks
* drop the separately resent "dt-bindings: fpga: fix freeze controller compatible in region doc"
* drop some of the acked patches that I send to Greg

Alan Tull (4):
  fpga: mgr: add devm_fpga_mgr_create
  fpga: bridge: add devm_fpga_bridge_create
  fpga: add devm_fpga_region_create
  docs: fpga: document programming fpgas using regions

 Documentation/driver-api/fpga/fpga-bridge.rst      |  37 ++----
 Documentation/driver-api/fpga/fpga-mgr.rst         | 126 +++------------------
 Documentation/driver-api/fpga/fpga-programming.rst | 107 +++++++++++++++++
 Documentation/driver-api/fpga/fpga-region.rst      |  91 +++++++--------
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
 drivers/fpga/dfl-fme-region.c                      |   6 +-
 drivers/fpga/dfl.c                                 |   6 +-
 drivers/fpga/fpga-bridge.c                         |  68 +++++++++--
 drivers/fpga/fpga-mgr.c                            |  64 +++++++++--
 drivers/fpga/fpga-region.c                         |  65 +++++++++--
 drivers/fpga/ice40-spi.c                           |  10 +-
 drivers/fpga/machxo2-spi.c                         |  11 +-
 drivers/fpga/of-fpga-region.c                      |   6 +-
 drivers/fpga/socfpga-a10.c                         |   5 +-
 drivers/fpga/socfpga.c                             |  10 +-
 drivers/fpga/ts73xx-fpga.c                         |  11 +-
 drivers/fpga/xilinx-pr-decoupler.c                 |   4 +-
 drivers/fpga/xilinx-spi.c                          |  12 +-
 drivers/fpga/zynq-fpga.c                           |   5 +-
 include/linux/fpga/fpga-bridge.h                   |   4 +
 include/linux/fpga/fpga-mgr.h                      |   4 +
 include/linux/fpga/fpga-region.h                   |   4 +
 31 files changed, 412 insertions(+), 326 deletions(-)
 create mode 100644 Documentation/driver-api/fpga/fpga-programming.rst

-- 
2.7.4

