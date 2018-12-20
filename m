Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE21C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79711217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388417AbeLTSDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:03:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45551 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbeLTSDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:03:16 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKI37NU3680515
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:03:08 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKI37Ck3680512;
        Thu, 20 Dec 2018 10:03:07 -0800
Date:   Thu, 20 Dec 2018 10:03:07 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-4fad4xahrn04y06o0lc49clm@git.kernel.org>
Cc:     jolsa@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
        acme@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org
Reply-To: tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          jolsa@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
          acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf beauty: Wire up the renameat flags table
 generator to the Makefile
Git-Commit-ID: 5a1cb7edfbf6ee8087b75d32461775501213a8e9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5a1cb7edfbf6ee8087b75d32461775501213a8e9
Gitweb:     https://git.kernel.org/tip/5a1cb7edfbf6ee8087b75d32461775501213a8e9
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 11 Dec 2018 10:26:13 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:23:56 -0300

perf beauty: Wire up the renameat flags table generator to the Makefile

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
 
