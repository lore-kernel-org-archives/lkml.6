Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC920C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A797D2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A797D2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbeIXQdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:33:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:46683 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbeIXQda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:33:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 03:32:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,297,1534834800"; 
   d="scan'208";a="91386610"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2018 03:28:41 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        hauke.mehrtens@intel.com
Cc:     Songjun Wu <songjun.wu@linux.intel.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] MIPS: lantiq: Unselect SWAP_IO_SPACE when LANTIQ is selected
Date:   Mon, 24 Sep 2018 18:27:54 +0800
Message-Id: <20180924102803.30263-6-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180924102803.30263-1-songjun.wu@linux.intel.com>
References: <20180924102803.30263-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWAP_IO_SPACE macro prevents serial driver /drivers/tty/serial/lantiq.c
to use readl/writel to replace ltq_r32/w32 which are SoC or platform
specific APIs.

readl/writel are used for this serial driver to support multiple
platforms and multiple architectures. The legacy lantiq platform(Danube)
enables SWAP_IO_SPACE for supporting PCI due to some hardware bugs.

It's a little-endian bus plus PCI TX/RX swap enable impacted both data
and control path for MIPS based platforms. But it is better to let PCI
device driver to do endian swap since SWAP_IO_SPACE is a global wide macro
which potentially impacts other peripheral like USB.
ltq_r32/ltq_w32 is not impacted in other device drivers based on MIPS when
SWAP_IO_SPACE is not selected as they use non-byte swapping OS API
(__raw_read/__raw_writel).

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 138d60cf19bc..dcc1fd39cbf3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -406,7 +406,6 @@ config LANTIQ
 	select SYS_SUPPORTS_VPE_LOADER
 	select SYS_HAS_EARLY_PRINTK
 	select GPIOLIB
-	select SWAP_IO_SPACE
 	select BOOT_RAW
 	select CLKDEV_LOOKUP
 	select USE_OF
-- 
2.11.0

