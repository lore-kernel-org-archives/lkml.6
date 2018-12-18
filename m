Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8E0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996DE21871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171321;
	bh=qSD11Gom9SdN96fbp+OiH7uTAlBjF7i0hz1LWFuu0p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rcts6nkxIvLzv5Vyrlt8CPQxgCOUNWIu02FtDPnHOEhJBhTG28yKO1UdtJ7pjZg24
	 rSwNCZHEgvK+9rzHWZ9B6yQLnj4iupMMJ2q9xSb3H7otPogCkZmVt4rnN+FS2RQA3G
	 Jyoli91lekOzcSnxKnmKwsB1fcBz9mN/HG2YAmPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeLRWPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:15:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727546AbeLRWPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:15:19 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67E1B21871;
        Tue, 18 Dec 2018 22:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171318;
        bh=qSD11Gom9SdN96fbp+OiH7uTAlBjF7i0hz1LWFuu0p8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uHCrpksNkN+E1APRYaoaFnnkE02c16JY+yCkA+Na8lV1wT8r+JhyktkoswgYnCmto
         yLZitLM5IIzP18lVSpgN3TdMntYqYDLN/GsDuaFsMHCuTlARWpYaiwIuslY6f7X+Bh
         h6ct7s158yjMAbTV9ZFXeixAwI7w0oeFgAXtFl/o=
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
Subject: [PATCH 52/63] perf beauty: Add a string table generator for x86's 'arch_prctl' codes
Date:   Tue, 18 Dec 2018 19:07:22 -0300
Message-Id: <20181218220733.15839-53-acme@kernel.org>
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

  $ tools/perf/trace/beauty/x86_arch_prctl.sh
  #define x86_arch_prctl_codes_1_offset 0x1001
  static const char *x86_arch_prctl_codes_1[] = {
	[0x1001 - 0x1001]= "SET_GS",
	[0x1002 - 0x1001]= "SET_FS",
	[0x1003 - 0x1001]= "GET_FS",
	[0x1004 - 0x1001]= "GET_GS",
	[0x1011 - 0x1001]= "GET_CPUID",
	[0x1012 - 0x1001]= "SET_CPUID",
  };

  #define x86_arch_prctl_codes_2_offset 0x2001
  static const char *x86_arch_prctl_codes_2[] = {
	[0x2001 - 0x2001]= "MAP_VDSO_X32",
	[0x2002 - 0x2001]= "MAP_VDSO_32",
	[0x2003 - 0x2001]= "MAP_VDSO_64",
  };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-w0fux1psivphhx6rve8kn3vq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/x86_arch_prctl.sh | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100755 tools/perf/trace/beauty/x86_arch_prctl.sh

diff --git a/tools/perf/trace/beauty/x86_arch_prctl.sh b/tools/perf/trace/beauty/x86_arch_prctl.sh
new file mode 100755
index 000000000000..7372d3cab959
--- /dev/null
+++ b/tools/perf/trace/beauty/x86_arch_prctl.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+# Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+# SPDX-License-Identifier: LGPL-2.1
+
+[ $# -eq 1 ] && x86_header_dir=$1 || x86_header_dir=tools/arch/x86/include/uapi/asm/
+
+prctl_arch_header=${x86_header_dir}/prctl.h
+
+print_range () {
+	local idx=$1
+	local prefix=$2
+	local first_entry=$3
+
+	printf "#define x86_arch_prctl_codes_%d_offset %s\n" $idx $first_entry
+	printf "static const char *x86_arch_prctl_codes_%d[] = {\n" $idx
+	regex=`printf '^[[:space:]]*#[[:space:]]*define[[:space:]]+ARCH_([[:alnum:]_]+)[[:space:]]+(%s[[:xdigit:]]+).*' ${prefix}`
+	fmt="\t[%#x - ${first_entry}]= \"%s\",\n"
+	egrep -q $regex ${prctl_arch_header} && \
+	(egrep $regex ${prctl_arch_header} | \
+		sed -r "s/$regex/\2 \1/g"	| \
+		xargs printf "$fmt")
+	printf "};\n\n"
+}
+
+print_range 1 0x1 0x1001
+print_range 2 0x2 0x2001
-- 
2.19.2

