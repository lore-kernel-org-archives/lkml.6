Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4F1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA8021B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="GuT9vFjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387550AbfBNXCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:02:09 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:52509 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387452AbfBNXCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=uXiiYaJXqE7SzRUWp3MydOEC7ExEr87TW8dYtDwEm8s=; b=GuT9vFjP8bhx
        cndYSS1n3F+AOSrmMwmEpgHUzTWgGAx+ZIzuJMycvwHfqCj/KeEScrA7L6A2nTq5tvjdf//uJjemG
        2xE8qZNCQPeUdDE9izHkjc3CjHXV6wh5hbFZo9ZRPBpHBlxJ/cVOvXCQy2HDID3CQ2f7tpPhOXmyh
        p54eLWks40/QV+/z/qkQrPXibbH0ktZv613TmpB6Cjtp9KY87k1d9+rdn24pm4hA2zxDTHWI+aW0h
        hdnYD3S0vBl3eug4PG2Oc5TmysTtzwU+YqAxWUXRY/CYXh63YSriM85562YfVqBezcPPaQS7l202k
        DcY4Ozk9Vxq9Ql9ufXf+tA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1guQ10-0000xu-9O; Fri, 15 Feb 2019 00:01:59 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 0317DC0482;
        Fri, 15 Feb 2019 00:01:55 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v7 22/23] lockdep tests: Fix run_tests.sh
Date:   Thu, 14 Feb 2019 15:00:57 -0800
Message-Id: <20190214230058.196511-23-bvanassche@acm.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190214230058.196511-1-bvanassche@acm.org>
References: <20190214230058.196511-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00281612446096)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5u+mFxByprPB90MMfC+/gyd602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTbXCyMe5v8y2H30acbVA7+CsLowAEMLnIs/c915wTAPANfX
 yKo+pvzCeHRww82sG/8HW2me2F11ZDpUG2A5Oiv0I5mALh2L1FvYZOvwUqXjvDk55wR+TsdsSUF6
 GKzdvFr/HXw7HB6/ASdSFy6HwS/kPXDwAtkmamZ68x0sIvfyXcDIKE+0kbt+hzad+8LmAP3D1N2U
 GbvmsuDbvpqB9SNial5u6w2P0n3AP5HxdAj+kw2FxVgE7SkvtWKxkgySOE3GN0ExaDjCWJE9qkQd
 cN59XS8Zh9aX20WLNn9SpsWOBHAZiNu+HNZfwKj7lz56u5py+28pF/HE/UXip0YpvmqSgtBtsvjK
 9mpXvZ581yfqNVA0hlu/NpOnaXNvrIp4mRGgQUA9iOUB9gXW15it62GvKaV7puimXuHjFEy4159w
 b450J4XCXsfFdbMPgtsajKwG2cpJ3lvOyWe43aQJV0FQAw4GDaNi9opIpCCZlwPhCSifQg48iasD
 JL+gSQdpc7Qjle0LcSTVPooEuo2QsxqqSZrgzSd/y/UPcC3OGqi0VJ9oPeZuzI4YvGloR1iXZcQ6
 rDn0tTOVcmJwqI8Ju2ne/wwIwzyV/WMPB6zTEWzEncEKJtZE3p7YZqOA3SmjVruGpS+C6BPAIEs8
 PiiVo3Eboi+cbnT5PTDQNVG9E6gOGiUCAW1FDxcZal9mohvTtVuaBo55LoXJ38umBncoBPaTGplH
 cpVCCoX989hgB8R+yBNKgbPqM+gWqiGtLl4stWpoD9FzZlLjMwJPDioYZIRvNrQ1dDBlyOeBTaT3
 tmySKHbBteMJzAkMC43e8+sp9ik9r/0RENuxoUHLfdnX97lYWfNCwcrS0aokqY9q7nrY3hEVniih
 uDwEGDcmr6e3OPRLa16pGRvAB1MNCAVzZzPG/W30w/zDcz636yEnTyvlnRmAYWvYmazXX5mZqpPP
 J/0CnmNt50px30RAYt+oxQhFctgzcDoFd+96Xw4QUNtTnfzp6yaSzf/mBOxmctH1xJW7ZqDnEZyA
 /o9yCJs753i5Anc+dePvuOLndsGRtxRwqudKEy7bP5gIt23U7fpAnNNWb77i3eb3c6Xj53IToZwL
 VabjergYMIEHYgna2Grb/XBEn95eECKi3gxjzXac2CKNL6Ugwa8G8LUBaMaYDRNMLxoq67wPPyTr
 tPptswtkm3vs+M4bivZGPOywGIoCFD0=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently the execute bits were set for the tests/*.sh scripts on my
test setup but these are not set in the kernel tree. Fix this by adding
the interpreter path in front of the script paths.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Fixes: 5ecb8e94b494 ("tools/lib/lockdep/tests: Improve testing accuracy") # v5.0-rc1
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tools/lib/lockdep/run_tests.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/lockdep/run_tests.sh b/tools/lib/lockdep/run_tests.sh
index c8fbd0306960..11f425662b43 100755
--- a/tools/lib/lockdep/run_tests.sh
+++ b/tools/lib/lockdep/run_tests.sh
@@ -11,7 +11,7 @@ find tests -name '*.c' | sort | while read -r i; do
 	testname=$(basename "$i" .c)
 	echo -ne "$testname... "
 	if gcc -o "tests/$testname" -pthread "$i" liblockdep.a -Iinclude -D__USE_LIBLOCKDEP &&
-		timeout 1 "tests/$testname" 2>&1 | "tests/${testname}.sh"; then
+		timeout 1 "tests/$testname" 2>&1 | /bin/bash "tests/${testname}.sh"; then
 		echo "PASSED!"
 	else
 		echo "FAILED!"
@@ -24,7 +24,7 @@ find tests -name '*.c' | sort | while read -r i; do
 	echo -ne "(PRELOAD) $testname... "
 	if gcc -o "tests/$testname" -pthread -Iinclude "$i" &&
 		timeout 1 ./lockdep "tests/$testname" 2>&1 |
-		"tests/${testname}.sh"; then
+		/bin/bash "tests/${testname}.sh"; then
 		echo "PASSED!"
 	else
 		echo "FAILED!"
@@ -37,7 +37,7 @@ find tests -name '*.c' | sort | while read -r i; do
 	echo -ne "(PRELOAD + Valgrind) $testname... "
 	if gcc -o "tests/$testname" -pthread -Iinclude "$i" &&
 		{ timeout 10 valgrind --read-var-info=yes ./lockdep "./tests/$testname" >& "tests/${testname}.vg.out"; true; } &&
-		"tests/${testname}.sh" < "tests/${testname}.vg.out" &&
+		/bin/bash "tests/${testname}.sh" < "tests/${testname}.vg.out" &&
 		! grep -Eq '(^==[0-9]*== (Invalid |Uninitialised ))|Mismatched free|Source and destination overlap| UME ' "tests/${testname}.vg.out"; then
 		echo "PASSED!"
 	else
-- 
2.21.0.rc0.258.g878e2cd30e-goog

