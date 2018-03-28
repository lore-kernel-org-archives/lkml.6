Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753630AbeC1OD0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:03:26 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:54205 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753098AbeC1ODZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:03:25 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jon Maloy <jon.maloy@ericsson.com>, Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Parthasarathy Bhuvaragan <parthasarathy.bhuvaragan@ericsson.com>,
        netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tipc: avoid possible string overflow
Date: Wed, 28 Mar 2018 16:02:04 +0200
Message-Id: <20180328140302.2594031-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:5RhZM5SbmawoVgP1LJGeBeNkOKj7yHdtvOneWGsGT6dQ+mXciGV
 9EArn0BsSTFl0KgS2TNvN+px6coiNgBZ6/f6N4aEfftAS5jBCJ2IYS569i5/1Y7W16i0h4V
 pO7A7uZ3aqMJDkARxD10Y5JiL/NhZRzdIrNBtFk9Sp7yC8E2PY17qh8A035vXWNPdGb/eCU
 SXUUmF1Wjh/oE9rcmblOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ARZNESDlisA=:PijNZ9FbgEocPXILR+4oGP
 BN4PNY3JdGJ/Mgx8+I1ITxAxc0mC5P5iIVYglWJrKeBOPBq6mT1hv52mPhcaI0qLu+DjTIW4m
 O4JH0P64eRuCJnMeCyvZRsVdqVLAZmIiPIeV1Ut4W8eNX7DCHR1wLZ3EZxYJ2q3fEV0zmY2a+
 6piYSXEXQ0mDpfeoOsnglZ3JXJBFhZ61n6EtqHkZ+5cgUcHoo1s41YOAQKIQ+eK06fmHhATUE
 rRwv2eE0ql7yjCfIhmM5YFLhA0voiiXfV5WssC6gUxf+kO+ThnfXjIjbkxW9vSYijx/FtN1vc
 vPieSnpntacC9mctTFbsVr+0+UOCKWx5mkuos9Qvc+P0e8+Ev5nILMqkVfwMsNgQStEd/jcnO
 m+VFPHDll/xUG/CXy2Znq2YyfQwDrnb+ZYFeKZhsTcM4cJt1xnZD28rzkcLCsuhlKCDPShSH9
 Dx8eCnjf8zfPBF9RCeAOLtNPbRg6pBEm7RiCYPLNtAJ8e/UR5B67en41BcCKD4CD4JupKDN0W
 9QCDSHTxs/vwlzG9vtDmAlgCgF0WGen6j6ujRgDrDNgUGNt/lVjMopLR/Y0tO6uY/MODAv11B
 uTVBaE1D23ZD6tls/dZfEur35AmGm0rhI3UoEME30F42KwrLcLWbHSxe9C44JrOgAuYKX1ZDm
 f/EnueM2UAz/abmk1Yc1C0F1JJ+Vs0Yv1R8efhesgabvd9gnUqw6lsrqqeQuZOdallSOXykcq
 RJNRgfFDZdkKU0R0ibw1nNJjqqdFmsKaKZG+aw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc points out that the combined length of the fixed-length inputs to
l->name is larger than the destination buffer size:

net/tipc/link.c: In function 'tipc_link_create':
net/tipc/link.c:465:26: error: '%s' directive writing up to 32 bytes into a region of size between 26 and 58 [-Werror=format-overflow=]
  sprintf(l->name, "%s:%s-%s:unknown", self_str, if_name, peer_str);
                          ^~                              ~~~~~~~~
net/tipc/link.c:465:2: note: 'sprintf' output 11 or more bytes (assuming 75) into a destination of size 60
  sprintf(l->name, "%s:%s-%s:unknown", self_str, if_name, peer_str);

Using snprintf() ensures that the destination is still a nul-terminated
string in all cases. It's still theoretically possible that the string
gets trunctated though, so this patch should be carefully reviewed to
ensure that either truncation is impossible in practice, or that we're
ok with the truncation.

Fixes: 25b0b9c4e835 ("tipc: handle collisions of 32-bit node address hash values")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/tipc/link.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 1289b4ba404f..c195ba036035 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -462,7 +462,8 @@ bool tipc_link_create(struct net *net, char *if_name, int bearer_id,
 			sprintf(peer_str, "%x", peer);
 	}
 	/* Peer i/f name will be completed by reset/activate message */
-	sprintf(l->name, "%s:%s-%s:unknown", self_str, if_name, peer_str);
+	snprintf(l->name, sizeof(l->name), "%s:%s-%s:unknown",
+		 self_str, if_name, peer_str);
 
 	strcpy(l->if_name, if_name);
 	l->addr = peer;
-- 
2.9.0
