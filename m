Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB08CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8FF20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8FF20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733210AbeHAUW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:22:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45948 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403961AbeHATDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:34 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CB10FF8C;
        Wed,  1 Aug 2018 16:57:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 082/336] selftests: memfd: return Kselftest Skip code for skipped tests
Date:   Wed,  1 Aug 2018 18:46:57 +0200
Message-Id: <20180801165032.327033721@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>

[ Upstream commit b27f0259e8cea74c627327c063742a83613dd460 ]

When memfd test is skipped because of unmet dependencies and/or unsupported
configuration, it returns non-zero value which is treated as a fail by the
Kselftest framework. This leads to false negative result even when the test
could not be run.

Change it to return kselftest skip code when a test gets skipped to clearly
report that the test could not be run.

Added an explicit check for root user at the start of memfd hugetlbfs test
and return skip code if a non-root user attempts to run it.

In addition, return skip code when not enough huge pages are available to
run the test.

Kselftest framework SKIP code is 4 and the framework prints appropriate
messages to indicate that the test is skipped.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/memfd/run_tests.sh |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/tools/testing/selftests/memfd/run_tests.sh
+++ b/tools/testing/selftests/memfd/run_tests.sh
@@ -1,6 +1,9 @@
 #!/bin/bash
 # please run as root
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 #
 # Normal tests requiring no special resources
 #
@@ -29,12 +32,13 @@ if [ -n "$freepgs" ] && [ $freepgs -lt $
 	nr_hugepgs=`cat /proc/sys/vm/nr_hugepages`
 	hpages_needed=`expr $hpages_test - $freepgs`
 
+	if [ $UID != 0 ]; then
+		echo "Please run memfd with hugetlbfs test as root"
+		exit $ksft_skip
+	fi
+
 	echo 3 > /proc/sys/vm/drop_caches
 	echo $(( $hpages_needed + $nr_hugepgs )) > /proc/sys/vm/nr_hugepages
-	if [ $? -ne 0 ]; then
-		echo "Please run this test as root"
-		exit 1
-	fi
 	while read name size unit; do
 		if [ "$name" = "HugePages_Free:" ]; then
 			freepgs=$size
@@ -53,7 +57,7 @@ if [ $freepgs -lt $hpages_test ]; then
 	fi
 	printf "Not enough huge pages available (%d < %d)\n" \
 		$freepgs $needpgs
-	exit 1
+	exit $ksft_skip
 fi
 
 #


