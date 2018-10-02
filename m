Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4D5C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF74E206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF74E206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeJBVNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:13:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbeJBVNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:13:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 252F33082E4E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Oct 2018 14:29:31 +0000 (UTC)
Received: from sansharm.bos.com (dhcp-17-34.bos.redhat.com [10.18.17.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C0A95882D;
        Tue,  2 Oct 2018 14:29:25 +0000 (UTC)
From:   Sanskriti Sharma <sansharm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: [PATCH 1/5] perf strbuf: match va_{add,copy} with va_end
Date:   Tue,  2 Oct 2018 10:29:10 -0400
Message-Id: <1538490554-8161-2-git-send-email-sansharm@redhat.com>
In-Reply-To: <1538490554-8161-1-git-send-email-sansharm@redhat.com>
References: <1538490554-8161-1-git-send-email-sansharm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 02 Oct 2018 14:29:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that all code paths in strbuf_addv() call va_end() on the
ap_saved copy that was made.

Fixes the following coverity complaint:

  Error: VARARGS (CWE-237): [#def683]
  tools/perf/util/strbuf.c:106: missing_va_end: va_end was not called
  for "ap_saved".

Signed-off-by: Sanskriti Sharma <sansharm@redhat.com>
---
 tools/perf/util/strbuf.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/strbuf.c b/tools/perf/util/strbuf.c
index 3d1cf5b..9005fbe 100644
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
 
-- 
1.8.3.1

