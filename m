Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2989C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972612075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972612075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeIFOzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:55:44 -0400
Received: from mail1.windriver.com ([147.11.146.13]:49951 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeIFOzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:55:43 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w86AKtBF027974
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 6 Sep 2018 03:20:55 -0700 (PDT)
Received: from pek-lyang0-d1.corp.ad.wrs.com (128.224.162.194) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Thu, 6 Sep 2018 03:20:53 -0700
From:   Lei Yang <Lei.Yang@windriver.com>
To:     <mcgrof@kernel.org>, <lei.yang@windriver.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] sysctl: kselftests: fix test_modprobe issue
Date:   Thu, 6 Sep 2018 18:22:54 +0800
Message-ID: <1536229374-25699-1-git-send-email-Lei.Yang@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when CONFIG_TEST_SYSCTL=y, there is no "/sys/module/test_sysctl/"
when CONFIG_TEST_SYSCTL=m, checking /sys/module/test_sysctl/ is
before kernel module loading

you'll get below error message
root@intel-x86-64:/tmp/sysctl# ./sysctl.sh
Checking production write strict setting ... ok
./sysctl.sh: /sys/module/test_sysctl/ not present
You must have the following enabled in your kernel:

This patch will fix this issue.
when CONFIG_TEST_SYSCTL=y, it has no chance to check "/sys/module/test_sysctl/"
when CONFIG_TEST_SYSCTL=m, it will load kernel module first before checking sys
interface.

Signed-off-by: Lei Yang <Lei.Yang@windriver.com>
---
 tools/testing/selftests/sysctl/sysctl.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index 584eb8e..08dc995 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -120,6 +120,7 @@ test_reqs()
 
 function load_req_mod()
 {
+        trap "test_modprobe" EXIT
 	if [ ! -d $DIR ]; then
 		if ! modprobe -q -n $TEST_DRIVER; then
 			echo "$0: module $TEST_DRIVER not found [SKIP]"
@@ -770,7 +771,6 @@ function parse_args()
 test_reqs
 allow_user_defaults
 check_production_sysctl_writes_strict
-test_modprobe
 load_req_mod
 
 trap "test_finish" EXIT
-- 
1.9.1

