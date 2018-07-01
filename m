Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4EDC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2F7242A7
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2F7242A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932636AbeGAQNo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:13:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60180 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932421AbeGAQNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:13:38 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 99B564A3;
        Sun,  1 Jul 2018 16:13:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nordmark Claes <Claes.Nordmark@tieto.com>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 3.18 55/85] ipmi:bt: Set the timeout before doing a capabilities check
Date:   Sun,  1 Jul 2018 18:02:13 +0200
Message-Id: <20180701153124.552928157@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153122.365061142@linuxfoundation.org>
References: <20180701153122.365061142@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/ipmi/ipmi_bt_sm.c |    3 ++-
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


