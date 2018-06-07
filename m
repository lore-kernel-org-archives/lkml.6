Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4uGuEJpOGVv4eAAAmS7hNA
	; Thu, 07 Jun 2018 15:27:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 536036089E; Thu,  7 Jun 2018 15:27:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1E5E4601B4;
	Thu,  7 Jun 2018 15:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1E5E4601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935605AbeFGP1A (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:27:00 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41122 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753712AbeFGO53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:57:29 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbm-0005hO-Pq; Thu, 07 Jun 2018 15:09:47 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb3-0002sf-4Y; Thu, 07 Jun 2018 15:09:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jan Chochol" <jan@chochol.info>,
        "Trond Myklebust" <trond.myklebust@primarydata.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.771748564@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 141/410] nfs: Do not convert nfs_idmap_cache_timeout
 to jiffies
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Chochol <jan@chochol.info>

commit cbebc6ef4fc830f4040d4140bf53484812d5d5d9 upstream.

Since commit 57e62324e469 ("NFS: Store the legacy idmapper result in the
keyring") nfs_idmap_cache_timeout changed units from jiffies to seconds.
Unfortunately sysctl interface was not updated accordingly.

As a effect updating /proc/sys/fs/nfs/idmap_cache_timeout with some
value will incorrectly multiply this value by HZ.
Also reading /proc/sys/fs/nfs/idmap_cache_timeout will show real value
divided by HZ.

Fixes: 57e62324e469 ("NFS: Store the legacy idmapper result in the keyring")
Signed-off-by: Jan Chochol <jan@chochol.info>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/nfs/nfs4sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfs/nfs4sysctl.c
+++ b/fs/nfs/nfs4sysctl.c
@@ -31,7 +31,7 @@ static struct ctl_table nfs4_cb_sysctls[
 		.data = &nfs_idmap_cache_timeout,
 		.maxlen = sizeof(int),
 		.mode = 0644,
-		.proc_handler = proc_dointvec_jiffies,
+		.proc_handler = proc_dointvec,
 	},
 	{ }
 };
