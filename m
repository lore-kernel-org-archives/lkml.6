Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kFnhNzXwG1sSQQAAmS7hNA
	; Sat, 09 Jun 2018 15:34:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BB47B608CD; Sat,  9 Jun 2018 15:34:17 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0fJura38"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 37C03607DC;
	Sat,  9 Jun 2018 15:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 37C03607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753727AbeFIPeO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:34:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932811AbeFIPeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:34:12 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6823C2087B;
        Sat,  9 Jun 2018 15:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558452;
        bh=skDkse6Ksg2B8jGsJ4LsdG7MX8DpqxxvzCpoXPu/Qs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0fJura38Vvc6f1Io8h7TvBwn7xm5YSHmdpSMZ/otQS0LeL3Nhi7g7fvGVV0hpGodP
         0ryf0sra3CreIGg15q7iz2qblLCYQNq4JGct/0OTCeezO4SjRSauzR4bsysWfWDS15
         fAw/k0Ib9W9p8+p0g/W9/n0l9C5VQ96BGvr3AlO0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 44/48] virtio-net: correctly redirect linearized packet
Date: Sat,  9 Jun 2018 17:29:56 +0200
Message-Id: <20180609145950.794487078@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>

[ Upstream commit 6890418bbb780f0ee9cf124055afa79777f1b4f1 ]

After a linearized packet was redirected by XDP, we should not go for
the err path which will try to pop buffers for the next packet and
increase the drop counter. Fixing this by just drop the page refcnt
for the original page.

Fixes: 186b3c998c50 ("virtio-net: support XDP_REDIRECT")
Reported-by: David Ahern <dsahern@gmail.com>
Tested-by: David Ahern <dsahern@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -786,7 +786,7 @@ static struct sk_buff *receive_mergeable
 			}
 			*xdp_xmit = true;
 			if (unlikely(xdp_page != page))
-				goto err_xdp;
+				put_page(page);
 			rcu_read_unlock();
 			goto xdp_xmit;
 		default:
