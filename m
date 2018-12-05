Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF65FC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA69A20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039620;
	bh=uSlJ7yIkrNASV5wOuMqLU7qH6qdI8ERc8pheAF4hSsQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Q2CwOyWVZ4LE83xD5FYcJXQVjxVeS/svwQCMaFLMxn9ou3fBCHwJMHXAAJDgeUCo0
	 Q3xFRpJmVrBeK1juPDfmGKqz51ksaU4BJxYuprJqceQjWmCA51R8W9HW3Iy/Z1C5VF
	 YiEshZdzNCoCqja5gxr51gfTpU/DauV2Hw+cLGM4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA69A20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbeLETxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:53:39 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43180 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbeLETvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:51:02 -0500
Received: by mail-oi1-f196.google.com with SMTP id u18so18623373oie.10;
        Wed, 05 Dec 2018 11:51:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SJ9ws45Vv3vAPydB9eOaRCa8LnZGc1t7yjxAlBirVB0=;
        b=a7SEdWWKb7lD1EA4Ekt+36TeN74a0F9+ZfvPbHtJovekSXt4tFRC53UITgZn58IxJx
         8q0hP7CGo3fUe/c7kq+5oIeKn00bf8Q/+5XuyQ4crZbUQYUnG518JMt+D4aWa/I8xdHz
         bwY/d/NxWnLNxmjvWC8TeGUhQ6Z7VJvQQJK+6hwJIzbKYxTwYW6LLe+ODuElhnwlJShP
         oEYcPgFN6+rbTW308KtDJ4flpzsByIIF+oRIamG8+W0oFVLgqL9YR0447zFXLxLHz2wY
         LSinGTd7guD00VOhHbXbL8SrJcp+ADg2ZzVTXdy8H0DnodORn8CzjYD3h0U2+XVebSQ7
         IgSQ==
X-Gm-Message-State: AA+aEWbe+SomKoVD+AdyiJfhafz1DDq1HTCGqSRXGaGIfKKLh+rktTwn
        INbhoApkWbAMbBTB5lpr7tRwiqY=
X-Google-Smtp-Source: AFSGD/X7aKQeZVng8JR2Bng8ewJcNCzuYa1uBshwFTyi0QJEfHBCA2uykUhLxJDIWg2UCxw4bvZniA==
X-Received: by 2002:aca:da02:: with SMTP id r2mr15033923oig.66.1544039461139;
        Wed, 05 Dec 2018 11:51:01 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:51:00 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ide: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:25 -0600
Message-Id: <20181205195050.4759-9-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-ide@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/ide/pmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index c5b902b86b44..ec46aa84d18d 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -1045,7 +1045,7 @@ static int pmac_ide_setup_device(pmac_ide_hwif_t *pmif, struct ide_hw *hw)
 		d.port_ops = &pmac_ide_ata4_port_ops;
 		d.udma_mask = ATA_UDMA5;
 	} else if (of_device_is_compatible(np, "keylargo-ata")) {
-		if (strcmp(np->name, "ata-4") == 0) {
+		if (of_node_name_eq(np, "ata-4")) {
 			pmif->kind = controller_kl_ata4;
 			d.port_ops = &pmac_ide_ata4_port_ops;
 			d.udma_mask = ATA_UDMA4;
-- 
2.19.1

