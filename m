Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A602C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3609A21733
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtJE16gq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3609A21733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeHTTcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:32:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeHTTcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:32:51 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FF592170E;
        Mon, 20 Aug 2018 16:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534781796;
        bh=XWDSRJPj4YRBRSDBCeUMRjbNTHKMWe4Qzqn5utl8OMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dtJE16gqG61ticM3V2gxuuug41Gecjv/zD2cJDRrsMs7pNXUlzEZKx1Zcvsp1yb7d
         3aGHsEPYKvKVBEHIrJsEft5taQfbice7TdHT5Cl/HiJwrvHWAqiR6HBHW5sT4mJ/LZ
         a/ZC/SvSTxUs3bsrBOkWOhpQ5GoP1/d5QK11t+7A=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/21] perf tools: Get rid of dso__needs_decompress() call in __open_dso()
Date:   Mon, 20 Aug 2018 13:15:48 -0300
Message-Id: <20180820161602.6830-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
References: <20180820161602.6830-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no need to call dso__needs_decompress() twice in the function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 51cf82cf1882..8ee1faa5726f 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -468,6 +468,7 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 	int fd = -EINVAL;
 	char *root_dir = (char *)"";
 	char *name = malloc(PATH_MAX);
+	bool decomp = false;
 
 	if (!name)
 		return -ENOMEM;
@@ -491,12 +492,13 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 			goto out;
 		}
 
+		decomp = true;
 		strcpy(name, newpath);
 	}
 
 	fd = do_open(name);
 
-	if (dso__needs_decompress(dso))
+	if (decomp)
 		unlink(name);
 
 out:
-- 
2.14.4

