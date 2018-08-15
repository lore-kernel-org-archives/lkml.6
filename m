Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06938C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1024221569
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fn8xdt1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1024221569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeHPBEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 21:04:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbeHPBEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 21:04:06 -0400
Received: from localhost.localdomain (user-0ccsrjt.cable.mindspring.com [24.206.110.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14C6F21528;
        Wed, 15 Aug 2018 22:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534371003;
        bh=AOdrRv4SDDzCjjCwU/NAUQu75U9uVNCFoHfEXlKErX4=;
        h=From:To:Cc:Subject:Date:From;
        b=Fn8xdt1eEMn916aSoBPzb+xrPM7MVlRLY3OldxBnk4gkz7/God4p/tRz9t4okJ47h
         ap/OCzEgMZLxgsRKwSTFLRaoP29/NnKOdD9CaEejRBjbvPFBf9b//R23vtfCnQVGuL
         bbGkNyNq591Jha+70dfHwi6PVTEa72JigBhUnCkM=
From:   Alan Tull <atull@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, Alan Tull <atull@kernel.org>,
        Alan Tull <atull@opensource.altera.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH 1/2] fpga: doc: documentation for FPGA debugfs
Date:   Wed, 15 Aug 2018 17:09:57 -0500
Message-Id: <20180815220958.3606-1-atull@kernel.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Tull <atull@opensource.altera.com>

This patch depends on my recently submitted documentation changes
("docs: fpga: document programming fpgas using regions")

Document the DebugFS interface for the core FPGA Manager
framework.

Signed-off-by: Alan Tull <atull@kernel.org>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 Documentation/driver-api/fpga/fpga-mgr.rst | 38 ++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
index 576f194..d7ca320 100644
--- a/Documentation/driver-api/fpga/fpga-mgr.rst
+++ b/Documentation/driver-api/fpga/fpga-mgr.rst
@@ -125,3 +125,41 @@ API for implementing a new FPGA Manager driver
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
    :functions: fpga_mgr_unregister
+
+FPGA Manager DebugFS
+--------------------
+
+This interface allows the user to program an FPGA from userspace.  However,
+bridges and soft IP device driver loading/unloading are not handled.  This makes
+it really easy to mess things up by doing things like reprogramming the hardware
+out from under a driver or reprogramming while a bridge is enabled, causing gunk
+to go out on a CPU bus.  It should go without saying that this interface is for
+debug and development only.  Not intended for production use.
+
+Each FPGA gets its own directory such as <debugfs>/fpga_manager/fpga0 and the
+files described below.  To program the FPGA, write the ``flags`` and/or
+``config_complete_timeout_us`` files (as needed), then use either the
+``firmware_name`` or ``image`` file to program.
+
+* ``flags`` - [RW] flags as defined in fpga-mgr.h.  For example::
+
+   $ echo 1 > /sys/kernel/debug/fpga_manager/fpga0/flags
+
+* ``config_complete_timeout_us`` - [RW] time out in microseconds to wait for the
+  FPGA to go to operating state after region has been programmed.  Not all
+  low level drivers use this.  For example::
+
+   $ echo 4 > /sys/kernel/debug/fpga_manager/fpga0/config_complete_timeout_us
+
+* ``firmware_name`` - [RW] Name of an FPGA image firmware file.  Writing
+  initiates an FPGA programming cycle.  Note that the image file must be in a
+  directory on the firmware search path such as /lib/firmware::
+
+   $ echo image.rbf > /sys/kernel/debug/fpga_manager/fpga0/firmware_name
+
+* ``image`` - [WO] Raw FPGA image data.  Writing the FPGA image data will
+  initiate an FPGA programming cycle.  Data must be written in one chunk, for
+  example::
+
+   $ dd bs=10M if=./image.rbf of=/sys/kernel/debug/fpga_manager/fpga0/image
+    (where image.rbf < 10M)
-- 
2.7.4

