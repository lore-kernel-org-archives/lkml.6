Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29367C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95D620838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895325;
	bh=kNcSL1ZfTSTjciDPKLioPB2oZ/7NQ91T2Co6b5B3j78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0HA8Y29ewrsX8cMV4p+5uehLtXi1fDLpT/0CYxElpKzfN06R+GVTd9OIbzjv5pGy+
	 YYrOR3ZZNmWLfCX3pvsqMhK8UXMFDEvPyTj2QD+unEVgOHBqzBk9gjdcuHYY+8bEgy
	 kUYLIWctKgbxKAlGiKesLS+vlaazfQUtOp78wHiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbfBKO2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:28:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729883AbfBKO2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:28:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C3FB20821;
        Mon, 11 Feb 2019 14:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895318;
        bh=kNcSL1ZfTSTjciDPKLioPB2oZ/7NQ91T2Co6b5B3j78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CRorByWhhJcBJGgH4xcNeuCj21T/wr7rCGV6M9sELGuC/8OKTvOGJ1vErRkndQltR
         fVq44eJJw/pA+eeJVCZoLwynRKizTyOstNmO8vabx3xGhBJxAiSKPzgZUw2lyblFpO
         PLl4h+IItM2cdvOEAK0O4nJmnWMpnCv1nKnjUr7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 165/352] fix dma-buf/udmabuf selftest
Date:   Mon, 11 Feb 2019 15:16:32 +0100
Message-Id: <20190211141857.475128124@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



