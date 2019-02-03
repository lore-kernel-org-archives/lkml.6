Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99D3C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C6020855
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfBCIt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 03:49:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:9690 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727289AbfBCIt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 03:49:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2019 00:49:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,555,1539673200"; 
   d="scan'208";a="112026283"
Received: from cvg-ubt08.iil.intel.com ([143.185.152.136])
  by orsmga007.jf.intel.com with ESMTP; 03 Feb 2019 00:49:24 -0800
From:   Vladimir Kondratiev <vladimir.kondratiev@intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] kbuild: gitignore output directory
Date:   Sun,  3 Feb 2019 10:48:40 +0200
Message-Id: <20190203084840.6113-1-vladimir.kondratiev@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <CAK7LNAS8g3g3OTtqTN8begMxzbSS82Wn0CqY8u6vuELEZaLo3g@mail.gmail.com>
References: <CAK7LNAS8g3g3OTtqTN8begMxzbSS82Wn0CqY8u6vuELEZaLo3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>

When compiling into output directory using O=, many files
created under KBUILD_OUTPUT that git considers
as new ones; git clients, ex. "git gui" lists it, and it clutters
file list making it difficult to see what was really changed

Generate .gitignore in output directory that ignores all
its content

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 141653226f3c..b1d651e822b1 100644
--- a/Makefile
+++ b/Makefile
@@ -483,10 +483,13 @@ PHONY += outputmakefile
 # outputmakefile generates a Makefile in the output directory, if using a
 # separate output directory. This allows convenient use of make in the
 # output directory.
+# At the same time when output Makefile generated, generate .gitignore to
+# ignore whole output directory
 outputmakefile:
 ifneq ($(KBUILD_SRC),)
 	$(Q)ln -fsn $(srctree) source
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree)
+	$(Q){ echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
 endif
 
 ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
-- 
2.19.1

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

