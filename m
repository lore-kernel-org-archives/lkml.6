Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E3CC04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9667A20851
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pYN9w2fS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9667A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeK1OUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:20:50 -0500
Received: from m12-17.163.com ([220.181.12.17]:40975 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbeK1OUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 09:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=ITOznSn5bQ58RWLkTe
        WjlqppC3foqi5QhYIlals98a4=; b=pYN9w2fShkpa8iNJ7jqwwqG6ltDR/S68/7
        mftKKva9Nr265I8l8B30CFFgwhwWqD0BEJLmjPsMclq3KmCzbu9bZYwNZmw9/TCm
        mXruAN3gLDMDBjHT7kTRL+pGvWWfm6emDNTmYuHGQ5Gg2N30EVtXgL4lU3od9Vg8
        2KBpgl6zg=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp13 (Coremail) with SMTP id EcCowACnRHZhCf5beSCwBw--.43667S3;
        Wed, 28 Nov 2018 11:20:03 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Artem Bityutskiy <dedekind1@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] ubi: do not drop UBI device reference before using
Date:   Wed, 28 Nov 2018 11:20:03 +0800
Message-Id: <1543375203-97876-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EcCowACnRHZhCf5beSCwBw--.43667S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr4UKr15Aw1DXF47Zw13urg_yoWfKwb_WF
        yxZFnIqr40gr18Kw1Sqr4fZFyI9FyY9F4IkF12g395Wayjgry5uFyvqr97ZFW7ZryIya4D
        Zr12vw45Gr43KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0G9aJUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBzwUNclaD0cQdXAAAs0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UBI device reference is dropped but then the device is used as a
parameter of ubi_err. The bug is introduced in changing ubi_err's 
behavior. The old ubi_err does not require a UBI device as its first 
parameter, but the new one does.

Fixes: 32608703310 ("UBI: Extend UBI layer debug/messaging capabilities")

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/mtd/ubi/kapi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/kapi.c b/drivers/mtd/ubi/kapi.c
index e9e9ecb..0b8f0c4 100644
--- a/drivers/mtd/ubi/kapi.c
+++ b/drivers/mtd/ubi/kapi.c
@@ -227,9 +227,9 @@ struct ubi_volume_desc *ubi_open_volume(int ubi_num, int vol_id, int mode)
 out_free:
 	kfree(desc);
 out_put_ubi:
-	ubi_put_device(ubi);
 	ubi_err(ubi, "cannot open device %d, volume %d, error %d",
 		ubi_num, vol_id, err);
+	ubi_put_device(ubi);
 	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(ubi_open_volume);
-- 
2.7.4


