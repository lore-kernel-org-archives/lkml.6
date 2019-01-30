Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF45DC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914172184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfA3LPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:15:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:11612 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfA3LPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:15:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 03:15:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="122532784"
Received: from cvg-ubt08.iil.intel.com ([143.185.152.136])
  by orsmga003.jf.intel.com with ESMTP; 30 Jan 2019 03:14:58 -0800
From:   Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: gitignore output directory
Date:   Wed, 30 Jan 2019 13:14:47 +0200
Message-Id: <20190130111447.26032-1-vladimir.kondratiev@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 141653226f3c..ee66ea28869b 100644
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
+	echo "# this is build directory, ignore it\n*" > .gitignore
 endif
 
 ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
-- 
2.19.1

