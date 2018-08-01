Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5368C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89AB9208A6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcSnD5ll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AB9208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732608AbeHAXZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732307AbeHAXZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:05 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76C9F208A5;
        Wed,  1 Aug 2018 21:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533159437;
        bh=zDJMmN84Wl1tp5JmoBNIwAdgm824+hC40OmpxmLnajM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fcSnD5llQKqM7LkbjcfylwA14wprIMu/vJVAxwsTepcuLK7xI70wwLpPYzSHDZ9BF
         ba8H61f9tcJ7I3Xy0Kjl1cP+3cAlkhdyqTqJbs9w8qcE92FbkUGvyy7gZVPpQmZm33
         /NxPxU6ASrmpc8kxBKEyUuqanTDxU06Q38GIe+Sk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 05/21] perf beauty: Add a generator for IPPROTO_ socket's protocol constants
Date:   Wed,  1 Aug 2018 18:36:32 -0300
Message-Id: <20180801213648.4814-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It'll use tools/include copy of linux/in.h to generate a table to be
used by tools, initially by the 'socket' and 'socketpair' beautifiers in
'perf trace', but that could also be used to translate from a string
constant to the integer value to be used in a eBPF or tracefs tracepoint
filter.

When used without any args it produces:

  $ tools/perf/trace/beauty/socket_ipproto.sh
  static const char *socket_ipproto[] = {
	[0] = "IP",
	[103] = "PIM",
	[108] = "COMP",
	[12] = "PUP",
	[132] = "SCTP",
	[136] = "UDPLITE",
	[137] = "MPLS",
	[17] = "UDP",
	[1] = "ICMP",
	[22] = "IDP",
	[255] = "RAW",
	[29] = "TP",
	[2] = "IGMP",
	[33] = "DCCP",
	[41] = "IPV6",
	[46] = "RSVP",
	[47] = "GRE",
	[4] = "IPIP",
	[50] = "ESP",
	[51] = "AH",
	[6] = "TCP",
	[8] = "EGP",
	[92] = "MTP",
	[94] = "BEETPH",
	[98] = "ENCAP",
  };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-v9rafqh3qn6b9kp9vfvj9f8s@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/socket_ipproto.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100755 tools/perf/trace/beauty/socket_ipproto.sh

diff --git a/tools/perf/trace/beauty/socket_ipproto.sh b/tools/perf/trace/beauty/socket_ipproto.sh
new file mode 100755
index 000000000000..a3cc24633bec
--- /dev/null
+++ b/tools/perf/trace/beauty/socket_ipproto.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
+
+printf "static const char *socket_ipproto[] = {\n"
+regex='^[[:space:]]+IPPROTO_(\w+)[[:space:]]+=[[:space:]]+([[:digit:]]+),.*'
+
+egrep $regex ${header_dir}/in.h | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	sort | xargs printf "\t[%s] = \"%s\",\n"
+printf "};\n"
-- 
2.14.4

