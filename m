Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93473C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F27214DD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F27214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933013AbeGCOob (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:44:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:61748 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932234AbeGCOo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:44:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 07:44:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,303,1526367600"; 
   d="scan'208";a="68333222"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jul 2018 07:44:13 -0700
From:   richard.gong@linux.intel.com
To:     catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, atull@kernel.org,
        mdf@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        corbet@lwn.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, yves.vandervennet@linux.intel.com,
        richard.gong@linux.intel.com, richard.gong@intel.com
Subject: [PATCHv6 8/8] Documentation: driver-api: add stratix10 service layer
Date:   Tue,  3 Jul 2018 09:46:55 -0500
Message-Id: <1530629215-26990-9-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530629215-26990-1-git-send-email-richard.gong@linux.intel.com>
References: <1530629215-26990-1-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add new file stratix10-svc.rst
Add stratix10-svc.rst to driver-api/index.rst

Signed-off-by: Richard Gong <richard.gong@intel.com>
Signed-off-by: Alan Tull <atull@kernel.org>
---
v5: this patch is added in patch set version 5
v6: no change
---
 Documentation/driver-api/index.rst         |  1 +
 Documentation/driver-api/stratix10-svc.rst | 32 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 Documentation/driver-api/stratix10-svc.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 6d9f2f9..d4d2671 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -53,6 +53,7 @@ available subsections can be seen below.
    slimbus
    soundwire/index
    fpga/index
+   stratix10-svc
 
 .. only::  subproject and html
 
diff --git a/Documentation/driver-api/stratix10-svc.rst b/Documentation/driver-api/stratix10-svc.rst
new file mode 100644
index 0000000..ed361d8
--- /dev/null
+++ b/Documentation/driver-api/stratix10-svc.rst
@@ -0,0 +1,32 @@
+
+Intel Stratix10 SoC Service Layer
+=================================
+
+Some features of the Intel Stratix10 SoC require a level of privilege
+higher than the kernel is granted. Such secure features include
+FPGA programming. In terms of the ARMv8 architecture, the kernel runs
+at Exception Level 1 (EL1), access to the features requires
+Exception Level 3 (EL3).
+
+The Intel Stratix10 SoC service layer provides an in kernel API for
+drivers to request access to the secure features. The requests are queued
+and processed one by one. ARM’s SMCCC is used to pass the execution
+of the requests on to a secure monitor (EL3).
+
+.. kernel-doc:: include/linux/stratix10-svc-client.h
+   :functions: stratix10_svc_command_code
+
+.. kernel-doc:: include/linux/stratix10-svc-client.h
+   :functions: stratix10_svc_client_msg
+
+.. kernel-doc:: include/linux/stratix10-svc-client.h
+   :functions: stratix10_svc_command_reconfig_payload
+
+.. kernel-doc:: include/linux/stratix10-svc-client.h
+   :functions: stratix10_svc_cb_data
+
+.. kernel-doc:: include/linux/stratix10-svc-client.h
+   :functions: stratix10_svc_client
+
+.. kernel-doc:: drivers/misc/stratix10-svc.c
+   :export:
-- 
2.7.4

