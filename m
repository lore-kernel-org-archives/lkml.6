Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45C2C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E1A214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRulE8Ut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E1A214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbeLDKzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:55:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:38564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbeLDKzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:55:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64B6D2146D;
        Tue,  4 Dec 2018 10:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543920939;
        bh=b6jf/IryfvBW2/WmAKhTfQWbj4iesrO6dsWqM4n9/wI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kRulE8Utu/+Y1hZz1Dmr7Utkasm8XeZ6Qnq7eA7ukQtBZfGj49NGmU+zC6bb4uFlK
         2cuq+l+ikEQacpkEoiut5UvpaDmQA7QzWXyvzg2RFOBPC9HcudV0wba63SvQWMNfOv
         jA9++yl7ogR2M7MxDxq8HsSYDnSqvNqYsfcCcw2g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 019/139] net: thunderx: set xdp_prog to NULL if bpf_prog_add fails
Date:   Tue,  4 Dec 2018 11:48:20 +0100
Message-Id: <20181204103650.768788031@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1784,6 +1784,7 @@ static int nicvf_xdp_setup(struct nicvf
 	bool if_up = netif_running(nic->netdev);
 	struct bpf_prog *old_prog;
 	bool bpf_attached = false;
+	int ret = 0;
 
 	/* For now just support only the usual MTU sized frames */
 	if (prog && (dev->mtu > 1500)) {
@@ -1817,8 +1818,12 @@ static int nicvf_xdp_setup(struct nicvf
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
@@ -1830,7 +1835,7 @@ static int nicvf_xdp_setup(struct nicvf
 		netif_trans_update(nic->netdev);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int nicvf_xdp(struct net_device *netdev, struct netdev_bpf *xdp)


