Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032837AbeE1KTe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:19:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936919AbeE1KTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:19:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 121/268] selftests/powerpc: Skip the subpage_prot tests if the syscall is unavailable
Date: Mon, 28 May 2018 12:01:35 +0200
Message-Id: <20180528100215.810823852@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit cd4a6f3ab4d80cb919d15897eb3cbc85c2009d4b ]

The subpage_prot syscall is only functional when the system is using
the Hash MMU. Since commit 5b2b80714796 ("powerpc/mm: Invalidate
subpage_prot() system call on radix platforms") it returns ENOENT when
the Radix MMU is active. Currently this just makes the test fail.

Additionally the syscall is not available if the kernel is built with
4K pages, or if CONFIG_PPC_SUBPAGE_PROT=n, in which case it returns
ENOSYS because the syscall is missing entirely.

So check explicitly for ENOENT and ENOSYS and skip if we see either of
those.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/powerpc/mm/subpage_prot.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/tools/testing/selftests/powerpc/mm/subpage_prot.c
+++ b/tools/testing/selftests/powerpc/mm/subpage_prot.c
@@ -135,6 +135,16 @@ static int run_test(void *addr, unsigned
 	return 0;
 }
 
+static int syscall_available(void)
+{
+	int rc;
+
+	errno = 0;
+	rc = syscall(__NR_subpage_prot, 0, 0, 0);
+
+	return rc == 0 || (errno != ENOENT && errno != ENOSYS);
+}
+
 int test_anon(void)
 {
 	unsigned long align;
@@ -145,6 +155,8 @@ int test_anon(void)
 	void *mallocblock;
 	unsigned long mallocsize;
 
+	SKIP_IF(!syscall_available());
+
 	if (getpagesize() != 0x10000) {
 		fprintf(stderr, "Kernel page size must be 64K!\n");
 		return 1;
@@ -180,6 +192,8 @@ int test_file(void)
 	off_t filesize;
 	int fd;
 
+	SKIP_IF(!syscall_available());
+
 	fd = open(file_name, O_RDWR);
 	if (fd == -1) {
 		perror("failed to open file");
