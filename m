Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D95AC67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027F7214C2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKCFwDUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027F7214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeJIIJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:09:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbeJIIJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 04:09:31 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FF12214C2;
        Tue,  9 Oct 2018 00:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539046510;
        bh=aGROLRvqINZNUeItfmAfnvxOhR2gc3Dv3tuBQzpSWjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RKCFwDUsKUqIgUPtdM/lzRLyfswFdDRzL34ZEx7jHqAcvJIbVUAuns8+etlUeDPvw
         vjny/q+0VNnKEt8Hg3a7G+4GPCPGMC46dnWSCPO8FodTXp0hm0EKD98K++C8qcSxF7
         nL+skEz/BrPl/sZ8jWcF9eiXyJNnzzuU1tGQb/Uc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Sanskriti Sharma <sansharm@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/12] perf tools: Avoid double free in read_event_file()
Date:   Mon,  8 Oct 2018 21:54:22 -0300
Message-Id: <20181009005427.6607-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181009005427.6607-1-acme@kernel.org>
References: <20181009005427.6607-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanskriti Sharma <sansharm@redhat.com>

The temporary 'buf' buffer allocated in read_event_file() may be freed
twice.  Move the free() call to the common function exit point.

Fixes the following coverity complaints:

  Error: USE_AFTER_FREE (CWE-825):
  tools/perf/util/trace-event-read.c:309: double_free: Calling "free"
  frees pointer "buf" which has already been freed.

Signed-off-by: Sanskriti Sharma <sansharm@redhat.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Link: http://lkml.kernel.org/r/1538490554-8161-5-git-send-email-sansharm@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/trace-event-read.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index b98ee2a2eb44..a278e1eee5f5 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -297,10 +297,8 @@ static int read_event_file(struct tep_handle *pevent, char *sys,
 	}
 
 	ret = do_read(buf, size);
-	if (ret < 0) {
-		free(buf);
+	if (ret < 0)
 		goto out;
-	}
 
 	ret = parse_event_file(pevent, buf, size, sys);
 	if (ret < 0)
-- 
2.14.4

