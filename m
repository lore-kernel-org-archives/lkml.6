Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BACC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A03D2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2aQXQ5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A03D2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733123AbeK3BbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:31:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:58870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731628AbeK3BbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:31:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 673252133F;
        Thu, 29 Nov 2018 14:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501549;
        bh=RPblNFY2qCdYDMrUeWLcczh9DYrdJok0ptvumGJ7H/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2aQXQ5+wSARpRK4kIqJ8LTQvsVeByNPqM5sbIJbPDfAJ9NIVpIPJj9Dd8AzsX2ev
         BnNr9oSQeQEg3XHwHpFvuU0XrwIkn+ucEtDK+WAnyGgyEzdK0mzaIYd+xRsqV5Y+rZ
         rylg7pVrfwTUSwMVpNRiA4pQTJ9hE0K2/YY59or8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.14 042/100] can: raw: check for CAN FD capable netdev in raw_sendmsg()
Date:   Thu, 29 Nov 2018 15:12:12 +0100
Message-Id: <20181129140102.440259394@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Hartkopp <socketcan@hartkopp.net>

commit a43608fa77213ad5ac5f75994254b9f65d57cfa0 upstream.

When the socket is CAN FD enabled it can handle CAN FD frame
transmissions.  Add an additional check in raw_sendmsg() as a CAN2.0 CAN
driver (non CAN FD) should never see a CAN FD frame. Due to the commonly
used can_dropped_invalid_skb() function the CAN 2.0 driver would drop
that CAN FD frame anyway - but with this patch the user gets a proper
-EINVAL return code.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/can/raw.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -745,18 +745,19 @@ static int raw_sendmsg(struct socket *so
 	} else
 		ifindex = ro->ifindex;
 
-	if (ro->fd_frames) {
+	dev = dev_get_by_index(sock_net(sk), ifindex);
+	if (!dev)
+		return -ENXIO;
+
+	err = -EINVAL;
+	if (ro->fd_frames && dev->mtu == CANFD_MTU) {
 		if (unlikely(size != CANFD_MTU && size != CAN_MTU))
-			return -EINVAL;
+			goto put_dev;
 	} else {
 		if (unlikely(size != CAN_MTU))
-			return -EINVAL;
+			goto put_dev;
 	}
 
-	dev = dev_get_by_index(sock_net(sk), ifindex);
-	if (!dev)
-		return -ENXIO;
-
 	skb = sock_alloc_send_skb(sk, size + sizeof(struct can_skb_priv),
 				  msg->msg_flags & MSG_DONTWAIT, &err);
 	if (!skb)


