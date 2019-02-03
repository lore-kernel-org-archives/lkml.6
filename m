Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EFAC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2142620823
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbfBCOEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:04:45 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52856 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727894AbfBCNto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:44 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9W-0003tf-Cy; Sun, 03 Feb 2019 13:49:42 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9U-0006ok-50; Sun, 03 Feb 2019 14:49:40 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Kalle Valo" <kvalo@codeaurora.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.162679882@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 022/305] libertas_tf: prevent underflow in
 process_cmdrequest()
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 3348ef6a6a126706d6a73ed40c18d8033df72783 upstream.

If recvlength is less than MESSAGE_HEADER_LEN (4) we would end up
corrupting memory.

Fixes: c305a19a0d0a ("libertas_tf: usb specific functions")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/wireless/libertas_tf/if_usb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/libertas_tf/if_usb.c
+++ b/drivers/net/wireless/libertas_tf/if_usb.c
@@ -610,9 +610,10 @@ static inline void process_cmdrequest(in
 				      struct if_usb_card *cardp,
 				      struct lbtf_private *priv)
 {
-	if (recvlength > LBS_CMD_BUFFER_SIZE) {
+	if (recvlength < MESSAGE_HEADER_LEN ||
+	    recvlength > LBS_CMD_BUFFER_SIZE) {
 		lbtf_deb_usbd(&cardp->udev->dev,
-			     "The receive buffer is too large\n");
+			     "The receive buffer is invalid: %d\n", recvlength);
 		kfree_skb(skb);
 		return;
 	}

