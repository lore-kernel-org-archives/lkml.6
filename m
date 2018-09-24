Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60F7ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CAE2148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CAE2148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbeIXSbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:31:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57622 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732800AbeIXSbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:31:24 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 14F8E1099;
        Mon, 24 Sep 2018 12:29:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sandipan Das <sandipan@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 050/235] perf tests: Fix record+probe_libc_inet_pton.sh to ensure cleanups
Date:   Mon, 24 Sep 2018 13:50:36 +0200
Message-Id: <20180924113110.176835908@linuxfoundation.org>
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

[ Upstream commit 83e3b6d73e66a10088f362b08b99c36fec3a14e7 ]

If there is a mismatch in the perf script output, this test fails and
exits before the event and temporary files created during its execution
are cleaned up.

This can be observed on a powerpc64 system running Fedora 27 as shown
below.

  # perf test -v "probe libc's inet_pton & backtrace it with ping"

  62: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 18655
  ping 18674 [013] 24511.496995: probe_libc:inet_pton: (7fffa6b423b0)
  7fffa6b423b0 __GI___inet_pton+0x0 (/usr/lib64/power8/libc-2.26.so)
  7fffa6af90dc gaih_inet.constprop.7+0xf4c (/usr/lib64/power8/libc-2.26.so)
  FAIL: expected backtrace entry "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib64/power8/libc-2.26.so\)$" got "7fffa6af90dc gaih_inet.constprop.7+0xf4c (/usr/lib64/power8/libc-2.26.so)"
  test child finished with -1
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: FAILED!

  # ls /tmp/expected.* /tmp/perf.data.* /tmp/perf.script.*

  /tmp/expected.u31  /tmp/perf.data.Pki  /tmp/perf.script.Bhs

  # perf probe --list

    probe_libc:inet_pton (on __inet_pton@resolv/inet_pton.c in /usr/lib64/power8/libc-2.26.so)

Cleanup of the event and the temporary files are now ensured by allowing
the cleanup code to be executed even if the lines from the backtrace do
not match their expected patterns instead of simply exiting from the
point of failure.

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/ce9fb091dd3028fba8749a1a267cfbcb264bbfb1.1530724939.git.sandipan@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -65,7 +65,7 @@ trace_libc_inet_pton_backtrace() {
 		echo "$line" | egrep -q "$pattern"
 		if [ $? -ne 0 ] ; then
 			printf "FAIL: expected backtrace entry \"%s\" got \"%s\"\n" "$pattern" "$line"
-			exit 1
+			return 1
 		fi
 	done
 


