Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647D6C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3567B2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276863;
	bh=IRlgtmCCfdxyhC1jCV6vvCshu+pPxLZbbcmtOfj8KRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R0c6hKULiF1PFXuGDoxBtNiKBavfg4qbynbS7m51Kz8VN1jIYl2o7b8bQCSZwagyb
	 uDs0jw8Ve7Db7L4StUpSbf1gHmMfbyHzVaM7RCZWOAfE/8Juy5Qa/IvMCvDYbdypoE
	 4+JxMvR1FbHXZn21Wmq1PlDhck6YV+3J6UmWn0AU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbfBDKlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:41:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:38972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730130AbfBDKk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:40:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 207B52070C;
        Mon,  4 Feb 2019 10:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276856;
        bh=IRlgtmCCfdxyhC1jCV6vvCshu+pPxLZbbcmtOfj8KRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2NvNmRK3EUsOHrnUJu5Vr2N56Akz/SkGmwuPE4HnlUDQtVCOP5djn1I6UrtSVEjcV
         A+CWh8rdYxzbMzoCuopBtHDYh/ob1mgh2AE8N9+RWfcoU7jWWfKJbldEeMIzvfmcd2
         vO2HXYzvxgBaSMMsP1GUZpMaoBSzLOKF4zvvJM9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bernard Pidoux <f6bvp@free.fr>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot+1a2c456a1ea08fa5b5f7@syzkaller.appspotmail.com,
        "David S. Miller" <davem@davemloft.net>,
        Ralf Baechle <ralf@linux-mips.org>, linux-hams@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 4.4 38/65] net/rose: fix NULL ax25_cb kernel panic
Date:   Mon,  4 Feb 2019 11:36:31 +0100
Message-Id: <20190204103617.200941339@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bernard Pidoux <f6bvp@free.fr>

[ Upstream commit b0cf029234f9b18e10703ba5147f0389c382bccc ]

When an internally generated frame is handled by rose_xmit(),
rose_route_frame() is called:

        if (!rose_route_frame(skb, NULL)) {
                dev_kfree_skb(skb);
                stats->tx_errors++;
                return NETDEV_TX_OK;
        }

We have the same code sequence in Net/Rom where an internally generated
frame is handled by nr_xmit() calling nr_route_frame(skb, NULL).
However, in this function NULL argument is tested while it is not in
rose_route_frame().
Then kernel panic occurs later on when calling ax25cmp() with a NULL
ax25_cb argument as reported many times and recently with syzbot.

We need to test if ax25 is NULL before using it.

Testing:
Built kernel with CONFIG_ROSE=y.

Signed-off-by: Bernard Pidoux <f6bvp@free.fr>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: syzbot+1a2c456a1ea08fa5b5f7@syzkaller.appspotmail.com
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Bernard Pidoux <f6bvp@free.fr>
Cc: linux-hams@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rose/rose_route.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/rose/rose_route.c
+++ b/net/rose/rose_route.c
@@ -848,6 +848,7 @@ void rose_link_device_down(struct net_de
 
 /*
  *	Route a frame to an appropriate AX.25 connection.
+ *	A NULL ax25_cb indicates an internally generated frame.
  */
 int rose_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 {
@@ -865,6 +866,10 @@ int rose_route_frame(struct sk_buff *skb
 
 	if (skb->len < ROSE_MIN_LEN)
 		return res;
+
+	if (!ax25)
+		return rose_loopback_queue(skb, NULL);
+
 	frametype = skb->data[2];
 	lci = ((skb->data[0] << 8) & 0xF00) + ((skb->data[1] << 0) & 0x0FF);
 	if (frametype == ROSE_CALL_REQUEST &&


