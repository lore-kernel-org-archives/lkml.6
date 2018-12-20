Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B96C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE83217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388281AbeLTR6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:58:13 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43493 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733211AbeLTR6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:58:12 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKHvtUQ3679473
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 09:57:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKHvs7X3679470;
        Thu, 20 Dec 2018 09:57:54 -0800
Date:   Thu, 20 Dec 2018 09:57:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-b5c2161cc415babb84d2b49599df8bd03b2b9b69@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        mingo@kernel.org, jolsa@redhat.com, hpa@zytor.com, acme@redhat.com,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, acme@redhat.com,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          mingo@kernel.org, hpa@zytor.com, jolsa@redhat.com
In-Reply-To: <20181127084634.12469-1-adrian.hunter@intel.com>
References: <20181127084634.12469-1-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf dso: Export data_file_size() method there are
 no symbols
Git-Commit-ID: b5c2161cc415babb84d2b49599df8bd03b2b9b69
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b5c2161cc415babb84d2b49599df8bd03b2b9b69
Gitweb:     https://git.kernel.org/tip/b5c2161cc415babb84d2b49599df8bd03b2b9b69
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 27 Nov 2018 10:46:34 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:21:44 -0300

perf dso: Export data_file_size() method there are no symbols

Will be used outside dso.c in a followup patch, so rename it and make it
non-static.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181127084634.12469-1-adrian.hunter@intel.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 6 +++---
 tools/perf/util/dso.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index cee717a3794f..62c8cf622607 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -894,7 +894,7 @@ static ssize_t cached_read(struct dso *dso, struct machine *machine,
 	return r;
 }
 
-static int data_file_size(struct dso *dso, struct machine *machine)
+int dso__data_file_size(struct dso *dso, struct machine *machine)
 {
 	int ret = 0;
 	struct stat st;
@@ -943,7 +943,7 @@ out:
  */
 off_t dso__data_size(struct dso *dso, struct machine *machine)
 {
-	if (data_file_size(dso, machine))
+	if (dso__data_file_size(dso, machine))
 		return -1;
 
 	/* For now just estimate dso data size is close to file size */
@@ -953,7 +953,7 @@ off_t dso__data_size(struct dso *dso, struct machine *machine)
 static ssize_t data_read_offset(struct dso *dso, struct machine *machine,
 				u64 offset, u8 *data, ssize_t size)
 {
-	if (data_file_size(dso, machine))
+	if (dso__data_file_size(dso, machine))
 		return -1;
 
 	/* Check the offset sanity. */
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index c5380500bed4..8c8a7abe809d 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -322,6 +322,7 @@ int dso__data_get_fd(struct dso *dso, struct machine *machine);
 void dso__data_put_fd(struct dso *dso);
 void dso__data_close(struct dso *dso);
 
+int dso__data_file_size(struct dso *dso, struct machine *machine);
 off_t dso__data_size(struct dso *dso, struct machine *machine);
 ssize_t dso__data_read_offset(struct dso *dso, struct machine *machine,
 			      u64 offset, u8 *data, ssize_t size);
