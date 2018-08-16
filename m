Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39240C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F5120C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxD5+StR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F5120C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeHPToU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbeHPToR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:44:17 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D93872054F;
        Thu, 16 Aug 2018 16:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534437880;
        bh=gCEwSdkPF7OubWeTx7OfnF0zKSoQeat8JneNmQ7e5uE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XxD5+StRW++1lMKymHAUoyqOrKa6v13dNDOMFxhZYuHenHR8NoYDuVs6zTsU5EPzH
         PgF4DGi5/Fy9aAXjbVSGZ+g3YlJ2hbZO68dO7N4mXu/hwrs49eVVRW8JrFa7pS6IX1
         Gq5btf//pzgDJML935JAFp21YqEYSqXY65kIKBOo=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 32/32] selftests/ftrace: Add blktrace testcase
Date:   Fri, 17 Aug 2018 01:44:18 +0900
Message-Id: <153443785794.23257.1676529524763163046.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153443695002.23257.13628220023468200991.stgit@devbox>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a basic testcase for blktrace. For making it portable,
this test uses a loop device.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/ftrace/config              |    1 
 .../testing/selftests/ftrace/test.d/tracer/blk.tc  |   91 ++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/tracer/blk.tc

diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
index c2c8de4fafff..d999032442e1 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -5,6 +5,7 @@ CONFIG_TRACER_SNAPSHOT=y
 CONFIG_STACK_TRACER=y
 CONFIG_HIST_TRIGGERS=y
 CONFIG_SCHED_TRACER=y
+CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_PREEMPT_TRACER=y
 CONFIG_IRQSOFF_TRACER=y
 CONFIG_PREEMPTIRQ_DELAY_TEST=m
diff --git a/tools/testing/selftests/ftrace/test.d/tracer/blk.tc b/tools/testing/selftests/ftrace/test.d/tracer/blk.tc
new file mode 100644
index 000000000000..9d6e72810c8a
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/tracer/blk.tc
@@ -0,0 +1,91 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL2.0
+# description: Test blktrace
+
+IMG=$TMPDIR/fs.img
+MNTDIR=$TMPDIR/mnt
+
+if ! grep -wq "blk" available_tracers ; then
+  echo "blktrace is not supported"
+  exit_unsupported
+fi
+
+available_fs() { #fstype
+  grep -q $1 /proc/filesystems && which mkfs.$1
+}
+
+if available_fs ext3; then
+  FSTYPE=ext3
+elif available_fs ext4; then
+  FSTYPE=ext4
+elif available_fs ext2; then
+  FSTYPE=ext2
+elif available_fs xfs; then
+  FSTYPE=xfs
+elif available_fs btrfs; then
+  FSTYPE=btrfs
+else
+  echo "No available block-based filesystems"
+  exit_unresolved
+fi
+
+if ! which losetup; then
+  echo "No losetup found"
+  exit_unresolved
+fi
+LODEV=`losetup -f`
+LODEVTRACE=/sys/block/`basename $LODEV`/trace
+
+do_cleanup() {
+  if [ -d $MNTDIR ]; then
+   umount $MNTDIR ||:
+  fi
+  losetup -d $LODEV ||:
+  rm -f $IMG
+}
+
+# workload failure is not a tracer's failure
+workload_fail() {
+  do_cleanup
+  echo "Failed to run workload"
+  exit_unresolved
+}
+
+do_fail() {
+  do_cleanup
+  echo "Test failed"
+  exit 1
+}
+
+enable_lodevtrace() {
+  if [ `cat $LODEVTRACE/enable` -ne 1 ]; then
+    echo 1 > $LODEVTRACE/enable
+  fi
+}
+
+echo blk > current_tracer
+
+dd if=/dev/zero of=$IMG bs=1M count=10 &&\
+losetup $LODEV $IMG &&\
+mkfs.$FSTYPE $LODEV &&\
+mkdir -p $MNTDIR &&\
+mount -t $FSTYPE $LODEV $MNTDIR &&\
+enable_lodevtrace &&\
+dd if=/dev/urandom of=$MNTDIR/testfile bs=1M count=1 &&\
+sync &&\
+umount $MNTDIR || workload_fail
+
+grep -q "[dd]" trace || do_fail
+grep -q "[umount]" trace || do_fail
+echo > trace
+
+losetup $LODEV $IMG &&\
+mount -t $FSTYPE $LODEV $MNTDIR &&\
+cat $MNTDIR/testfile > /dev/null &&\
+echo 0 > $LODEVTRACE/enable &&\
+umount $MNTDIR || workload_fail
+
+grep -q "[cat]" trace || do_fail
+grep -q "[mount]" trace || do_fail
+
+do_cleanup

