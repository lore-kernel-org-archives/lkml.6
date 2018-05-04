Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbeEDNjl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:39:41 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.4]:49720 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751302AbeEDNjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:39:36 -0400
X-Authority-Reason: nr=8
Date: Fri, 4 May 2018 08:39:32 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] apparmor: secid: fix error return value in error handling
 path
Message-ID: <20180504133932.GA15968@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.172.56.86
X-Source-L: No
X-Exim-ID: 1fEavu-000c7G-C0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.172.56.86]:48808
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, function apparmor_secid_to_secctx returns always zero,
no matter if the value returned by aa_label_asxprint is negative
(which implies that an error has occurred).

Fix this by temporarily storing the value returned by aa_label_asxprint
into a variable of type int (signed) for its further evaluation.

Addresses-Coverity-ID: 1468514 ("Unsigned compared against 0")
Fixes: c092921219d2 ("apparmor: add support for mapping secids and using secctxes")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 security/apparmor/secid.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 5029248..4b902ed 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -142,6 +142,7 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
 	/* TODO: cache secctx and ref count so we don't have to recreate */
 	struct aa_label *label = aa_secid_to_label(secid);
+	int seclen_tmp;
 
 	AA_BUG(!secdata);
 	AA_BUG(!seclen);
@@ -150,17 +151,19 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 		return -EINVAL;
 
 	if (secdata)
-		*seclen = aa_label_asxprint(secdata, root_ns, label,
+		seclen_tmp = aa_label_asxprint(secdata, root_ns, label,
 					    FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
 					    FLAG_HIDDEN_UNCONFINED |
 					    FLAG_ABS_ROOT, GFP_ATOMIC);
 	else
-		*seclen = aa_label_snxprint(NULL, 0, root_ns, label,
+		seclen_tmp = aa_label_snxprint(NULL, 0, root_ns, label,
 					    FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
 					    FLAG_HIDDEN_UNCONFINED |
 					    FLAG_ABS_ROOT);
-	if (*seclen < 0)
+	if (seclen_tmp < 0)
 		return -ENOMEM;
+	else
+		*seclen = seclen_tmp;
 
 	return 0;
 }
-- 
2.7.4
