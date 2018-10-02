Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92014C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF00208D9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF00208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbeJCDvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:51:54 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:45909 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbeJCDvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:51:53 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MUog3-1gFwBL2wEb-00QfuK; Tue, 02 Oct 2018 23:06:22 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MUog3-1gFwBL2wEb-00QfuK; Tue, 02 Oct 2018 23:06:22 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Matthew Wilcox <willy@infradead.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] xarray: fix unused-variable warnings
Date:   Tue,  2 Oct 2018 23:06:08 +0200
Message-Id: <20181002210621.2538114-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:tjC3FWE0G2awhN76A3IR6mzTzy4YZtXfUIc0p8AXEGoNyQwf9mo
 qera5pmtYEavoFtAlJxvlEOsA0LLM5/zkCd9jLGeTz65MJ1BQrkpWqVF9CzK9oATA2M3Cp9
 X/qVDrvd4LG5TjK2h573dmcGsM1MjSJtWs156AOBch+txpsqB0MH7hmvB1XJ20pN+Ejdvv6
 Jd3jz4DmuYVHwgZvAo3SA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6SF4fEfrFns=:/nC6iFfr4YtlOXpF9OWjxP
 ltcH5xNR+N6QO9Cpj6MzGb57udwbD2ezaI4g9sN1C8YsSnR19RLVPSCe8GS93eECwVnl7TSz4
 nXYNqwSMxYt8p9e+rq66rV9G4mWDz5PcB8tJ777PxfDlTlickNQG3o8KnWwaHnuGhACjD0AVL
 Z+uR1A0cmAcgwzx8Uocyza2L5xuIeYuFDiRV7PLBdwRZt7p2artJpfU9nmpUsXskMO+2PrHTK
 WbVBKP0wnmMd2r9MiSyQdPSaZ196l2EAC/oApRThwRZlWLGBT+MUfor/6b3dMa/ePFN9TaqNB
 KfPXNX702nBftTtkl4HXADKq0XJnnirMVsMiFcepHLq/aGCle6m9MDTsvTFmOeCN5aunIPx5t
 bUnjhGenpNHvOHK2up4DC5+X3WdXN+CXJU+dOIGxo/nsCOe/Et8aJ2AcyORKf8Y+vDW9CDX4B
 ezigkGRHHeZBbOUwX+O9r/yxktrEqsh57vVPMgQXQFmN/rrvBDOJuU7P3oGScmFr5L8WZVCsP
 eDVIlTEJou0qUzdajcTVAvlpjAnUFSoX/uxJXy/TQb2qX4zs9pyIzfdSCuzVkrwwhcZdHa6n7
 4zCYuRnyNygle8yjRkJD9IbjwyM6Dl3eLYTO80kyuQ2ZICzo83IW05DnupssZwNedJMEnM97n
 BJUH3RCsL4CdcHzERVkGiZYo3tw+/Jbsmy3+pU1IWOO7ytMGwq2nZuF8vop43DrdOzDs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two variables that are only used in an #ifdef cause compiler warnings:

lib/test_xarray.c: In function 'check_xa_tag_1':
lib/test_xarray.c:162:15: error: unused variable 'order' [-Werror=unused-variable]
  unsigned int order;

lib/test_xarray.c: In function 'check_xa_shrink':
lib/test_xarray.c:288:15: error: unused variable 'order' [-Werror=unused-variable]
  unsigned int order;

Add another #ifdef around the declaration to avoid the warning.

Fixes: 4f79afaf4662 ("xarray: Move multiorder_shrink to kernel tests")
Fixes: 137689411a26 ("xarray: Move multiorder account test in-kernel")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/test_xarray.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index ef68a3f0fc4c..1f3674fda53d 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -159,7 +159,9 @@ static noinline void check_xa_load(struct xarray *xa)
 
 static noinline void check_xa_tag_1(struct xarray *xa, unsigned long index)
 {
+#ifdef CONFIG_XARRAY_MULTI
 	unsigned int order;
+#endif
 
 	/* NULL elements have no tags set */
 	XA_BUG_ON(xa, xa_get_mark(xa, index, XA_MARK_0));
@@ -285,7 +287,9 @@ static noinline void check_xa_shrink(struct xarray *xa)
 {
 	XA_STATE(xas, xa, 1);
 	struct xa_node *node;
+#ifdef CONFIG_XARRAY_MULTI
 	unsigned int order;
+#endif
 
 	XA_BUG_ON(xa, !xa_empty(xa));
 	XA_BUG_ON(xa, xa_store_index(xa, 0, GFP_KERNEL) != NULL);
-- 
2.18.0

