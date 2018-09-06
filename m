Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125C6C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 04:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4492075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 04:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4492075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeIFIjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 04:39:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727850AbeIFIjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 04:39:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34C758780F;
        Thu,  6 Sep 2018 04:06:06 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-125.pek2.redhat.com [10.72.12.125])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 37E6E101041E;
        Thu,  6 Sep 2018 04:06:02 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        mst@redhat.com, jasowang@redhat.com
Subject: [PATCH net-next 07/11] tuntap: move XDP flushing out of tun_do_xdp()
Date:   Thu,  6 Sep 2018 12:05:22 +0800
Message-Id: <20180906040526.22518-8-jasowang@redhat.com>
In-Reply-To: <20180906040526.22518-1-jasowang@redhat.com>
References: <20180906040526.22518-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 06 Sep 2018 04:06:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 06 Sep 2018 04:06:06 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow adding batch flushing on top.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 21b125020b3b..ff1cbf3ebd50 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1646,7 +1646,6 @@ static u32 tun_do_xdp(struct tun_struct *tun,
 	switch (act) {
 	case XDP_REDIRECT:
 		*err = xdp_do_redirect(tun->dev, xdp, xdp_prog);
-		xdp_do_flush_map();
 		if (*err)
 			break;
 		goto out;
@@ -1735,6 +1734,9 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 		act = tun_do_xdp(tun, tfile, xdp_prog, &xdp, &err);
 		if (err)
 			goto err_xdp;
+
+		if (act == XDP_REDIRECT)
+			xdp_do_flush_map();
 		if (act != XDP_PASS)
 			goto out;
 
-- 
2.17.1

