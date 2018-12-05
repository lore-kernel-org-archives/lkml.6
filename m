Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EF7C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F6520850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039522;
	bh=v0WQAzdCSL7/Ici8Fmlg3gUuInDumjG16oHH8vnXEMo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=v49FqWqlrjo46dPnR5D2t21mNSertILpStx15fdrhe+m/Q5/38/LYGio74cRamXpf
	 xx6L5//h9iBxj5SfwhIBuz9T5TOZj60liND0jAput7XT38iJiiBmAiIPLnJuOdGaqN
	 +4FqZZ0z7CVPRE+0Ldt0RRTF4MqgXGT6WYNRTr08=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F6520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbeLETwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:52:01 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40337 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbeLETvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:51:24 -0500
Received: by mail-oi1-f193.google.com with SMTP id t204so18616815oie.7;
        Wed, 05 Dec 2018 11:51:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JCXdYlnAt2HdHVZalF+fwjEn668jWlLT5LjFiqstols=;
        b=WtpNqB/SDH0liYKR45jaWN3x1fZANuH2xvbz+zNDXhSRAkJULSeVLYw9a6agMlot4g
         lz3uwgAPIjq6sU86TYIYHFlMOA+uq9deP09STPcoV/nR6WFA6RVssvfPC5KXA42Yl4Qx
         zXQMh519Wr0hoeMrRQBUSg91MF/B7YnWEcRjZM6YVD372DwkWcGfHoDmPOMBth89qIYe
         mREG9lwp8zCNoB8oBEi5m/DLGPJLPOIBfM8j71DF8tX4dkMOxH9LvFz5g68vr5V83RHW
         SPqgc0MXqRkEIc6O1Kv9NxWUOs7dZRDGMHUtjww4nD2qT10aMsZ7O9D4JMv6GcD9Esqo
         ikXA==
X-Gm-Message-State: AA+aEWZgYLNKseIzicYFG++r3RQd27kmuVZSdItS6FdV0zzwR5SrIINv
        4XfYo9XxcjaL88pNnikBnda6hBYACQ==
X-Google-Smtp-Source: AFSGD/W6YA1YDCRuDZ+g49HJkJtNXQ5G0y4DAPjyI8KFIX4SoaOOmN4tKzhOm0vsvWPneHC8VsbXcA==
X-Received: by 2002:aca:e495:: with SMTP id b143mr14757328oih.286.1544039483012;
        Wed, 05 Dec 2018 11:51:23 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:51:22 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH] video/backlight: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:44 -0600
Message-Id: <20181205195050.4759-28-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For instances using of_node_cmp, this has the side effect of now using
case sensitive comparisons. This should not matter for any FDT based
system which this is.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/video/backlight/88pm860x_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/88pm860x_bl.c b/drivers/video/backlight/88pm860x_bl.c
index 6d8dc2c77520..51e0c4be08df 100644
--- a/drivers/video/backlight/88pm860x_bl.c
+++ b/drivers/video/backlight/88pm860x_bl.c
@@ -174,7 +174,7 @@ static int pm860x_backlight_dt_init(struct platform_device *pdev,
 		return -ENODEV;
 	}
 	for_each_child_of_node(nproot, np) {
-		if (!of_node_cmp(np->name, name)) {
+		if (of_node_name_eq(np, name)) {
 			of_property_read_u32(np, "marvell,88pm860x-iset",
 					     &iset);
 			data->iset = PM8606_WLED_CURRENT(iset);
-- 
2.19.1

