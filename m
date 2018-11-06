Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F32CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586532083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcnrOi4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586532083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388154AbeKFVb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:31:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387612AbeKFVb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:31:58 -0500
Received: from jouet.infradead.org (unknown [189.40.102.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 226142086B;
        Tue,  6 Nov 2018 12:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541506024;
        bh=sVC6GQlJuTsMIhL7F7h+0Cmdy/L8ecg/9Hoe7zcxtR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qcnrOi4Rl03r+A/G7ZrS8b7PtLwL+8ngMmSduTKgVtoT32piqQFizKXC1bLPzmPRu
         6QVCmBOBTWse/tpHDd1mphbXnj1HTRSw/EPu9vhmHab6Vgj+4WEwieOH4VcLW5JXcJ
         ZGjH4K2vYtPaq0eT7c+ZbXQDlsZ4fHHhIoRCcjiY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/18] perf scripts python: exported-sql-viewer.py: Fall back to /usr/local/lib/libxed.so
Date:   Tue,  6 Nov 2018 09:06:04 -0300
Message-Id: <20181106120612.8262-11-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
References: <20181106120612.8262-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Fall back to /usr/local/lib/libxed.so to cater for distributions that do
not have /usr/local/lib in the library path by default.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181104151238.15947-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 24cb0bd56afa..20cc8e7879b9 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1929,7 +1929,12 @@ class XEDInstruction():
 class LibXED():
 
 	def __init__(self):
-		self.libxed = CDLL("libxed.so")
+		try:
+			self.libxed = CDLL("libxed.so")
+		except:
+			self.libxed = None
+		if not self.libxed:
+			self.libxed = CDLL("/usr/local/lib/libxed.so")
 
 		self.xed_tables_init = self.libxed.xed_tables_init
 		self.xed_tables_init.restype = None
-- 
2.14.4

