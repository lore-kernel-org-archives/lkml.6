Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE36C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09704214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09704214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbeKLGJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:09:21 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53412 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726652AbeKLGJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:09:21 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt8-0000l9-Ks; Sun, 11 Nov 2018 19:59:18 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsP-0001S9-UB; Sun, 11 Nov 2018 19:58:33 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Corey Minyard" <cminyard@mvista.com>,
        "Nordmark Claes" <Claes.Nordmark@tieto.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.196163143@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 076/366] ipmi:bt: Set the timeout before doing a
 capabilities check
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Corey Minyard <cminyard@mvista.com>

commit fe50a7d0393a552e4539da2d31261a59d6415950 upstream.

There was one place where the timeout value for an operation was
not being set, if a capabilities request was done from idle.  Move
the timeout value setting to before where that change might be
requested.

IMHO the cause here is the invisible returns in the macros.  Maybe
that's a job for later, though.

Reported-by: Nordmark Claes <Claes.Nordmark@tieto.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/char/ipmi/ipmi_bt_sm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/char/ipmi/ipmi_bt_sm.c
+++ b/drivers/char/ipmi/ipmi_bt_sm.c
@@ -522,11 +522,12 @@ static enum si_sm_result bt_event(struct
 		if (status & BT_H_BUSY)		/* clear a leftover H_BUSY */
 			BT_CONTROL(BT_H_BUSY);
 
+		bt->timeout = bt->BT_CAP_req2rsp;
+
 		/* Read BT capabilities if it hasn't been done yet */
 		if (!bt->BT_CAP_outreqs)
 			BT_STATE_CHANGE(BT_STATE_CAPABILITIES_BEGIN,
 					SI_SM_CALL_WITHOUT_DELAY);
-		bt->timeout = bt->BT_CAP_req2rsp;
 		BT_SI_SM_RETURN(SI_SM_IDLE);
 
 	case BT_STATE_XACTION_START:

