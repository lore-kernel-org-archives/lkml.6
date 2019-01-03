Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0BFC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1043520815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgXnFROF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbfACOWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:22:44 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44611 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731031AbfACOWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:22:40 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so29806486lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 06:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KGoHN334DZNkqWv2smL0AGypDg5avCRm0FTt0IHsxCg=;
        b=FgXnFROF2uw5rUs18+D159AuX48O8b00qTHM3dz0lrZAa1rbwI7PiZCJ1yoSul7UCd
         XMbsEJsTx5VDoT5670LhhPnf8AWKVe0cfNg3Y7Q3YWMz8xoAGkJ4qbYJhGyBo7J3n6d/
         /BVTHQnZNZNCGdizso4JPLXTJE00INLjXw79x80sUYNUUluRl7eJwEcboIOFXPXhczX9
         +ysMm+cOZiVJr2Di7GmWjFBiv3dDTrnytTKS2bR9vRmzNLZFp/Sp/2ap3KoTZ5VD1p9m
         7SzNsxYqQaVGCrepXCboSFeg3gJ9u3HHowf+Zba2DMXjIxLcg6O8NHjNLr0yAILYwmAw
         wi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KGoHN334DZNkqWv2smL0AGypDg5avCRm0FTt0IHsxCg=;
        b=oGQMWFCAgXD11NZ2dp5euitXWeMIiYTVl5B5NhPsFNQHxVgAOX61KiAPhbfFAn8W2K
         mx0B4ufqmIGhEGg3YCAyDsJuEGVvCVGNGF+g3+O/Li3P3qwk0zmPjxS6eJryrxNyP9+A
         DU9tUogemZoyl45f10Lu/jJ1SElHlfjCBnOXih4jS1RWXRs3G/G88G85092XcU8q1Rhh
         S78BQCVCvR4HNSOJUmUhymuJOvjWvajA20QPL0T9ZetWNruAxQkzrynKbwIGgOcjKAFz
         AAdBdEpeItjsNtQv5DlcPfwin4GbsvBre9FsCPY1yMHuT57CZzKeZsoJeGxA3IE4/8jF
         Q46Q==
X-Gm-Message-State: AJcUukfM9IsERiyyfI65ZkoshRqUvpDUYVRw1kCkPPXXPT8WccUkdteK
        Aa4G/kpALqLAbqbWVZFpSuo=
X-Google-Smtp-Source: AFSGD/VlHsOjo4kT1Htw31QucG73s9as9B/mjMeVAQu9hdC+qKe3PonCTrE6ghy6ar9qEsEa94uBsg==
X-Received: by 2002:a2e:744:: with SMTP id i4-v6mr26451587ljd.140.1546525357638;
        Thu, 03 Jan 2019 06:22:37 -0800 (PST)
Received: from localhost.localdomain ([37.212.195.0])
        by smtp.gmail.com with ESMTPSA id b25sm10594690lfa.96.2019.01.03.06.22.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 06:22:37 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [RFC PATCH 3/3] selftests/vm: add script helper for CONFIG_TEST_VMALLOC_MODULE
Date:   Thu,  3 Jan 2019 15:21:08 +0100
Message-Id: <20190103142108.20744-4-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190103142108.20744-1-urezki@gmail.com>
References: <20190103142108.20744-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the test script for the kernel test driver to analyse vmalloc
allocator for benchmarking and stressing purposes. It is just a kernel
module loader. You can specify and pass different parameters in order
to investigate allocations behaviour. See "usage" output for more
details.

Also add basic vmalloc smoke test to the "run_vmtests" suite.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 tools/testing/selftests/vm/run_vmtests     |  16 +++
 tools/testing/selftests/vm/test_vmalloc.sh | 176 +++++++++++++++++++++++++++++
 2 files changed, 192 insertions(+)
 create mode 100755 tools/testing/selftests/vm/test_vmalloc.sh

diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftests/vm/run_vmtests
index 584a91ae4a8f..951c507a27f7 100755
--- a/tools/testing/selftests/vm/run_vmtests
+++ b/tools/testing/selftests/vm/run_vmtests
@@ -211,4 +211,20 @@ else
     echo "[PASS]"
 fi
 
+echo "------------------------------------"
+echo "running vmalloc stability smoke test"
+echo "------------------------------------"
+./test_vmalloc.sh smoke
+ret_val=$?
+
+if [ $ret_val -eq 0 ]; then
+	echo "[PASS]"
+elif [ $ret_val -eq $ksft_skip ]; then
+	 echo "[SKIP]"
+	 exitcode=$ksft_skip
+else
+	echo "[FAIL]"
+	exitcode=1
+fi
+
 exit $exitcode
