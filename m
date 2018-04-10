Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeDJBPN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 21:15:13 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33810 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeDJBPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 21:15:12 -0400
X-Google-Smtp-Source: AIpwx49WEBlR+lamSeASF/XaiEItiGq0DPoVpbMkbd3ED9JZo5vOdG33MYdObGOQk1BZbT+m/n7MuA==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: gerrit@erg.abdn.ac.uk, davem@davemloft.net
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] net: dccp: Replace GFP_ATOMIC with GFP_KERNEL in dccp_init
Date: Tue, 10 Apr 2018 09:14:58 +0800
Message-Id: <1523322898-27833-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dccp_init() is never called in atomic context.
This function is only set as a parameter of module_init().

Despite never getting called from atomic context,
dccp_init() calls __get_free_pages() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Modify the description of GFP_ATOMIC in v1.
  Thank Eric for good advice.
---
 net/dccp/proto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index b68168f..f63ba93 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -1159,7 +1159,7 @@ static int __init dccp_init(void)
 			hash_size--;
 		dccp_hashinfo.ehash_mask = hash_size - 1;
 		dccp_hashinfo.ehash = (struct inet_ehash_bucket *)
-			__get_free_pages(GFP_ATOMIC|__GFP_NOWARN, ehash_order);
+			__get_free_pages(GFP_KERNEL|__GFP_NOWARN, ehash_order);
 	} while (!dccp_hashinfo.ehash && --ehash_order > 0);
 
 	if (!dccp_hashinfo.ehash) {
@@ -1182,7 +1182,7 @@ static int __init dccp_init(void)
 		    bhash_order > 0)
 			continue;
 		dccp_hashinfo.bhash = (struct inet_bind_hashbucket *)
-			__get_free_pages(GFP_ATOMIC|__GFP_NOWARN, bhash_order);
+			__get_free_pages(GFP_KERNEL|__GFP_NOWARN, bhash_order);
 	} while (!dccp_hashinfo.bhash && --bhash_order >= 0);
 
 	if (!dccp_hashinfo.bhash) {
-- 
1.9.1
