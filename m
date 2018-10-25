Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED984ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EB120848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fpg0t/nr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4EB120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeJYTo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:44:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727459AbeJYTo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:44:26 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1EC220834;
        Thu, 25 Oct 2018 11:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540465928;
        bh=fD6WVXjAEahrP7aGh0d8oz+cmT9nxJdmMFTkSj95+PM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fpg0t/nrK6T/DKXV2Tu8GqIB2LO3ZDxf3fpphIIgTRduHzpu/jW7Xk3NQSdAAGWgq
         DhXISLaXrPus1yqIz/rTh9b5uA/DzxM4QjoJrSdMr+8Dbq4gj7qd11HJ8AnbHnydJB
         1R5KU/x/oqykwXvzjj4Zml2LXpSSvOugnhvKK/E0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 30/37] perf scripts python: exported-sql-viewer.py: Add ability to shrink / enlarge font
Date:   Thu, 25 Oct 2018 08:10:24 -0300
Message-Id: <20181025111031.3440-31-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Shrinking the font allows more information to display.

Committer testing:

Works, tested with the convenient Control+Shift+'+' and Control+'-' as
well with the more cumbersome top menu "Edit" + "Enlarge/Shrink font"
options.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-16-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 0386a600ffc7..310ba7147583 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -706,6 +706,20 @@ class WindowMenu():
 	def setActiveSubWindow(self, nr):
 		self.mdi_area.setActiveSubWindow(self.mdi_area.subWindowList()[nr - 1])
 
+# Font resize
+
+def ResizeFont(widget, diff):
+	font = widget.font()
+	sz = font.pointSize()
+	font.setPointSize(sz + diff)
+	widget.setFont(font)
+
+def ShrinkFont(widget):
+	ResizeFont(widget, -1)
+
+def EnlargeFont(widget):
+	ResizeFont(widget, 1)
+
 # Unique name for sub-windows
 
 def NumberedWindowName(name, nr):
@@ -765,6 +779,8 @@ class MainWindow(QMainWindow):
 
 		edit_menu = menu.addMenu("&Edit")
 		edit_menu.addAction(CreateAction("&Find...", "Find items", self.Find, self, QKeySequence.Find))
+		edit_menu.addAction(CreateAction("&Shrink Font", "Make text smaller", self.ShrinkFont, self, [QKeySequence("Ctrl+-")]))
+		edit_menu.addAction(CreateAction("&Enlarge Font", "Make text bigger", self.EnlargeFont, self, [QKeySequence("Ctrl++")]))
 
 		reports_menu = menu.addMenu("&Reports")
 		reports_menu.addAction(CreateAction("Context-Sensitive Call &Graph", "Create a new window containing a context-sensitive call graph", self.NewCallGraph, self))
@@ -779,6 +795,14 @@ class MainWindow(QMainWindow):
 			except:
 				pass
 
+	def ShrinkFont(self):
+		win = self.mdi_area.activeSubWindow()
+		ShrinkFont(win.view)
+
+	def EnlargeFont(self):
+		win = self.mdi_area.activeSubWindow()
+		EnlargeFont(win.view)
+
 	def NewCallGraph(self):
 		CallGraphWindow(self.glb, self)
 
-- 
2.14.4

