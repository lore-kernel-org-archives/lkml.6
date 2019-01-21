Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84416C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5438720861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080052;
	bh=TTtwpAzxR1MSRKjvQRMQB4vT+lMVwmoHqMjhLJCI6B4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Iz3LzhSjtJ2Mpu30McT0DIIHcEgYRg/oYrl4f928TDwGfGBiKvAOd8LGT3gNXSfCy
	 6P/mWzXXBZb7YAhW0bWhLWwHv+hZti0SA8ueNgtFOCLeQhK2o1naFWaqdtVBJp8Gr6
	 kQKno1cftzYXEcblthNM2UkD9vDuo3PSVy0RrEJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbfAUNwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:52:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730257AbfAUNwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:52:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EB412087F;
        Mon, 21 Jan 2019 13:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078755;
        bh=TTtwpAzxR1MSRKjvQRMQB4vT+lMVwmoHqMjhLJCI6B4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QxYvBaaw5E3Mm7/yU1fRVyb+6Su0U0nWRZkECc+PtpMicB59FpfW0lgi7fCAq7FNa
         LDYCSO+mi5IAy2rTurhJq+DMY4+sqeoM/94LPO/UV6uoO6zyarQ/VhO2YW+MlZRUNm
         USPhAM5w8VGeOwmUiJmWkO1H8UeARUfwHUaShq7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Muyu Yu <ieatmuttonchuan@gmail.com>,
        Marcus Meissner <meissner@suse.de>,
        Michal Kubecek <mkubecek@suse.cz>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 05/59] can: gw: ensure DLC boundaries after CAN frame modification
Date:   Mon, 21 Jan 2019 14:43:30 +0100
Message-Id: <20190121122457.082497022@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
References: <20190121122456.529172919@linuxfoundation.org>
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

From: Oliver Hartkopp <socketcan@hartkopp.net>

commit 0aaa81377c5a01f686bcdb8c7a6929a7bf330c68 upstream.

Muyu Yu provided a POC where user root with CAP_NET_ADMIN can create a CAN
frame modification rule that makes the data length code a higher value than
the available CAN frame data size. In combination with a configured checksum
calculation where the result is stored relatively to the end of the data
(e.g. cgw_csum_xor_rel) the tail of the skb (e.g. frag_list pointer in
skb_shared_info) can be rewritten which finally can cause a system crash.

Michael Kubecek suggested to drop frames that have a DLC exceeding the
available space after the modification process and provided a patch that can
handle CAN FD frames too. Within this patch we also limit the length for the
checksum calculations to the maximum of Classic CAN data length (8).

CAN frames that are dropped by these additional checks are counted with the
CGW_DELETED counter which indicates misconfigurations in can-gw rules.

This fixes CVE-2019-3701.

Reported-by: Muyu Yu <ieatmuttonchuan@gmail.com>
Reported-by: Marcus Meissner <meissner@suse.de>
Suggested-by: Michal Kubecek <mkubecek@suse.cz>
Tested-by: Muyu Yu <ieatmuttonchuan@gmail.com>
Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-stable <stable@vger.kernel.org> # >= v3.2
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/can/gw.c |   30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -416,13 +416,29 @@ static void can_can_gw_rcv(struct sk_buf
 	while (modidx < MAX_MODFUNCTIONS && gwj->mod.modfunc[modidx])
 		(*gwj->mod.modfunc[modidx++])(cf, &gwj->mod);
 
-	/* check for checksum updates when the CAN frame has been modified */
+	/* Has the CAN frame been modified? */
 	if (modidx) {
-		if (gwj->mod.csumfunc.crc8)
+		/* get available space for the processed CAN frame type */
+		int max_len = nskb->len - offsetof(struct can_frame, data);
+
+		/* dlc may have changed, make sure it fits to the CAN frame */
+		if (cf->can_dlc > max_len)
+			goto out_delete;
+
+		/* check for checksum updates in classic CAN length only */
+		if (gwj->mod.csumfunc.crc8) {
+			if (cf->can_dlc > 8)
+				goto out_delete;
+
 			(*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
+		}
+
+		if (gwj->mod.csumfunc.xor) {
+			if (cf->can_dlc > 8)
+				goto out_delete;
 
-		if (gwj->mod.csumfunc.xor)
 			(*gwj->mod.csumfunc.xor)(cf, &gwj->mod.csum.xor);
+		}
 	}
 
 	/* clear the skb timestamp if not configured the other way */
@@ -434,6 +450,14 @@ static void can_can_gw_rcv(struct sk_buf
 		gwj->dropped_frames++;
 	else
 		gwj->handled_frames++;
+
+	return;
+
+ out_delete:
+	/* delete frame due to misconfiguration */
+	gwj->deleted_frames++;
+	kfree_skb(nskb);
+	return;
 }
 
 static inline int cgw_register_filter(struct net *net, struct cgw_job *gwj)


