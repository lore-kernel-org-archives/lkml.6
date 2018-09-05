Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F0AC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D284D2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D284D2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeIFAJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:09:34 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41629 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbeIFAJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:09:33 -0400
Received: by mail-oi0-f68.google.com with SMTP id k12-v6so15893041oiw.8;
        Wed, 05 Sep 2018 12:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s3OlCcnQtVwqjPItkwhGyBmzTtRlvMcJ/T8eD1Ua590=;
        b=Vhte3upClIY0I+g+ED9LAaJ8FeZbmh61jvcNlg7hoH5BZN04W72KhOf/CIjzI3YgGW
         CQmXXuoTMhbo5J6laaHElA/HRuxcWsm1SGJ1DJN9kT+hFExgdDqlwW19wD2A4vBVw9u5
         h3+t4F4J96+jT2YUYHA0M8Kc1CO9OF+Lc4oMNYmpoyvYApf/x+t8Se+Cp5j73UmivDBu
         +uGsUIddHnDUERHov6KPJe1tYJE+5/wP7wPeW8PwpY0fcTeZo+dt5p0MbjHIkVUWDWcy
         I5CpPZYN0adA9sRcnH67uOul4NiAa4V6fAQtTg+r0Mq60Dj0E69MSQtKBZKUwdl7OciE
         S9Fg==
X-Gm-Message-State: APzg51Abbz2qtyEMVJNBpTAHkazaskc/vVx3Xd5CuRnl9Lre69/TCGAJ
        WNKRfugO/mfSWEicGrBqyuEOimE=
X-Google-Smtp-Source: ANB0VdbHu6FRko3iccCmiHvTxno2oOG3jnm/17Jr1z1UrIWZCDZAUCvenWLrvNykaQJVNQLR22HLtg==
X-Received: by 2002:a54:4091:: with SMTP id i17-v6mr19205119oii.352.1536176274820;
        Wed, 05 Sep 2018 12:37:54 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm2296053oie.22.2018.09.05.12.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:37:52 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 12/21] powerpc: 4xx: get cpu node with of_get_cpu_node
Date:   Wed,  5 Sep 2018 14:37:29 -0500
Message-Id: <20180905193738.19325-13-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905193738.19325-1-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"device_type" use is deprecated for FDT though it has continued to be used
for nodes like cpu nodes. Use of_get_cpu_node() instead which works using
node names by default. This will allow the eventually removal of cpu
device_type properties.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 arch/powerpc/platforms/4xx/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/4xx/soc.c b/arch/powerpc/platforms/4xx/soc.c
index 5e36508b2a70..1844bf502fcf 100644
--- a/arch/powerpc/platforms/4xx/soc.c
+++ b/arch/powerpc/platforms/4xx/soc.c
@@ -200,7 +200,7 @@ void ppc4xx_reset_system(char *cmd)
 	u32 reset_type = DBCR0_RST_SYSTEM;
 	const u32 *prop;

-	np = of_find_node_by_type(NULL, "cpu");
+	np = of_get_cpu_node(0, NULL);
 	if (np) {
 		prop = of_get_property(np, "reset-type", NULL);

--
2.17.1
