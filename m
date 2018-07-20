Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3119EECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AA120854
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1AA120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388097AbeGTNQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:16:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36862 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388057AbeGTNQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:16:43 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1C305BBF;
        Fri, 20 Jul 2018 12:28:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 17/66] atm: zatm: Fix potential Spectre v1
Date:   Fri, 20 Jul 2018 14:13:34 +0200
Message-Id: <20180720121408.258812786@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121407.228772286@linuxfoundation.org>
References: <20180720121407.228772286@linuxfoundation.org>
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

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

[ Upstream commit ced9e191501e52b95e1b57b8e0db00943869eed0 ]

pool can be indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/atm/zatm.c:1491 zatm_ioctl() warn: potential spectre issue
'zatm_dev->pool_info' (local cap)

Fix this by sanitizing pool before using it to index
zatm_dev->pool_info

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/atm/zatm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/atm/zatm.c
+++ b/drivers/atm/zatm.c
@@ -1483,6 +1483,8 @@ static int zatm_ioctl(struct atm_dev *de
 					return -EFAULT;
 				if (pool < 0 || pool > ZATM_LAST_POOL)
 					return -EINVAL;
+				pool = array_index_nospec(pool,
+							  ZATM_LAST_POOL + 1);
 				if (copy_from_user(&info,
 				    &((struct zatm_pool_req __user *) arg)->info,
 				    sizeof(info))) return -EFAULT;


