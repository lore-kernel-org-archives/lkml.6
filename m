Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0936C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9CB2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9CB2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeHUJz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:55:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57208 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbeHUJz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:55:57 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 347C98A5;
        Tue, 21 Aug 2018 06:37:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+278893f3f7803871f7ce@syzkaller.appspotmail.com,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 03/29] llc: use refcount_inc_not_zero() for llc_sap_find()
Date:   Tue, 21 Aug 2018 08:20:56 +0200
Message-Id: <20180821055108.518052264@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055108.333930282@linuxfoundation.org>
References: <20180821055108.333930282@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 0dcb82254d65f72333aa50ad626d1e9665ad093b ]

llc_sap_put() decreases the refcnt before deleting sap
from the global list. Therefore, there is a chance
llc_sap_find() could find a sap with zero refcnt
in this global list.

Close this race condition by checking if refcnt is zero
or not in llc_sap_find(), if it is zero then it is being
removed so we can just treat it as gone.

Reported-by: <syzbot+278893f3f7803871f7ce@syzkaller.appspotmail.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/llc.h  |    5 +++++
 net/llc/llc_core.c |    4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

--- a/include/net/llc.h
+++ b/include/net/llc.h
@@ -116,6 +116,11 @@ static inline void llc_sap_hold(struct l
 	refcount_inc(&sap->refcnt);
 }
 
+static inline bool llc_sap_hold_safe(struct llc_sap *sap)
+{
+	return refcount_inc_not_zero(&sap->refcnt);
+}
+
 void llc_sap_close(struct llc_sap *sap);
 
 static inline void llc_sap_put(struct llc_sap *sap)
--- a/net/llc/llc_core.c
+++ b/net/llc/llc_core.c
@@ -73,8 +73,8 @@ struct llc_sap *llc_sap_find(unsigned ch
 
 	rcu_read_lock_bh();
 	sap = __llc_sap_find(sap_value);
-	if (sap)
-		llc_sap_hold(sap);
+	if (!sap || !llc_sap_hold_safe(sap))
+		sap = NULL;
 	rcu_read_unlock_bh();
 	return sap;
 }


