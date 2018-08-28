Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1314C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B662A20645
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B662A20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeH1FoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:44:13 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35733 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeH1FoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:12 -0400
Received: by mail-oi0-f68.google.com with SMTP id m11-v6so39622oic.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 18:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iCRvxN/pzzJg98QNFDTCqJ9YnymZzXtlsb8aCPTvMx4=;
        b=hfoT8k/Jryj8MjyTzzULBKhumJKK+8+AhK6EMRdu5tc4cXnyhDGRJdMatx6SwTPgOy
         +3pIEQW8b7E5ixvL/E9nmyB6hYIEaIomCz9fmPzytEh08kvOGID/QLu1UmcWCnxq4Lvy
         7JHbL81dJXm6Q8nTIlZ94rkO5bjfpBCNpBSTt6NKlzAb5yyNW8DWnH3+G/attfko/U0u
         ZNecBmIWkN3VgvKNg3eLllzv1L6l/rE4DSR9Do+/cN2YzSzCjamb8Y+UsYXxoUon/vIH
         XSD4yB63ILGMJyfkBfl75eiXhpcJylxELy6RW0eO9xuJjdnBVtvW+lELBCMCp3+4c3ZN
         R2qg==
X-Gm-Message-State: APzg51APshWWWXyRrHyyJptMCnO8LIzD5klkKnncYk38QSBat6vBKine
        DCN/IUzdn01VC5VFN1lnTVR77fA=
X-Google-Smtp-Source: ANB0VdYL0Vf2bOSXIQD9P5hhMmStjYmDCil1EqOewmRImoVsCRGV5aGBus7DmKeomunLrzkclYUWlQ==
X-Received: by 2002:aca:ea57:: with SMTP id i84-v6mr986708oih.266.1535421296929;
        Mon, 27 Aug 2018 18:54:56 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:54:56 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] mfd: max77620: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:31 -0500
Message-Id: <20180828015252.28511-30-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/mfd/max77620.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index b1700b5fa640..d8217366ed36 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -285,7 +285,7 @@ static int max77620_config_fps(struct max77620_chip *chip,
 	}
 
 	if (fps_id == MAX77620_FPS_COUNT) {
-		dev_err(dev, "FPS node name %s is not valid\n", fps_np->name);
+		dev_err(dev, "FPS node name %pOFn is not valid\n", fps_np);
 		return -EINVAL;
 	}
 
-- 
2.17.1

