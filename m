Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C60C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C33217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545170900;
	bh=LwC6vuiOy9bthH7ukgnSu801D9RBOb31M0FEPYWYR2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ieUt8FpaOEySE9sMSF2R+XQib4mNbD5SW04NrJO94hdHX0gXgWOFDBrcOWZ96kBKi
	 8yItfx96sVJG4yRaKFoDPoWMrV9k/AfW6FDf+AzxEPHjse/OW7GjPKhYPgvsjl5+qm
	 50KhHzViGQ9Blp84jkNRLNHxD9rylmtap+lbbKOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeLRWIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:08:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbeLRWIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:08:17 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B80EF218A2;
        Tue, 18 Dec 2018 22:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545170897;
        bh=LwC6vuiOy9bthH7ukgnSu801D9RBOb31M0FEPYWYR2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ec/fpzNSVm476LXtp4j+nRZkU91MTmQy1CsgJ4D0mCVh+F36CzzHpmqZybZkvbRxd
         qm4I+B0kqrjOumSIriJdmiIp5kQFnbXbHEP9cD1rNCxgWpdGacB6aWhB6No+D02kfk
         YyXVKStj6sf4BvCOA0ZYIBUXvmyJJ54fV7J3KG38=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/63] perf dso: Export data_file_size() method there are no symbols
Date:   Tue, 18 Dec 2018 19:06:31 -0300
Message-Id: <20181218220733.15839-2-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Will be used outside dso.c in a followup patch, so rename it and make it
non-static.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181127084634.12469-1-adrian.hunter@intel.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 6 +++---
 tools/perf/util/dso.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index cee717a3794f..62c8cf622607 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -894,7 +894,7 @@ static ssize_t cached_read(struct dso *dso, struct machine *machine,
 	return r;
 }
 
-static int data_file_size(struct dso *dso, struct machine *machine)
+int dso__data_file_size(struct dso *dso, struct machine *machine)
 {
 	int ret = 0;
 	struct stat st;
@@ -943,7 +943,7 @@ static int data_file_size(struct dso *dso, struct machine *machine)
  */
 off_t dso__data_size(struct dso *dso, struct machine *machine)
 {
-	if (data_file_size(dso, machine))
+	if (dso__data_file_size(dso, machine))
 		return -1;
 
 	/* For now just estimate dso data size is close to file size */
@@ -953,7 +953,7 @@ off_t dso__data_size(struct dso *dso, struct machine *machine)
 static ssize_t data_read_offset(struct dso *dso, struct machine *machine,
 				u64 offset, u8 *data, ssize_t size)
 {
-	if (data_file_size(dso, machine))
+	if (dso__data_file_size(dso, machine))
 		return -1;
 
 	/* Check the offset sanity. */
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index c5380500bed4..8c8a7abe809d 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -322,6 +322,7 @@ int dso__data_get_fd(struct dso *dso, struct machine *machine);
 void dso__data_put_fd(struct dso *dso);
 void dso__data_close(struct dso *dso);
 
+int dso__data_file_size(struct dso *dso, struct machine *machine);
 off_t dso__data_size(struct dso *dso, struct machine *machine);
 ssize_t dso__data_read_offset(struct dso *dso, struct machine *machine,
 			      u64 offset, u8 *data, ssize_t size);
-- 
2.19.2

