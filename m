Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="sGnhg8sZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5006A60764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeFFNy6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:54:58 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:37891 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbeFFNyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:54:55 -0400
X-IronPort-AV: E=Sophos;i="5.49,483,1520899200";
   d="scan'208";a="681907920"
From: Norbert Manthey <nmanthey@amazon.de>
CC: Norbert Manthey <nmanthey@amazon.de>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Josef Bacik <jbacik@fb.com>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ding Tianhong <dingtianhong@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [less-CONFIG_NET 6/7] seccomp: drop CONFIG_NET
Date: Wed, 6 Jun 2018 15:53:25 +0200
Message-ID: <1528293206-24298-6-git-send-email-nmanthey@amazon.de>
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

With the goal of dropping CONFIG_NET, we have to drop the dependency
in the configuration management. Since SECCOMP_FILTER also requires
BPF functionality, which is usually activated by CONFIG_NET, imply
BPF from SECCOMP_FILTER directly.

In case both CONFIG_NET and CONFIG_SECCOMP_FILTER are activated, BPF
will be activated as well, so this additional dependency does not
destroy original builds.

Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
---
 arch/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 75dd23a..c7108fd 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -393,7 +393,8 @@ config HAVE_ARCH_SECCOMP_FILTER
 
 config SECCOMP_FILTER
 	def_bool y
-	depends on HAVE_ARCH_SECCOMP_FILTER && SECCOMP && NET
+	depends on HAVE_ARCH_SECCOMP_FILTER && SECCOMP
+	select BPF
 	help
 	  Enable tasks to build secure computing environments defined
 	  in terms of Berkeley Packet Filter programs which implement
-- 
2.7.4

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
