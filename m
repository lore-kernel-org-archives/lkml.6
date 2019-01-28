Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C37AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2973E20989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691668;
	bh=hwCBoP3TF53Hf3L/UK+DH2PVmqFhzQfX/W+E5YP2rqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FLd6zRQlizvMU+RLPkewKMulJAGniNQI1bwUVaGsBY1QQuKH5sNyf+lpF7ZIGq6hd
	 v65CY3mePRn/MK4dE2DbSm0vfUWWIrQkCJ+20spkqjaV6pxisI4AD4dJ9VD3ZObSxs
	 Wq5s1oGax4ZzOn/VKrgg1rlstviQbu3FigPksx68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbfA1QHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:07:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730554AbfA1QHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:07:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA76520989;
        Mon, 28 Jan 2019 16:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691663;
        bh=hwCBoP3TF53Hf3L/UK+DH2PVmqFhzQfX/W+E5YP2rqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pI6FRwGfs3PVviHZxgggzSNy7K/jrjAqa6wlX3TqPn/1w1rQtz33NPModIT/Kks3W
         d5UK7MgrQ/xwV9V8XIdV8vuxGj4L0SuSIRfSfAupE74XL94qEcQs5U4IK2HmH8d86q
         nGnF7nc4uGD+mCSM8ldXaOJyRonIkp8dbEDZFl0g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 178/258] perf header: Fix up argument to ctime()
Date:   Mon, 28 Jan 2019 10:58:04 -0500
Message-Id: <20190128155924.51521-178-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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