diff --git a/tools/testing/selftests/vm/test_vmalloc.sh b/tools/testing/selftests/vm/test_vmalloc.sh
new file mode 100755
index 000000000000..06d2bb109f06
--- /dev/null
+++ b/tools/testing/selftests/vm/test_vmalloc.sh
@@ -0,0 +1,176 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2018 Uladzislau Rezki (Sony) <urezki@gmail.com>
+#
+# This is a test script for the kernel test driver to analyse vmalloc
+# allocator. Therefore it is just a kernel module loader. You can specify
+# and pass different parameters in order to:
+#     a) analyse performance of vmalloc allocations;
+#     b) stressing and stability check of vmalloc subsystem.
+
+TEST_NAME="vmalloc"
+DRIVER="test_${TEST_NAME}"
+
+# 1 if fails
+exitcode=1
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+#
+# Static templates for performance, stressing and smoke tests.
+# Also it is possible to pass any supported parameters manualy.
+#
+PERF_PARAM="single_cpu_test=1 sequential_test_order=1 test_repeat_count=3"
+SMOKE_PARAM="single_cpu_test=1 test_loop_count=10000 test_repeat_count=10"
+STRESS_PARAM="test_repeat_count=20"
+
+check_test_requirements()
+{
+	uid=$(id -u)
+	if [ $uid -ne 0 ]; then
+		echo "$0: Must be run as root"
+		exit $ksft_skip
+	fi
+
+	if ! which modprobe > /dev/null 2>&1; then
+		echo "$0: You need modprobe installed"
+		exit $ksft_skip
+	fi
+
+	if ! modinfo $DRIVER > /dev/null 2>&1; then
+		echo "$0: You must have the following enabled in your kernel:"
+		echo "CONFIG_TEST_VMALLOC=m"
+		exit $ksft_skip
+	fi
+}
+
+run_perfformance_check()
+{
+	echo "Run performance tests to evaluate how fast vmalloc allocation is."
+	echo "It runs all test cases on one single CPU with sequential order."
+
+	modprobe $DRIVER $PERF_PARAM > /dev/null 2>&1
+	echo "Done."
+	echo "Ccheck the kernel message buffer to see the summary."
+}
+
+run_stability_check()
+{
+	echo "Run stability tests. In order to stress vmalloc subsystem we run"
+	echo "all available test cases on all available CPUs simultaneously."
+	echo "It will take time, so be patient."
+
+	modprobe $DRIVER $STRESS_PARAM > /dev/null 2>&1
+	echo "Done."
+	echo "Check the kernel ring buffer to see the summary."
+}
+
+run_smoke_check()
+{
+	echo "Run smoke test. Note, this test provides basic coverage."
+	echo "Please check $0 output how it can be used"
+	echo "for deep performance analysis as well as stress testing."
+
+	modprobe $DRIVER $SMOKE_PARAM > /dev/null 2>&1
+	echo "Done."
+	echo "Check the kernel ring buffer to see the summary."
+}
+
+usage()
+{
+	echo -n "Usage: $0 [ performance ] | [ stress ] | | [ smoke ] | "
+	echo "manual parameters"
+	echo
+	echo "Valid tests and parameters:"
+	echo
+	modinfo $DRIVER
+	echo
+	echo "Example usage:"
+	echo
+	echo "# Shows help message"
+	echo "./${DRIVER}.sh"
+	echo
+	echo "# Runs 1 test(id_1), repeats it 5 times on all online CPUs"
+	echo "./${DRIVER}.sh run_test_mask=1 test_repeat_count=5"
+	echo
+	echo -n "# Runs 4 tests(id_1|id_2|id_4|id_16) on one CPU with "
+	echo "sequential order"
+	echo -n "./${DRIVER}.sh single_cpu_test=1 sequential_test_order=1 "
+	echo "run_test_mask=23"
+	echo
+	echo -n "# Runs all tests on all online CPUs, shuffled order, repeats "
+	echo "20 times"
+	echo "./${DRIVER}.sh test_repeat_count=20"
+	echo
+	echo "# Performance analysis"
+	echo "./${DRIVER}.sh performance"
+	echo
+	echo "# Stress testing"
+	echo "./${DRIVER}.sh stress"
+	echo
+	exit 0
+}
+
+function validate_passed_args()
+{
+	VALID_ARGS=`modinfo $DRIVER | awk '/parm:/ {print $2}' | sed 's/:.*//'`
+
+	#
+	# Something has been passed, check it.
+	#
+	for passed_arg in $@; do
+		key=${passed_arg//=*/}
+		val="${passed_arg:$((${#key}+1))}"
+		valid=0
+
+		for valid_arg in $VALID_ARGS; do
+			if [[ $key = $valid_arg ]] && [[ $val -gt 0 ]]; then
+				valid=1
+				break
+			fi
+		done
+
+		if [[ $valid -ne 1 ]]; then
+			echo "Error: key or value is not correct: ${key} $val"
+			exit $exitcode
+		fi
+	done
+}
+
+function run_manual_check()
+{
+	#
+	# Validate passed parameters. If there is wrong one,
+	# the script exists and does not execute further.
+	#
+	validate_passed_args $@
+
+	echo "Run the test with following parameters: $@"
+	modprobe $DRIVER $@ > /dev/null 2>&1
+	echo "Done."
+	echo "Check the kernel ring buffer to see the summary."
+}
+
+function run_test()
+{
+	if [ $# -eq 0 ]; then
+		usage
+	else
+		if [[ "$1" = "performance" ]]; then
+			run_perfformance_check
+		elif [[ "$1" = "stress" ]]; then
+			run_stability_check
+		elif [[ "$1" = "smoke" ]]; then
+			run_smoke_check
+		else
+			run_manual_check $@
+		fi
+	fi
+}
+
+check_test_requirements
+run_test $@
+
+exit 0
-- 
2.11.0

