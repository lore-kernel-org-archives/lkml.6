Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058DDC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C110E20878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tn86oeBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C110E20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbeLEJmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:42:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:47136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728038AbeLEJmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:42:33 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D58620850;
        Wed,  5 Dec 2018 09:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002952;
        bh=QDx8YnEdylUcYj+aBeIWlfrECI+eDkZY74B8NGKWB9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tn86oeBtelJilg1avsGgZgZT5rFnFFEAwLfRp8B7/u6qrcf4fSzwtMZ2zOohVlnGl
         S2c9JWCEFupxMRL0Al7kZcfVR3pkK7P+JGwvhMp786yvkIAA8vDyRDxmVS/H0QmiF0
         Y1l75lgJrpgVA96rzo5uvXs9ILpxP6nCGFj8bhH0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 120/123] proc: fixup map_files test on arm
Date:   Wed,  5 Dec 2018 04:35:52 -0500
Message-Id: <20181205093555.5386-120-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>

[ Upstream commit dbd4af54745fc0c805217693c807a3928b2d408b ]

https://bugs.linaro.org/show_bug.cgi?id=3782

Turns out arm doesn't permit mapping address 0, so try minimum virtual
address instead.

Link: http://lkml.kernel.org/r/20181113165446.GA28157@avx2
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Reported-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
Tested-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
Acked-by: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/proc/proc-self-map-files-002.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-self-map-files-002.c b/tools/testing/selftests/proc/proc-self-map-files-002.c
index 6f1f4a6e1ecb..85744425b08d 100644
--- a/tools/testing/selftests/proc/proc-self-map-files-002.c
+++ b/tools/testing/selftests/proc/proc-self-map-files-002.c
@@ -13,7 +13,7 @@
  * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
-/* Test readlink /proc/self/map_files/... with address 0. */
+/* Test readlink /proc/self/map_files/... with minimum address. */
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -47,6 +47,11 @@ static void fail(const char *fmt, unsigned long a, unsigned long b)
 int main(void)
 {
 	const unsigned int PAGE_SIZE = sysconf(_SC_PAGESIZE);
+#ifdef __arm__
+	unsigned long va = 2 * PAGE_SIZE;
+#else
+	unsigned long va = 0;
+#endif
 	void *p;
 	int fd;
 	unsigned long a, b;
@@ -55,7 +60,7 @@ int main(void)
 	if (fd == -1)
 		return 1;
 
-	p = mmap(NULL, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE|MAP_FIXED, fd, 0);
+	p = mmap((void *)va, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE|MAP_FIXED, fd, 0);
 	if (p == MAP_FAILED) {
 		if (errno == EPERM)
 			return 2;
-- 
2.17.1

