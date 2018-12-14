Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77526C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8F721486
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789025;
	bh=jxSOx522DCKTv8/x8kr4hXDuk8BubicG0phQE09KSy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TD7Iy25q+GFYDNux2F4PFwAM0Zon/8JF6f66MnXmZ60GQsXW/NBoDpXbQRMlvydLc
	 76SPW5OeRnXatK2XSt1w0hC2S/iawGz1KeT/aLfdpoYdEaVfSVDpwz3SrLVOeS36Rs
	 3zxkCgIH31SO65UE325EnEVibKgrOnMdac6zriVI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8F721486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbeLNMDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:03:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730345AbeLNMDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:03:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECBCC2145D;
        Fri, 14 Dec 2018 12:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789019;
        bh=jxSOx522DCKTv8/x8kr4hXDuk8BubicG0phQE09KSy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zf6P6SD1E8zBTtJUes+tDkSDxskSjVVrG2GFRKF6r9lp43sa6DrO4CisXQzMUDFcY
         agRiwqutJUW99g28lQ+ibGj2BnO42pidTHJ0KO+SmYEvWEg38h37fmvENCgvK8NQOe
         BuLlA+WhxvKQ4y7PgKesW20pXUO7d+jMGAjZfWdc=
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
Subject: [PATCH 4.19 062/142] perf tools: Restore proper cwd on return from mnt namespace
Date:   Fri, 14 Dec 2018 12:59:07 +0100
Message-Id: <20181214115749.533533277@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -223,11 +231,16 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 
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
-- 
2.19.1



