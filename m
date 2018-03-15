Return-Path: <msuchanek@suse.de>
X-Google-Smtp-Source: AG47ELt7J62p3k9BsOiRbDDp40Q6zZTpDC962IJ3u6IhCMGYb9Dd9eoUrHcK1UrAEhevn1QAReVj
ARC-Seal: i=1; a=rsa-sha256; t=1521141382; cv=none;
        d=google.com; s=arc-20160816;
        b=RDL7EZpVpvFAd8Ge8paqeWJd6ZxA1Vk06785460BT9xoVQKtTberVwU3Ul7sNZ48tN
         eIL0KyxdddRPJuoX1FuXk4M698nxl139SGXj5uHzeS8WK/jfNgU+wy0ZN4us2qVFaetr
         cBM30QgnyJWDv7xcqy0Qmy2nCtyukuSarVeZCEN5rUs1GIKOSa7QrubfGBUn6GUXH+xY
         5JDyjI3DVJWf4lO3LbzfVugyXUR0Sl1+DXUuELHcAuYZzhssPprSvd2PlJRSln6sTepS
         5RmBlsoHgvwJ+hfNSqfQo2AhPiHNKPDst/+0elpN41aezqbdin3P0zXkhQvhj71JmamW
         3u1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MjeQH6/o+pSQUiPMo6susXjsjdsbYhgfwRnxrq1rbxc=;
        b=ci0Rk9sHMsR0U8oOtXISfm0AUAjeeFxIWRe8MHQ2iGwNozPonN3Qz0dCR/9zGRJN/5
         ZEJcqWKvMoLHl9RwRzXqpn4BYwxno1NEuDdJjmrR5R9aCqPGIOsJBBD2GRhr3/Fe5Hy1
         3BaDypRJt+rkdj4o4MDbkLR+QpRDZReIYaIqqcWJk8Vi80rL3hd4FPkUNQ11JYO7pK7R
         6MEyC4elmEd5k3arxUT5Qzd5L1TvHAdQ1/3LY2dd8KoZcAJlJeRsdfBgyEnXmrT+aiG6
         WUtILtueLuFH+FNeoCELzY7b280zIS0d8sihPEAg+QHHis2CBcbfXaek9g4Wp56I9sVN
         cdDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	Michael Neuling <mikey@neuling.org>,
	"Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Daniel Axtens <dja@axtens.net>,
	Nicholas Piggin <npiggin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	David Gibson <david@gibson.dropbear.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Joe Perches <joe@perches.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Tobin C. Harding" <me@tobin.cc>,
	Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH RFC rebase 1/9] powerpc: Add barrier_nospec
Date: Thu, 15 Mar 2018 20:15:50 +0100
Message-Id: <8cb7d41beef9bdd351120d0512f73ac3bfada168.1521141122.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
 <cover.1521141122.git.msuchanek@suse.de>
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <cover.1521141122.git.msuchanek@suse.de>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594848477585828051?=
X-GMAIL-MSGID: =?utf-8?q?1595032346073305379?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When the firmware supports it an otherwise useless combination of ORI
instruction arguments is interpreted as speculation barrier. Implement
barrier_nospec using this instruction.

Based on the out-of-tree gmb() implementation.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/include/asm/barrier.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index 10daa1d56e0a..8e47b3abe405 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -75,6 +75,15 @@ do {									\
 	___p1;								\
 })
 
+/* TODO: add patching so this can be disabled */
+/* Prevent speculative execution past this barrier. */
+#define barrier_nospec_asm ori 31,31,0
+#ifdef __ASSEMBLY__
+#define barrier_nospec barrier_nospec_asm
+#else
+#define barrier_nospec() __asm__ __volatile__ (stringify_in_c(barrier_nospec_asm) : : :)
+#endif
+
 #include <asm-generic/barrier.h>
 
 #endif /* _ASM_POWERPC_BARRIER_H */
-- 
2.13.6
