Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E6CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11CB4224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B6+uoQyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CB4224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbeKMC75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:59:57 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41512 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeKMC75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:59:57 -0500
Received: by mail-pg1-f194.google.com with SMTP id 70so4329753pgh.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 09:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZyHeoPe3HYBqVVD4vZ58X71GnzYrhsyxuiXBm4arnBo=;
        b=B6+uoQytaiX/Y8BbZnb51Iig0N9dfqXFaFe/+Eeqyzu6rN7L0FBqesXed6bdQVOwRP
         slLnYnPBlEsQiUYU9qH1a8u+ojjnbqwpBBTXUapNaWi4oQMH4kYVNinoULKQNs5tO55K
         LYYYtMUVPbb+bg2JUWKfGriPEOeFnhSAm6vzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZyHeoPe3HYBqVVD4vZ58X71GnzYrhsyxuiXBm4arnBo=;
        b=pM/At0sZ9H8qL1e2BAg0X9M22+Qj/Tz2K0F/zgWC3XUPhE85TLhmwEjdGEJET5bvbJ
         3o5htu0F9ZWfyxmgwwQfISyiTjCqnVTIjk5qyZrjhAre1s6GG0cl5m7T9F4t1WxfOHPQ
         OtuztwQKvHqhXYtd3BYG2MRchp1PxqqLjkh83j0hMymDziRh1CmQ5vM4CbcRuTaucS31
         7resdeVZ0FaIDhCh5valKUsAFLzkPv/FvKS7Qz4IcoC3X3mNpLdflQ/z7DcdtsK876E3
         PEm/9GncmUcGnH+a/0G6Ug+5w1ytKc+/CYR3YEY0LD9wd6gfug06vAQkmx5gTwgrYg4R
         7MOg==
X-Gm-Message-State: AGRZ1gLle83Do/jnfwO9xQffsMTecGqeAdHocSbXSWl30TXPYsPk3z+3
        KRzhtu3BuPTy+yg3GlBIdq8ukQ==
X-Google-Smtp-Source: AJdET5fXFaIGMJVH0xc7n4AzBz+k0ZWFc4eBmjj0dUWEpvZLttv3Ya9d47KA5ljX3NK5Vo9w+w6Cmw==
X-Received: by 2002:a65:6645:: with SMTP id z5mr1509663pgv.351.1542042350135;
        Mon, 12 Nov 2018 09:05:50 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o4-v6sm19806849pfi.172.2018.11.12.09.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 09:05:49 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        davem@davemloft.net, akpm@linux-foundation.org
Cc:     nicolas.ferre@microchip.com, arnd@arndb.de, suzuki.poulose@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add reviewer for CoreSight sub-system
Date:   Mon, 12 Nov 2018 10:05:47 -0700
Message-Id: <1542042347-12389-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On top of providing useful review and comments, Suzuki has done good work
in the CoreSight sub-system over the past couple of years.  As agreed
during a recent face-to-face converstation, adding him as a reviewer to
lessen the maintenance workload.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0abecc528dac..4f93b877c4eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1426,6 +1426,7 @@ F:	arch/arm/mach-ep93xx/micro9.c
 
 ARM/CORESIGHT FRAMEWORK AND DRIVERS
 M:	Mathieu Poirier <mathieu.poirier@linaro.org>
+R:	Suzuki K Poulose <suzuki.poulose@arm.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/hwtracing/coresight/*
-- 
2.7.4

