Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EBAC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAD42147D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789316;
	bh=jRhRDEZfrcx30+167hz9xPCDphFrjTQq0o9tuViYok0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B6TKcSxYdZO6NBR233qBh6lTuvAS1URafW+rZRpIQzabjrmdaWaHtq1dTWOZE7vyq
	 RsB7Pm8vlMlBp+8KeNHf4r5t0BguyuEjawZok31Yd7DBKIdYlEa/CQYy8StbayHvBj
	 MmU31GXP/KgiWg9vsGTGFLFetoSs3mBkVPQXrd/k=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAD42147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbeLNMIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:08:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:53968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731280AbeLNMIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:08:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB616214AE;
        Fri, 14 Dec 2018 12:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789310;
        bh=jRhRDEZfrcx30+167hz9xPCDphFrjTQq0o9tuViYok0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hq3vwblw8gCjHTmEc73Hs5SLCS87CShgy213gc6sqy3EojOlxwOe/aHHSHBvv2RHO
         U+8swCszZGcNCq2OpecukhTy+wrMIEKQB9po6q8fR5OzIpNFr4imJZPZZtTutU6Wj7
         sZ9Uo7m2UUT2iDfAzulEO2mYHz84DoVNZODUXEGI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 33/89] perf tools: Restore proper cwd on return from mnt namespace
Date:   Fri, 14 Dec 2018 12:59:46 +0100
Message-Id: <20181214115731.318917308@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b01c1f69c8660eaeab7d365cd570103c5c073a02 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/namespaces.c | 17 +++++++++++++++--
 tools/perf/util/namespaces.h |  1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 1ef0049860a8..eadc7ddacbf6 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -17,6 +17,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
+#include <asm/bug.h>
 
 struct namespaces *namespaces__new(struct namespaces_event *event)
 {
@@ -185,6 +186,7 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	char curpath[PATH_MAX];
 	int oldns = -1;
 	int newns = -1;
+	char *oldcwd = NULL;
 
 	if (nc == NULL)
 		return;
@@ -198,9 +200,13 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
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
@@ -209,11 +215,13 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
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
@@ -222,11 +230,16 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 
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
index 05d82601c9a6..23584a6dd048 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -36,6 +36,7 @@ struct nsinfo {
 struct nscookie {
 	int			oldns;
 	int			newns;
+	char			*oldcwd;
 };
 
 int nsinfo__init(struct nsinfo *nsi);
-- 
2.19.1



