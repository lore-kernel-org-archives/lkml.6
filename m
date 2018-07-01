Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9E0C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCC9256D3
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCC9256D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031016AbeGARpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:45:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35550 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030914AbeGAQeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:34:17 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3372E92B;
        Sun,  1 Jul 2018 16:34:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Joakim Tjernlund <joakim.tjernlund@infinera.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.14 076/157] mtd: cfi_cmdset_0002: Avoid walking all chips when unlocking.
Date:   Sun,  1 Jul 2018 18:22:28 +0200
Message-Id: <20180701160856.412238446@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
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

From: Joakim Tjernlund <joakim.tjernlund@infinera.com>

commit f1ce87f6080b1dda7e7b1eda3da332add19d87b9 upstream.

cfi_ppb_unlock() walks all flash chips when unlocking sectors,
avoid walking chips unaffected by the unlock operation.

Fixes: 1648eaaa1575 ("mtd: cfi_cmdset_0002: Support Persistent Protection Bits (PPB) locking")
Cc: stable@vger.kernel.org
Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/chips/cfi_cmdset_0002.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -2685,6 +2685,8 @@ static int __maybe_unused cfi_ppb_unlock
 			i++;
 
 		if (adr >> cfi->chipshift) {
+			if (offset >= (ofs + len))
+				break;
 			adr = 0;
 			chipnum++;
 


