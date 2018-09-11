Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B353BC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F0D20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F0D20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeIKTzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:55:49 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45745 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKTzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:55:49 -0400
Received: by mail-oi0-f68.google.com with SMTP id t68-v6so47658556oie.12;
        Tue, 11 Sep 2018 07:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k7AVLB9lcI+ZZD5i6K8Uly97g4wcFneJFRswawwZ9dg=;
        b=e7BVDETcA/5CViShXQmHJ/E7O1ugYFfEDm1GDMvCS3sAiIAfftMF+LKKCBozKiaDQG
         ap/h+moFPR6aa7caTxJpzNBCogyjQ9dQjsEHLrIhMow7HYleG/nQEfcQQ0wBRd4xwNJ3
         6cMwX8sd07NN+uqGlymlAJgNZK+SmkJI81BKQq0SU1UGA+PEXi5nUrm8RokGdqk+QuD6
         tOwfMLOLCiF8psR3AQULp49aluGKfBFfkmwRwtPDWTeKdkut4g3z2ltxYPsEFgNbMd7f
         fUiXXehKDu0QP5zsCzDnhsvz5z8xIckEuEbpc6R0BwC1zuvurNktA8JEwU8J92mlm7MW
         +mhw==
X-Gm-Message-State: APzg51Bvdfarce51lj666IxmCeSbliXkhWsDywogqfkKYI94pKgJmf5K
        t6+PwmkY49pOYlDv/v2NYA==
X-Google-Smtp-Source: ANB0Vdam+KYhDtUJcxE7V2VJgyYBvneS/1C9LEiN1IHEI41ChePLC/2doH0nmRQhzuy0FpcJY5kr2A==
X-Received: by 2002:a54:448b:: with SMTP id v11-v6mr29223241oiv.208.1536677769415;
        Tue, 11 Sep 2018 07:56:09 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id y85-v6sm16403991oie.25.2018.09.11.07.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 07:56:08 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Finn Thain <fthain@telegraphics.com.au>,
        Stan Johnson <userm57@yahoo.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Subject: [PATCH] of: fix phandle cache creation for DTs with no phandles
Date:   Tue, 11 Sep 2018 09:56:07 -0500
Message-Id: <20180911145607.6009-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of
of_find_node_by_phandle()"), a G3 PowerMac fails to boot. The root cause
is the DT for this system has no phandle properties when booted with
BootX. of_populate_phandle_cache() does not handle the case of no
phandles correctly. The problem is roundup_pow_of_two() for 0 is
undefined. The implementation subtracts 1 underflowing and then things
are in the weeds.

Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
Cc: stable@vger.kernel.org # 4.17+
Reported-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Stan Johnson <userm57@yahoo.com>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Here's a formal patch of what Stan tested. Will send to Linus this week.

Rob

 drivers/of/base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index a055cd1ef96d..17ae594b7014 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -140,6 +140,9 @@ void of_populate_phandle_cache(void)
 		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
 			phandles++;
 
+	if (!phandles)
+		goto out;
+
 	cache_entries = roundup_pow_of_two(phandles);
 	phandle_cache_mask = cache_entries - 1;
 
-- 
2.17.1

