Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32A6C07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3CF20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039648;
	bh=marxXJEiX88EUHlWXIOxHGOijkawQ6Uomp3svLslup4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=dqhwSE3tIrapP8D61OwO/oZrvfmoos6inyrevWDeSSOI9UA2ibDOzso9YncSw2R+L
	 6i6siIujZBA9+yXzL5bQsShKynIZEAUgZU3cqAKZ402t2CeFCjd64YVjeXMNM+8Dbr
	 bkjm5FuzPYF6mtO/9RxauktD9QwA0sN7zwCk3KDQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3CF20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbeLETyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:54:07 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38086 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbeLETu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:50:56 -0500
Received: by mail-ot1-f67.google.com with SMTP id e12so19827118otl.5;
        Wed, 05 Dec 2018 11:50:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FCXujmAcS1tG2NvhiK6bdTt5bEKhFlnBEggkTIyE7Co=;
        b=srKtaAOaiadrxsSF+O0uhq94hM+1HsApcF7o4PwnHJeyE6ngT9rb0CP0zp3VCm3ZFA
         zK0HjgkhtzFl2184BEOq7ef0AGKv5ifHcYPnQ/KgvVUfzUWdW/zDw+j6ivHFvBY4i09X
         DJ1UWsa2O2rwcpQZBIH1pGctK04+wy9Lq9F0jJKQGxbyoyq1qYCKpQuyMy06DE4HzJZG
         5KPqzQybsh/smNhWxekUf2JxruDMeOMzmVrdDY0HiTBfSIftZOchKr5fkVMgVdVo1+X4
         BWGudxA5slRtCHkjBTpRPhUCGGDDWwg7Ih0/lmfv68JXqFPcmztfYnmH7jOUMZb9enoU
         6RZg==
X-Gm-Message-State: AA+aEWY/fpfj2spDm7Cq/2vQC7oOePB08NIUhSnWmzbDtxCwpW2KvqWp
        I8EOQFZThecZ7klFgIP01hBW++s=
X-Google-Smtp-Source: AFSGD/Wb6MPtIWyYifjSIUPFPfdiI+aKlDBhOSgJqj3ycEAFcwFp59sviRPEgmxIagf+pdvBJTceJg==
X-Received: by 2002:a9d:6a1a:: with SMTP id g26mr5813360otn.172.1544039455409;
        Wed, 05 Dec 2018 11:50:55 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:50:54 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Subject: [PATCH] ata: macio: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:20 -0600
Message-Id: <20181205195050.4759-4-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/ata/pata_macio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 9588e685d994..9e2501da4638 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -948,7 +948,7 @@ static void pata_macio_invariants(struct pata_macio_priv *priv)
 		priv->kind = controller_k2_ata6;
 	        priv->timings = pata_macio_kauai_timings;
 	} else if (of_device_is_compatible(priv->node, "keylargo-ata")) {
-		if (strcmp(priv->node->name, "ata-4") == 0) {
+		if (of_node_name_eq(priv->node, "ata-4")) {
 			priv->kind = controller_kl_ata4;
 			priv->timings = pata_macio_kl66_timings;
 		} else {
-- 
2.19.1

