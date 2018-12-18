Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C48C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F08218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171279;
	bh=PXvFE2FimfYS75RqLtMki4t/fXe4v1ylfRs7wCqzstE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QLJHv6Mfz/eFkFUnYm8pvnR159UpU7rOxhtS/wG7ioXJy3eHmGc/Xhhvc06Q3IhN8
	 XYqxII4swKjWUhu9jaYlv1+O7WX6aMKOFd7Q7ob6YMhdcjrp67G/K7O+qV5IummkqO
	 Fg89EJLiRMOiP+EJEa1FPv4wqCalGHHIOm+Hnct0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbeLRWOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:14:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbeLRWOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:14:37 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 722B921871;
        Tue, 18 Dec 2018 22:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171276;
        bh=PXvFE2FimfYS75RqLtMki4t/fXe4v1ylfRs7wCqzstE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DmIA8VF+Dk4S9H46yuzuo/TeTsNs5YfNxcVr8B8LmecJhPfE/F1bhK7OfvXCgcL7h
         djSqNAoVrCcptHZjON/K7BfGFy5USfjSa5RJ2BblGiyTC88p5GkeGOoii3vWj/QJWi
         CSVesWE5rXCZ2o+hpFujcKJFzQrVhRyFS1YDrSyU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 46/63] perf trace beauty: Print O_RDONLY when (flags & O_ACCMODE) == 0
Date:   Tue, 18 Dec 2018 19:07:16 -0300
Message-Id: <20181218220733.15839-47-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

And there are more flags, to match strace's output.

 openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3

Also to help with regression tests.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ofovpmvdli3bwch30936xn7t@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/open_flags.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/open_flags.c b/tools/perf/trace/beauty/open_flags.c
index 6da48893a1bb..78f6566ef110 100644
--- a/tools/perf/trace/beauty/open_flags.c
+++ b/tools/perf/trace/beauty/open_flags.c
@@ -27,8 +27,10 @@ size_t open__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool sh
 	const char *prefix = "O_";
 	int printed = 0;
 
+	if ((flags & O_ACCMODE) == O_RDONLY)
+		printed = scnprintf(bf, size, "%s%s", show_prefix ? prefix : "", "RDONLY");
 	if (flags == 0)
-		return scnprintf(bf, size, "%s%s", show_prefix ? prefix : "", "RDONLY");
+		return printed;
 #define	P_FLAG(n) \
 	if (flags & O_##n) { \
 		printed += scnprintf(bf + printed, size - printed, "%s%s%s", printed ? "|" : "", show_prefix ? prefix : "", #n); \
-- 
2.19.2

