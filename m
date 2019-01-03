Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B54C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55112184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519622;
	bh=IchGJ9Q3J1M+xaFMd7klGH8DUCdKbH5t7jDqjppsAas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Bjfzdn2zJhxiz5Q91LctBQnlbcCbpYfD8WyUXa/++G/E01cQPjVuWOqkbI3HZ4KR
	 Vq10Qelz7IcnIlVISSUfktE7P0iEXLffZ2jQEZSVrG+Oc4xKm4XpW3hD12LeReLjUi
	 UtAankjZ0VnoW3oEBSEo/FziYpNIYobU15rc6WYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbfACMrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:47:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731432AbfACMq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:46:57 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E89AE218A4;
        Thu,  3 Jan 2019 12:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519616;
        bh=IchGJ9Q3J1M+xaFMd7klGH8DUCdKbH5t7jDqjppsAas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0KHum1FV6iOgyytXBd5u9yl86sNaFcuGjhp24v6kV6/oZx9HZ3eM0Gm8rwN0DdpN5
         RStdE0kxo26AuUqNkVxeZGnzOGtV5xgN1UHAAKddlGXDTlEu1iWE2tsxiYl8lmzxLP
         5Zf6tcPwxioqSjpag4GnG2MwdbfmsCPaf6aFnSAk=
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
Subject: [PATCH 12/29] perf beauty ioctl: Add generator for USBDEVFS_ ioctl commands
Date:   Thu,  3 Jan 2019 09:45:52 -0300
Message-Id: <20190103124609.29672-13-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Will be associated with fds with the right device major.

  $ tools/perf/trace/beauty/usbdevfs_ioctl.sh
  static const char *usbdevfs_ioctl_cmds[] = {
	[0] = "CONTROL",
	[10] = "SUBMITURB",
	[11] = "DISCARDURB",
	[12] = "REAPURB",
	[13] = "REAPURBNDELAY",
	[14] = "DISCSIGNAL",
	[15] = "CLAIMINTERFACE",
	[16] = "RELEASEINTERFACE",
	[17] = "CONNECTINFO",
	[18] = "IOCTL",
	[19] = "HUB_PORTINFO",
	[20] = "RESET",
	[21] = "CLEAR_HALT",
	[22] = "DISCONNECT",
	[23] = "CONNECT",
	[24] = "CLAIM_PORT",
	[25] = "RELEASE_PORT",
	[26] = "GET_CAPABILITIES",
	[27] = "DISCONNECT_CLAIM",
	[28] = "ALLOC_STREAMS",
	[29] = "FREE_STREAMS",
	[2] = "BULK",
	[30] = "DROP_PRIVILEGES",
	[31] = "GET_SPEED",
	[3] = "RESETEP",
	[4] = "SETINTERFACE",
	[5] = "SETCONFIGURATION",
	[8] = "GETDRIVER",
  };

  #if 0
  static const char *usbdevfs_ioctl_32_cmds[] = {
	[0] = "CONTROL32",
	[10] = "SUBMITURB32",
	[12] = "REAPURB32",
	[13] = "REAPURBNDELAY32",
	[14] = "DISCSIGNAL32",
	[18] = "IOCTL32",
	[2] = "BULK32",
  };
  #endif
  $

Leaving the '32' variants commented, later we can try to support those
as well, from some other hint (maybe something about the thread issuing
the ioctls) and from the _IOC_SIZE(cmd).

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-neq1lrji5k4ku0rktn7ytnri@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/usbdevfs_ioctl.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100755 tools/perf/trace/beauty/usbdevfs_ioctl.sh

diff --git a/tools/perf/trace/beauty/usbdevfs_ioctl.sh b/tools/perf/trace/beauty/usbdevfs_ioctl.sh
new file mode 100755
index 000000000000..930b80f422e8
--- /dev/null
+++ b/tools/perf/trace/beauty/usbdevfs_ioctl.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
+
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
+
+printf "static const char *usbdevfs_ioctl_cmds[] = {\n"
+regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)[[:space:]]+_IO[WR]{0,2}\([[:space:]]*'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
+egrep $regex ${header_dir}/usbdevice_fs.h | egrep -v 'USBDEVFS_\w+32[[:space:]]' | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	sort | xargs printf "\t[%s] = \"%s\",\n"
+printf "};\n\n"
+printf "#if 0\n"
+printf "static const char *usbdevfs_ioctl_32_cmds[] = {\n"
+regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)[[:space:]]+_IO[WR]{0,2}\([[:space:]]*'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
+egrep $regex ${header_dir}/usbdevice_fs.h | egrep 'USBDEVFS_\w+32[[:space:]]' | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	sort | xargs printf "\t[%s] = \"%s\",\n"
+printf "};\n"
+printf "#endif\n"
-- 
2.19.2

