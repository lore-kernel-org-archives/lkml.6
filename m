Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148E0C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6994208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6994208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeH1FnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:43:01 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41019 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbeH1Fm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:42:26 -0400
Received: by mail-oi0-f67.google.com with SMTP id k12-v6so1738726oiw.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 18:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Hg3/aCmTTKeUM5DPz4uRGx9Qz6ER5C2bJUMxpFVPgSE=;
        b=Efx9igfw5Im1r6YLQEIZdKURmXmFRxgARw/9anivg/q6BVBVSgbxbnDn842qX+qWT7
         Rtw/UMOE/2Q9OAWIoF8p0a0lqhoqPzGyir1XiWNtZbAN8riMI7LYWNWoAzN4vTJXPlV5
         JzG601ql87q5zwGQJfZ4F2t0tPqhVJ7UnCBFiCWLdxkrr2ArsN6isyJmHA+4utEJqk00
         smE7+6Mx+7cOyzHVr2RD1dtdB3d534mp7dHPhmXCVPtwcmk9pIjIlqxJwsiDw6RxOu3N
         K+/+ioO9v4NiJoovRZwgRWQc4tsoyixEF7GE7YhkZaO6/VIwbiXKJ6Un0q2IqaETPgJk
         uRlQ==
X-Gm-Message-State: APzg51CY/oAeZkxwwLVJ6p822bBHnqOZFYmpfX6QyVTvEcFw8PRdnMU/
        9GVic9TMHGTB0spDDIX64fJxzVc=
X-Google-Smtp-Source: ANB0VdY+YSK4sW4I4z9trdUENik8RsYBVxy0L8JA+p8cedG+vopV6GsPbIcTH/w4GSEvZLONneS+Pw==
X-Received: by 2002:aca:3a57:: with SMTP id h84-v6mr1073480oia.336.1535421190729;
        Mon, 27 Aug 2018 18:53:10 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.53.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:53:09 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:18 -0500
Message-Id: <20180828015252.28511-17-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/firmware/scpi_pm_domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/scpi_pm_domain.c b/drivers/firmware/scpi_pm_domain.c
index f395dec27113..390aa13391e4 100644
--- a/drivers/firmware/scpi_pm_domain.c
+++ b/drivers/firmware/scpi_pm_domain.c
@@ -121,7 +121,7 @@ static int scpi_pm_domain_probe(struct platform_device *pdev)
 
 		scpi_pd->domain = i;
 		scpi_pd->ops = scpi_ops;
-		sprintf(scpi_pd->name, "%s.%d", np->name, i);
+		sprintf(scpi_pd->name, "%pOFn.%d", np, i);
 		scpi_pd->genpd.name = scpi_pd->name;
 		scpi_pd->genpd.power_off = scpi_pd_power_off;
 		scpi_pd->genpd.power_on = scpi_pd_power_on;
-- 
2.17.1

