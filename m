Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B747C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD452086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Lw0bbEg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfARNpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:45:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41896 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfARNpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:45:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so15087978wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 05:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=zUoPYr9AHJpaiRFFf+oN0QlgGX+8XWZXPgr4fqLX26Y=;
        b=Lw0bbEg3tDOtgmO/RlNdblGneCGiacYfsPOPdfbJi3hZMkN/B+sEbm9+hkZz54Qemv
         iQW2DnN/dnhp21CBWIlwHRcEdU8TGbW9Vyxj+T1eJXo9LOOHfU2qqHnpdFC8/z69snIy
         smT7VCo6+MVD8UOnP4JEvM+WkkclHWko/aTb89zZ+HHTdzGmsUS5H33uqEG2uAm8231/
         kcSpssXNzL9Alj0LQGx/7f1tCPPBuBUqNC0mVD+iGyGr5Rgve2A4aFjJvc/J1/UGol4A
         +jK3vhSOlDH8bRPcB0m3YfyVQIPeCq9q/rz8V3PiPtZgSh1tREgbLor9GIBwjS8JiZL1
         /oeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zUoPYr9AHJpaiRFFf+oN0QlgGX+8XWZXPgr4fqLX26Y=;
        b=Jq1VMNJqnjw39QD2txg7/CtWLcKTl8jOdT1ykbNHDr9J2NWuV5kx1zSZWu78w/U85X
         wJRwTN8T91zm+OMB0FvgKqIdgmWOuKLnRc/fYJ2FeY2VOIcgxuLgNvTY1q/2uocgKUDX
         zQySxu+Pwyy8Kqlkd5Hfodb8OsoZ0OvzLuVOy8eIRrmbhqdsYrn1yVmNxbkoqCr7vCOu
         6ACc7eCuO7Wf7IvNUnbfyD2S3clUi4lmAYgsvF5D0QB92Awj1joBWSqmAyBG+y92fSb3
         OPHid+BdMgMq5StQ+kUW4K0pkShpMnHMzHLtvN2YNJbdgnC9jTuyB8m4/kGSt75toMNn
         aFLQ==
X-Gm-Message-State: AJcUukd6qIj7t3PYtEBFsDwHsfT7glc3ai8D1NTFWYLQKlpRwU7r7nWg
        8yjKYwy74VnnOEk5NYVQzawt9w==
X-Google-Smtp-Source: ALg8bN74uYAgQL+PmkbeK8Og8mVvWUpTQ5MGZxWIWbtz6YFIdiP7/j2YDH3etu1LUfuDZ6lW7EbQHw==
X-Received: by 2002:a5d:47d1:: with SMTP id l17mr16323399wrs.319.1547819144556;
        Fri, 18 Jan 2019 05:45:44 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id z7sm76696206wrw.22.2019.01.18.05.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Jan 2019 05:45:43 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     chris@zankel.net, jcmvbkbc@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] xtensa: Fix typo use space=>user space
Date:   Fri, 18 Jan 2019 13:45:27 +0000
Message-Id: <1547819127-4439-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a simple typo.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/xtensa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 20a0756f27ef..48906ac5fd25 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -164,7 +164,7 @@ config XTENSA_FAKE_NMI
 	  If unsure, say N.
 
 config XTENSA_UNALIGNED_USER
-	bool "Unaligned memory access in use space"
+	bool "Unaligned memory access in user space"
 	help
 	  The Xtensa architecture currently does not handle unaligned
 	  memory accesses in hardware but through an exception handler.
-- 
2.19.2

