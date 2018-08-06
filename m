Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4274CC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C370F21A29
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C370F21A29
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbeHFQVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:21:22 -0400
Received: from bran.ispras.ru ([83.149.199.196]:20271 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727940AbeHFQVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:21:22 -0400
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id 4F94F203C7;
        Mon,  6 Aug 2018 17:12:00 +0300 (MSK)
From:   Anton Vasilyev <vasilyev@ispras.ru>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH v2] tty: rocket: Fix possible buffer overwrite on register_PCI
Date:   Mon,  6 Aug 2018 17:10:57 +0300
Message-Id: <20180806141057.7105-1-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802150201.316e3361@alans-desktop>
References: 
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
v2: do not enable device which will not be managed by driver.
Based on Alan's comment.

NOTE: I can't find if there is a call of pci_disable_device(),
corresponding to pci_enable_device() from register_PCI().
---
 drivers/tty/rocket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index bdd17d2aaafd..f2238dc40426 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -1881,7 +1881,7 @@ static __init int register_PCI(int i, struct pci_dev *dev)
 	ByteIO_t UPCIRingInd = 0;
 
 	if (!dev || !pci_match_id(rocket_pci_ids, dev) ||
-	    pci_enable_device(dev))
+	    i >= NUM_BOARDS || pci_enable_device(dev))
 		return 0;
 
 	rcktpt_io_addr[i] = pci_resource_start(dev, 0);
-- 
2.18.0

