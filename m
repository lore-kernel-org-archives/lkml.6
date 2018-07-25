Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AF6C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F1220833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxQh8VCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F1220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbeGYTOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:14:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729171AbeGYTOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:14:22 -0400
Received: from jouet.infradead.org (189-94-96-116.3g.claro.net.br [189.94.96.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1980020833;
        Wed, 25 Jul 2018 18:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532541697;
        bh=SQKfGYhVyZFih8AVXQctoJJafhORMEtfOuZAI0Nn3kw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YxQh8VCz6ug3GwCfBtIcMwG+xq8f3yVifykPEjp4DAKsKZYkfZVxMXVy4Tvol8NXT
         hOTCZrwtKg4wi4OD15lZDmZiJd+SoI3/o33VEc4jTZQKNwfrlYs+3j+6lvqAJsjl1n
         HgSSVoBoGZXQdfgaQcZyYBatzxEN3Vnmsujs13Os=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Sandipan Das <sandipan@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/27] perf tests: Fix record+probe_libc_inet_pton.sh to ensure cleanups
Date:   Wed, 25 Jul 2018 14:59:48 -0300
Message-Id: <20180725180001.15108-15-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandipan Das <sandipan@linux.ibm.com>

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
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 1220e5e052bb..0502a9e04c79 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -52,7 +52,7 @@ trace_libc_inet_pton_backtrace() {
 		echo "$line" | egrep -q "$pattern"
 		if [ $? -ne 0 ] ; then
 			printf "FAIL: expected backtrace entry \"%s\" got \"%s\"\n" "$pattern" "$line"
-			exit 1
+			return 1
 		fi
 	done
 
-- 
2.14.4

