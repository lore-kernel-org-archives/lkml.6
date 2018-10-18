Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE60AECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7782A20658
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zxpAikMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7782A20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbeJSCHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:07:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbeJSCHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:07:52 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E47F520658;
        Thu, 18 Oct 2018 18:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885945;
        bh=yzXk4Ds8kXJZgZ23D+BCghZ49CK1iwYKuAjN7TW/8wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zxpAikMumGZ9ZymIls20mZLxbkOHHAXX9CNMNros//y8RAwvMKdj3vW9aPrveqIqM
         40OMsP+B3SFpIN75hLk+qsLODgvvuuH2gSiVfplnuKgSw8dx92aI8+gBgkqB6qP3FN
         Uh2I40c05VpQjVy6Mnu2ysR1kealQWgQyqJH217U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 25/48] net/usb: cancel pending work when unbinding smsc75xx
Date:   Thu, 18 Oct 2018 19:55:00 +0200
Message-Id: <20181018175429.333929086@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175427.133690306@linuxfoundation.org>
References: <20181018175427.133690306@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Zhao <yuzhao@google.com>

[ Upstream commit f7b2a56e1f3dcbdb4cf09b2b63e859ffe0e09df8 ]

Cancel pending work before freeing smsc75xx private data structure
during binding. This fixes the following crash in the driver:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000050
IP: mutex_lock+0x2b/0x3f
<snipped>
Workqueue: events smsc75xx_deferred_multicast_write [smsc75xx]
task: ffff8caa83e85700 task.stack: ffff948b80518000
RIP: 0010:mutex_lock+0x2b/0x3f
<snipped>
Call Trace:
 smsc75xx_deferred_multicast_write+0x40/0x1af [smsc75xx]
 process_one_work+0x18d/0x2fc
 worker_thread+0x1a2/0x269
 ? pr_cont_work+0x58/0x58
 kthread+0xfa/0x10a
 ? pr_cont_work+0x58/0x58
 ? rcu_read_unlock_sched_notrace+0x48/0x48
 ret_from_fork+0x22/0x40

Signed-off-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/smsc75xx.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -1506,6 +1506,7 @@ static void smsc75xx_unbind(struct usbne
 {
 	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
 	if (pdata) {
+		cancel_work_sync(&pdata->set_multicast);
 		netif_dbg(dev, ifdown, dev->net, "free pdata\n");
 		kfree(pdata);
 		pdata = NULL;


