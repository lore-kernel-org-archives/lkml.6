Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1001C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3E3217AC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3E3217AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbeHMN4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 09:56:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728310AbeHMN4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 09:56:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1872E7C809;
        Mon, 13 Aug 2018 11:15:07 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36E0F10FD2BA;
        Mon, 13 Aug 2018 11:15:05 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     namhyung@kernel.org, dsahern@gmail.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        alexander.kapshuk@gmail.com
Subject: [PATCH 1/2] perf tools: Make check-headers.sh check based on kernel dir
Date:   Mon, 13 Aug 2018 13:15:03 +0200
Message-Id: <20180813111504.3568-1-jolsa@kernel.org>
In-Reply-To: <20180811083915.17471-1-alexander.kapshuk@gmail.com>
References: <20180811083915.17471-1-alexander.kapshuk@gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 13 Aug 2018 11:15:07 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 13 Aug 2018 11:15:07 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing the logic to compare files with paths relative
to kernel source base dir. This way we can keep the output
message for 2 unrelated files, which is coming in following
patch.

Link: http://lkml.kernel.org/n/tip-gpfv1vdqfjda80m451w9a7mt@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/check-headers.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index ea48aa6f8d19..9d466e853aec 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -69,8 +69,8 @@ check_2 () {
 
   test -f $file2 && {
     eval $cmd || {
-      echo "Warning: Kernel ABI header at 'tools/$file' differs from latest version at '$file'" >&2
-      echo diff -u tools/$file $file
+      echo "Warning: Kernel ABI header at '$file1' differs from latest version at '$file2'" >&2
+      echo diff -u $file1 $file2
     }
   }
 }
@@ -80,7 +80,7 @@ check () {
 
   shift
 
-  check_2 ../$file ../../$file $*
+  check_2 tools/$file $file $*
 }
 
 # Check if we have the kernel headers (tools/perf/../../include), else
@@ -88,6 +88,8 @@ check () {
 # differences.
 test -d ../../include || exit 0
 
+pushd ../.. > /dev/null
+
 # simple diff check
 for i in $HEADERS; do
   check $i -B
@@ -98,3 +100,5 @@ check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/ex
 check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>"'
 check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common.h>"'
 check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
+
+popd > /dev/null
-- 
2.17.1

