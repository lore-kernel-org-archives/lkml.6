Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDA5C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE852081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896401;
	bh=SYk5uCgsQWlBdDX/VgnMlvE7FQqeI+o4uDljeQiBGZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FVxfQ4jIKLvYiWA/opDYDrMY95x5D5Z2vbR2DRhSo0hBM35DJbIuri4m/SZeB1k10
	 pZsTIeGQlw/3YYM31JFnSxMyAx6nUl/yTX+mGdU8W6Y/tY4wzFsC95KUIGju6jJvHK
	 FzsKYsW48Lshl1T56QCA5OjfMGiHx8VSEFWSIJn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733281AbfBKOqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:46:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:59734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733247AbfBKOqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:46:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CECE206BA;
        Mon, 11 Feb 2019 14:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896394;
        bh=SYk5uCgsQWlBdDX/VgnMlvE7FQqeI+o4uDljeQiBGZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R60raL4oDz51XC+UD3c0uYJN8hhnOqBn1BT74pJLN3nz8jvsEFmsnWKPBj/+WD8jx
         kFR5TU4As3MPcQXCg8X6Xp5yrf+BKcXyM4kbeyBmIyJMSVdqR6eqFOks1Ei31jyvu8
         +ROp3Y/6N/cWVK4JCpkDReR+DBk7/gUkFH3fVuCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 170/313] perf header: Fix up argument to ctime()
Date:   Mon, 11 Feb 2019 15:17:30 +0100
Message-Id: <20190211141904.768861358@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0afcf29bab35d3785204cd9bd51693b231ad7181 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/header.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index ac3c59e7da16..bd9226bc5945 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2636,6 +2636,7 @@ int perf_header__fprintf_info(struct perf_session *session, FILE *fp, bool full)
 	struct perf_header *header = &session->header;
 	int fd = perf_data__fd(session->data);
 	struct stat st;
+	time_t stctime;
 	int ret, bit;
 
 	hd.fp = fp;
@@ -2645,7 +2646,8 @@ int perf_header__fprintf_info(struct perf_session *session, FILE *fp, bool full)
 	if (ret == -1)
 		return -1;
 
-	fprintf(fp, "# captured on    : %s", ctime(&st.st_ctime));
+	stctime = st.st_ctime;
+	fprintf(fp, "# captured on    : %s", ctime(&stctime));
 
 	fprintf(fp, "# header version : %u\n", header->version);
 	fprintf(fp, "# data offset    : %" PRIu64 "\n", header->data_offset);
-- 
2.19.1



