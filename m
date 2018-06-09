Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id VwSdB7PzG1sTZwAAmS7hNA
	; Sat, 09 Jun 2018 15:36:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5FEBB608C8; Sat,  9 Jun 2018 15:36:30 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYokOJsC"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C0D7C606FA;
	Sat,  9 Jun 2018 15:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0D7C606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933239AbeFIPg0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932878AbeFIPgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:36:22 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04FBA2087B;
        Sat,  9 Jun 2018 15:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558581;
        bh=9J+sYlPUOGVVXkFxo0LDZCu25twlz04Clt4JahxYxNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bYokOJsCH+5C4LQq01VeHZt6KR/4uWTA2anp3TNidUfjR7FIK8+VK/QlLIm2XuUCk
         6wo1Z1PF6OQtFrnGPZec2UgIiRj4NULH035sRFXtY6MYOkjgb0Y8zsHSlekSyzHbgS
         /oabu8W0AXQWdooNqAC+885KcEnU1WM1e152H1z4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 38/41] virtio-net: fix leaking page for gso packet during mergeable XDP
Date: Sat,  9 Jun 2018 17:30:10 +0200
Message-Id: <20180609152928.497056859@linuxfoundation.org>
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

[ Upstream commit 3d62b2a0db505bbf9ed0755f254e45d775f9807f ]

We need to drop refcnt to xdp_page if we see a gso packet. Otherwise
it will be leaked. Fixing this by moving the check of gso packet above
the linearizing logic. While at it, remove useless comment as well.

Cc: John Fastabend <john.fastabend@gmail.com>
Fixes: 72979a6c3590 ("virtio_net: xdp, add slowpath case for non contiguous buffers")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -632,6 +632,13 @@ static struct sk_buff *receive_mergeable
 		void *data;
 		u32 act;
 
+		/* Transient failure which in theory could occur if
+		 * in-flight packets from before XDP was enabled reach
+		 * the receive path after XDP is loaded.
+		 */
+		if (unlikely(hdr->hdr.gso_type))
+			goto err_xdp;
+
 		/* This happens when rx buffer size is underestimated */
 		if (unlikely(num_buf > 1 ||
 			     headroom < virtnet_get_headroom(vi))) {
@@ -647,14 +654,6 @@ static struct sk_buff *receive_mergeable
 			xdp_page = page;
 		}
 
-		/* Transient failure which in theory could occur if
-		 * in-flight packets from before XDP was enabled reach
-		 * the receive path after XDP is loaded. In practice I
-		 * was not able to create this condition.
-		 */
-		if (unlikely(hdr->hdr.gso_type))
-			goto err_xdp;
-
 		/* Allow consuming headroom but reserve enough space to push
 		 * the descriptor on if we get an XDP_TX return code.
 		 */
