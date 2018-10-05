Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8006C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800122084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ax75dUez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800122084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbeJEW7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:59:07 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:39998 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeJEW7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:59:06 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4C64C1264
        for <linux-kernel@vger.kernel.org>; Fri,  5 Oct 2018 15:59:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id im-LsaAzWm0n for <linux-kernel@vger.kernel.org>;
        Fri,  5 Oct 2018 10:59:46 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 22D139A8
        for <linux-kernel@vger.kernel.org>; Fri,  5 Oct 2018 10:59:46 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id w132-v6so2633446ita.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 08:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SZ+IKJaLqG32Em6f8LOmJdvlpvwhZjzlbCjbXT0/1l4=;
        b=ax75dUezaVrD/5PsNZEqWBrByIHEJOYvQopInjzeo8hLR8FcIrmt6A+HTyQaYwirvx
         AZDAqFZdF2ZOP+gJXT22bfy4tt6/LpTxawJp18QRko1pJ1YHUQ/Awo85oXzl3iHrxRPC
         +pRi+yBNQcReFVplveXZyZu7XUHuxFBS2LWHH9wEJN7U3aKq2jq/fdBI0FamefiDI2P6
         CQxpa6PfovqDVXXNxAN8TZaFzEGER2AVJqQVEu67ZeeBqh1o0pOeleMprxLQ9sNCnJ7/
         jbgF1dDs2C4THOQzGqv6/gGhm/iJfgJtc8bhGgYdcql/2RIaVdas38DEwluWw6Fa3inj
         Svjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SZ+IKJaLqG32Em6f8LOmJdvlpvwhZjzlbCjbXT0/1l4=;
        b=sJCG55RoI0mnwobK4LPfNJxahu8LLl1jD4YhPcOdUx5RjNPwwAb1JCVkFHzao7DhNt
         YmiRiixA4KhFQkkjI+i7CC1FcnnkdU4iZwF3CrqyCeeBcvP0UceOL7sKHdIIxHTDkZN8
         wQbAxAQ286KZp7eX6c0qB5sloudZP+oDRCHooubqFTyAdE+yJ87zQ1ZIInV9bzjmt9Wn
         tpdzzYN+N3JWQ92g1uB2mSLScz0UcZ3yZ4DfQ/oKCxWH+Ad606KhzXNv6yhdAYjxsPew
         Uwtu6S/6/LJ/FHl+z4ktrN3k00QXg/LfRH1Eo6E7zm2ZI2U+n3uGor0engYmYFOmREzP
         bpTQ==
X-Gm-Message-State: ABuFfojHNo3HFhNwKke+La2PIOKFiU/2rz8r3bwNSU2+v0ER5Af8Ikfz
        rim6PM9sID+PQhLuvGasmxrzaKPo2jD6R02thlMF03ALK2bMo876vkCklRD+J2c462zYopULTeO
        mVYh5zc3R3NK2VWuStAYGnzt61jsg
X-Received: by 2002:a6b:c60e:: with SMTP id w14-v6mr5573831iof.159.1538755185795;
        Fri, 05 Oct 2018 08:59:45 -0700 (PDT)
X-Google-Smtp-Source: ACcGV63dzAy8OskfNGMfqCBXu+A4AIfVHXK/JCy4ivY/9FcpU5PPBZzfbk2zuD6cIF36ODUOoNjkjQ==
X-Received: by 2002:a6b:c60e:: with SMTP id w14-v6mr5573818iof.159.1538755185594;
        Fri, 05 Oct 2018 08:59:45 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id y190-v6sm2269034itg.3.2018.10.05.08.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Oct 2018 08:59:44 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, Jean-Paul Roubelat <jpr@f6fbb.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-hams@vger.kernel.org (open list:YAM DRIVER FOR AX.25),
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] yam: fix a missing-check bug
Date:   Fri,  5 Oct 2018 10:59:36 -0500
Message-Id: <1538755176-22355-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In yam_ioctl(), the concrete ioctl command is firstly copied from the
user-space buffer 'ifr->ifr_data' to 'ioctl_cmd' and checked through the
following switch statement. If the command is not as expected, an error
code EINVAL is returned. In the following execution the buffer
'ifr->ifr_data' is copied again in the cases of the switch statement to
specific data structures according to what kind of ioctl command is
requested. However, after the second copy, no re-check is enforced on the
newly-copied command. Given that the buffer 'ifr->ifr_data' is in the user
space, a malicious user can race to change the command between the two
copies. This way, the attacker can inject inconsistent data and cause
undefined behavior.

This patch adds a re-check in each case of the switch statement if there is
a second copy in that case, to re-check whether the command obtained in the
second copy is the same as the one in the first copy. If not, an error code
EINVAL will be returned.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/net/hamradio/yam.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/hamradio/yam.c b/drivers/net/hamradio/yam.c
index 16ec7af..ba9df43 100644
--- a/drivers/net/hamradio/yam.c
+++ b/drivers/net/hamradio/yam.c
@@ -966,6 +966,8 @@ static int yam_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 				 sizeof(struct yamdrv_ioctl_mcs));
 		if (IS_ERR(ym))
 			return PTR_ERR(ym);
+		if (ym->cmd != SIOCYAMSMCS)
+			return -EINVAL;
 		if (ym->bitrate > YAM_MAXBITRATE) {
 			kfree(ym);
 			return -EINVAL;
@@ -981,6 +983,8 @@ static int yam_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 		if (copy_from_user(&yi, ifr->ifr_data, sizeof(struct yamdrv_ioctl_cfg)))
 			 return -EFAULT;
 
+		if (yi.cmd != SIOCYAMSCFG)
+			return -EINVAL;
 		if ((yi.cfg.mask & YAM_IOBASE) && netif_running(dev))
 			return -EINVAL;		/* Cannot change this parameter when up */
 		if ((yi.cfg.mask & YAM_IRQ) && netif_running(dev))
-- 
2.7.4

