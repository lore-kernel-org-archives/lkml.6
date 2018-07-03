Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C198C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCFE20875
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCFE20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932458AbeGCOnh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:43:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:10704 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932219AbeGCOnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:43:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 07:43:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,303,1526367600"; 
   d="scan'208";a="68333030"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jul 2018 07:43:32 -0700
From:   richard.gong@linux.intel.com
To:     catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, atull@kernel.org,
        mdf@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        corbet@lwn.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, yves.vandervennet@linux.intel.com,
        richard.gong@linux.intel.com, richard.gong@intel.com
Subject: [PATCHv6 0/8] Add Intel Stratix10 FPGA manager and service layer 
Date:   Tue,  3 Jul 2018 09:46:47 -0500
Message-Id: <1530629215-26990-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

This is the 6th submission of Intel stratix10 service layer patches. Intel
Stratix10 FPGA manager, which is 1st Stratix10 service layer client, is
included in this submission.

Stratix10 service layer patches have been reviewed internally by Alan Tull
and other colleagues at Intel.

Some features of the Intel Stratix10 SoC require a level of privilege
higher than the kernel is granted. Such secure features include
FPGA programming. In terms of the ARMv8 architecture, the kernel runs
at Exception Level 1 (EL1), access to the features requires
Exception Level 3 (EL3).

The Intel Stratix10 service layer provides an in kernel API for drivers to
request access to the secure features. The requests are queued and
processed one by one. ARM’s SMCCC is used to pass the execution of the
requests on to a secure monitor (EL3).

Later the Intel Stratix10 service layer driver will be extended to provide
services for QSPI, Crypto and warm reset.

v2: add patches for FPGA manager, FPGA manager binding, dts and defconfig
    remove intel-service subdirectory and intel-service.h, move intel-smc.h
    and intel-service.c to driver/misc subdirectory
    remove global variables
    change service layer driver be 'default n'
    correct SPDX markers
    add timeout for do..while() loop
    add kernel-doc for the functions and structs, correct multiline comments
    replace kfifo_in/kfifo_out with kfifo_in_spinlocked/kfifo_out_spinlocked
    rename struct intel_svc_data (at client header) to intel_svc_client_msg
    rename struct intel_svc_private_mem to intel_svc_data
    other corrections/changes from Intel internal code reviews
v3: change all exported functions with "intel_svc_" as the prefix
    increase timeout values for claiming back submitted buffer(s)
    rename struct intel_command_reconfig_payload to
    struct intel_svc_command_reconfig_payload
    add pr_err() to provide the error return value
    change to put fpga_mgr node under firmware/svc node
    change to FPGA manager to align the update of service client APIs, and the
    update of fpga_mgr device node
    Other corrections/changes
v4: s/intel/stratix10/ on some variables, structs, functions, and file names
    intel-service.c -> stratix10-svc.c
    intel-smc.h -> stratix10-smc.h
    intel-service-client.h -> stratix10-svc-client.h
    remove non-kernel-doc formatting
    s/fpga-mgr@0/fpga-mgr/ to remove unit_address at fpga_mgr node
    add Rob's Reviewed-by
    add Richard's signed-off-by
v5: add a new API statix10_svc_done() which is called by service client
    when client request is completed or error occurs during request
    process. Which allows service layer to free its resources.
    remove dummy client from service layer client header and service layer
    source file.
    add Rob's Reviewed-by
    add a new file stratix10-svc.rst and add that to driver-api/index.rst
    kernel-doc fixes
v6: replace kthread_create_on_cpu() with kthread_create_on_node()
    extend stratix_svc_send() to support service client which doesn't use
    memory allocated by service layer
    add S10_RECONFIG_TIMEOUT
    rename s/S10_BUF_TIMEOUT/S10_BUFFER_TIMEOUT/
    fix service layer and FPGA manager Klocwork errors

Alan Tull (3):
  dt-bindings: fpga: add Stratix10 SoC FPGA manager binding
  arm64: dts: stratix10: add fpga manager and region
  fpga: add intel stratix10 soc fpga manager driver

Richard Gong (5):
  dt-bindings, firmware: add Intel Stratix10 service layer binding
  arm64: dts: stratix10: add stratix10 service driver binding to base
    dtsi
  driver, misc: add Intel Stratix10 service layer driver
  defconfig: enable fpga and service layer
  Documentation: driver-api: add stratix10 service layer

 .../bindings/firmware/intel,stratix10-svc.txt      |   57 ++
 .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt |   17 +
 Documentation/driver-api/index.rst                 |    1 +
 Documentation/driver-api/stratix10-svc.rst         |   32 +
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |   48 +
 arch/arm64/configs/defconfig                       |    6 +
 drivers/fpga/Kconfig                               |    6 +
 drivers/fpga/Makefile                              |    1 +
 drivers/fpga/stratix10-soc.c                       |  553 +++++++++++
 drivers/misc/Kconfig                               |   12 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/stratix10-smc.h                       |  205 ++++
 drivers/misc/stratix10-svc.c                       | 1000 ++++++++++++++++++++
 include/linux/stratix10-svc-client.h               |  201 ++++
 14 files changed, 2140 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
 create mode 100644 Documentation/driver-api/stratix10-svc.rst
 create mode 100644 drivers/fpga/stratix10-soc.c
 create mode 100644 drivers/misc/stratix10-smc.h
 create mode 100644 drivers/misc/stratix10-svc.c
 create mode 100644 include/linux/stratix10-svc-client.h

-- 
2.7.4

