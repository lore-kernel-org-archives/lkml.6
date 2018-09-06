Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E53EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EA7206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3EA7206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbeIFNxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:53:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728110AbeIFNxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:53:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3150B402332F;
        Thu,  6 Sep 2018 09:18:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1ECCFFA973;
        Thu,  6 Sep 2018 09:18:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/11] UAPI: coda: Move kernel internals out of public view
 [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Yann Droneaud <ydroneaud@opteya.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        codalist@coda.cs.cmu.edu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Thu, 06 Sep 2018 10:18:57 +0100
Message-ID: <153622553762.14298.10096062467394188420.stgit@warthog.procyon.org.uk>
In-Reply-To: <153622549721.14298.8116794954073122489.stgit@warthog.procyon.org.uk>
References: <153622549721.14298.8116794954073122489.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 06 Sep 2018 09:18:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 06 Sep 2018 09:18:59 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upc_req struct and the CODA_REQ_* constants are kernel internals and
shouldn't have been exposed to userspace.  Indeed, the upc_req struct
contains other kernel internal structs.

Move them to include/linux/coda_psdev.h.

Suggested-by: Yann Droneaud <ydroneaud@opteya.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Yann Droneaud <ydroneaud@opteya.com>
cc: Jan Harkes <jaharkes@cs.cmu.edu>
cc: coda@cs.cmu.edu
cc: codalist@coda.cs.cmu.edu
cc: linux-fsdevel@vger.kernel.org
---

 include/linux/coda_psdev.h      |   18 +++++++++++++++++-
 include/uapi/linux/coda_psdev.h |   18 ------------------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/include/linux/coda_psdev.h b/include/linux/coda_psdev.h
index 15170954aa2b..c61e70b97319 100644
--- a/include/linux/coda_psdev.h
+++ b/include/linux/coda_psdev.h
@@ -8,6 +8,23 @@
 
 struct kstatfs;
 
+/* messages between coda filesystem in kernel and Venus */
+struct upc_req {
+	struct list_head    uc_chain;
+	caddr_t	            uc_data;
+	u_short	            uc_flags;
+	u_short             uc_inSize;  /* Size is at most 5000 bytes */
+	u_short	            uc_outSize;
+	u_short	            uc_opcode;  /* copied from data to save lookup */
+	int		    uc_unique;
+	wait_queue_head_t   uc_sleep;   /* process' wait queue */
+};
+
+#define CODA_REQ_ASYNC  0x1
+#define CODA_REQ_READ   0x2
+#define CODA_REQ_WRITE  0x4
+#define CODA_REQ_ABORT  0x8
+
 /* communication pending/processing queues */
 struct venus_comm {
 	u_long		    vc_seq;
@@ -19,7 +36,6 @@ struct venus_comm {
 	struct mutex	    vc_mutex;
 };
 
-
 static inline struct venus_comm *coda_vcp(struct super_block *sb)
 {
 	return (struct venus_comm *)((sb)->s_fs_info);
diff --git a/include/uapi/linux/coda_psdev.h b/include/uapi/linux/coda_psdev.h
index aa6623efd2dd..3dacb7fad66a 100644
--- a/include/uapi/linux/coda_psdev.h
+++ b/include/uapi/linux/coda_psdev.h
@@ -7,22 +7,4 @@
 #define CODA_PSDEV_MAJOR 67
 #define MAX_CODADEVS  5	   /* how many do we allow */
 
-
-/* messages between coda filesystem in kernel and Venus */
-struct upc_req {
-	struct list_head    uc_chain;
-	caddr_t	            uc_data;
-	u_short	            uc_flags;
-	u_short             uc_inSize;  /* Size is at most 5000 bytes */
-	u_short	            uc_outSize;
-	u_short	            uc_opcode;  /* copied from data to save lookup */
-	int		    uc_unique;
-	wait_queue_head_t   uc_sleep;   /* process' wait queue */
-};
-
-#define CODA_REQ_ASYNC  0x1
-#define CODA_REQ_READ   0x2
-#define CODA_REQ_WRITE  0x4
-#define CODA_REQ_ABORT  0x8
-
 #endif /* _UAPI__CODA_PSDEV_H */

