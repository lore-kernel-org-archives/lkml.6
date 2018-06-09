Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PKy0HxvzG1vjYgAAmS7hNA
	; Sat, 09 Jun 2018 15:32:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3FA26608B8; Sat,  9 Jun 2018 15:32:50 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hf8muNbL"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A196F608B8;
	Sat,  9 Jun 2018 15:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A196F608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753459AbeFIPcs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:32:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753646AbeFIPcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:32:45 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9743B208A4;
        Sat,  9 Jun 2018 15:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558365;
        bh=3XCaPL1Q7hc94Cfg06xWSc+JpoGtRLdrU9L43F2j8Wk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hf8muNbLO2PuGAgzb8iXqMFb/3nmrsFlHH5i6WJrfTJVgqnuGTL2u6KZNNHy3rpVa
         eINTg5R525XZvR2pdlBsAp0f4D2vGHiXqy96pc49z31SEPpa2K1wUFOvB5PLo5b6v0
         FH5xL2bK38MvCU8W9eeibN1hSGdIkJL6BzSzvJLU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+3dcd59a1f907245f891f@syzkaller.appspotmail.com,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 29/48] sctp: not allow transport timeout value less than HZ/5 for hb_timer
Date: Sat,  9 Jun 2018 17:29:41 +0200
Message-Id: <20180609145949.660211633@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 1d88ba1ebb2763aa86172cd7ca05dedbeccc0d35 ]

syzbot reported a rcu_sched self-detected stall on CPU which is caused
by too small value set on rto_min with SCTP_RTOINFO sockopt. With this
value, hb_timer will get stuck there, as in its timer handler it starts
this timer again with this value, then goes to the timer handler again.

This problem is there since very beginning, and thanks to Eric for the
reproducer shared from a syzbot mail.

This patch fixes it by not allowing sctp_transport_timeout to return a
smaller value than HZ/5 for hb_timer, which is based on TCP's min rto.

Note that it doesn't fix this issue by limiting rto_min, as some users
are still using small rto and no proper value was found for it yet.

Reported-by: syzbot+3dcd59a1f907245f891f@syzkaller.appspotmail.com
Suggested-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/transport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -634,7 +634,7 @@ unsigned long sctp_transport_timeout(str
 	    trans->state != SCTP_PF)
 		timeout += trans->hbinterval;
 
-	return timeout;
+	return max_t(unsigned long, timeout, HZ / 5);
 }
 
 /* Reset transport variables to their initial values */
