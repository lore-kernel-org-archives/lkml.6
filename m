Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C986C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83192083A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CU32zN5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83192083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeIZCq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:46:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46238 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeIZCq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:46:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id d8-v6so5055264pfo.13;
        Tue, 25 Sep 2018 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m4QOKNEjjVWSlgV+T97paCua5vGfTGeALBNxE08We+E=;
        b=CU32zN5SW/IqocVxGlKto6POLV4qgrSUkzE/RUURbATcUjVeOlcaw3B3H1HjeOpCJJ
         qkIZVZTurE+FMp//AxI7A4W+66beJHCh8pu8vmvutFIH556xddsANLOd47RyrUm/ieB5
         5zu7T5jWBO9NzjH++Pkq39vyYFoWSewzqABD/5qmVBetqNkzFmb/SxyiiQv3TA+WVcJi
         aLd2QlBlFVPlC3g531dSopdJM1xQDNdnxiRQ/RgxavwRvPbef9Z0L1cIKfH7zSuQSa/b
         604P4xv3u9/82u0+Hq16VFDFYzXpAFknf574EZ1okqYmgjyoEDrvPKt0cWxffAhBa9jG
         Zd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m4QOKNEjjVWSlgV+T97paCua5vGfTGeALBNxE08We+E=;
        b=OyCxp2DCU1B7rka8P8xCjZKjxpMQnVX21Lc5z5PFNruXJQEgmj3BqfhPoYU3ouQsrF
         uK48zL4cJ51XTqfDoozQvZ9fmQ9D5tLPsh4dZ0kiFT6wfTqNtzYtIlSsPUA1IbAz+tnO
         x66z8z2x6q9hAlnl11wVy0xtzr5u881cwyms8yh177V88lbhMgXrmor3pLvpiIddF9a7
         pz7iTbH9GiZQCr7HgRQ6FHNIKFeIVZNXphAtqV8V/x9FsJNkbTn3JyoaK538FBNE1x1L
         CPzkxwD70Yhhuttox4KBiG+4hbFbmBMrlZw4omZO/zM9DDBkM51jW8zgf4uc7yxypDID
         VYcA==
X-Gm-Message-State: ABuFfogzEBGh12T3qRr5X+suU8H8DEAoFg/8f+dsKePvxwd6OaycJGO/
        IaW4Zt99wAcVkw3uj/7XRnk=
X-Google-Smtp-Source: ACcGV612rgIqh39VflN926pAaM8sn9n4IIa0RfEeUPwEw+K1tjQxyildnTQ+3cW894Gy1FpHO+y9xw==
X-Received: by 2002:a63:e855:: with SMTP id a21-v6mr2595006pgk.4.1537907857264;
        Tue, 25 Sep 2018 13:37:37 -0700 (PDT)
Received: from hieu-Inspiron-7577.net.fpt ([1.54.224.16])
        by smtp.gmail.com with ESMTPSA id g3-v6sm4042129pfi.9.2018.09.25.13.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 13:37:36 -0700 (PDT)
From:   Hieu Tran Dang <dangtranhieu2012@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Gao Pan <pandy.gao@nxp.com>
Cc:     Hieu Tran Dang <dangtranhieu2012@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: spi: fsl-lpspi: Option to allow stalling
Date:   Wed, 26 Sep 2018 03:37:00 +0700
Message-Id: <20180925203701.13605-2-dangtranhieu2012@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925203701.13605-1-dangtranhieu2012@gmail.com>
References: <20180925203701.13605-1-dangtranhieu2012@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add fsl,allow-stalling property documentation for fsl-lpspi

Signed-off-by: Hieu Tran Dang <dangtranhieu2012@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
index 4af132606b37..2b012b8cb05e 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
@@ -6,6 +6,8 @@ Required properties:
 - reg : address and length of the lpspi master registers
 - interrupts : lpspi interrupt
 - clocks : lpspi clock specifier
+- fsl,allow-stall : allow stalling of transfers when the transmit FIFO is empty
+  or when the receive FIFO is full
 
 Examples:
 
-- 
2.17.1

