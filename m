Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E32C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B71B2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B71B2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbeHBJ7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:59:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35113 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbeHBJ7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:59:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7289Nwk3430877
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 01:09:23 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7289N7r3430874;
        Thu, 2 Aug 2018 01:09:23 -0700
Date:   Thu, 2 Aug 2018 01:09:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-v9rafqh3qn6b9kp9vfvj9f8s@git.kernel.org>
Cc:     adrian.hunter@intel.com, acme@redhat.com, hpa@zytor.com,
        mingo@kernel.org, wangnan0@huawei.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        dsahern@gmail.com, namhyung@kernel.org
Reply-To: wangnan0@huawei.com, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org,
          tglx@linutronix.de, adrian.hunter@intel.com, mingo@kernel.org,
          acme@redhat.com, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf beauty: Add a generator for IPPROTO_ socket's
 protocol constants
Git-Commit-ID: 9849eec3a44c6f47948117c14d7afb8cf53bf0fb
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

Commit-ID:  9849eec3a44c6f47948117c14d7afb8cf53bf0fb
Gitweb:     https://git.kernel.org/tip/9849eec3a44c6f47948117c14d7afb8cf53bf0fb
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 26 Jul 2018 09:26:13 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 31 Jul 2018 10:52:41 -0300

perf beauty: Add a generator for IPPROTO_ socket's protocol constants

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
