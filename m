Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF39EC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A352075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TG4DAKBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A352075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeJYTnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:43:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbeJYTnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:43:53 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6448A2083E;
        Thu, 25 Oct 2018 11:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540465895;
        bh=9RQO3N866kMrIfPRlTdEM7gdAAjfBXWx4dF9Td4Ls+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TG4DAKBQifya2v7KgOrean7pfKmfJ5FP+xKJEl1803Ox1MMPE1gnRxT3nclPYYJu1
         49h3VxV9UKCgA3yzkJVXoSbrU801bFxsdDYR6pm/cOQEp5PDQ5T0zvpP/gNEQf9ghf
         1HeUGV5wr0CKtSDe/qY3dZNgCnk/tQe/51HI40ec=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/37] perf scripts python: call-graph-from-sql.py: Provide better default column sizes
Date:   Thu, 25 Oct 2018 08:10:11 -0300
Message-Id: <20181025111031.3440-18-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Set initial column sizes to improve initial display.

Committer testing:

Extended instructions on testing this, using the sqlite variant:

Make sure you have the SQLite glue for python+Qt installed, on fedora 27
I used:

  # dnf install python-pyside

Collect some PT samples, say 5-secs worth, system wide:

  # perf record -r 10 -e intel_pt//u -a sleep 5
  [ perf record: Woken up 49 times to write data ]
  [ perf record: Captured and wrote 96.131 MB perf.data ]

This results in this perf.data file:

  # ls -larth perf.data
  -rw-------. 1 root root 97M Oct 23 10:11 perf.data

With the following attributes:

  # perf evlist -v
  intel_pt//u: type: 8, size: 112, config: 0x300e601, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|IDENTIFIER, read_format: ID, disabled: 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, sample_id_all: 1
  dummy:u: type: 1, size: 112, config: 0x9, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|IDENTIFIER, read_format: ID, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, mmap2: 1, comm_exec: 1, context_switch: 1
  #

Then generate the "pt_example" tables using:

  # perf script -s ~/libexec/perf-core/scripts/python/export-to-sqlite.py pt_example branches calls
  2018-10-23 10:56:59.177711 Creating database...
  2018-10-23 10:56:59.195842 Writing records...
   instruction trace error type 1 cpu 2 pid 1644 tid 1644 ip 0x263984516750 code 5: Failed to get instruction
   instruction trace error type 1 cpu 2 pid 1644 tid 1644 ip 0x7f26e116fd20 code 6: Trace doesn't match instruction
   instruction trace error type 1 cpu 2 pid 1644 tid 1644 ip 0x7f26e162c9ee code 6: Trace doesn't match instruction
   instruction trace error type 1 cpu 2 pid 1644 tid 1644 ip 0x7f26e9ce831a code 6: Trace doesn't match instruction
  <SNIP>
   instruction trace error type 1 cpu 0 pid 1644 tid 1644 ip 0x7f26e13d07b4 code 6: Trace doesn't match instruction
  Warning:
  132 instruction trace errors
  2018-10-23 11:25:25.015717 Adding indexes
  2018-10-23 11:25:28.788061 Done
  #

In my example, that perf.data file generated this db:

  # file pt_example
  pt_example: SQLite 3.x database, last written using SQLite version 3020001
  [root@seventh perf]# ls -lah pt_example
  -rw-r--r--. 1 root root 6.6G Oct 23 11:25 pt_example
  #

Then use this python script to use that db and provide a GUI:

  $ python tools/perf/scripts/python/call-graph-from-sql.py pt_example branches calls

I compared the column widths before this patch and after applying it,
the visual results match the patch intent.

The following patches will refer to this set of instructions in the "Committer
Testing" section.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/call-graph-from-sql.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/scripts/python/call-graph-from-sql.py b/tools/perf/scripts/python/call-graph-from-sql.py
index ce1b91fcd6b8..e1014f2628a7 100644
--- a/tools/perf/scripts/python/call-graph-from-sql.py
+++ b/tools/perf/scripts/python/call-graph-from-sql.py
@@ -280,6 +280,9 @@ class MainWindow(QMainWindow):
 		self.view = QTreeView()
 		self.view.setModel(self.model)
 
+		for c, w in ((0, 250), (1, 100), (2, 60), (3, 70), (4, 70), (5, 100)):
+			self.view.setColumnWidth(c, w)
+
 		self.setCentralWidget(self.view)
 
 if __name__ == '__main__':
-- 
2.14.4

