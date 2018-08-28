Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1A7C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152E8208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152E8208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbeH1Fq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:46:28 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39786 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbeH1FoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:14 -0400
Received: by mail-oi0-f66.google.com with SMTP id c190-v6so14855oig.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 18:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2IvS3Vo8cXkdzxaRQYdCXbqDcsHSO8p6rmBHDtM8PeQ=;
        b=TM5AKkrW5SDo/ROKQPODBxAy/AfQoJyrE7hrtDasNCTMESaT+gYyTmut7lDxPkAFQa
         anhiuCupAI2O4V4XI6bo0HAENdKqUGsVhi7WLSSl3zt1tttPjnVGno8DKT5UByZ5ygfZ
         aFoA8YTGe8PW0OZITTxUA63ANfXO0fDdaED4b05L21y71NX3H7eZyDb01+Df+2VJXlWL
         t8w/KWbfW1hrf36rA4PMvXrdMAfVRnlEOq8pDQEf49HmpchNq/nn+z93sEHNY8SdlFss
         p+zAG2rIKqMpHzG/dPfXX82gLpie0o64QwsV1EgBJ1IS+swyMxXeexQ4WtxECK9snoDH
         4TCg==
X-Gm-Message-State: APzg51CUHIryiFGqBVjq+qIf6ZgzKBcXr7/K7PADLF1ANW+09xFCv/3v
        /r3bQsH5BnNhMAgiH2iYWFM3OZ8=
X-Google-Smtp-Source: ANB0VdYzxHNrst212K7KkZC/9uNIWRz3IzzWKMy8KzECPPRrGVjFQ4BegIImVp0JmRbZ6UAXkZAatw==
X-Received: by 2002:aca:5cd4:: with SMTP id q203-v6mr969347oib.217.1535421298024;
        Mon, 27 Aug 2018 18:54:58 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:54:57 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] misc: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:32 -0500
Message-Id: <20180828015252.28511-31-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/misc/cxl/flash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/flash.c b/drivers/misc/cxl/flash.c
index 43917898fb9a..4d6836f19489 100644
--- a/drivers/misc/cxl/flash.c
+++ b/drivers/misc/cxl/flash.c
@@ -92,8 +92,8 @@ static int update_property(struct device_node *dn, const char *name,
 
 	val = (u32 *)new_prop->value;
 	rc = cxl_update_properties(dn, new_prop);
-	pr_devel("%s: update property (%s, length: %i, value: %#x)\n",
-		  dn->name, name, vd, be32_to_cpu(*val));
+	pr_devel("%pOFn: update property (%s, length: %i, value: %#x)\n",
+		  dn, name, vd, be32_to_cpu(*val));
 
 	if (rc) {
 		kfree(new_prop->name);
-- 
2.17.1

