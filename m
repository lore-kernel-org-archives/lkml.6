Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BC8C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A3B20C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A3B20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeJIMqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 08:46:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38311 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeJIMqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 08:46:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w995V1fa910258
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 Oct 2018 22:31:01 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w995V1el910255;
        Mon, 8 Oct 2018 22:31:01 -0700
Date:   Mon, 8 Oct 2018 22:31:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sanskriti Sharma <tipbot@zytor.com>
Message-ID: <tip-470c8f7c88de013d266e1b61044efe8937728b7f@git.kernel.org>
Cc:     mingo@kernel.org, sansharm@redhat.com, jolsa@kernel.org,
        joe.lawrence@redhat.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de, acme@redhat.com
Reply-To: sansharm@redhat.com, mingo@kernel.org, tglx@linutronix.de,
          acme@redhat.com, jolsa@kernel.org, joe.lawrence@redhat.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <1538490554-8161-5-git-send-email-sansharm@redhat.com>
References: <1538490554-8161-5-git-send-email-sansharm@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Avoid double free in read_event_file()
Git-Commit-ID: 470c8f7c88de013d266e1b61044efe8937728b7f
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

Commit-ID:  470c8f7c88de013d266e1b61044efe8937728b7f
Gitweb:     https://git.kernel.org/tip/470c8f7c88de013d266e1b61044efe8937728b7f
Author:     Sanskriti Sharma <sansharm@redhat.com>
AuthorDate: Tue, 2 Oct 2018 10:29:13 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 8 Oct 2018 14:23:46 -0300

perf tools: Avoid double free in read_event_file()

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
