Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4513C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC6720855
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVw0VsGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbfAaDyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:54:19 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:35091 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfAaDyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:54:19 -0500
Received: by mail-qt1-f201.google.com with SMTP id p24so2221278qtl.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 19:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fnyzfi4yjVwz7Fyg+QDUndSTcoOupKEHKb/Z+jqY0/I=;
        b=wVw0VsGB3/bfde3sRiFR5/NSPzbTZVVA0Zoenf5cxc7HsgEM2ADLI7PyQ9ZRkeqjAo
         qFyICs8Hwj137HvaW7AphmwBVN4f33JEhwigZv7o1afl05FdLuMVb0GZKZgGM3xOu3gu
         NsDghCQk2MopTqhu9F8XpIhCARVrNUjk+l1tEnl2eYSCD5+ESegXWdo/nvRSPmHpaYp7
         KWt+gHIulgVYQ1P6PDjN+MLhx2Z+WvtTvT6iQ7sYJUzQ1NxXHXTKSNGCCZ9pLZp4cFrI
         vxeN50qao/QJ6LoiDzSVj78TMzcq9ZxTosJF0mBUaqDCIsLrHJe8O9/0NH3PdaazeyrY
         G6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fnyzfi4yjVwz7Fyg+QDUndSTcoOupKEHKb/Z+jqY0/I=;
        b=i1EieGMbU6o9WCMdaMrhySpi31y2f52WBETzqLwVt2sf9SPbzCF5teZtZwgVoZ5gSw
         m5hq53gzI+Q2vRc7Qihv5zDhyGRwZHGPhMHUVdz0extH4rIoXMEgTq3rzAadqJCgc5Gd
         DgxqN/kjAz6gYExB6u/7gJs+xZOnPYAp6e7dnn/lK51k1mzCqWw2q3JmvHdIBdJxu4n0
         QVLUNMR+6+zws2Frgn99MJd+Xc8c2B63ogMaefB28aBaVyD85y2CXTplmz1SbEngIGtA
         tRe1IFVZiWCwvlKNq4X1vEigvLTgs5RCIzOmTxu481FRBubgryuWCPtE9QVbJf3JfnGX
         vvTA==
X-Gm-Message-State: AHQUAuZQkXviTXC7thAI+pJ0SArWkHRoRjR7bJch7AzYByBNPWr6VsVD
        VQmOkSEKOus9GD7sZDf6lba4AODheh9W
X-Google-Smtp-Source: ALg8bN4LCQcrGgLGwmMNMvispYuVuT5K2DECeZwh5Hs0JJOMGFKD+sP2QewlgATLDVE3y2g6vbm3Ulo4Cxy9
X-Received: by 2002:ac8:17af:: with SMTP id o44mr8163254qtj.24.1548906858039;
 Wed, 30 Jan 2019 19:54:18 -0800 (PST)
Date:   Thu, 31 Jan 2019 11:54:11 +0800
Message-Id: <20190131035411.53576-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
Subject: [PATCH] usb: typec: tcpm: Export partner Source Capabilities
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a function to get the partner Source Capabilities.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 23 +++++++++++++++++++++++
 include/linux/usb/tcpm.h      |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index f1d3e54210df..29cd84ba9960 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4494,6 +4494,29 @@ int tcpm_update_sink_capabilities(struct tcpm_port *port, const u32 *pdo,
 }
 EXPORT_SYMBOL_GPL(tcpm_update_sink_capabilities);
 
+/*
+ * Don't call this function in interrupt context. Caller needs to free the
+ * memory itself.
+ */
+int tcpm_get_partner_src_caps(struct tcpm_port *port, u32 **src_pdo)
+{
+	unsigned int nr_pdo;
+
+	if (port->nr_source_caps == 0)
+		return -ENODATA;
+
+	*src_pdo = kcalloc(port->nr_source_caps, sizeof(u32), GFP_KERNEL);
+	if (!src_pdo)
+		return -ENOMEM;
+
+	mutex_lock(&port->lock);
+	nr_pdo = tcpm_copy_pdos(*src_pdo, port->source_caps,
+				port->nr_source_caps);
+	mutex_unlock(&port->lock);
+	return nr_pdo;
+}
+EXPORT_SYMBOL_GPL(tcpm_get_partner_src_caps);
+
 /* Power Supply access to expose source power information */
 enum tcpm_psy_online_states {
 	TCPM_PSY_OFFLINE = 0,
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 50c74a77db55..fe56d759567c 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -173,5 +173,6 @@ void tcpm_pd_transmit_complete(struct tcpm_port *port,
 			       enum tcpm_transmit_status status);
 void tcpm_pd_hard_reset(struct tcpm_port *port);
 void tcpm_tcpc_reset(struct tcpm_port *port);
+int tcpm_get_partner_src_caps(struct tcpm_port *port, u32 **pdo);
 
 #endif /* __LINUX_USB_TCPM_H */
-- 
2.20.1.495.gaa96b0ce6b-goog

