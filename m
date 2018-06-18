Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A40DC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F60A2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F60A2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935648AbeFRSCI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:02:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:35567 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935505AbeFRSCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:02:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 11:02:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,240,1526367600"; 
   d="scan'208";a="67958382"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga002.jf.intel.com with ESMTP; 18 Jun 2018 11:02:06 -0700
Subject: [PATCH] libnvdimm,
 pmem: Fix memcpy_mcsafe() return code handling in nsio_rw_bytes()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Jun 2018 10:52:09 -0700
Message-ID: <152934432951.24427.11070204367866836632.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 60622d68227d "x86/asm/memcpy_mcsafe: Return bytes remaining"
converted callers of memcpy_mcsafe() to expect a positive 'bytes
remaining' value rather than a negative error code. The nsio_rw_bytes()
conversion failed to return success. The failure is benign in that
nsio_rw_bytes() will end up writing back what it just read.

Fixes: 60622d68227d ("x86/asm/memcpy_mcsafe: Return bytes remaining")
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/claim.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index 2e96b34bc936..fb667bf469c7 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -278,6 +278,7 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
 			return -EIO;
 		if (memcpy_mcsafe(buf, nsio->addr + offset, size) != 0)
 			return -EIO;
+		return 0;
 	}
 
 	if (unlikely(is_bad_pmem(&nsio->bb, sector, sz_align))) {

