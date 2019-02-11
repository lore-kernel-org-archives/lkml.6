Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62952C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229B9222A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896982;
	bh=87Bw8zAz4gLLvU+JCtZ3xmXExfG+rGT5u2wSKgHiRDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HhHfamKi2C+m7IxnPy7eu+M+VJaK7KvgECDL6Fosxxrswpg3G+q3FPQcvwll1FzlA
	 +W8ooeoXA070z+Qx2cClAeDbiXgZvXZSc/PoPZLIctN3HwhwWnFLgAuaz1hW9M38Dr
	 gA50lJwVAZZdRRPAXgJqgTb98Zn35t7ZRG9NQ0h4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389153AbfBKO4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:56:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:43432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389123AbfBKO4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:56:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C36A02229E;
        Mon, 11 Feb 2019 14:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896974;
        bh=87Bw8zAz4gLLvU+JCtZ3xmXExfG+rGT5u2wSKgHiRDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JMfmfjGP3JUeDfUuLk1Caiv8I/8DKoUknvZGI8cDvXi0NoPQkcvK8heE3NhaL3u1h
         9xnEPpDGZEbWkx+XYwso+6lUDuD8Ur4eFZ5UGWUNJ0KeT+o8gfOWzZxWb0v24dsovp
         bKmcBTpCBwTDERrGdoVDcJq4WBg9QvuKJQ8WMuT8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Young Xiao <YangX92@hotmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 048/205] sunvdc: Do not spin in an infinite loop when vio_ldc_send() returns EAGAIN
Date:   Mon, 11 Feb 2019 15:17:26 +0100
Message-Id: <20190211141832.005931077@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index ad9749463d4f..ed4d6276e94f 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -41,6 +41,8 @@ MODULE_VERSION(DRV_MODULE_VERSION);
 #define WAITING_FOR_GEN_CMD	0x04
 #define WAITING_FOR_ANY		-1
 
+#define	VDC_MAX_RETRIES	10
+
 static struct workqueue_struct *sunvdc_wq;
 
 struct vdc_req_entry {
@@ -427,6 +429,7 @@ static int __vdc_tx_trigger(struct vdc_port *port)
 		.end_idx		= dr->prod,
 	};
 	int err, delay;
+	int retries = 0;
 
 	hdr.seq = dr->snd_nxt;
 	delay = 1;
@@ -439,6 +442,8 @@ static int __vdc_tx_trigger(struct vdc_port *port)
 		udelay(delay);
 		if ((delay <<= 1) > 128)
 			delay = 128;
+		if (retries++ > VDC_MAX_RETRIES)
+			break;
 	} while (err == -EAGAIN);
 
 	if (err == -ENOTCONN)
-- 
2.19.1



