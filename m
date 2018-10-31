Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C51FECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B04720664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AB2N0Qf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B04720664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbeKAILS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:11:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731520AbeKAILQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:11:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3744220854;
        Wed, 31 Oct 2018 23:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027463;
        bh=gojFPBeyQ9OTSnw7s0NYVrsPphBWRNvaVVv9aMXUY7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AB2N0Qf5f2DoZsIHtK18umEdx4dxDKS2r+WLU8YYZT2VsgKXFE+kUtAoukJT2uQrI
         W0PfOUKuVZpqZEJXF43L2QMHJONNHnniJ7A7jfM+lp6CW5PkpzQbSE3d+uMSf6XxFp
         O1yf1FUPruKyInche5xaaTTqEJ6juSurF+riWXZ4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sanskriti Sharma <sansharm@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 10/48] perf strbuf: Match va_{add,copy} with va_end
Date:   Wed, 31 Oct 2018 19:10:16 -0400
Message-Id: <20181031231054.29333-10-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231054.29333-1-sashal@kernel.org>
References: <20181031231054.29333-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanskriti Sharma <sansharm@redhat.com>

[ Upstream commit ce49d8436cffa9b7a6a5f110879d53e89dbc6746 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/strbuf.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/strbuf.c b/tools/perf/util/strbuf.c
index 817593908d47..842cf3fd9235 100644
--- a/tools/perf/util/strbuf.c
+++ b/tools/perf/util/strbuf.c
@@ -105,19 +105,25 @@ static int strbuf_addv(struct strbuf *sb, const char *fmt, va_list ap)
 
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
2.17.1

