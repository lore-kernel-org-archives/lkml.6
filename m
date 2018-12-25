Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53601C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 09:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D21B2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 09:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbeLYJBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 04:01:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55774 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbeLYJBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 04:01:32 -0500
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1gbiag-0003XF-GD
        for linux-kernel@vger.kernel.org; Tue, 25 Dec 2018 09:01:30 +0000
Received: by mail-pg1-f198.google.com with SMTP id s22so12623594pgv.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 01:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Xo049x0xiIqeDYPyD0QhBX1kSGrXxCvtHAOi6WBWmm0=;
        b=dqlvL+wO+pRd0YC9OhSKr9+TJLLlM8NVE9OeYJPg7U3aQ/2e74Le0zPfiCkZQeQGw4
         jSC1QESTeM0mleHNCoYVusNBSHCKXseGlyUSoKRoTjoX5JzE2cdsAVTCI708scs0sOgZ
         VNCy275TSF8E0K1dAf/qZJjttuXfdMGdXXSR0+vYnfsQf4/IE7uAepsuDtUidXY85H3v
         p5O/yzK1dDVLISILhgbtiDDwGXBZwXohvhcXXWxoeiOu+I6TSoz4YFbISMm++oHENKQb
         nTN7lzDL6PbAlM5Yk9AjDmWlxoi6Pw0IOU/rOEzW2jxos0ij6dE8kr+TjopgiMU38JES
         O6Ug==
X-Gm-Message-State: AJcUukeV6gXbYbHESZCE+6jkPuF9C+Z/xQscbJmoZQtaLrN6B5h7t4G2
        8/eH+5gehenK42KseKt+UhPCVXVN+7DhIYxk/pM/2c24hPvOmw2jVbJCsHmOzSQXW2EYgvJieVH
        rcRFGA6L1u4UtOhjjZIvlI1flCKIpYwf9b6kig5A3
X-Received: by 2002:a17:902:e20b:: with SMTP id ce11mr15249412plb.251.1545728489094;
        Tue, 25 Dec 2018 01:01:29 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5VVBgJ1D4NFF+WwtYwp6FGXHvu1j8sAJdo6ZELsV7nFTqvt9bTwdr6QjzPw758p+/fCqwSDw==
X-Received: by 2002:a17:902:e20b:: with SMTP id ce11mr15249393plb.251.1545728488750;
        Tue, 25 Dec 2018 01:01:28 -0800 (PST)
Received: from Leggiero.taipei.internal (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id s130sm70460103pgc.60.2018.12.25.01.01.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Dec 2018 01:01:27 -0800 (PST)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/efivarfs: clean up test files from test_create*()
Date:   Tue, 25 Dec 2018 16:59:45 +0800
Message-Id: <20181225085945.13686-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test files created by test_create*() tests will stay in the $efivarfs_mount
directory until next reboot.

When the tester tries to run this efivarfs test again on the same system, the
immutable characteristics in that directory with those previously generated
files will cause some "Permission denied" noises and a false-positive test
result to the test_create_read() test.

Remove those test files in the end of each test to solve this issue.

Link: https://bugs.launchpad.net/bugs/1809704

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/efivarfs/efivarfs.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/efivarfs/efivarfs.sh b/tools/testing/selftests/efivarfs/efivarfs.sh
index a47029a..ea2e2a0 100755
--- a/tools/testing/selftests/efivarfs/efivarfs.sh
+++ b/tools/testing/selftests/efivarfs/efivarfs.sh
@@ -60,6 +60,12 @@ test_create()
 		echo "$file has invalid size" >&2
 		exit 1
 	fi
+
+        rm $file 2>/dev/null
+        if [ $? -ne 0 ]; then
+                chattr -i $file
+                rm $file
+        fi
 }
 
 test_create_empty()
@@ -72,12 +78,24 @@ test_create_empty()
 		echo "$file can not be created without writing" >&2
 		exit 1
 	fi
+
+        rm $file 2>/dev/null
+        if [ $? -ne 0 ]; then
+                chattr -i $file
+                rm $file
+        fi
 }
 
 test_create_read()
 {
 	local file=$efivarfs_mount/$FUNCNAME-$test_guid
 	./create-read $file
+
+        rm $file 2>/dev/null
+        if [ $? -ne 0 ]; then
+                chattr -i $file
+                rm $file
+        fi
 }
 
 test_delete()
-- 
2.7.4

