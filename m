Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0D8C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894D620C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894D620C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeJIMqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 08:46:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44639 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeJIMqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 08:46:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w995VXNQ910303
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 Oct 2018 22:31:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w995VXBC910300;
        Mon, 8 Oct 2018 22:31:33 -0700
Date:   Mon, 8 Oct 2018 22:31:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sanskriti Sharma <tipbot@zytor.com>
Message-ID: <tip-1e44224fb0528b4c0cc176bde2bb31e9127eb14b@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org,
        joe.lawrence@redhat.com, sansharm@redhat.com, acme@redhat.com,
        mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com
Reply-To: joe.lawrence@redhat.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          sansharm@redhat.com, acme@redhat.com, tglx@linutronix.de,
          hpa@zytor.com
In-Reply-To: <1538490554-8161-6-git-send-email-sansharm@redhat.com>
References: <1538490554-8161-6-git-send-email-sansharm@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Free temporary 'sys' string in
 read_event_files()
Git-Commit-ID: 1e44224fb0528b4c0cc176bde2bb31e9127eb14b
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

Commit-ID:  1e44224fb0528b4c0cc176bde2bb31e9127eb14b
Gitweb:     https://git.kernel.org/tip/1e44224fb0528b4c0cc176bde2bb31e9127eb14b
Author:     Sanskriti Sharma <sansharm@redhat.com>
AuthorDate: Tue, 2 Oct 2018 10:29:14 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 8 Oct 2018 14:23:46 -0300

perf tools: Free temporary 'sys' string in read_event_files()

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
---
 tools/perf/util/trace-event-read.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index a278e1eee5f5..add8441de579 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -347,9 +347,12 @@ static int read_event_files(struct tep_handle *pevent)
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
