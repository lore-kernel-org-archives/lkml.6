Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922B3ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B1F20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogTYXr7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B1F20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbeKAIka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:40:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727802AbeKAIIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:08:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 427732081B;
        Wed, 31 Oct 2018 23:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027289;
        bh=iIs37oMI0J+wd0O3eAfzOumMgM63rXt1f9fEPWOkA4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ogTYXr7SSgtkviFk6t5HiMzn8PIfYgDUr1XhBZKgIl8mNjPKkd+urcgcoSV3nubME
         hf6JJZcqWwh3eLPRifAjCwjJWQZGaZu+BapTtslrkENcb+Xoyhz6Qf3xpU1VQLuWqK
         0MGmlwp3kJvPXziaQgCW2yjJRIqUZMwDxByNS1II=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sanskriti Sharma <sansharm@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 016/126] perf tools: Free temporary 'sys' string in read_event_files()
Date:   Wed, 31 Oct 2018 19:06:04 -0400
Message-Id: <20181031230754.29029-16-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanskriti Sharma <sansharm@redhat.com>

[ Upstream commit 1e44224fb0528b4c0cc176bde2bb31e9127eb14b ]

For each system in a given pevent, read_event_files() reads in a
temporary 'sys' string.  Be sure to free this string before moving onto
to the next system and/or leaving read_event_files().

Fixes the following coverity complaints:

  Error: RESOURCE_LEAK (CWE-772):

  tools/perf/util/trace-event-read.c:343: overwrite_var: Overwriting
  "sys" in "sys = read_string()" leaks the storage that "sys" points to.

  tools/perf/util/trace-event-read.c:353: leaked_storage: Variable "sys"
  going out of scope leaks the storage it points to.

Signed-off-by: Sanskriti Sharma <sansharm@redhat.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Link: http://lkml.kernel.org/r/1538490554-8161-6-git-send-email-sansharm@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/trace-event-read.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index 40b425949aa3..2d50e4384c72 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -349,9 +349,12 @@ static int read_event_files(struct pevent *pevent)
 		for (x=0; x < count; x++) {
 			size = read8(pevent);
 			ret = read_event_file(pevent, sys, size);
-			if (ret)
+			if (ret) {
+				free(sys);
 				return ret;
+			}
 		}
+		free(sys);
 	}
 	return 0;
 }
-- 
2.17.1

