Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9497C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB4E208B0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="n7P+mBPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB4E208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753399AbeGCNND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:13:03 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:43947 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752700AbeGCNNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1530623582; x=1562159582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=feaKBl52W7u/ZYabXhJvVXPj/ncxzDPnKpEI1MQV7Gg=;
  b=n7P+mBPIqTIvjttHVtiDhNu0J8Z9DyS31mKYvLClWNVFV1JzK6I5QHIS
   etuMQTyXR/F8vXMv9EnR4UhGscr65qAlEHdlmvQvEsiq5dsRel2sjdiws
   OhonG+nCiR9hMf+Xg/4XXu4YSPUSp+hqvWdo2LUC87LiibdT3nuymn6PC
   A=;
X-IronPort-AV: E=Sophos;i="5.51,303,1526342400"; 
   d="scan'208";a="741337749"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Jul 2018 13:12:47 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w63DCknn038243
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 13:12:46 GMT
Received: from EX13D08UEE002.ant.amazon.com (10.43.62.92) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 3 Jul 2018 13:12:45 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D08UEE002.ant.amazon.com (10.43.62.92) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 3 Jul 2018 13:12:45 +0000
Received: from uc1a35a69ae4659.ant.amazon.com (10.28.85.80) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 13:12:44 +0000
From:   Norbert Manthey <nmanthey@amazon.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Norbert Manthey <nmanthey@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        <linux-kernel@vger.kernel.org>
Subject: [build-check] scripts: add check_build script
Date:   Tue, 3 Jul 2018 15:12:10 +0200
Message-ID: <1530623539-650-1-git-send-email-nmanthey@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530186789-28808-1-git-send-email-nmanthey@amazon.de>
References: <1530186789-28808-1-git-send-email-nmanthey@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This script performs build testing, by building several configurations
several times. The script is introduced to improve the consistency of
testing changes in the kernel configuration.

This version build randconfig 10 times, as well as allyesconfig,
allnoconfig and allmodconfig. Depending on the used machine and system
setup, the script might take a while to finish.

The script logs all the used config files, as well as the output of the
build commands to a log directory "build_check_logs", so that this data
can be retrieved after running the script.

Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 scripts/check_build.sh | 136 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100755 scripts/check_build.sh

diff --git a/scripts/check_build.sh b/scripts/check_build.sh
new file mode 100755
index 0000000..a100d99
--- /dev/null
+++ b/scripts/check_build.sh
@@ -0,0 +1,136 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Check whether kernel changes compile with multiple configurations.
+# Configurations that fail for the current commit are tested on an upstream
+# commit, and failures are ignored in case the configuration fails on the
+# upstream commit as well.
+#
+# Usage:
+# ./scripts/check_build.sh [upstream-commit]
+#
+# Example:
+# ./scripts/check_build.sh origin/master
+
+# Fail early on error or uninitialized values
+set -e -u
+
+# Write all files to this directory
+declare -r LOG_DIR=build_check_logs
+
+# Gather all configurations we should build, in form of make targets
+collect_configurations ()
+{
+	local CONFIGS="randconfig allyesconfig allnoconfig allmodconfig"
+	local -i I=0
+
+	while [ "$I" -le 8 ]; do I=$((I+1)); CONFIGS+=" randconfig"; done
+
+	echo "$CONFIGS"
+}
+
+# Build the kernel with the current configuration, return the status, log to $1
+build ()
+{
+	local -r LOG_FILE="$1"
+	local -i STATUS=0
+
+	make clean -j $(nproc) &> /dev/null
+	make -j $(nproc) &>> "$LOG_FILE" || STATUS=$?
+
+	echo "build status: $STATUS" >> "$LOG_FILE"
+	echo "[$SECONDS] build status: $STATUS"
+	return "$STATUS"
+}
+
+# Check whether we're executing from a clean repository, and proper location
+check_environment()
+{
+	local -r UPSTREAM_COMMIT="$1"
+
+	if [ ! -x scripts/check_build.sh ]; then
+		echo "error: please execute script from repository root!"
+		exit 1
+	fi
+
+	if ! git diff-index --quiet HEAD --; then
+		echo "error: please commit or stash your local changes!"
+		exit 1
+	fi
+
+	if ! git cat-file -e "$UPSTREAM_COMMIT" &> /dev/null; then
+		echo "error: upstream commit $UPSTREAM_COMMIT does not exist!"
+		exit 1
+	fi
+}
+
+TEST_COMMIT=$(git rev-parse --short HEAD)
+
+LAST_TAG=$(git describe --abbrev=0)
+DEFAULT_UPSTREAM="origin/master"
+[ -z "$LAST_TAG" ] || DEFAULT_UPSTREAM="$LAST_TAG"
+UPSTREAM_COMMIT="${1:-$DEFAULT_UPSTREAM}"
+
+# Before starting, check call location and git environment
+check_environment "$UPSTREAM_COMMIT"
+
+# Collect status, as well as failing configuration file names
+declare -i OVERALL_STATUS=0
+mkdir -p "$LOG_DIR"
+BRANCH_FAILS=""
+UPSTREAM_FAILS=""
+
+# Build multiple configurations
+declare -i COUNT=0
+declare -r CONFIGS=$(collect_configurations)
+echo "[$SECONDS] Check commit $TEST_COMMIT with upstream reference $UPSTREAM_COMMIT"
+for config in $CONFIGS
+do
+	COUNT=$((COUNT+1))
+	echo "[$SECONDS] build $config as build nr $COUNT"
+	LOG_FILE=$LOG_DIR/build-"$COUNT"-"$config".log
+
+	# Prepare configuration, and memorize it
+	STATUS=0
+	make "$config" &> "$LOG_FILE" || STATUS=$?
+	cp .config $LOG_DIR/config-"$COUNT"-"$config"
+
+	# Try to build with current configuration
+	build "$LOG_FILE" || STATUS=$?
+
+	# Evaluate build failure
+	if [ "$STATUS" -ne 0 ]
+	then
+		cp .config "$LOG_DIR"/config-failing-branch-"$COUNT"-"$config"
+		echo "[$SECONDS] check whether current configuration fails upstream as well ..."
+		echo "[$SECONDS] go back in time to commit $UPSTREAM_COMMIT"
+
+		# Check whether upstream commit builds
+		git checkout "$UPSTREAM_COMMIT" &>> "$LOG_FILE"
+		UPSTREAM_STATUS=0
+		build "$LOG_FILE" || UPSTREAM_STATUS=$?
+		git checkout "$TEST_COMMIT" &>> "$LOG_FILE"
+
+		if [ "$UPSTREAM_STATUS" -ne 0 ]
+		then
+			echo "[$SECONDS] upstream build fails as well, ignore failure"
+			cp .config "$LOG_DIR"/config-failing-upstream-"$COUNT"-"$config"
+			UPSTREAM_FAILS+=" config-$COUNT-$config"
+		else
+			echo "[$SECONDS] upstream build succeeds, while branch build fails"
+			BRANCH_FAILS+=" config-$COUNT-$config"
+			OVERALL_STATUS=1
+		fi
+
+		echo "[$SECONDS] jump back to commit under test, $TEST_COMMIT"
+	fi
+done
+
+# Print summary, and exit with status of local changes
+echo "Finished after $SECONDS seconds"
+echo "Found upstream failures: $UPSTREAM_FAILS"
+echo "Found branch failures: $BRANCH_FAILS"
+echo "Collected configurations and logs can be found in $LOG_DIR"
+
+# Exit 0, if no build fails, or the upstream commit always fails as well
+exit $OVERALL_STATUS
-- 
2.7.4

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B

