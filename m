Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753952AbeFDHFa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:05:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8630 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751796AbeFDHF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:05:27 -0400
From: nixiaoming <nixiaoming@huawei.com>
To: <davem@davemloft.net>, <dhowells@redhat.com>,
        <manuel.schoelling@gmx.de>, <wang840925@gmail.com>
CC: <nixiaoming@huawei.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: [PATCH] net/dns_resolver: dns_query Modify parameter checking to avoid dead code
Date: Mon, 4 Jun 2018 14:40:31 +0800
Message-ID: <20180604064031.116472-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.10.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 1a4240f4764a ("DNS: Separate out CIFS DNS Resolver code")
a dead code exists in function dns_query

code show as below:
	if (!name || namelen == 0)
		return -EINVAL;
	/*Now the value of "namelen" cannot be equal to 0*/
	....
	if (!namelen) /*The condition "!namelen"" cannot be true*/
		namelen = strnlen(name, 256); /*deadcode*/

Modify parameter checking to avoid dead code

Signed-off-by: nixiaoming <nixiaoming@huawei.com>
---
 net/dns_resolver/dns_query.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/dns_resolver/dns_query.c b/net/dns_resolver/dns_query.c
index 49da670..f2acee2 100644
--- a/net/dns_resolver/dns_query.c
+++ b/net/dns_resolver/dns_query.c
@@ -81,7 +81,9 @@ int dns_query(const char *type, const char *name, size_t namelen,
 	kenter("%s,%*.*s,%zu,%s",
 	       type, (int)namelen, (int)namelen, name, namelen, options);
 
-	if (!name || namelen == 0)
+	if (!name || namelen < 3 || namelen > 255)
+		return -EINVAL;
+	if (namelen > strnlen(name, 256)) /*maybe only need part of name*/
 		return -EINVAL;
 
 	/* construct the query key description as "[<type>:]<name>" */
@@ -94,10 +96,6 @@ int dns_query(const char *type, const char *name, size_t namelen,
 		desclen += typelen + 1;
 	}
 
-	if (!namelen)
-		namelen = strnlen(name, 256);
-	if (namelen < 3 || namelen > 255)
-		return -EINVAL;
 	desclen += namelen + 1;
 
 	desc = kmalloc(desclen, GFP_KERNEL);
-- 
2.10.1
