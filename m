Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA06C00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 14:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C132075C
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 14:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C132075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbeJGWEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 18:04:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727834AbeJGWEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 18:04:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E98B93097029;
        Sun,  7 Oct 2018 14:57:00 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-33.brq.redhat.com [10.40.200.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 76C2E10001BC;
        Sun,  7 Oct 2018 14:56:58 +0000 (UTC)
Date:   Sun, 7 Oct 2018 16:57:31 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Ursula Braun <ubraun@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Hans Wippel <hwippel@linux.ibm.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH net v2 1/2] net/smc: use __aligned_u64 for 64-bit smc_diag
 fields
Message-ID: <20181007145731.GA24045@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sun, 07 Oct 2018 14:57:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4b1b7d3b30a6 ("net/smc: add SMC-D diag support") introduced
new UAPI-exposed structure, struct smcd_diag_dmbinfo.  However,
it's not usable by compat binaries, as it has different layout there.
Probably, the most straightforward fix that will avoid similar issues
in the future is to use __aligned_u64 for 64-bit fields.

Fixes: 4b1b7d3b30a6 ("net/smc: add SMC-D diag support")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 include/uapi/linux/smc_diag.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/smc_diag.h b/include/uapi/linux/smc_diag.h
index ac9e8c9..6180c6d 100644
--- a/include/uapi/linux/smc_diag.h
+++ b/include/uapi/linux/smc_diag.h
@@ -18,14 +18,14 @@ struct smc_diag_req {
  * on the internal clcsock, and more SMC-related socket data
  */
 struct smc_diag_msg {
-	__u8	diag_family;
-	__u8	diag_state;
-	__u8	diag_mode;
-	__u8	diag_shutdown;
+	__u8		diag_family;
+	__u8		diag_state;
+	__u8		diag_mode;
+	__u8		diag_shutdown;
 	struct inet_diag_sockid id;
 
-	__u32	diag_uid;
-	__u64	diag_inode;
+	__u32		diag_uid;
+	__aligned_u64	diag_inode;
 };
 
 /* Mode of a connection */
@@ -99,11 +99,11 @@ struct smc_diag_fallback {
 };
 
 struct smcd_diag_dmbinfo {		/* SMC-D Socket internals */
-	__u32 linkid;			/* Link identifier */
-	__u64 peer_gid;			/* Peer GID */
-	__u64 my_gid;			/* My GID */
-	__u64 token;			/* Token of DMB */
-	__u64 peer_token;		/* Token of remote DMBE */
+	__u32		linkid;		/* Link identifier */
+	__aligned_u64	peer_gid;	/* Peer GID */
+	__aligned_u64	my_gid;		/* My GID */
+	__aligned_u64	token;		/* Token of DMB */
+	__aligned_u64	peer_token;	/* Token of remote DMBE */
 };
 
 #endif /* _UAPI_SMC_DIAG_H_ */
-- 
2.1.4

