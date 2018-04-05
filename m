Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbeDEPRA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 11:17:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751179AbeDEPQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 11:16:57 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Eugene Syromiatnikov <esyr@redhat.com>, Jiri Benc <jbenc@redhat.com>,
        Stanislav Kozina <skozina@redhat.com>,
        Jerome Marchand <jmarchan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 2/9] perf tools: Add fetch_kernel_buildid function
Date: Thu,  5 Apr 2018 17:16:38 +0200
Message-Id: <20180405151645.19130-3-jolsa@kernel.org>
In-Reply-To: <20180405151645.19130-1-jolsa@kernel.org>
References: <20180405151645.19130-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding fetch_kernel_buildid helper function to
retrieve build id from running kernel. It will
be used in following patches.

Link: http://lkml.kernel.org/n/tip-at98orsncas8v2ito61u3qod@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/util.c | 18 ++++++++++++++++++
 tools/perf/util/util.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 41fc61d941ef..26f93866bc02 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -495,6 +495,24 @@ int parse_notes_buildid(void *note_data, size_t note_len, void *bf,
 	return -1;
 }
 
+int fetch_kernel_buildid(char *buildid, int size)
+{
+	char path[PATH_MAX], *buf;
+	size_t len;
+	int err;
+
+	scnprintf(path, PATH_MAX, "%s/kernel/notes",
+		  sysfs__mountpoint());
+
+	if (filename__read_str(path, &buf, &len))
+		return -EINVAL;
+
+	err = parse_notes_buildid(buf, len, buildid, size, false);
+
+	free(buf);
+	return err;
+}
+
 const char *perf_tip(const char *dirpath)
 {
 	struct strlist *tips;
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 27106548396b..1ccaa957e3ab 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -48,6 +48,8 @@ extern int cacheline_size;
 int fetch_kernel_version(unsigned int *puint,
 			 char *str, size_t str_sz);
 
+int fetch_kernel_buildid(char *buildid, int size);
+
 int parse_notes_buildid(void *note_data, size_t note_len, void *bf,
 			size_t size, bool need_swap);
 
-- 
2.13.6
