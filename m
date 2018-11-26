Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF65CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789302089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPZsG/9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789302089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbeKZV7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:59:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729543AbeKZV7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:59:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 679FA20672;
        Mon, 26 Nov 2018 11:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230349;
        bh=9ILF32lIcul4Z5RQhXNFWI3+90Y+0gLbYtAsRosaews=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SPZsG/9uX7qDfjq3a1XZE3R1Hh+Ag6esVBz58t8XX3WG+hATPPNgmv1zhAdf0nCwf
         0iCdHKV55hWbSDHI8cfHnb/3TE0lTYX0sTxjgz+nGTCtXYP2dJY7UhN54x/0IHioMO
         B/fhCz4qpJ3oeT5CCEHg23KC3cPP1Fabc5HX+tgc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.19 102/118] can: kvaser_usb: Fix potential uninitialized variable use
Date:   Mon, 26 Nov 2018 11:51:36 +0100
Message-Id: <20181126105105.792853190@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jimmy Assarsson <jimmyassarsson@gmail.com>

commit 95217260649aa504eb5d4a0d50959ca4e67c8f96 upstream.

If alloc_can_err_skb() fails, cf is never initialized.
Move assignment of cf inside check.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1019,6 +1019,11 @@ kvaser_usb_hydra_error_frame(struct kvas
 					new_state : CAN_STATE_ERROR_ACTIVE;
 
 			can_change_state(netdev, cf, tx_state, rx_state);
+
+			if (priv->can.restart_ms &&
+			    old_state >= CAN_STATE_BUS_OFF &&
+			    new_state < CAN_STATE_BUS_OFF)
+				cf->can_id |= CAN_ERR_RESTARTED;
 		}
 
 		if (new_state == CAN_STATE_BUS_OFF) {
@@ -1028,11 +1033,6 @@ kvaser_usb_hydra_error_frame(struct kvas
 
 			can_bus_off(netdev);
 		}
-
-		if (priv->can.restart_ms &&
-		    old_state >= CAN_STATE_BUS_OFF &&
-		    new_state < CAN_STATE_BUS_OFF)
-			cf->can_id |= CAN_ERR_RESTARTED;
 	}
 
 	if (!skb) {


