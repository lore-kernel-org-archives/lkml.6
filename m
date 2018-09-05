Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFF6C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA4B2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA4B2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbeIFAKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:10:08 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45527 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbeIFAJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:09:37 -0400
Received: by mail-oi0-f66.google.com with SMTP id t68-v6so15895516oie.12;
        Wed, 05 Sep 2018 12:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VGNyhY5tgQV4KWn3opIp4M/wV8dFtqeR1pRxx+K7ox8=;
        b=chNCd9vk1q8uKgMf/9J9U9X5Dh3CIGsTDJSwVh5EmGkVNmj2+7LheeXkpaZXUyNNwd
         IjkC5l0W4M9JHZstAsXFK7eDxzbEQAz1xu9gJkW8KtbJ6eWVIa1MqDoTbEk7cZQ0TPRe
         b3pde8KKEuI9GA1sEiA91y6uBy4bIighG2L/OOufVnYmrMQqnxzkrTD4JffeV9qknoNE
         F1VKpQ8T99oNWRhjerBhtWLjDYHxB3jZd25FJaCknZEhd1IcNtsu7JsBkzmwOcEc771P
         x4IazCBsi+I2XcAbt35Bi3obf+U0kGTn0udGdoj2YzEeV2tR69JcTZrAV2I1MVUmkkcn
         KOUQ==
X-Gm-Message-State: APzg51Df0uDW3DNm+CRZsT+7NcPuRwfDqHG9IZ+c9V91rHsXzbQitm+r
        lkSbW8ZT3ier04hRk5Al3RN/dns=
X-Google-Smtp-Source: ANB0Vdb2JW4ND8zDM1aF+poUak65J2eydp6/a206Fc33NQMQk6Qkn1Ap0sZ5HxZaEVCk3LL76RxKbQ==
X-Received: by 2002:aca:aa06:: with SMTP id t6-v6mr33049663oie.152.1536176278961;
        Wed, 05 Sep 2018 12:37:58 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm2296053oie.22.2018.09.05.12.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:37:58 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH 16/21] x86: DT: use for_each_of_cpu_node iterator
Date:   Wed,  5 Sep 2018 14:37:33 -0500
Message-Id: <20180905193738.19325-17-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905193738.19325-1-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
has the side effect of defaulting to iterating using "cpu" node names in
preference to the deprecated (for FDT) device_type == "cpu".

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 arch/x86/kernel/devicetree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index f39f3a06c26f..7299dcbf8e85 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -140,7 +140,7 @@ static void __init dtb_cpu_setup(void)
 	int ret;

 	version = GET_APIC_VERSION(apic_read(APIC_LVR));
-	for_each_node_by_type(dn, "cpu") {
+	for_each_of_cpu_node(dn) {
 		ret = of_property_read_u32(dn, "reg", &apic_id);
 		if (ret < 0) {
 			pr_warn("%pOF: missing local APIC ID\n", dn);
--
2.17.1
