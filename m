Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25326C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2478208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="El22LD7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2478208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbeK0R7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 12:59:15 -0500
Received: from m12-12.163.com ([220.181.12.12]:60153 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728597AbeK0R7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 12:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=n4qcQHCUeLmjnPnVLj
        h/wKr5FAa6bQ0ff11NUi0uUiw=; b=El22LD7oU3p2nJ0h7Y8voiZOxZJlw9au4c
        5BlumJGD3bWLvMuQwA6Jn3mxtmnZmmnA7ULGCN0YxETZTcN6ncisNoogC9Co+acT
        +gn4LLIvE4co9GoR1idff7sNn/qz5lu1SHgYZAIdSzl0e215JeD6X4Ra6Gm4JD66
        Z6wyfLsqI=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp8 (Coremail) with SMTP id DMCowAB3uzHv6_xbhguxCA--.15263S3;
        Tue, 27 Nov 2018 15:02:09 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>,
        Sage Weil <sage@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     ceph-devel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: [PATCH] libceph: fix use after free
Date:   Tue, 27 Nov 2018 15:02:07 +0800
Message-Id: <1543302127-14435-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DMCowAB3uzHv6_xbhguxCA--.15263S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr4DCFy5XFy7XF45GFWfKrg_yoWDJrX_Za
        yjvr92ga1IyFWFk3ZFkws8AF4Igw1ruF1fGr1fCrW8A34UJFZxArs2v3s5ZF1fWF4UC3W7
        XF4q9ry5Jr4xZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnO6pDUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiDhEMclXlpnhhiAAAsm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function ceph_monc_handle_map calls kfree(old) to free the old
monitor map, old points to monc->monmap. However, after that, it reads
monc->monmap->epoch and passes it to __ceph_monc_got_map. This result in
a use-after-free bug. The patch moves the free operation after the call
to __ceph_monc_got_map.

Fixes: 82dcabad750("libceph: revamp subs code, switch to SUBSCRIBE2
protocol")

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 net/ceph/mon_client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 18deb3d..05ef5aa 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -478,9 +478,10 @@ static void ceph_monc_handle_map(struct ceph_mon_client *monc,
 	}
 
 	client->monc.monmap = monmap;
-	kfree(old);
 
 	__ceph_monc_got_map(monc, CEPH_SUB_MONMAP, monc->monmap->epoch);
+	kfree(old);
+
 	client->have_fsid = true;
 
 out:
-- 
2.7.4


