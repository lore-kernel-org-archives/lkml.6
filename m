Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDABAC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9293A2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498530;
	bh=mtUItnYdoMPJ2isFZzVGav2YxRSY8rNC0jwnyXUG/54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ESV6VviPHNGK/UYGc6zzTAXt1VAfgQLcSgopFAjFG5fiRLVQ44EfJxlu5aiUFnABd
	 KXW1OLh9MdPDPna8jOf8sX/mFGOuUoLsA512jnm4a1XiZRmEJoEJ+/ugweg5jNJlvO
	 1+U5sohjqZJyfJsSCxLQ4IhzPrINrtX4eQo0t3As=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389359AbfBROCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:02:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389317AbfBROCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:02:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7ABA2173C;
        Mon, 18 Feb 2019 14:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498525;
        bh=mtUItnYdoMPJ2isFZzVGav2YxRSY8rNC0jwnyXUG/54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wh2SyVyCZSUBazr07OVYYAuIH7S83Fz/BJgpgwMY2zOB6LL66T9f8iBpKWiKtK73j
         y6j1QjJrT/QP13JASEfhFBo+LZvGbASIOC9AobjJ9+AOFQaiqkPCn5MISE1BKzZaJ7
         tFbHDvz2fZRms6oEBh25Hk7u740Bc68a30RqQhRc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Young Xiao <YangX92@hotmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 019/143] sunvdc: Do not spin in an infinite loop when vio_ldc_send() returns EAGAIN
Date:   Mon, 18 Feb 2019 14:42:27 +0100
Message-Id: <20190218133529.860260792@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

[ Upstream commit a11f6ca9aef989b56cd31ff4ee2af4fb31a172ec ]

__vdc_tx_trigger should only loop on EAGAIN a finite
number of times.

See commit adddc32d6fde ("sunvnet: Do not spin in an
infinite loop when vio_ldc_send() returns EAGAIN") for detail.

Signed-off-by: Young Xiao <YangX92@hotmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/sunvdc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 4b911ed96ea3..31219fb9e7f4 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -40,6 +40,8 @@ MODULE_VERSION(DRV_MODULE_VERSION);
 #define WAITING_FOR_GEN_CMD	0x04
 #define WAITING_FOR_ANY		-1
 
+#define	VDC_MAX_RETRIES	10
+
 static struct workqueue_struct *sunvdc_wq;
 
 struct vdc_req_entry {
@@ -419,6 +421,7 @@ static int __vdc_tx_trigger(struct vdc_port *port)
 		.end_idx		= dr->prod,
 	};
 	int err, delay;
+	int retries = 0;
 
 	hdr.seq = dr->snd_nxt;
 	delay = 1;
@@ -431,6 +434,8 @@ static int __vdc_tx_trigger(struct vdc_port *port)
 		udelay(delay);
 		if ((delay <<= 1) > 128)
 			delay = 128;
+		if (retries++ > VDC_MAX_RETRIES)
+			break;
 	} while (err == -EAGAIN);
 
 	if (err == -ENOTCONN)
-- 
2.19.1



