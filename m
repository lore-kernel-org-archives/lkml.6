Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53F5C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68321208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68321208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732706AbeG0PBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:01:43 -0400
Received: from bran.ispras.ru ([83.149.199.196]:23467 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730682AbeG0PBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:01:43 -0400
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id E84DE203B2;
        Fri, 27 Jul 2018 16:39:41 +0300 (MSK)
From:   Anton Vasilyev <vasilyev@ispras.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>, Jiri Slaby <jslaby@suse.com>,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] tty: rocket: Fix possible buffer overwrite on register_PCI
Date:   Fri, 27 Jul 2018 16:39:31 +0300
Message-Id: <20180727133931.12701-1-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If number of isa and pci boards exceed NUM_BOARDS on the path
rp_init()->init_PCI()->register_PCI() then buffer overwrite occurs
in register_PCI() on assign rcktpt_io_addr[i].

The patch adds check on upper bound for index of registered
board in register_PCI.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/tty/rocket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index bdd17d2aaafd..b121d8f8f3d7 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -1881,7 +1881,7 @@ static __init int register_PCI(int i, struct pci_dev *dev)
 	ByteIO_t UPCIRingInd = 0;
 
 	if (!dev || !pci_match_id(rocket_pci_ids, dev) ||
-	    pci_enable_device(dev))
+	    pci_enable_device(dev) || i >= NUM_BOARDS)
 		return 0;
 
 	rcktpt_io_addr[i] = pci_resource_start(dev, 0);
-- 
2.18.0

