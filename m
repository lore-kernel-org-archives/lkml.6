Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5F6C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F017A20880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690735;
	bh=DvUyKWnTWKSkTCcHgqPaGrG5pkyZcljY0OEYlqP3RKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pDIsjR7c2U+1bTmJiyhvtn24Kvghpj9t/pabHK2Rv1DMYLos9jhWXCPK5VWjZLnNB
	 v5mKjmAlN6NFA8aNY2YINvRauxdxvjYhEU7pNNrZhjL/Mb/l77LqqjZ4Jq22SegY8C
	 dxkf6lkkE+e10wUFFuQI5tdLlW3iIUWHDI/m1Gw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfA1PwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:52:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbfA1PwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:52:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DFE32147A;
        Mon, 28 Jan 2019 15:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690730;
        bh=DvUyKWnTWKSkTCcHgqPaGrG5pkyZcljY0OEYlqP3RKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mUhvRi7ovXaOiK/+bEAOvhOR/iI23HwEYwaCbMuhRVucJ0qC+9WLnr9lDDZUkco0P
         WRLEpSF1NpgyzM0K0D9CskrL4p1ONzngkIulIjvhb/WN/EsLrX5uSpgOeUhP6QKGSi
         jT9be2I6aZwH33gAhhVBFV510n+myH52AD3eo548=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tom Murphy <murphyt7@tcd.ie>, Shuah Khan <shuah@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 176/304] fix dma-buf/udmabuf selftest
Date:   Mon, 28 Jan 2019 10:41:33 -0500
Message-Id: <20190128154341.47195-176-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Murphy <murphyt7@tcd.ie>

[ Upstream commit 6edf2e3710f4ef2555ad7a2681dbeb4a69092b2d ]

This patch fixes the udmabuf selftest. Currently the selftest is broken.
I fixed the selftest by setting the F_SEAL_SHRINK seal on the memfd
file descriptor which is required by udmabuf and added the test to
the selftest Makefile.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/Makefile                  |  1 +
 tools/testing/selftests/drivers/dma-buf/Makefile  |  2 ++
 tools/testing/selftests/drivers/dma-buf/udmabuf.c | 11 +++++++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index f0017c831e57..a43a07a09a98 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -6,6 +6,7 @@ TARGETS += capabilities
 TARGETS += cgroup
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
+TARGETS += drivers/dma-buf
 TARGETS += efivarfs
 TARGETS += exec
 TARGETS += filesystems
diff --git a/tools/testing/selftests/drivers/dma-buf/Makefile b/tools/testing/selftests/drivers/dma-buf/Makefile
index 4154c3d7aa58..f22c3f7cf612 100644
--- a/tools/testing/selftests/drivers/dma-buf/Makefile
+++ b/tools/testing/selftests/drivers/dma-buf/Makefile
@@ -2,4 +2,6 @@ CFLAGS += -I../../../../../usr/include/
 
 TEST_GEN_PROGS := udmabuf
 
+top_srcdir ?=../../../../..
+
 include ../../lib.mk
diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
index 376b1d6730bd..4de902ea14d8 100644
--- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
+++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
@@ -4,7 +4,7 @@
 #include <unistd.h>
 #include <string.h>
 #include <errno.h>
-#include <fcntl.h>
+#include <linux/fcntl.h>
 #include <malloc.h>
 
 #include <sys/ioctl.h>
@@ -33,12 +33,19 @@ int main(int argc, char *argv[])
 		exit(77);
 	}
 
-	memfd = memfd_create("udmabuf-test", MFD_CLOEXEC);
+	memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
 	if (memfd < 0) {
 		printf("%s: [skip,no-memfd]\n", TEST_PREFIX);
 		exit(77);
 	}
 
+	ret = fcntl(memfd, F_ADD_SEALS, F_SEAL_SHRINK);
+	if (ret < 0) {
+		printf("%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
+		exit(77);
+	}
+
+
 	size = getpagesize() * NUM_PAGES;
 	ret = ftruncate(memfd, size);
 	if (ret == -1) {
-- 
2.19.1

