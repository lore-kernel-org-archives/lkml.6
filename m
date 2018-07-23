Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0F3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BE820874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPf7oT7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BE820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388182AbeGWJ6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:58:22 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:42271 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387978AbeGWJ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:58:21 -0400
Received: by mail-io0-f194.google.com with SMTP id g11-v6so14904365ioq.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 01:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Fka0vitggGyahAMbZNcUZqNpMbWxc2hePbIwCYKcFTU=;
        b=MPf7oT7IkuT7bbyv8la7r/jR+mF09WfH3yLJctGlihvYQ2/8nn+9Eq+IMOXCHzI8pl
         Ps35CMYmgnzqKk9CsN3b+WWpvF6yFl5nIPgwgBUdbchLq9nwCbVpBwzCwGme7yc2JCjh
         RBEAAfTSptCRRetbuy9jEkC1aDluyosZz5+Wan/StNZp7/KaTwyECKabiQWgquQv6ekU
         oiZuBZUeS8G0I/SDG1hbWUKu/PxLfv+wCRO3E3qMFAmudMs8cVZHVm/GdmK0+AA83Lmx
         Vyo9qEZoIFceR1WGxw3nUJrhlfG8jjTh5O6fyKyYM77kUmlirvOB1RorWmHb0fuXZcmO
         9J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Fka0vitggGyahAMbZNcUZqNpMbWxc2hePbIwCYKcFTU=;
        b=ufMkb1rYgp8DYf/N7pc0p4Z4ouQBNHI65l2/BfNuNRA5m9/5Q7Cd/aBZnvhmTblCln
         lS/7YIAn/MYF9VxPnZz7qxOZYsabw1vxnPEwzrpq4KYAPeCkufNJCvI+sklhd5wZeRSr
         sc8bBQZZ3JCRMX5ZMcFoZF8CAv5phtQKBqjAFv1xtdIAPWz39+22u3kwaDT1WjB2Pst/
         +pPBhyW632zCPVM3fHnx44Sc2ZzS9pt8vp7ixYcO88dXqjWSAL3GusXRiuicnewFdqaS
         GH+DddzolwEpKCtMeUzFvW8N56vYA/VHt1XJkSmiMriX8DQeXzb8XyLWOcJjYhrb5LXy
         iTQA==
X-Gm-Message-State: AOUpUlGj25tRcm01sWRV4f+YUd6ArtD9guMmZBootSW4FDGOuRLdg+qI
        DCKU1iyqkJDUK3GEkGbDsb4OdvvM
X-Google-Smtp-Source: AAOMgpdeIw7ZNfrMKoMf5/4AUCIegZU29dbrPCkQ3w8jgqgoguHeorXw2kC0x0uTfnOqrVmuXhzfog==
X-Received: by 2002:a6b:e814:: with SMTP id f20-v6mr8891688ioh.269.1532336291572;
        Mon, 23 Jul 2018 01:58:11 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:e422:450a:e730:728b])
        by smtp.gmail.com with ESMTPSA id b2-v6sm2610911iok.40.2018.07.23.01.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 01:58:11 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] firewire: sbp2: Replace GFP_ATOMIC with GFP_KERNEL in sbp2_scsi_queuecommand()
Date:   Mon, 23 Jul 2018 16:58:01 +0800
Message-Id: <20180723085801.6711-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sbp2_scsi_queuecommand() is only set to .queuecommand of 
"struct scsi_host_template", and this function pointer is never called
in atomic context.

sbp2_scsi_queuecommand() calls kzalloc() with GFP_ATOMIC,
which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.
I also manually check the kernel code before reporting it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/firewire/sbp2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/sbp2.c b/drivers/firewire/sbp2.c
index 6bac03999fd4..a7cd9d87eb02 100644
--- a/drivers/firewire/sbp2.c
+++ b/drivers/firewire/sbp2.c
@@ -1463,7 +1463,7 @@ static int sbp2_scsi_queuecommand(struct Scsi_Host *shost,
 	struct sbp2_command_orb *orb;
 	int generation, retval = SCSI_MLQUEUE_HOST_BUSY;
 
-	orb = kzalloc(sizeof(*orb), GFP_ATOMIC);
+	orb = kzalloc(sizeof(*orb), GFP_KERNEL);
 	if (orb == NULL)
 		return SCSI_MLQUEUE_HOST_BUSY;
 
-- 
2.17.0

