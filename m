Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424570AbeE1LPa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424556AbeE1LP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:15:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 250/272] perf test: Fix test case inet_pton to accept inlines.
Date: Mon, 28 May 2018 12:04:43 +0200
Message-Id: <20180528100301.275246330@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

[ Upstream commit 0f19a038afdc592176c9a302f0d08be6a68ad74a ]

Using Fedora 27 and latest Linux kernel the test case
trace+probe_libc_inet_pton.sh fails again on s390.  This time is the
inlining of functions which does not match.  After an update of the
glibc (from 2.26-16 to 2.26-24) the output is different

The expected output is:

             __inet_pton (/usr/lib64/libc-2.26.so)
             gaih_inet (inlined)
             ....

The actual output is:

  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev = 0.061/0.061/0.061/0.000 ms
       0.000 probe_libc:inet_pton:(3ffb2140448))
             __inet_pton (inlined)
             gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
             ...

Fix this by being less strict on 'inlined' verses library name and
accept both

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180214070303.55757-1-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/tests/shell/trace+probe_libc_inet_pton.sh |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
@@ -21,12 +21,12 @@ trace_libc_inet_pton_backtrace() {
 	expected[3]=".*packets transmitted.*"
 	expected[4]="rtt min.*"
 	expected[5]="[0-9]+\.[0-9]+[[:space:]]+probe_libc:inet_pton:\([[:xdigit:]]+\)"
-	expected[6]=".*inet_pton[[:space:]]\($libc\)$"
+	expected[6]=".*inet_pton[[:space:]]\($libc|inlined\)$"
 	case "$(uname -m)" in
 	s390x)
 		eventattr='call-graph=dwarf'
-		expected[7]="gaih_inet[[:space:]]\(inlined\)$"
-		expected[8]="__GI_getaddrinfo[[:space:]]\(inlined\)$"
+		expected[7]="gaih_inet.*[[:space:]]\($libc|inlined\)$"
+		expected[8]="__GI_getaddrinfo[[:space:]]\($libc|inlined\)$"
 		expected[9]="main[[:space:]]\(.*/bin/ping.*\)$"
 		expected[10]="__libc_start_main[[:space:]]\($libc\)$"
 		expected[11]="_start[[:space:]]\(.*/bin/ping.*\)$"
