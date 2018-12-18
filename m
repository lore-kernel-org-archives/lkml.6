Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34232C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3047218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171353;
	bh=ae62FjCrGGhi7S9k8IQNtLUej6CZgcP4OdKeKGRk5Yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ytman3ZqCEHg1a0u+NEgDSScCtFQGeSzyl0FELebE5Ilg9/8u4E6J0G7XghoWbmCB
	 Dlx60Txg/aAAbrwBuMtnU/vAIwpobAOMYtgZ9o77h7qSi8LNbhdasY5lnBz8umhbuZ
	 NDoNMSxDydF0YRqO55B19tRG4VrgU2BQ3ImIjCmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeLRWPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:15:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbeLRWPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:15:51 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7864221871;
        Tue, 18 Dec 2018 22:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171350;
        bh=ae62FjCrGGhi7S9k8IQNtLUej6CZgcP4OdKeKGRk5Yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j/dNk2b17mDPW99JKHTnfgucNBVb9eKXUv9o6ij4seiyyx1FSS50npOy4vCNjtsxn
         iCoAV7EXYeaJRleonyYw+ZaOB3rye+lZyLpn9becq9wvelSgWG354N/eqhq7TCyobL
         SmNdsYjoaHBNO5DaPJtYi+vgj7Ei84e/FgdKSPLs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 55/63] perf trace: When showing string prefixes show prefix + ??? for unknown entries
Date:   Tue, 18 Dec 2018 19:07:25 -0300
Message-Id: <20181218220733.15839-56-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To match 'strace' output, like in:

  arch_prctl(0x3001 /* ARCH_??? */, 0x7ffc8a92dc80) = -1 EINVAL (Invalid argument)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-kx59j2dk5l1x04ou57mt99ck@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 9d30e0f3b7ea..6d9be952e3a7 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -365,8 +365,12 @@ size_t strarray__scnprintf(struct strarray *sa, char *bf, size_t size, const cha
 {
 	int idx = val - sa->offset;
 
-	if (idx < 0 || idx >= sa->nr_entries || sa->entries[idx] == NULL)
-		return scnprintf(bf, size, intfmt, val);
+	if (idx < 0 || idx >= sa->nr_entries || sa->entries[idx] == NULL) {
+		size_t printed = scnprintf(bf, size, intfmt, val);
+		if (show_prefix)
+			printed += scnprintf(bf + printed, size - printed, " /* %s??? */", sa->prefix);
+		return printed;
+	}
 
 	return scnprintf(bf, size, "%s%s", show_prefix ? sa->prefix : "", sa->entries[idx]);
 }
@@ -388,6 +392,7 @@ static size_t syscall_arg__scnprintf_strarray(char *bf, size_t size,
 
 size_t strarrays__scnprintf(struct strarrays *sas, char *bf, size_t size, const char *intfmt, bool show_prefix, int val)
 {
+	size_t printed;
 	int i;
 
 	for (i = 0; i < sas->nr_entries; ++i) {
@@ -401,7 +406,10 @@ size_t strarrays__scnprintf(struct strarrays *sas, char *bf, size_t size, const
 		}
 	}
 
-	return scnprintf(bf, size, intfmt, val);
+	printed = scnprintf(bf, size, intfmt, val);
+	if (show_prefix)
+		printed += scnprintf(bf + printed, size - printed, " /* %s??? */", sas->entries[0]->prefix);
+	return printed;
 }
 
 size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size,
-- 
2.19.2

