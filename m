Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6096EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B516214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gygMZCje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B516214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732514AbeISVKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:10:11 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39755 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbeISVKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:10:11 -0400
Received: by mail-qt0-f194.google.com with SMTP id o15-v6so5472976qtk.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 08:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E75YbFt7zouutHqr8dmDFN4XCuyQr69KupJK0t/yLBw=;
        b=gygMZCjextPxXNV8TVHTGqPVDoADAPWc3BBUE8CxeECyk2j/BmLMseOXn489FeUSF6
         aF+cL7xGA59e78OQjarAUX9zADrLYvdZwFOl7s6xRQr1/L0bF32Dzw+SI02DC0CDgyae
         oTaGLdSMzvN4eCeJZkSsZ8Va5sDirqg5dau+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E75YbFt7zouutHqr8dmDFN4XCuyQr69KupJK0t/yLBw=;
        b=p6Eh7oO0LLZ1B6oQC9w4XDyA3BJMQ1KS7Ioro4SfcbyD7TcRuYP+yRJYxydPwhgujT
         gI1xVs8VZNwyzrfMU3nNf+sxGxXVEEwmGG9TC90DkmH9A239VB8Kdlq9f1klzbMxTQxE
         +Uve0JvaMhYOJfUce2IUBmNlBRXcV5/NaFCHcTQH+9mYQM4EUBjlUf9QVFfiUSQnoDNI
         uzWG2xj22DAnM/hZ4ZKwcrBGLTCoSpPN6bjlGTvE8PmmFFs0WosRmQZT8JhBqVP4J7DZ
         wpEERtdjPM+Ce8IFzhSIn6CviMLrZxrLy5w64bXY6P2sJipJ344BK85JAvFK8d4AP53A
         njKQ==
X-Gm-Message-State: APzg51DZNdDbm1fW5LOblfVzm+/Yq3kfQZG8pcXsM7IoJz85Eb1cxcFd
        JOqacqUwdYlusiOPJsePfh7TWhBJzcU=
X-Google-Smtp-Source: ANB0VdZKw4iTjEklyMJLlUmslqwnex/qWwFMXxPZRMyIw2YZ2bAGDgzQmCTfhQquahw/EfCyM96G6Q==
X-Received: by 2002:a0c:8646:: with SMTP id p64-v6mr25135415qva.91.1537371103058;
        Wed, 19 Sep 2018 08:31:43 -0700 (PDT)
Received: from venom ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 39-v6sm3866886qku.18.2018.09.19.08.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 08:31:42 -0700 (PDT)
Received: by venom (sSMTP sendmail emulation); Wed, 19 Sep 2018 11:31:40 -0400
From:   Jon Mason <jon.mason@broadcom.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH] MAINTAINERS: Remove self from Broadcom SoCs
Date:   Wed, 19 Sep 2018 11:31:40 -0400
Message-Id: <1537371100-8245-1-git-send-email-jon.mason@broadcom.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm leaving Broadcom, and will no longer have access to hardware and
documentation necessary to be effective in a maintainership role.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ece30f15777..d063c605074e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2886,7 +2886,6 @@ F:	arch/mips/include/asm/mach-bcm47xx/*
 BROADCOM BCM5301X ARM ARCHITECTURE
 M:	Hauke Mehrtens <hauke@hauke-m.de>
 M:	Rafał Miłecki <zajec5@gmail.com>
-M:	Jon Mason <jonmason@broadcom.com>
 M:	bcm-kernel-feedback-list@broadcom.com
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
@@ -3024,7 +3023,6 @@ F:	drivers/net/ethernet/broadcom/genet/
 BROADCOM IPROC ARM ARCHITECTURE
 M:	Ray Jui <rjui@broadcom.com>
 M:	Scott Branden <sbranden@broadcom.com>
-M:	Jon Mason <jonmason@broadcom.com>
 M:	bcm-kernel-feedback-list@broadcom.com
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 T:	git git://github.com/broadcom/cygnus-linux.git
-- 
2.7.4

