Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A815BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A08206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfAJLh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:37:28 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41225 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbfAJLh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 06:37:28 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1ghYeM-0006Ze-16; Thu, 10 Jan 2019 11:37:26 +0000
From:   Colin King <colin.king@canonical.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: cpu-hotplug: fix case where CPUs offline > CPUs present
Date:   Thu, 10 Jan 2019 11:37:25 +0000
Message-Id: <20190110113725.12369-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The cpu-hotplug test assumes that we can offline the maximum CPU as
described by /sys/devices/system/cpu/offline.  However, in the case
where the number of CPUs exceeds like kernel configuration then
the offline count can be greater than the present count and we end
up trying to test the offlining of a CPU that is not available to
offline.  Fix this by testing the maximum present CPU instead.

Also, the test currently offlines the CPU and does not online it,
so fix this by onlining the CPU after the test.

Fixes: d89dffa976bc ("fault-injection: add selftests for cpu and memory hotplug")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 .../selftests/cpu-hotplug/cpu-on-off-test.sh      | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
index bab13dd025a6..8670fb38a40e 100755
--- a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
+++ b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
@@ -31,12 +31,17 @@ prerequisite()
 	echo "CPU online/offline summary:"
 	online_cpus=`cat $SYSFS/devices/system/cpu/online`
 	online_max=${online_cpus##*-}
+	echo "online_cpus = $online_cpus online_max = $online_max"
 
 	if [[ "$online_cpus" = "$online_max" ]]; then
 		echo "$msg: since there is only one cpu: $online_cpus"
 		exit $ksft_skip
 	fi
 
+	present_cpus=`cat $SYSFS/devices/system/cpu/present`
+	present_max=${present_cpus##*-}
+	echo "present_cpus = $present_cpus present_max = $present_max"
+
 	echo -e "\t Cpus in online state: $online_cpus"
 
 	offline_cpus=`cat $SYSFS/devices/system/cpu/offline`
@@ -46,6 +51,7 @@ prerequisite()
 		offline_max=${offline_cpus##*-}
 	fi
 	echo -e "\t Cpus in offline state: $offline_cpus"
+
 }
 
 #
@@ -151,6 +157,8 @@ online_cpus=0
 online_max=0
 offline_cpus=0
 offline_max=0
+present_cpus=0
+present_max=0
 
 while getopts e:ahp: opt; do
 	case $opt in
@@ -190,9 +198,10 @@ if [ $allcpus -eq 0 ]; then
 	online_cpu_expect_success $online_max
 
 	if [[ $offline_cpus -gt 0 ]]; then
-		echo -e "\t offline to online to offline: cpu $offline_max"
-		online_cpu_expect_success $offline_max
-		offline_cpu_expect_success $offline_max
+		echo -e "\t offline to online to offline: cpu $present_max"
+		online_cpu_expect_success $present_max
+		offline_cpu_expect_success $present_max
+		online_cpu $present_max
 	fi
 	exit 0
 else
-- 
2.19.1

