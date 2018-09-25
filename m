Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB69BC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692372086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692372086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeIYX2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:28:19 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:44242 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeIYX2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:28:19 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4r02-00050H-Lc; Tue, 25 Sep 2018 11:19:50 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4r01-0001uD-Dd; Tue, 25 Sep 2018 11:19:50 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 25 Sep 2018 19:19:01 +0200
Message-Id: <20180925171906.19683-1-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87h8idv6nw.fsf@xmission.com>
References: <87h8idv6nw.fsf@xmission.com>
X-XM-SPF: eid=1g4r01-0001uD-Dd;;;mid=<20180925171906.19683-1-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ARmvtKbdtRAblkAemujLwwcaNsbEJ190=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 1/6] signal/sparc: Move EMT_TAGOVF into the generic siginfo.h
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When moving all of the architectures specific si_codes into
siginfo.h, I apparently overlooked EMT_TAGOVF.  Move it now.

Remove the now redundant test in siginfo_layout for SIGEMT
as now NSIGEMT is always defined.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/sparc/include/uapi/asm/siginfo.h | 6 ------
 include/uapi/asm-generic/siginfo.h    | 6 ++++++
 kernel/signal.c                       | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/siginfo.h b/arch/sparc/include/uapi/asm/siginfo.h
index e7049550ac82..6c820ea0813b 100644
--- a/arch/sparc/include/uapi/asm/siginfo.h
+++ b/arch/sparc/include/uapi/asm/siginfo.h
@@ -17,10 +17,4 @@
 
 #define SI_NOINFO	32767		/* no information in siginfo_t */
 
-/*
- * SIGEMT si_codes
- */
-#define EMT_TAGOVF	1	/* tag overflow */
-#define NSIGEMT		1
-
 #endif /* _UAPI__SPARC_SIGINFO_H */
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 80e2a7227205..1811b8101937 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -285,6 +285,12 @@ typedef struct siginfo {
 #define SYS_SECCOMP	1	/* seccomp triggered */
 #define NSIGSYS		1
 
+/*
+ * SIGEMT si_codes
+ */
+#define EMT_TAGOVF	1	/* tag overflow */
+#define NSIGEMT		1
+
 /*
  * sigevent definitions
  * 
diff --git a/kernel/signal.c b/kernel/signal.c
index e16278710b36..7b49c31d3fdb 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2856,7 +2856,7 @@ enum siginfo_layout siginfo_layout(int sig, int si_code)
 			[SIGSEGV] = { NSIGSEGV, SIL_FAULT },
 			[SIGBUS]  = { NSIGBUS,  SIL_FAULT },
 			[SIGTRAP] = { NSIGTRAP, SIL_FAULT },
-#if defined(SIGEMT) && defined(NSIGEMT)
+#if defined(SIGEMT)
 			[SIGEMT]  = { NSIGEMT,  SIL_FAULT },
 #endif
 			[SIGCHLD] = { NSIGCHLD, SIL_CHLD },
-- 
2.17.1

