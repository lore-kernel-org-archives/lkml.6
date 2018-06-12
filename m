Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E22BEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97992208B4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wzdiTxKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97992208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935010AbeFLQwT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933748AbeFLQrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:47:39 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E1E7208B0;
        Tue, 12 Jun 2018 16:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822059;
        bh=M5GFHwf6v9y3Ddk7j/7l01bza6MR046y9PiOU+i6yV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wzdiTxKU1o8no+MIrccqmSokiJjnrg9gkd+n1v2QBbBMiAuVVDhM8YwptmTCRjS4M
         9o+KjnV+SSfM/ptt1eW+I/taTNUsG9ko1toh8W9tUr5/50UsNw5j4iGeaFHSxCdFUc
         XUqMvuxsLeuf/uy6z8P/0w6r2G00sJFkF3HmTdS8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+3dcd59a1f907245f891f@syzkaller.appspotmail.com,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 20/31] sctp: not allow transport timeout value less than HZ/5 for hb_timer
Date:   Tue, 12 Jun 2018 18:46:23 +0200
Message-Id: <20180612164621.590815384@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164620.797338191@linuxfoundation.org>
References: <20180612164620.797338191@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -608,7 +608,7 @@ unsigned long sctp_transport_timeout(str
 	    trans->state != SCTP_PF)
 		timeout += trans->hbinterval;
 
-	return timeout;
+	return max_t(unsigned long, timeout, HZ / 5);
 }
 
 /* Reset transport variables to their initial values */


