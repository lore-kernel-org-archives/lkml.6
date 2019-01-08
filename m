Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98656C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E8620827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfAHPpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:45:05 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36761 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbfAHPpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:45:04 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x08Fiprd3568793
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 07:44:52 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x08Fipwe3568789;
        Tue, 8 Jan 2019 07:44:51 -0800
Date:   Tue, 8 Jan 2019 07:44:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mattias Jacobsson <tipbot@zytor.com>
Message-ID: <tip-099be748865eece21362aee416c350c0b1ae34df@git.kernel.org>
Cc:     sansharm@redhat.com, jolsa@kernel.org, hpa@zytor.com,
        mingo@kernel.org, 2pi@mok.nu, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, acme@redhat.com, peterz@infradead.org
Reply-To: sansharm@redhat.com, jolsa@kernel.org, hpa@zytor.com,
          mingo@kernel.org, 2pi@mok.nu, tglx@linutronix.de,
          acme@redhat.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20181229141750.16945-1-2pi@mok.nu>
References: <20181229141750.16945-1-2pi@mok.nu>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf strbuf: Remove redundant va_end() in
 strbuf_addv()
Git-Commit-ID: 099be748865eece21362aee416c350c0b1ae34df
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

Commit-ID:  099be748865eece21362aee416c350c0b1ae34df
Gitweb:     https://git.kernel.org/tip/099be748865eece21362aee416c350c0b1ae34df
Author:     Mattias Jacobsson <2pi@mok.nu>
AuthorDate: Sat, 29 Dec 2018 15:17:50 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 4 Jan 2019 12:54:49 -0300

perf strbuf: Remove redundant va_end() in strbuf_addv()

Each call to va_copy() should have one, and only one, corresponding call
to va_end(). In strbuf_addv() some code paths result in va_end() getting
called multiple times. Remove the superfluous va_end().

Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sanskriti Sharma <sansharm@redhat.com>
Link: http://lkml.kernel.org/r/20181229141750.16945-1-2pi@mok.nu
Fixes: ce49d8436cff ("perf strbuf: Match va_{add,copy} with va_end")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/strbuf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/strbuf.c b/tools/perf/util/strbuf.c
index 9005fbe0780e..23092fd6451d 100644
--- a/tools/perf/util/strbuf.c
+++ b/tools/perf/util/strbuf.c
@@ -109,7 +109,6 @@ static int strbuf_addv(struct strbuf *sb, const char *fmt, va_list ap)
 			return ret;
 		}
 		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap_saved);
-		va_end(ap_saved);
 		if (len > strbuf_avail(sb)) {
 			pr_debug("this should not happen, your vsnprintf is broken");
 			va_end(ap_saved);
