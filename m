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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA79C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 15:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEBB214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 15:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="d1XwGHkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfA0Px6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 10:53:58 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25421 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfA0Px6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 10:53:58 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548604350; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=e402abOJhfYEdqEx7IR6MNQhTy0pXk5BAj7ssgLZoYQIKnJDhU4bdmCZ9VNOavoKONFQON0U3ByLYIjejaS+t2j/xRRjgoCXsugdUhiRc+Dn9zWvcyJyd9HrIlZw0flrMOei1yEYGTZxQ2Ae5Bkhv8XXASM1LQCPV1yBTIsZRb0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548604350; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=Lfws+SrUczlVhQeNpWQFRPeyRaEDp8ULidmj4Ev13yc=; 
        b=XD6FvV1ZDNLABzrfK14vLkfFfeQYtX7gYfKJ8MTlG9r9fKMSU+xU04KfHNOtwmXhJ7skZMNMAeIgf+YAhOCm4okqdf6B2b7C5ikUnp+gO9XA/Da5NSA703PwpKZbW11d+V7A9HFJl4CwMkLda3GSCrVlie5GAjDBLqxXJ932rQc=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=oIRtoUId1HBg2MuxNmGdL2ER5HWWXS2FqZ+Y0R990krx0FJtRepcQs0VsOotxGi+UcVq7r2RdKWm
    nKYqkj9B/d+XEjY0koWeNZ0QRtuhpeMFFAW4r1RAfqEDJrX058DV  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548604350;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=770;
        bh=Lfws+SrUczlVhQeNpWQFRPeyRaEDp8ULidmj4Ev13yc=;
        b=d1XwGHkVSm2u/fjlJMzKnncO/XGrSFOnFL8lkq3/FQqjLI1fW+e3JHkOaiKw/qyN
        PdiDjIqZ3VDdcJAU439YKvAz5iGwFjo3h4yhRDQWcRf28QnN4XyVSvSDTY17iNb9eZn
        0sHyCD6ZtDMF0qShknjDH7FOaGuJBSImySmWPa6U=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548604348459936.5804509612525; Sun, 27 Jan 2019 07:52:28 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, jason@lakedaemon.net, tglx@linutronix.de,
        syq@debian.org, jiaxun.yang@flygoat.com, 772753199@qq.com
Subject: [PATCH v2 3/4] Irqchip: Ingenic: Add support for the X1000.
Date:   Sun, 27 Jan 2019 23:50:31 +0800
Message-Id: <1548604232-19159-4-git-send-email-zhouyanjie@zoho.com>
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
 drivers/irqchip/irq-ingenic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index 32d090a..814c68c 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -176,3 +176,4 @@ static int __init intc_2chip_of_init(struct device_node *node,
 IRQCHIP_DECLARE(jz4770_intc, "ingenic,jz4770-intc", intc_2chip_of_init);
 IRQCHIP_DECLARE(jz4775_intc, "ingenic,jz4775-intc", intc_2chip_of_init);
 IRQCHIP_DECLARE(jz4780_intc, "ingenic,jz4780-intc", intc_2chip_of_init);
+IRQCHIP_DECLARE(x1000_intc, "ingenic,x1000-intc", intc_2chip_of_init);
-- 
2.7.4


