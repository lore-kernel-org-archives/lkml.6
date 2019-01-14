Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DFAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC7320659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTrU/v3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfANUcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:32:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38346 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfANUcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:32:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so432859wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gNmW5T0YScBiyljYGBLZ2IYfjuq3k1z3ZZExTAp2Eyw=;
        b=XTrU/v3h8WGq0S6k6FMteivYBATMv8Om1MiBOoye19YAtuuwvmLm0ImpYPKZ/H61w1
         j3Emp/FtTpFbxrhcT+YFdRRvcpVNNPsMM7BagLbpUwBYvldxqfn6gC6zc68t5f8o8o2v
         oXmfZyiLS/hVulPEBUL92pj7YLT86LjRURkkygvuavYSokndtS0AMb8YJ73USnU0xw84
         ZleFpUD5GW9sfV58W85htQ4T1lnfZHkbNDBXmLZiD0W7eY8yrpZ5d7yF8unwhkr9yasH
         +8pq7ga4DDksaXb09UESFf0dSkTPB/CsRNyAxAAeI0eVO8s/Nl9my9zin2ezDBtccgeU
         Be1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=gNmW5T0YScBiyljYGBLZ2IYfjuq3k1z3ZZExTAp2Eyw=;
        b=tiBw7G1kUCOfT9p7sLQj/2V1h4mlAHWiIhdIsjRCU0G6Eg+2cTmsXHi7oeU3525Qcd
         s6/JCIxvp8a0ojI8AS/W+de/Ql1+r8NXF3/E/V5HZH3lnwuqiB8IX7Yc0HU0Q8NzAvgg
         0JBL+zTX6kXCNpqSdRrQ5zqe335MWEEgOviNU/lZJHIWSAjlnOy4JcZhMPaFmnX9WlWV
         U63/6EB6AIgSMmLqlgZWAqZmpNDY5c03vkoWgmV5K/YoqRgH6hG8WanA28joe7rQBFnu
         w9xwhGse3EGCofj3SMcxnr26GD1ExXLg/JzpToK84xYz/N01xBbKXhRXXmT+u+N11Zzp
         eQ2Q==
X-Gm-Message-State: AJcUukdKwhmDWON+sdeescdf0LDUHRfoIa3K/f0TPznn0SdKBoEEp1Vj
        +hjmSqV6fQo8utuAeF4sJw1gSErh
X-Google-Smtp-Source: ALg8bN5pMILWeBtnDUUVpGQTtCqf7bg5w795n/VZ8oxzH/eGGj3XQbExkQ+opqv6vJCsPrWdogbiOg==
X-Received: by 2002:adf:ed46:: with SMTP id u6mr212425wro.262.1547497920420;
        Mon, 14 Jan 2019 12:32:00 -0800 (PST)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id s16sm58021512wrt.77.2019.01.14.12.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:31:59 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 7CA8C11422AD; Mon, 14 Jan 2019 21:31:58 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] genirq: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:31:54 +0100
Message-Id: <20190114203154.17125-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

This commit remove the following warning:

  kernel/irq/manage.c:725:3: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 kernel/irq/manage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index a4888ce4667a..1ca39dc4538d 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -723,6 +723,7 @@ int __irq_set_trigger(struct irq_desc *desc, unsigned long flags)
 	case IRQ_SET_MASK_OK_DONE:
 		irqd_clear(&desc->irq_data, IRQD_TRIGGER_MASK);
 		irqd_set(&desc->irq_data, flags);
+		/* fall through */
 
 	case IRQ_SET_MASK_OK_NOCOPY:
 		flags = irqd_get_trigger_type(&desc->irq_data);
-- 
2.19.2

