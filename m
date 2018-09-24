Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD37ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A9E21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A9E21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388112AbeIXSeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:34:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58078 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbeIXSeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:34:02 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DD315109A;
        Mon, 24 Sep 2018 12:32:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sandipan Das <sandipan@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Maynard Johnson <maynard@us.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 048/235] perf tests: Fix record+probe_libc_inet_pton.sh for powerpc64
Date:   Mon, 24 Sep 2018 13:50:34 +0200
Message-Id: <20180924113110.026098187@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sandipan Das <sandipan@linux.ibm.com>

[ Upstream commit 3eae52f842329a95f8549124079518231c0daba8 ]

For powerpc64, this test currently fails due to a mismatch in the
expected output.

This can be observed on a powerpc64le system running Fedora 27 as shown
below.

  # perf test -v "probe libc's inet_pton & backtrace it with ping"

Before:

  62: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 23948
  ping 23965 [003] 71136.075084: probe_libc:inet_pton: (7fff996aaf28)
  7fff996aaf28 __GI___inet_pton+0x8 (/usr/lib64/libc-2.26.so)
  7fff9965fa54 gaih_inet.constprop.7+0xf44 (/usr/lib64/libc-2.26.so)
  FAIL: expected backtrace entry 2 "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib64/libc-2.26.so\)$" got "7fff9965fa54 gaih_inet.constprop.7+0xf44 (/usr/lib64/libc-2.26.so)"
  test child finished with -1
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: FAILED!

After:

  62: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 24638
  ping 24655 [001] 71208.525396: probe_libc:inet_pton: (7fffa245af28)
  7fffa245af28 __GI___inet_pton+0x8 (/usr/lib64/libc-2.26.so)
  7fffa240fa54 gaih_inet.constprop.7+0xf44 (/usr/lib64/libc-2.26.so)
  7fffa24105b4 getaddrinfo+0x164 (/usr/lib64/libc-2.26.so)
  138d52d70 main+0x3e0 (/usr/bin/ping)
  test child finished with 0
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: Ok

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Maynard Johnson <maynard@us.ibm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Fixes: e07d585e2454 ("perf tests: Switch trace+probe_libc_inet_pton to use record")
Link: http://lkml.kernel.org/r/49621ec5f37109f0655e5a8c32287ad68d85a1e5.1530724939.git.sandipan@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -26,6 +26,12 @@ trace_libc_inet_pton_backtrace() {
 		echo "(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
 		echo "main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
 		;;
+	ppc64|ppc64le)
+		eventattr='max-stack=4'
+		echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
+		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
+		echo ".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
+		;;
 	*)
 		eventattr='max-stack=3'
 		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected


