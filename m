Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6489C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74252214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74252214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbeKVBh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:37:28 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43765 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbeKVBh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:37:28 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wALF2Ca33416712
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 07:02:12 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wALF2C4U3416709;
        Wed, 21 Nov 2018 07:02:12 -0800
Date:   Wed, 21 Nov 2018 07:02:12 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-b01c1f69c8660eaeab7d365cd570103c5c073a02@git.kernel.org>
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org, alexander.shishkin@linux.intel.com,
        acme@redhat.com, tglx@linutronix.de, kjlx@templeofstupid.com,
        hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          namhyung@kernel.org, jolsa@kernel.org, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          acme@redhat.com, hpa@zytor.com, kjlx@templeofstupid.com
In-Reply-To: <20181101170001.30019-1-jolsa@kernel.org>
References: <20181101170001.30019-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Restore proper cwd on return from mnt
 namespace
Git-Commit-ID: b01c1f69c8660eaeab7d365cd570103c5c073a02
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

Commit-ID:  b01c1f69c8660eaeab7d365cd570103c5c073a02
Gitweb:     https://git.kernel.org/tip/b01c1f69c8660eaeab7d365cd570103c5c073a02
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 1 Nov 2018 18:00:01 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 19 Nov 2018 12:12:26 -0800

perf tools: Restore proper cwd on return from mnt namespace

When reporting on 'record' server we try to retrieve/use the mnt
namespace of the profiled tasks. We use following API with cookie to
hold the return namespace, roughly:

  nsinfo__mountns_enter(struct nsinfo *nsi, struct nscookie *nc)
    setns(newns, 0);
  ...
  new ns related open..
  ...
  nsinfo__mountns_exit(struct nscookie *nc)
    setns(nc->oldns)

Once finished we setns to old namespace, which also sets the current
working directory (cwd) to "/", trashing the cwd we had.

This is mostly fine, because we use absolute paths almost everywhere,
but it screws up 'perf diff':

  # perf diff
  failed to open perf.data: No such file or directory  (try 'perf record' first)
  ...

Adding the current working directory to be part of the cookie and
restoring it in the nsinfo__mountns_exit call.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 843ff37bb59e ("perf symbols: Find symbols in different mount namespace")
Link: http://lkml.kernel.org/r/20181101170001.30019-1-jolsa@kernel.org
[ No need to check for NULL args for free(), use zfree() for struct members ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/namespaces.c | 17 +++++++++++++++--
 tools/perf/util/namespaces.h |  1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index cf8bd123cf73..aed170bd4384 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -18,6 +18,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
+#include <asm/bug.h>
 
 struct namespaces *namespaces__new(struct namespaces_event *event)
 {
@@ -186,6 +187,7 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	char curpath[PATH_MAX];
 	int oldns = -1;
 	int newns = -1;
+	char *oldcwd = NULL;
 
 	if (nc == NULL)
 		return;
@@ -199,9 +201,13 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	if (snprintf(curpath, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
 		return;
 
+	oldcwd = get_current_dir_name();
+	if (!oldcwd)
+		return;
+
 	oldns = open(curpath, O_RDONLY);
 	if (oldns < 0)
-		return;
+		goto errout;
 
 	newns = open(nsi->mntns_path, O_RDONLY);
 	if (newns < 0)
@@ -210,11 +216,13 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	if (setns(newns, CLONE_NEWNS) < 0)
 		goto errout;
 
+	nc->oldcwd = oldcwd;
 	nc->oldns = oldns;
 	nc->newns = newns;
 	return;
 
 errout:
+	free(oldcwd);
 	if (oldns > -1)
 		close(oldns);
 	if (newns > -1)
@@ -223,11 +231,16 @@ errout:
 
 void nsinfo__mountns_exit(struct nscookie *nc)
 {
-	if (nc == NULL || nc->oldns == -1 || nc->newns == -1)
+	if (nc == NULL || nc->oldns == -1 || nc->newns == -1 || !nc->oldcwd)
 		return;
 
 	setns(nc->oldns, CLONE_NEWNS);
 
+	if (nc->oldcwd) {
+		WARN_ON_ONCE(chdir(nc->oldcwd));
+		zfree(&nc->oldcwd);
+	}
+
 	if (nc->oldns > -1) {
 		close(nc->oldns);
 		nc->oldns = -1;
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index cae1a9a39722..d5f46c09ea31 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -38,6 +38,7 @@ struct nsinfo {
 struct nscookie {
 	int			oldns;
 	int			newns;
+	char			*oldcwd;
 };
 
 int nsinfo__init(struct nsinfo *nsi);
