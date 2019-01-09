Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB70BC43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A9F20821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbfAIBgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:36:48 -0500
Received: from mga14.intel.com ([192.55.52.115]:12992 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728854AbfAIBgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 20:36:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2019 17:36:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,455,1539673200"; 
   d="scan'208";a="108388967"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008.jf.intel.com with ESMTP; 08 Jan 2019 17:36:47 -0800
Subject: [PATCH] libnvdimm/dimm: Fix security capability detection for
 non-Intel NVDIMMs
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Date:   Tue, 08 Jan 2019 17:24:11 -0800
Message-ID: <154699705105.1135364.887652664638853916.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees reports a crash with the following signature...

 RIP: 0010:nvdimm_visible+0x79/0x80
 [..]
 Call Trace:
  internal_create_group+0xf4/0x380
  sysfs_create_groups+0x46/0xb0
  device_add+0x331/0x680
  nd_async_device_register+0x15/0x60
  async_run_entry_fn+0x38/0x100

...when starting a QEMU environment with "label-less" DIMM. Without
labels QEMU does not publish any DSM methods. Without defined methods
the NVDIMM_FAMILY type is not established and the nfit driver will skip
registering security operations.

In that case the security state should be initialized to a negative
value in __nvdimm_create() and nvdimm_visible() should skip
interrogating the specific ops. However, since 'enum
nvdimm_security_state' was only defined to contain positive values the
"if (nvdimm->sec.state < 0)" check always fails.

Define a negative error state to allow negative state values to be
handled as expected.

Fixes: f2989396553a ("acpi/nfit, libnvdimm: Introduce nvdimm_security_ops")
Cc: Dave Jiang <dave.jiang@intel.com>
Reported-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/libnvdimm.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index 5440f11b0907..7315977b64da 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -160,6 +160,7 @@ static inline struct nd_blk_region_desc *to_blk_region_desc(
 }
 
 enum nvdimm_security_state {
+	NVDIMM_SECURITY_ERROR = -1,
 	NVDIMM_SECURITY_DISABLED,
 	NVDIMM_SECURITY_UNLOCKED,
 	NVDIMM_SECURITY_LOCKED,

