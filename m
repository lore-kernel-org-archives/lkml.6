Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="KgLp9pa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B6DDD60764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbeFFNye (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:54:34 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:49236 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbeFFNyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:54:31 -0400
X-IronPort-AV: E=Sophos;i="5.49,483,1520899200";
   d="scan'208";a="723031022"
From: Norbert Manthey <nmanthey@amazon.de>
CC: Norbert Manthey <nmanthey@amazon.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Terrell <terrelln@fb.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jinbum Park <jinb.park7@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Dave Young <dyoung@redhat.com>,
        Tom Herbert <tom@quantonium.net>,
        <linux-kernel@vger.kernel.org>
Subject: [less-CONFIG_NET 4/7] seccomp: include nlattr
Date: Wed, 6 Jun 2018 15:53:23 +0200
Message-ID: <1528293206-24298-4-git-send-email-nmanthey@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528293206-24298-1-git-send-email-nmanthey@amazon.de>
References: <1528293127-23825-1-git-send-email-nmanthey@amazon.de>
 <1528293206-24298-1-git-send-email-nmanthey@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we want to use CONFIG_SECCOMP_FILTER without CONFIG_NET, we have
to ensure that the required files that would be pulled in via
CONFIG_NET are compiled when dropping CONFIG_NET.

Here, we could also select CONFIG_NLATTR instead of pulling the file
in explicitly. One could go even one step further and cut the only
required function off, namely nla_find.

This is part of the effort to split CONFIG_SECCOMP_FILTER and
CONFIG_NET.

Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
---
 lib/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/Makefile b/lib/Makefile
index ce20696..bbe09f3 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -163,7 +163,9 @@ obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
 
 obj-$(CONFIG_DYNAMIC_DEBUG) += dynamic_debug.o
 
-obj-$(CONFIG_NLATTR) += nlattr.o
+ifneq ($(filter y,$(CONFIG_NLATTR) $(CONFIG_SECCOMP_FILTER)),)
+obj-y += nlattr.o
+endif
 
 obj-$(CONFIG_LRU_CACHE) += lru_cache.o
 
-- 
2.7.4

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
