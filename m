Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FADC282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71352077B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5pnJnzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfBJRxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:53:45 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36464 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfBJRxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:53:42 -0500
Received: by mail-ot1-f67.google.com with SMTP id k98so13934581otk.3;
        Sun, 10 Feb 2019 09:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FGFWf5U9CHtZ6FB5zlzDIcFUgfeHDErZdPOql/NjREc=;
        b=U5pnJnzi48HrxK6RxIa5OSjwz0/2L0TQnyMRZ4Tm+xif1YMbHJprB+onmSkF2bd457
         DsUlwbe3TNherXstL0/xa8GSJTebXKNK4gO0d5y4Y2zdW7B03a5p1fCLufp8OitBK05k
         WaZIeT1P/JpV3JLoxf53pdjUO/h3jYfUcKvRecTyeOS0EUPrvv6BYEhM+m0T+lxCrDQl
         iqe1wuEefekU9BAA0yxQo6iqXW1LPvRbMWdb+lEKkARsPYXlY8jY6+eQL5RRreJqpeti
         mfbnXUlrwOUCKp07hcg4aovGARIy8DLLsbmVWHC4uDeU8RyL5zCTKLMP7GwqP74+a54B
         jv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FGFWf5U9CHtZ6FB5zlzDIcFUgfeHDErZdPOql/NjREc=;
        b=FwKhcWJhmiJU8mzwJox3S+qz81WFARF5V2Yx/XGmVz23b73i9wtv/lgiaqi767waO1
         vS3IzO2EQmdvFloiz8aOCosVYRywrIvsNqjI9nopVIzNsriC+cBGF9XmrkkfUWFavBfT
         mb6TD/KBrueSlrR4Phawp/QJVD2fIqb8oxN/Wo/K5QTnWRmtHxgHqHwXkVCEIGJ6x7Wv
         3CPYSGskfHoyvbo7IiN592Z5zZkVD4pJw6hZwyRrJlesMY9k5abg+kM66bKuaQ1MQ8Zq
         OdrxZSY2tVWCVF6MOqFJ/cYcERPsMJFn9mvPS7JXvyGoAr138aOX3K54uwYWjr37XKBU
         7Exg==
X-Gm-Message-State: AHQUAuYKuZOBQUeOWLnd2DQMVHn7ivu36oZGd3gO2O4FM0OC080JV7En
        4gWsRUFe387RKTqmEMNEQVudd9hE
X-Google-Smtp-Source: AHgI3IYnbsH0T0Kkg1sBRApGT119FUb2sKgSgsAfs0yaTQs20rVc/5IIpKXHVpRcpJK2fBXZyc7poA==
X-Received: by 2002:a9d:629a:: with SMTP id x26mr1123244otk.173.1549821221134;
        Sun, 10 Feb 2019 09:53:41 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id n9sm3156425otq.14.2019.02.10.09.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 09:53:40 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 14/16] staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_SET
Date:   Sun, 10 Feb 2019 09:51:03 -0800
Message-Id: <20190210175105.31629-15-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare ethsw to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and simply translate that into the existing
swdev_port_attr_set() call.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index b195b09e0d1d..8baa503d9a6a 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1092,6 +1092,20 @@ ethsw_switchdev_port_obj_event(unsigned long event, struct net_device *netdev,
 	return notifier_from_errno(err);
 }
 
+static int
+ethsw_switchdev_port_attr_set_event(unsigned long event,
+		struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err;
+
+	err = swdev_port_attr_set(netdev, port_attr_info->attr,
+				  port_attr_info->trans);
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int port_switchdev_blocking_event(struct notifier_block *unused,
 					 unsigned long event, void *ptr)
 {
@@ -1104,6 +1118,8 @@ static int port_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return ethsw_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return ethsw_switchdev_port_attr_set_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.19.1

