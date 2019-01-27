Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAA9C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 15:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6D4214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 15:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="BeAE2/jM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfA0PyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 10:54:21 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25435 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfA0PyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 10:54:20 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548604356; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=R6/ZdaMgNOF9pkw0bLVsNrpse8OEETmN4ZArUey8KW//SP16rP932NJrozwqeE1Q1Ntd0+cc/HCWLodUVbcG+/xBYZ5mMSx+pJxwM9UMTdo+TssDbbZU6TDGfbA5V6vKIoB7411OItZ0ORCa3PrNniqrX9xqH4iIN2yG09yADDU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548604356; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=rY/XavGAwUpYPVOpnXYmGfQXmo2eWhWeTg/xV/xoD0k=; 
        b=ZEODltv9czxVgPZuAjOv3eCAq/x3iUQHtCvqFtuxE75iIbEMm1MayhvhcJ9zMla5IAmC1QzFPEXxEQniOvuBHh2chNzwBWbfqQ36EwkvKJHrIis+WuqvSjMeuGXApsvSrd1EHQZ2nnRx5uaBRgPXfG8vOwxB8gaKP6wyLfymQfQ=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=d/13z0UZMZlmc+qHCciFDkPvjTbdVaNNS4K2aHMGUYHEM2jKI8ZLIQe6eEEPs38bqYx1XclxH/3L
    twb3otmKKcM7pT3CUOxtdZwlojxt8Vd2eBDVuAXnnWCZ8qXMfW4i  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548604356;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=940;
        bh=rY/XavGAwUpYPVOpnXYmGfQXmo2eWhWeTg/xV/xoD0k=;
        b=BeAE2/jMCtKLZpV4oJLekFrgcLlBROEbqbHK+olAQ0A+aK12zGdbZT5DPHJDmmRA
        dtBFD3q7xIgDs1hh9dAgGLfeGU03DMMVRZ9ueuTGjNQAZ0M5maW7lxuSvx8XK++9c60
        8JBCsuxBD3G9gZcr5/4AL4VmbFcegqBysUC8lkEs=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548604355986950.1175891927965; Sun, 27 Jan 2019 07:52:35 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, jason@lakedaemon.net, tglx@linutronix.de,
        syq@debian.org, jiaxun.yang@flygoat.com, 772753199@qq.com
Subject: [PATCH v2 4/4] Irqchip: Ingenic: Add support for the X1000.
Date:   Sun, 27 Jan 2019 23:50:32 +0800
Message-Id: <1548604232-19159-5-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548604232-19159-1-git-send-email-zhouyanjie@zoho.com>
References: <1548517123-60058-2-git-send-email-zhouyanjie@zoho.com>
 <1548604232-19159-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for probing the irq-ingenic driver on the X1000 Soc.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt
index d4373d0..fa69b3f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt
@@ -8,6 +8,7 @@ Required properties:
     ingenic,jz4770-intc
     ingenic,jz4775-intc
     ingenic,jz4780-intc
+    ingenic,x1000-intc
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
-- 
2.7.4


