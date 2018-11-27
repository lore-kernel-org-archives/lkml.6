Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACA1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1F82086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="egnCOtzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1F82086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbeK0USx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:18:53 -0500
Received: from m12-15.163.com ([220.181.12.15]:34748 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729747AbeK0USx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=P7d7oRFMpZRZlDmpOo
        /WNtGhi4hsYq/yW6a+B3n9tDM=; b=egnCOtzZcjXz52iCk8VBMq08h1scOMjhsb
        tgX5ggP8iUCetDSdqT28o2zKHTjiNXJiC3xeySCSE0zYaT5O6wot7ep0jgC8IEPy
        q2sgLLadgRJd2PyP2kTEsvyAvh0AjJsjQn18EtiDhZoL8f2+geagZujILuukSACv
        thxiqr0dY=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp11 (Coremail) with SMTP id D8CowACHjyyRDP1bJXitAA--.6645S3;
        Tue, 27 Nov 2018 17:21:24 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>,
        Sage Weil <sage@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     ceph-devel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: [PATCH V2] libceph: fix use after free
Date:   Tue, 27 Nov 2018 17:21:12 +0800
Message-Id: <1543310472-31861-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: D8CowACHjyyRDP1bJXitAA--.6645S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr4DCFy5XFy7XF48tw1UKFg_yoWDArg_Za
        yUZryvgw1SyFWFk3ZFkws8AF4xWw18uF1fGr1fArW8A34UJrsxArs2v34rZF1xGF4UCw17
        XF4Dury5Jr1xZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0qXdUUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBzxQMclaD0boqxAAAs1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function ceph_monc_handle_map calls kfree(old) to free the old
monitor map, old points to monc->monmap. However, after that, it reads
monc->monmap->epoch and passes it to __ceph_monc_got_map. This will 
result in a use-after-free bug. The patch moves the free operation after
the call to __ceph_monc_got_map.

Fixes: 82dcabad750 ("libceph: revamp subs code, switch to SUBSCRIBE2 protocol")

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
V2: correct the format of the tag Fixes
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


