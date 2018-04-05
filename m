Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751534AbeDEPQ5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 11:16:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751179AbeDEPQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 11:16:54 -0400
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
Subject: [PATCH 1/9] perf tools: Make read_build_id function public
Date: Thu,  5 Apr 2018 17:16:37 +0200
Message-Id: <20180405151645.19130-2-jolsa@kernel.org>
In-Reply-To: <20180405151645.19130-1-jolsa@kernel.org>
References: <20180405151645.19130-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And renaming it into parse_notes_buildid to be more
precise and usable in following patches.

Link: http://lkml.kernel.org/n/tip-v1mz76rkdxfnbfz2v05fumn6@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/symbol-minimal.c | 50 ++--------------------------------------
 tools/perf/util/util.c           | 48 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/util.h           |  4 ++++
 3 files changed, 54 insertions(+), 48 deletions(-)

diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index ff48d0d49584..bd281d3dc508 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -24,53 +24,6 @@ static bool check_need_swap(int file_endian)
 	return host_endian != file_endian;
 }
 
-#define NOTE_ALIGN(sz) (((sz) + 3) & ~3)
-
-#define NT_GNU_BUILD_ID	3
-
-static int read_build_id(void *note_data, size_t note_len, void *bf,
-			 size_t size, bool need_swap)
-{
-	struct {
-		u32 n_namesz;
-		u32 n_descsz;
-		u32 n_type;
-	} *nhdr;
-	void *ptr;
-
-	ptr = note_data;
-	while (ptr < (note_data + note_len)) {
-		const char *name;
-		size_t namesz, descsz;
-
-		nhdr = ptr;
-		if (need_swap) {
-			nhdr->n_namesz = bswap_32(nhdr->n_namesz);
-			nhdr->n_descsz = bswap_32(nhdr->n_descsz);
-			nhdr->n_type = bswap_32(nhdr->n_type);
-		}
-
-		namesz = NOTE_ALIGN(nhdr->n_namesz);
-		descsz = NOTE_ALIGN(nhdr->n_descsz);
-
-		ptr += sizeof(*nhdr);
-		name = ptr;
-		ptr += namesz;
-		if (nhdr->n_type == NT_GNU_BUILD_ID &&
-		    nhdr->n_namesz == sizeof("GNU")) {
-			if (memcmp(name, "GNU", sizeof("GNU")) == 0) {
-				size_t sz = min(size, descsz);
-				memcpy(bf, ptr, sz);
-				memset(bf + sz, 0, size - sz);
-				return 0;
-			}
-		}
-		ptr += descsz;
-	}
-
-	return -1;
-}
-
 int filename__read_debuglink(const char *filename __maybe_unused,
 			     char *debuglink __maybe_unused,
 			     size_t size __maybe_unused)
@@ -153,7 +106,8 @@ int filename__read_build_id(const char *filename, void *bf, size_t size)
 			if (fread(buf, buf_size, 1, fp) != 1)
 				goto out_free;
 
-			ret = read_build_id(buf, buf_size, bf, size, need_swap);
+			ret = parse_notes_buildid(buf, buf_size, bf, size,
+						  need_swap);
 			if (ret == 0)
 				ret = size;
 			break;
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 1019bbc5dbd8..41fc61d941ef 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -447,6 +447,54 @@ fetch_kernel_version(unsigned int *puint, char *str,
 	return 0;
 }
 
+#define NOTE_ALIGN(sz) (((sz) + 3) & ~3)
+
+#define NT_GNU_BUILD_ID	3
+
+int parse_notes_buildid(void *note_data, size_t note_len, void *bf,
+			size_t size, bool need_swap)
+{
+	struct {
+		u32 n_namesz;
+		u32 n_descsz;
+		u32 n_type;
+	} *nhdr;
+	void *ptr;
+
+	ptr = note_data;
+	while (ptr < (note_data + note_len)) {
+		const char *name;
+		size_t namesz, descsz;
+
+		nhdr = ptr;
+		if (need_swap) {
+			nhdr->n_namesz = bswap_32(nhdr->n_namesz);
+			nhdr->n_descsz = bswap_32(nhdr->n_descsz);
+			nhdr->n_type = bswap_32(nhdr->n_type);
+		}
+
+		namesz = NOTE_ALIGN(nhdr->n_namesz);
+		descsz = NOTE_ALIGN(nhdr->n_descsz);
+
+		ptr += sizeof(*nhdr);
+		name = ptr;
+		ptr += namesz;
+		if (nhdr->n_type == NT_GNU_BUILD_ID &&
+		    nhdr->n_namesz == sizeof("GNU")) {
+			if (memcmp(name, "GNU", sizeof("GNU")) == 0) {
+				size_t sz = min(size, descsz);
+
+				memcpy(bf, ptr, sz);
+				memset(bf + sz, 0, size - sz);
+				return 0;
+			}
+		}
+		ptr += descsz;
+	}
+
+	return -1;
+}
+
 const char *perf_tip(const char *dirpath)
 {
 	struct strlist *tips;
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 9496365da3d7..27106548396b 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -47,6 +47,10 @@ extern int cacheline_size;
 
 int fetch_kernel_version(unsigned int *puint,
 			 char *str, size_t str_sz);
+
+int parse_notes_buildid(void *note_data, size_t note_len, void *bf,
+			size_t size, bool need_swap);
+
 #define KVER_VERSION(x)		(((x) >> 16) & 0xff)
 #define KVER_PATCHLEVEL(x)	(((x) >> 8) & 0xff)
 #define KVER_SUBLEVEL(x)	((x) & 0xff)
-- 
2.13.6
