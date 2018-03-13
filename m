Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933069AbeCMN4j (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:56:39 -0400
Received: from omr-a018e.mx.aol.com ([204.29.186.64]:42308 "EHLO
        omr-a018e.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeCMN4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:56:31 -0400
From: Martin Vuille <jpmv27@aim.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Martin Vuille <jpmv27@aim.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] perf annotate: Don't prepend symfs path to build_id_filename
Date: Tue, 13 Mar 2018 09:56:18 -0400
Message-Id: <20180313135618.2900-1-jpmv27@aim.com>
X-Mailer: git-send-email 2.13.6
x-aol-global-disposition: G
x-aol-sid: 3039ac1afd4e5aa7d88d2938
X-AOL-IP: 99.246.128.134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

build_id_filename already contains symfs path if applicable, so
don't prepend it a second time.

- dso__build_id_filename calls build_id_cache__linkname
- build_id_cache__linkname uses buildid_dir
- when symfs option is specified, symbol__config_symfs sets
  buildid_dir to include the symfs directory

Signed-off-by: Martin Vuille <jpmv27@aim.com>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 007170efa014..0b78cc4fb155 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1381,7 +1381,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 
 	build_id_filename = dso__build_id_filename(dso, NULL, 0, false);
 	if (build_id_filename) {
-		__symbol__join_symfs(filename, filename_size, build_id_filename);
+		scnprintf(filename, filename_size, "%s", build_id_filename);
 		free(build_id_filename);
 	} else {
 		if (dso->has_build_id)
-- 
2.13.6
