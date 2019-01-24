Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BCAC282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DAB21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="mGm3dThw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfAXCPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 21:15:39 -0500
Received: from m50-112.126.com ([123.125.50.112]:55419 "EHLO m50-112.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbfAXCPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 21:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=MOhb/KxrNV+Kz08mu0
        ABo+to0TLS8Vf608VGSzEtxZ8=; b=mGm3dThwL13Qx1D6bhh1ySRk0GZOcYHshU
        QjyULT1PhonRCyisaPuTut7dFscP9yox9MpEvxSFeNdfJ55hVsg+hmvhabh4fqlZ
        hhvD2k9G/L5XkqhRPNpU28Lr2rhBV2m6B/PqP+QSAQFbmStYWTuLCoo7jRt+dty/
        bLt0wnJME=
Received: from pek-zhang3-d1.corp.ad.wrs.com (unknown [60.247.85.82])
        by smtp6 (Coremail) with SMTP id j9KowACHOLWyH0lc1f_FAQ--.86S2;
        Thu, 24 Jan 2019 10:15:20 +0800 (CST)
From:   Zhaolong Zhang <zhangzl2013@126.com>
To:     jon.maloy@ericsson.com, ying.xue@windriver.com,
        davem@davemloft.net, zhangzl2013@126.com
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tipc: remove dead code in struct tipc_topsrv
Date:   Thu, 24 Jan 2019 10:06:41 +0800
Message-Id: <1548295601-23063-1-git-send-email-zhangzl2013@126.com>
X-Mailer: git-send-email 1.9.1
X-CM-TRANSID: j9KowACHOLWyH0lc1f_FAQ--.86S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFykAF4xCw1DuryfuF1kGrg_yoWDZwcEk3
        4xtF4xCr48Ww4vvws8Gw43Xa4kJw4rJF10gr10vryqgwsIqr18Ars5XryDWFW5uw4xC3W5
        uw1DWrnIywsrGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbApntUUUUU==
X-Originating-IP: [60.247.85.82]
X-CM-SenderInfo: x2kd0wt2osiiat6rjloofrz/1tbi6xlGz1pD7mM2CAAAsR
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max_rcvbuf_size is no longer used since commit "414574a0af36".

Signed-off-by: Zhaolong Zhang <zhangzl2013@126.com>
---
 net/tipc/topsrv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index efb16f6..4b1c083 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -60,7 +60,6 @@
  * @awork: accept work item
  * @rcv_wq: receive workqueue
  * @send_wq: send workqueue
- * @max_rcvbuf_size: maximum permitted receive message length
  * @listener: topsrv listener socket
  * @name: server name
  */
@@ -72,7 +71,6 @@ struct tipc_topsrv {
 	struct work_struct awork;
 	struct workqueue_struct *rcv_wq;
 	struct workqueue_struct *send_wq;
-	int max_rcvbuf_size;
 	struct socket *listener;
 	char name[TIPC_SERVER_NAME_LEN];
 };
@@ -648,7 +646,6 @@ int tipc_topsrv_start(struct net *net)
 		return -ENOMEM;
 
 	srv->net = net;
-	srv->max_rcvbuf_size = sizeof(struct tipc_subscr);
 	INIT_WORK(&srv->awork, tipc_topsrv_accept);
 
 	strscpy(srv->name, name, sizeof(srv->name));
-- 
1.9.1

