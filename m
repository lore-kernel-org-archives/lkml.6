Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5197EECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF012086E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQs0j0nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF012086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbeISUEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731889AbeISUEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:04:37 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CD3621525;
        Wed, 19 Sep 2018 14:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537367187;
        bh=lNdr2WIFySIi7nppYs0QPMsm2/vpwJ4AyqvOz95BBaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tQs0j0nm0YzDF9fY64i4CSqvLx+lj/cCkw+T7OKDtr2bXUaDHmIOrw6KVfc6gqd1Z
         L5jIg5sdfttbHOgRpwLjLGX4ZS4mvyzoieyEbOdfT+6xDaKzjgzUM+cIyLjBlKEaCK
         HpfLnE9KE9+ZKnvAT1MbLA8gL1866uNbynNx02yY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?= 
        <jeremie.galarneau@efficios.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/13] perf tools: Initialize perf_data_file fd field
Date:   Wed, 19 Sep 2018 11:25:36 -0300
Message-Id: <20180919142537.29985-13-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180919142537.29985-1-acme@kernel.org>
References: <20180919142537.29985-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérémie Galarneau <jeremie.galarneau@efficios.com>

Building the perf CTF converter fails with gcc 4.8.4 on Ubuntu 14.04
with the following error:

  error: missing initializer for field ‘fd’ of ‘struct perf_data_file’
  [-Werror=missing-field-initializers]

Per 4b838b0db4e9 ("perf tools: Add compression id into 'struct
kmod_path'") and the ensuing discussion on the mailing list, it appears
that this affects other distributions and gcc versions.

Signed-off-by: Jeremie Galarneau <jeremie.galarneau@efficios.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180829201648.19588-1-jeremie.galarneau@efficios.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data-convert-bt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index abd38abf1d91..f75d4aa612c5 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1578,7 +1578,7 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 {
 	struct perf_session *session;
 	struct perf_data data = {
-		.file.path = input,
+		.file      = { .path = input, .fd = -1 },
 		.mode      = PERF_DATA_MODE_READ,
 		.force     = opts->force,
 	};
-- 
2.14.4

