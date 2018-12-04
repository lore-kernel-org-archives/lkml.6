Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544BBC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2252087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdhE/YVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2252087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbeLDLDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:03:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbeLDLDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:03:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F39F8214DA;
        Tue,  4 Dec 2018 11:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921413;
        bh=qkfZuLZIoYZeKmE8gwabuLu9asWF11a4mhPlUJBTlD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sdhE/YVw4s0uQQtOUySYFEOQOFg66OkuzVYEZaj9h7DQyf3yqOZMDP6Hp/Uz9v/jq
         LohbP8Hm63vpb8HLuLCgCT3oaveqa7sB8l3lI7d8jU5fqdNzDa/cKqunZbIjCrvnTb
         OBwpjq4H8/ZDm/wJ7FXa+AfntxjXbRoFzSorTp3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 060/146] net: thunderx: set xdp_prog to NULL if bpf_prog_add fails
Date:   Tue,  4 Dec 2018 11:49:06 +0100
Message-Id: <20181204103729.251516299@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

[ Upstream commit 6d0f60b0f8588fd4380ea5df9601e12fddd55ce2 ]

Set xdp_prog pointer to NULL if bpf_prog_add fails since that routine
reports the error code instead of NULL in case of failure and xdp_prog
pointer value is used in the driver to verify if XDP is currently
enabled.
Moreover report the error code to userspace if nicvf_xdp_setup fails

Fixes: 05c773f52b96 ("net: thunderx: Add basic XDP support")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1691,6 +1691,7 @@ static int nicvf_xdp_setup(struct nicvf
 	bool if_up = netif_running(nic->netdev);
 	struct bpf_prog *old_prog;
 	bool bpf_attached = false;
+	int ret = 0;
 
 	/* For now just support only the usual MTU sized frames */
 	if (prog && (dev->mtu > 1500)) {
@@ -1724,8 +1725,12 @@ static int nicvf_xdp_setup(struct nicvf
 	if (nic->xdp_prog) {
 		/* Attach BPF program */
 		nic->xdp_prog = bpf_prog_add(nic->xdp_prog, nic->rx_queues - 1);
-		if (!IS_ERR(nic->xdp_prog))
+		if (!IS_ERR(nic->xdp_prog)) {
 			bpf_attached = true;
+		} else {
+			ret = PTR_ERR(nic->xdp_prog);
+			nic->xdp_prog = NULL;
+		}
 	}
 
 	/* Calculate Tx queues needed for XDP and network stack */
@@ -1737,7 +1742,7 @@ static int nicvf_xdp_setup(struct nicvf
 		netif_trans_update(nic->netdev);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int nicvf_xdp(struct net_device *netdev, struct netdev_xdp *xdp)


