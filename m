Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YRiEGJFAGVv2YwAAmS7hNA
	; Thu, 07 Jun 2018 14:26:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D5F0C607E7; Thu,  7 Jun 2018 14:26:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 38AE1602FC;
	Thu,  7 Jun 2018 14:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 38AE1602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933657AbeFGO0q (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:26:46 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40185 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932814AbeFGO0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:26:43 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbQ-0005Zi-Mj; Thu, 07 Jun 2018 15:09:25 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0003D2-8k; Thu, 07 Jun 2018 15:09:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Julia Lawall" <Julia.Lawall@lip6.fr>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.776067330@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 338/410] USB: usbmon: remove assignment from IS_ERR
 argument
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Julia Lawall <Julia.Lawall@lip6.fr>

commit 46c236dc7d1212d7417e6fb0317f91c44c719322 upstream.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e1,e2;
statement S1,S2;
@@

+e1 = e2;
if (IS_ERR(
    e1
-   = e2
   )) S1 else S2
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/mon/mon_text.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/usb/mon/mon_text.c
+++ b/drivers/usb/mon/mon_text.c
@@ -386,7 +386,8 @@ static ssize_t mon_text_read_t(struct fi
 	struct mon_event_text *ep;
 	struct mon_text_ptr ptr;
 
-	if (IS_ERR(ep = mon_text_read_wait(rp, file)))
+	ep = mon_text_read_wait(rp, file);
+	if (IS_ERR(ep))
 		return PTR_ERR(ep);
 	mutex_lock(&rp->printf_lock);
 	ptr.cnt = 0;
@@ -413,7 +414,8 @@ static ssize_t mon_text_read_u(struct fi
 	struct mon_event_text *ep;
 	struct mon_text_ptr ptr;
 
-	if (IS_ERR(ep = mon_text_read_wait(rp, file)))
+	ep = mon_text_read_wait(rp, file);
+	if (IS_ERR(ep))
 		return PTR_ERR(ep);
 	mutex_lock(&rp->printf_lock);
 	ptr.cnt = 0;
