Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A25C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17ED420C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17ED420C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeJIMoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 08:44:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52937 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeJIMoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 08:44:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w995TPTT909896
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 Oct 2018 22:29:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w995TP57909893;
        Mon, 8 Oct 2018 22:29:25 -0700
Date:   Mon, 8 Oct 2018 22:29:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sanskriti Sharma <tipbot@zytor.com>
Message-ID: <tip-ce49d8436cffa9b7a6a5f110879d53e89dbc6746@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
        joe.lawrence@redhat.com, sansharm@redhat.com, jolsa@kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Reply-To: hpa@zytor.com, tglx@linutronix.de, acme@redhat.com,
          joe.lawrence@redhat.com, sansharm@redhat.com, jolsa@kernel.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1538490554-8161-2-git-send-email-sansharm@redhat.com>
References: <1538490554-8161-2-git-send-email-sansharm@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf strbuf: Match va_{add,copy} with va_end
Git-Commit-ID: ce49d8436cffa9b7a6a5f110879d53e89dbc6746
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

Commit-ID:  ce49d8436cffa9b7a6a5f110879d53e89dbc6746
Gitweb:     https://git.kernel.org/tip/ce49d8436cffa9b7a6a5f110879d53e89dbc6746
Author:     Sanskriti Sharma <sansharm@redhat.com>
AuthorDate: Tue, 2 Oct 2018 10:29:10 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 8 Oct 2018 14:23:44 -0300

perf strbuf: Match va_{add,copy} with va_end

Ensure that all code paths in strbuf_addv() call va_end() on the
ap_saved copy that was made.

Fixes the following coverity complaint:

  Error: VARARGS (CWE-237): [#def683]
  tools/perf/util/strbuf.c:106: missing_va_end: va_end was not called
  for "ap_saved".

Signed-off-by: Sanskriti Sharma <sansharm@redhat.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Link: http://lkml.kernel.org/r/1538490554-8161-2-git-send-email-sansharm@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/strbuf.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/strbuf.c b/tools/perf/util/strbuf.c
index 3d1cf5bf7f18..9005fbe0780e 100644
--- a/tools/perf/util/strbuf.c
+++ b/tools/perf/util/strbuf.c
@@ -98,19 +98,25 @@ static int strbuf_addv(struct strbuf *sb, const char *fmt, va_list ap)
 
 	va_copy(ap_saved, ap);
 	len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
-	if (len < 0)
+	if (len < 0) {
+		va_end(ap_saved);
 		return len;
+	}
 	if (len > strbuf_avail(sb)) {
 		ret = strbuf_grow(sb, len);
-		if (ret)
+		if (ret) {
+			va_end(ap_saved);
 			return ret;
+		}
 		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap_saved);
 		va_end(ap_saved);
 		if (len > strbuf_avail(sb)) {
 			pr_debug("this should not happen, your vsnprintf is broken");
+			va_end(ap_saved);
 			return -EINVAL;
 		}
 	}
+	va_end(ap_saved);
 	return strbuf_setlen(sb, sb->len + len);
 }
 
