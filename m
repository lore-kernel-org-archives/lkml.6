Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97C5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF01217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171070;
	bh=kD5qDdgazUJZ4bfm6JtJ+vL/+wOvHg4tYlpAm70o2WM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vdra9HYo+VAAnnjk/PN/dBzjNGkz5WB+Yv2x5hwwsubWxXUdDCBU20qwnKV+ufyht
	 EOe/cY6dx/GSz08BpL++FS85AH2Ao7G1nC2WxMdRMNzIC/8cs55GhS5zPskcfOCUI4
	 lK2JJ+C/LjUjo9RKEq+m6hAnmy4Pea2DV2VSMvH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeLRWLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:11:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbeLRWIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:08:45 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AA14218A2;
        Tue, 18 Dec 2018 22:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545170925;
        bh=kD5qDdgazUJZ4bfm6JtJ+vL/+wOvHg4tYlpAm70o2WM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ElMbjWQUqUFHDUIvT7OTaBByPaaWgc5Lx9SKHXstQT/nQLkgzygVl5trF0dGWCDtl
         bgXcceF3jlYrbDytLfeQozUUCn+msIMrYgvxd511HZJET0Q6XNsZlYjiHclbAhDUlI
         9QtKA/b446whqCg7FFYMGU0MK0nQrzgOPu49wh2I=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 08/63] perf trace beauty: Beautify renameat2's fd arg wrt AT_FDCWD
Date:   Tue, 18 Dec 2018 19:06:38 -0300
Message-Id: <20181218220733.15839-9-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just like is done with the 'renameat' syscall.

  # strace -e renameat2 -f perf trace -e rename* mv c /tmp
  [pid 12334] renameat2(AT_FDCWD, "c", AT_FDCWD, "/tmp", RENAME_NOREPLACE) = -1 EXDEV (Invalid cross-device link)
  [pid 12334] renameat2(AT_FDCWD, "c", AT_FDCWD, "/tmp/c", RENAME_NOREPLACE) = -1 EEXIST (File exists)
     1.947 ( 0.007 ms): mv/12334 renameat2(olddfd: CWD, oldname: 0x7ffce8b7fd81, newdfd: CWD, newname: 0x7ffce8b7fd83, flags: 1) = -1 EXDEV Invalid cross-device link
     2.073 ( 0.009 ms): mv/12334 renameat2(olddfd: CWD, oldname: 0x7ffce8b7fd81, newdfd: CWD, newname: 0x55ce7f0a1cc0, flags: 1mv: ) = -1 EEXIST File exists'c' and '/tmp/c' are the same file
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8q9l92eh9eee3y2bwyqku3tc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 406bceda6a2b..60c61a89436f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -799,6 +799,9 @@ static struct syscall_fmt {
 	  .arg = { [2] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
 	{ .name	    = "renameat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
+	{ .name	    = "renameat2",
+	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* olddirfd */ },
+		   [2] = { .scnprintf = SCA_FDAT, /* newdirfd */ }, }, },
 	{ .name	    = "rt_sigaction",
 	  .arg = { [0] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
 	{ .name	    = "rt_sigprocmask",
-- 
2.19.2

