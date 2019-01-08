Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9972C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980E5217D9
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977590;
	bh=uqXC2bdLpw4kmUxDXzHUVspxmDr2j/YekWDinGqOZis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FrPDlbze23hkdMQ3j+x2j1SWxvanmW8d5/Mesi/tXeX5DhDWJ0CWtBKPQ3+3k7BHT
	 suJ1mRaoWZ5TpPVIcUGNExdahPn2/0IK3fde8+fPeNas8Gk0gYmrgnElSYrfqQkrjv
	 Y5cNOXYj1HWYbok/wglnkgPAutD3oOquEMx2P3I0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732948AbfAHT7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:59:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:56706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731701AbfAHT7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:59:45 -0500
Received: from quaco.ghostprotocols.net (unknown [177.135.9.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 376942183F;
        Tue,  8 Jan 2019 19:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546977584;
        bh=uqXC2bdLpw4kmUxDXzHUVspxmDr2j/YekWDinGqOZis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P37dpHI2aYCL++gMlGPH4kaHipKkC1U+o220ncODVaL0O7u0gaHpxwbYJ6/cFMYec
         TTVzrnUdSZSzrWN6tCFPtPwxUiI9gxirrcWlTFTsRMTqanu45mZiqHOyYmSaQkijMe
         85z5jyUKQTbCYt8NtKogb7HkzY0VkBYN4jxbi34c=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/16] tools lib traceevent: Initialize host_bigendian at tep_handle allocation
Date:   Tue,  8 Jan 2019 16:59:00 -0300
Message-Id: <20190108195910.17726-7-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108195910.17726-1-acme@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

This patch initializes the host_bigendian member of the tep_handle
structure with the byte order of the current host, when this handler is
created - in tep_alloc() API. We need this in order to remove the
tep_set_host_bigendian() API.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181201040852.216292134@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 156e513074b2..44b80471b024 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -6762,8 +6762,10 @@ struct tep_handle *tep_alloc(void)
 {
 	struct tep_handle *pevent = calloc(1, sizeof(*pevent));
 
-	if (pevent)
+	if (pevent) {
 		pevent->ref_count = 1;
+		pevent->host_bigendian = tep_host_bigendian();
+	}
 
 	return pevent;
 }
-- 
2.20.1

