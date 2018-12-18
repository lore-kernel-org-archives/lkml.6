Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F31C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2D9218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545170938;
	bh=/8Mhi12BM54ekgcd/WYWNdI+/n4xL+bKUi7SkLR+TMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dPizRXY2nCyA/zsZ4YvI1SkLrwUuJE1sbVJK82jdSNXCk2IlmAm8BYILqcpstMQbz
	 Jrxk15BAF9Bce35qTxGL1RN4pOp95rxJBbK/XG+z+otjly45p+PZgPAbpOfmDw4/sG
	 0Pu5nQ+gsJLmE4I4jcHOLbpkWku8DrmPD5sxheE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeLRWI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:08:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:36862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726904AbeLRWI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:08:56 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B3BD217D9;
        Tue, 18 Dec 2018 22:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545170935;
        bh=/8Mhi12BM54ekgcd/WYWNdI+/n4xL+bKUi7SkLR+TMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wD+IsPOwpEzvniFuNicT/deqVl2VPDc200tAAawNXKkrtdMxH9ptMUvYoNZdMCZi4
         vKiwutexyARiTVK1s/s8tPyq1UBHBNYj7zYTtPnEzTjitPRt5jfHLELlqK8kl4a//z
         cvrhIGYFJuOFSeBjYWQIvnW+i3pDhyHwMNvkes+4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 10/63] perf beauty: Wire up the renameat flags table generator to the Makefile
Date:   Tue, 18 Dec 2018 19:06:40 -0300
Message-Id: <20181218220733.15839-11-acme@kernel.org>
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

Now when we run 'make -C tools/perf O=/tmp/build/perf' we end up with:

  $ cat /tmp/build/perf/trace/beauty/generated/rename_flags_array.c
  static const char *rename_flags[] = {
	[0 + 1] = "NOREPLACE",
	[1 + 1] = "EXCHANGE",
	[2 + 1] = "WHITEOUT",
  };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-4fad4xahrn04y06o0lc49clm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index bfdaefd500ab..22956a85e4c6 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -490,6 +490,12 @@ prctl_option_tbl := $(srctree)/tools/perf/trace/beauty/prctl_option.sh
 $(prctl_option_array): $(prctl_hdr_dir)/prctl.h $(prctl_option_tbl)
 	$(Q)$(SHELL) '$(prctl_option_tbl)' $(prctl_hdr_dir) > $@
 
+rename_flags_array := $(beauty_outdir)/rename_flags_array.c
+rename_flags_tbl := $(srctree)/tools/perf/trace/beauty/rename_flags.sh
+
+$(rename_flags_array): $(linux_uapi_dir)/fs.h $(rename_flags_tbl)
+	$(Q)$(SHELL) '$(rename_flags_tbl)' $(linux_uapi_dir) > $@
+
 arch_errno_name_array := $(beauty_outdir)/arch_errno_name_array.c
 arch_errno_hdr_dir := $(srctree)/tools
 arch_errno_tbl := $(srctree)/tools/perf/trace/beauty/arch_errno_names.sh
@@ -604,6 +610,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(mount_flags_array) \
 	$(perf_ioctl_array) \
 	$(prctl_option_array) \
+	$(rename_flags_array) \
 	$(arch_errno_name_array)
 
 $(OUTPUT)%.o: %.c prepare FORCE
@@ -900,6 +907,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(vhost_virtio_ioctl_array) \
 		$(OUTPUT)$(perf_ioctl_array) \
 		$(OUTPUT)$(prctl_option_array) \
+		$(OUTPUT)$(rename_flags_array) \
 		$(OUTPUT)$(arch_errno_name_array)
 	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) clean
 
-- 
2.19.2

