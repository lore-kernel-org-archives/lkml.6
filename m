Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vNl4O+byG1vpXwAAmS7hNA
	; Sat, 09 Jun 2018 15:36:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9592F608C8; Sat,  9 Jun 2018 15:36:12 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfui+IKT"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0CCC3606FA;
	Sat,  9 Jun 2018 15:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0CCC3606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933191AbeFIPgJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:36:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933117AbeFIPgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:36:07 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27498208A4;
        Sat,  9 Jun 2018 15:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558566;
        bh=LXQa/BVeiPpQhv7liRxvmVfFnEoWVp7YBLGs3wUnvs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lfui+IKT/O6tMqAdey37V4qAQjid1ZhuELHwYPQfWtPSvbe8gShWWXpctNh2xSjsU
         rLDf9yGLvcvcKphUGrlkLJtlgi+N29mLSN6WjagdNCepImpcr9AB8tg0e1Ou65ssaj
         UrtVDo0oNPYbEOLQ0Yk5vwcaIOYMORDELcIyJuSg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 33/41] virtio-net: correctly transmit XDP buff after linearizing
Date: Sat,  9 Jun 2018 17:30:05 +0200
Message-Id: <20180609152928.239882436@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609152926.389750182@linuxfoundation.org>
References: <20180609152926.389750182@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>

[ Upstream commit 5d458a13dd59d04b4d6658a6d5b94d42732b15ae ]

We should not go for the error path after successfully transmitting a
XDP buffer after linearizing. Since the error path may try to pop and
drop next packet and increase the drop counters. Fixing this by simply
drop the refcnt of original page and go for xmit path.

Fixes: 72979a6c3590 ("virtio_net: xdp, add slowpath case for non contiguous buffers")
Cc: John Fastabend <john.fastabend@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -688,7 +688,7 @@ static struct sk_buff *receive_mergeable
 				trace_xdp_exception(vi->dev, xdp_prog, act);
 			ewma_pkt_len_add(&rq->mrg_avg_pkt_len, len);
 			if (unlikely(xdp_page != page))
-				goto err_xdp;
+				put_page(page);
 			rcu_read_unlock();
 			goto xdp_xmit;
 		default:
