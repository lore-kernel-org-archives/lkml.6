Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03352C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7820217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545170959;
	bh=S7RkpW6QyRD7aRXXZt+zrZiU/40iBbcmL6mif47j/Xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eoGJwsCsgOl4mdM2UC1fi20vv2ve8Rxs1KrOL/YVoVheWZGnaHIaAxltEdM8UDK/4
	 WL22zVQpsQkQLYSrb1JZU9c2aqc8ZSoKemKl0XPaS7VDLjB4Uc1hQai0RhcndOPvYp
	 PMlRRH15mtlyHM2kZkSKywX0rCOR0uMbZTXLvr5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeLRWJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:09:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727917AbeLRWJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:09:14 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65CE1218A4;
        Tue, 18 Dec 2018 22:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545170953;
        bh=S7RkpW6QyRD7aRXXZt+zrZiU/40iBbcmL6mif47j/Xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tiLyLFk4C3qaefSFIdpASK7yGxu+5N1LdRrEFrR7AQ7DlfeZoJbw8HzmG0mZ9+vgd
         7aeTkOFft8y5AZntdqzdDQiEE0n7kyw7SISZAZ/7NvK854i4yH60i6/p58jF+zaqob
         IiMbru3SbkKfotBWSP6ahMxPkSWPjrWhD3ZaIhjE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 15/63] perf header: Fix up argument to ctime()
Date:   Tue, 18 Dec 2018 19:06:45 -0300
Message-Id: <20181218220733.15839-16-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Reducing this noise when cross building to the Android NDK:

  util/header.c: In function 'perf_header__fprintf_info':
  util/header.c:2710:45: warning: pointer targets in passing argument 1 of 'ctime' differ in signedness [-Wpointer-sign]
    fprintf(fp, "# captured on    : %s", ctime(&st.st_ctime));
                                               ^
  In file included from util/../perf.h:5:0,
                   from util/evlist.h:11,
                   from util/header.c:22:
  /opt/android-ndk-r15c/platforms/android-26/arch-arm/usr/include/time.h:81:14: note: expected 'const time_t *' but argument is of type 'long unsigned int *'
   extern char* ctime(const time_t*) __LIBC_ABI_PUBLIC__;
                ^

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-6bz74zp080yhmtiwb36enso9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 1171d8400bf4..dec6d218c31c 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2698,6 +2698,7 @@ int perf_header__fprintf_info(struct perf_session *session, FILE *fp, bool full)
 	struct perf_header *header = &session->header;
 	int fd = perf_data__fd(session->data);
 	struct stat st;
+	time_t stctime;
 	int ret, bit;
 
 	hd.fp = fp;
@@ -2707,7 +2708,8 @@ int perf_header__fprintf_info(struct perf_session *session, FILE *fp, bool full)
 	if (ret == -1)
 		return -1;
 
-	fprintf(fp, "# captured on    : %s", ctime(&st.st_ctime));
+	stctime = st.st_ctime;
+	fprintf(fp, "# captured on    : %s", ctime(&stctime));
 
 	fprintf(fp, "# header version : %u\n", header->version);
 	fprintf(fp, "# data offset    : %" PRIu64 "\n", header->data_offset);
-- 
2.19.2

