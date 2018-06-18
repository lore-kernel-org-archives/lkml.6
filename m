Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97047C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418022083A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="QfClRbOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418022083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935072AbeFRRGf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:06:35 -0400
Received: from alln-iport-4.cisco.com ([173.37.142.91]:42251 "EHLO
        alln-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933501AbeFRRGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:06:34 -0400
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Jun 2018 13:06:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1624; q=dns/txt; s=iport;
  t=1529341594; x=1530551194;
  h=from:to:cc:subject:date:message-id;
  bh=N3wMoz+PM82/jSafjpB1WORKx6rdkh1miyN3Dt5WEvs=;
  b=QfClRbOy/ncP/qBnSDH4As1sEgJEGgTt69SC4JE4N4O8nxjXnj4xU0Zg
   P9ls9Ki8FEm1xg8kr6rC2mcbFYepIGgb/Iz5saxki3cXqy2nPMLK1K5XE
   TQF2SouqKPfrf6lLSrDDesD4Y2y78pzqqhd2DjJTZVqHuHnsICzul2c6t
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DgAACf4ydb/40NJK1bGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYNIgWEoi32MUIJ0k3yBeAuEbIJhITQYAQIBAQEBAQECbSi?=
 =?us-ascii?q?GKCmBFRODJYIAAawniESBaBSIQIFUP4EPgleEc4YNAo0hi3UJjn4LjToBK5E?=
 =?us-ascii?q?igUE4gVIzGggbFYJ+kG9PAY4IgkgBAQ?=
X-IronPort-AV: E=Sophos;i="5.51,240,1526342400"; 
   d="scan'208";a="131260321"
Received: from alln-core-8.cisco.com ([173.36.13.141])
  by alln-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 16:57:07 +0000
Received: from sjc-ads-2388.cisco.com (sjc-ads-2388.cisco.com [171.70.63.76])
        by alln-core-8.cisco.com (8.14.5/8.14.5) with ESMTP id w5IGv61r025191;
        Mon, 18 Jun 2018 16:57:06 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     xe-kernel@external.cisco.com,
        "Guilherme G . Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Gavin Shan <gwshan@linux.vnet.ibm.com>,
        Ian Munsie <imunsie@au1.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arch: powerpc: pci-common: fix wrong return value check on phd_id
Date:   Mon, 18 Jun 2018 09:57:06 -0700
Message-Id: <20180618165706.42679-1-danielwa@cisco.com>
X-Mailer: git-send-email 2.10.3.dirty
X-Auto-Response-Suppress: DR, OOF, AutoReply
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cisco has a couple platforms which depend on the domain values getting
set a certain way. We discovered our machines not detecting the pci
devices, and traced it back to this commit,

63a7228 powerpc/pci: Assign fixed PHB number based on device-tree
properties

It seems that the code is expecting the return value of of_property_read_u64()
to be the opposite of what it actually is.. It returns zero on success, and a
negative return value on error. So if you only check when it's non-zero your
going to set Opal for all platforms but Opal, which I assume is not what was
expected.

Fix is just to negate the ret value.

Cc: xe-kernel@external.cisco.com
Cc: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Fixes: 63a72284b159 ("powerpc/pci: Assign fixed PHB number based on device-tree properties")
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 arch/powerpc/kernel/pci-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index fe9733f..0a1bcbe 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -89,7 +89,7 @@ static int get_phb_number(struct device_node *dn)
 	 * reading "ibm,opal-phbid", only present in OPAL environment.
 	 */
 	ret = of_property_read_u64(dn, "ibm,opal-phbid", &prop);
-	if (ret) {
+	if (!ret) {
 		ret = of_property_read_u32_index(dn, "reg", 1, &prop_32);
 		prop = prop_32;
 	}
-- 
2.10.3.dirty

