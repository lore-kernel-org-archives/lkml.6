Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13D7C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3A620892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791032;
	bh=Jm3Jbwbjv3lL2E/YJZaLbivBWy4VVWRA25LqVDzyAKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rGASLsw2po4qoN1hnB46+m19Dle4f9lsq1oCHb/riWGfOXhAE6/xs8MnSIc+fyE3K
	 +SGybM+XO29XGBIPl2f4mImsHmIrVkxGc94/vDegiKNTcmLnBoWvCkIk625X/3593L
	 tfJxZknmErkSYAVrpvt525dGdxPiTAzXWKy4DtmM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3A620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbeLNMhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:37:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:51546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730929AbeLNMG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:06:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF6022147D;
        Fri, 14 Dec 2018 12:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789189;
        bh=Jm3Jbwbjv3lL2E/YJZaLbivBWy4VVWRA25LqVDzyAKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RetLiqDxJm/8vp4NHdnxu2Ut6HvmYiX1bCRlvq2EJogQ8Gl2yMFdivZMPXpsWjAtg
         AM8g9aiCL1uCIZQmssleu/QI5a7q4TI18Ctn929NMIVY4S55jRS8fF+QYcRFyx4JYx
         oL994NX7ewgSgUFvOqZUICAbS1GODckTvkK5efCo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
        Rafael David Tinoco <rafael.tinoco@linaro.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 129/142] proc: fixup map_files test on arm
Date:   Fri, 14 Dec 2018 13:00:14 +0100
Message-Id: <20181214115752.202104280@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



