Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EF7C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6F12184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfBFLod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:44:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:65384 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbfBFLod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:44:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 03:44:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,339,1544515200"; 
   d="scan'208";a="120367400"
Received: from cvg-ubt08.iil.intel.com ([143.185.152.136])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2019 03:44:31 -0800
From:   Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Kondratiev <vladimir.kondratiev@lnux.intel.com>,
        Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
Subject: [PATCH v2] mips: cm: reprime error cause
Date:   Wed,  6 Feb 2019 13:44:24 +0200
Message-Id: <20190206114424.24206-1-vladimir.kondratiev@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190206113413.23566-1-vladimir.kondratiev@linux.intel.com>
References: <20190206113413.23566-1-vladimir.kondratiev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Kondratiev <vladimir.kondratiev@lnux.intel.com>

Accordingly to the documentation
---cut---
The GCR_ERROR_CAUSE.ERR_TYPE field and the GCR_ERROR_MULT.ERR_TYPE
fields can be cleared by either a reset or by writing the current
value of GCR_ERROR_CAUSE.ERR_TYPE to the
GCR_ERROR_CAUSE.ERR_TYPE register.
---cut---
Do exactly this. Original value of cm_error may be safely written back;
it clears error cause and keeps other bits untouched.

Fixes: 3885c2b463f6 ("MIPS: CM: Add support for reporting CM cache errors")
Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
---
 arch/mips/kernel/mips-cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 8f5bd04f320a..7f3f136572de 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -457,5 +457,5 @@ void mips_cm_error_report(void)
 	}
 
 	/* reprime cause register */
-	write_gcr_error_cause(0);
+	write_gcr_error_cause(cm_error);
 }
-- 
2.19.1

