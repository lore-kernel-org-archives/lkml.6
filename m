Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBEBC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E576221785
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E576221785
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeHMFph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 01:45:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725849AbeHMFpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 01:45:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 758054022905;
        Mon, 13 Aug 2018 03:05:24 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-183.pek2.redhat.com [10.72.12.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD31A2156712;
        Mon, 13 Aug 2018 03:05:20 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, jbrouer@redhat.com,
        mst@redhat.com, Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH net-next 1/5] net: core: generic XDP support for stacked device
Date:   Mon, 13 Aug 2018 11:05:09 +0800
Message-Id: <1534129513-4845-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1534129513-4845-1-git-send-email-jasowang@redhat.com>
References: <1534129513-4845-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 13 Aug 2018 03:05:24 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 13 Aug 2018 03:05:24 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stacked device usually change skb->dev to its own and return
RX_HANDLER_ANOTHER during rx handler processing. But we don't call
generic XDP routine at that time, this means it can't work for stacked
device.

Fixing this by calling netif_do_generic_xdp() if rx handler returns
RX_HANDLER_ANOTHER. This allows us to do generic XDP on stacked device
e.g macvlan.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/core/dev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 605c66e..a77ce08 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4822,6 +4822,11 @@ static int __netif_receive_skb_core(struct sk_buff *skb, bool pfmemalloc,
 			ret = NET_RX_SUCCESS;
 			goto out;
 		case RX_HANDLER_ANOTHER:
+			ret = netif_do_generic_xdp(skb);
+			if (ret != XDP_PASS) {
+				ret = NET_RX_SUCCESS;
+				goto out;
+			}
 			goto another_round;
 		case RX_HANDLER_EXACT:
 			deliver_exact = true;
-- 
2.7.4

