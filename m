Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9785ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BE920834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayakMDUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81BE920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeJYTn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbeJYTnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:43:55 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB70B2075D;
        Thu, 25 Oct 2018 11:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540465897;
        bh=rhw7vLX5FeEZsX6hjoc+KfjM35Gh8ZD7V6g6GcNWyP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ayakMDUvjph1vIDKF9Q5x9TxKXXhmI7S9VBK1Jh2BLzKJBGAvubuV0s696EX/JmLG
         4Lj95CRvZsrdnqp247zACE/WNLb8OtaKnpmDBXDxVOoFO2nkRcFmpiMeTuK50lOa9i
         ibVt9OrafHVhtFnrgZgQ6agBT6fZVcOW189cfKMg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 18/37] perf scripts python: call-graph-from-sql.py: Set a minimum window size
Date:   Thu, 25 Oct 2018 08:10:12 -0300
Message-Id: <20181025111031.3440-19-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Prevent weirdly small window size.

Committer testing:

Seems to work, but even before this patch, on my system, it always
started with:

xwininfo: Window id: 0x1e00002 "Call Graph: pt_example"
<SNIP>
  Width: 800
  Height: 600
<SNIP>

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/call-graph-from-sql.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/scripts/python/call-graph-from-sql.py b/tools/perf/scripts/python/call-graph-from-sql.py
index e1014f2628a7..68153fa1b4d1 100644
--- a/tools/perf/scripts/python/call-graph-from-sql.py
+++ b/tools/perf/scripts/python/call-graph-from-sql.py
@@ -274,6 +274,7 @@ class MainWindow(QMainWindow):
 		style = self.style()
 		icon = style.standardIcon(QStyle.SP_MessageBoxInformation)
 		self.setWindowIcon(icon);
+		self.setMinimumSize(200, 100)
 
 		self.model = TreeModel(db)
 
-- 
2.14.4

