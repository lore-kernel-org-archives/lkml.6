Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3C4C67790
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 02:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D31D20862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 02:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB5Btazj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D31D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389491AbeG1Dzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 23:55:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45982 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389395AbeG1Dzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 23:55:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id f1-v6so4204946pgq.12;
        Fri, 27 Jul 2018 19:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PRFzjwMH69ofptw47YioM8dvxk1eD5+6BvPdX8LRxlA=;
        b=TB5Btazjk6BwAXJVIzTSNSRFQ4NofqtvKgV5oKV6WLyl8blJJ9cm9uXCDtWr7jH0Mq
         3jhC1Q8NVVNKKsKErwt6NwzP125ttO+vcdSqDnc51Y6BoXqIKsM2ot6xCskKwHT787cg
         uuF6HkkA2Pi0WoPv8nTCNxCWtZvDcH4inqTMZ0nlpIbsbW+vNmYLb6bSgg4EhxwEN7ZA
         3aI/Zou5u2odUV3PNYKp2fNE4RURqdBG30TJhPYTO8fqWdPq7Ditnx9colV9L3jH3/DF
         9OZ4kwrGM172xV/7B55D8vNPOdP46fxUC3WN7qQXSTG/o9yOYaCdn4tKsKoTzToNTzoJ
         4X4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PRFzjwMH69ofptw47YioM8dvxk1eD5+6BvPdX8LRxlA=;
        b=Pt0K6zIht39vpg0hjcQaihGDkLlK7XemmlBLFhRxH6iK3MmtWDDbPq5wPO3EGML6L1
         CpcYq9BIrYhzx13pgqvSXNQhi1DAt3DVCt1i6yKJIl8NFPkAC1Ure1xI6FzHp0FHpw4a
         GTOsswUexJ5iQdQQ74vjM9jMF8qB5/Dy9aqkahH6zD5CwMVhqyn2Uwp5U7NiPL5CFdfO
         saMwZnm30i8zQvXyMapo9ha5qH5/bLHrwclbm5YKKHx30HI4r4xhJRyjofVgPnemCd92
         eFUYrC1i6EFPDlY1Am4kyDYA+ZhrIzkls00P4KuFyydapkWISqvOvNsvUPm7NIlGjIi1
         fjVQ==
X-Gm-Message-State: AOUpUlFr7p9e1o/ikjg2kU1ezXXeTv42OTGUb8pYyCAt7WuqBzILWcKa
        2CgEda9MOp2AFxsi11Y+bODakPeb
X-Google-Smtp-Source: AAOMgpdHae0h3cMfCLFWukakoRrzc2eeLVdzeDJyWglEAGV950Q4nlLg3BVC+lA9uWRbJQbBC+bLpA==
X-Received: by 2002:a65:4107:: with SMTP id w7-v6mr7933715pgp.302.1532745065918;
        Fri, 27 Jul 2018 19:31:05 -0700 (PDT)
Received: from pjb1027-Latitude-E5410 ([58.227.15.43])
        by smtp.gmail.com with ESMTPSA id a25-v6sm5770281pgv.51.2018.07.27.19.31.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 27 Jul 2018 19:31:05 -0700 (PDT)
Date:   Sat, 28 Jul 2018 11:30:58 +0900
From:   Jinbum Park <jinb.park7@gmail.com>
To:     axboe@kernel.dk, bart.vanassche@wdc.com,
        jiufei.xue@linux.alibaba.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        gustavo@embeddedor.com
Subject: [PATCH v2] pktcdvd: Fix possible Spectre-v1 for pkt_devs
Message-ID: <20180728023058.GA21103@pjb1027-Latitude-E5410>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User controls @dev_minor which to be used as index of pkt_devs.
So, It can be exploited via Spectre-like attack. (speculative execution)

This kind of attack leaks address of pkt_devs, [1]
It leads an attacker to bypass security mechanism such as KASLR.

So sanitize @dev_minor before using it to prevent attack.

[1] https://github.com/jinb-park/linux-exploit/
tree/master/exploit-remaining-spectre-gadget/leak_pkt_devs.c

Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
---
v2: Fix coding style by Gustavo.

 drivers/block/pktcdvd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index c61d20c..8ec2eaa 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -67,8 +67,8 @@
 #include <scsi/scsi.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
-
 #include <linux/uaccess.h>
+#include <linux/nospec.h>
 
 #define DRIVER_NAME	"pktcdvd"
 
@@ -2231,6 +2231,7 @@ static struct pktcdvd_device *pkt_find_dev_from_minor(unsigned int dev_minor)
 {
 	if (dev_minor >= MAX_WRITERS)
 		return NULL;
+	dev_minor = array_index_nospec(dev_minor, MAX_WRITERS);
 	return pkt_devs[dev_minor];
 }
 
-- 
1.9.1

