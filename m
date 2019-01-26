Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C55C282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B210A21906
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="t8tTbEgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfAZPl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 10:41:59 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25440 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfAZPl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 10:41:58 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548517244; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=Q5GFpBRCG4nJuTtDdnjZKmfAr3wwbOK0SdbP6NPx3YcRu6iycxXjki7+XL+fc5vUr2/dt2wunuMKOF7I1TM6tK2pZH0mvuidpCGUa5YyWW0ChYGDWEbj3WhQTMP54ppEzZm9F2rW8s5+mu/mseouKwY1oYv4uHMU3G8wMc6Qitc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548517244; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=N6teaqVxhuf2qKCXnWrscSgmJF+o+tkdXKbnyxIiobI=; 
        b=cl5Tw5WhWQuZBT1O/oDxCcsGa1UJ1vUWYS9I+kPbOWwZDYGb2p0fE1CJyRx1a98EvTe4AW+xejsl9U3tppC33FV6zYDKId52UsCqRmxhGeAoStlczWLc717G1T9zO8MxTcyyxCZN8TAoEtNQavzYTjwb/nEAa3zl9A3Cqj6Tzn4=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=Ffdd3MS5rHsF3JQPfYUVdIpkgN0se8Ka8wKwa0vrY77dJufDoMn2ln1JZ1WjCfVP19ac9mcyrDks
    jeufBM7YesB6PIn2AGXmSe+ZHvQrg5y9q3L845HpKhXePc663SfD  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548517244;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=1059; bh=N6teaqVxhuf2qKCXnWrscSgmJF+o+tkdXKbnyxIiobI=;
        b=t8tTbEgps0mIV+y0b0SiXl4sBg1Upugyso5NQm1Dhds8drNirGATTOzJn+a/sr/U
        yMdm8q0r9ArmFuQde6IDpfNgJQmhcTqR8OTr2xVb+KPpqGYp8vUFEakgPSOWhOtOZo0
        dfBfaCu77/f0VE2uv9GSLlF69cyn2EZ2jjjl2q3s=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548517242318369.82441176351415; Sat, 26 Jan 2019 07:40:42 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, jason@lakedaemon.net, tglx@linutronix.de,
        syq@debian.org, jiaxun.yang@flygoat.com, 772753199@qq.com
Subject: [PATCH 4/4] Irqchip: Ingenic: Add support for the X1000.
Date:   Sat, 26 Jan 2019 23:38:43 +0800
Message-Id: <1548517123-60058-5-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548517123-60058-1-git-send-email-zhouyanjie@zoho.com>
References: <1548517123-60058-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for probing the irq-ingenic driver on the X1000 Soc.
X1000 is a 1.0GHz processor for IoT. It has MIPS32 XBurst RISC core
with double precision hardware float point unit.

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


