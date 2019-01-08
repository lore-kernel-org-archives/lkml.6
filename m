Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF34C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D7520827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfAHPqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:46:12 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38363 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbfAHPqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:46:12 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x08Fk45H3569207
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 07:46:04 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x08Fk4R83569204;
        Tue, 8 Jan 2019 07:46:04 -0800
Date:   Tue, 8 Jan 2019 07:46:04 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-klt3n0i58dfqttveti09q3fi@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, jolsa@kernel.org, namhyung@kernel.org,
        hpa@zytor.com, mingo@kernel.org, acme@redhat.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          adrian.hunter@intel.com, jolsa@kernel.org, namhyung@kernel.org,
          hpa@zytor.com, acme@redhat.com, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf test shell: Use a fallback to get the
 pathname in vfs_getname
Git-Commit-ID: 03fa483821c0b4db7c2b1453d3332f397d82313f
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

Commit-ID:  03fa483821c0b4db7c2b1453d3332f397d82313f
Gitweb:     https://git.kernel.org/tip/03fa483821c0b4db7c2b1453d3332f397d82313f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 4 Jan 2019 15:10:00 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 4 Jan 2019 15:12:29 -0300

perf test shell: Use a fallback to get the pathname in vfs_getname

Some kernels, like 4.19.13-300.fc29.x86_64 in fedora 29, fail with the
existing probe definition asking for the contents of result->name,
working when we ask for the 'filename' variable instead, so add a
fallback to that.

Now those tests are back working on fedora 29 systems with that kernel:

  # perf test vfs_getname
  65: Use vfs_getname probe to get syscall args filenames   : Ok
  66: Add vfs_getname probe to get syscall args filenames   : Ok
  67: Check open filename arg using perf trace + vfs_getname: Ok
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-klt3n0i58dfqttveti09q3fi@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/lib/probe_vfs_getname.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 1c16e56cd93e..7cb99b433888 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -13,7 +13,8 @@ add_probe_vfs_getname() {
 	local verbose=$1
 	if [ $had_vfs_getname -eq 1 ] ; then
 		line=$(perf probe -L getname_flags 2>&1 | egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
-		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=result->name:string"
+		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
+		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
 	fi
 }
 
