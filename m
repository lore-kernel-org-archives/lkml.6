Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E4CC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C2B2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="VL9jg9H+";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="pysE7kyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C2B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbeIGAKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:10:38 -0400
Received: from node.akkea.ca ([192.155.83.177]:40694 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbeIGAKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:10:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 1BE145420F0;
        Thu,  6 Sep 2018 19:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1536262023; bh=pl8iQv5Xs8vqp2I/bTrbJRdWs0RmqcAX9AMOI1isexs=;
        h=From:To:Cc:Subject:Date;
        b=VL9jg9H+OwOUyklxa3z0FKhASmM4+MSttC5FOGcCB9N+W8N2uTLz1eg8Kef/b9vMq
         /SATYMgMeweMw+cvJ88gzPOACr2yWo4J0WRNkcERc3vNWaxTyq5Dt2SAyRRARFk0pN
         iN63/vPWdVkPKAGjZsoCPWRYneQWtKX0IqUm9pjE=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TrWbLe468vYm; Thu,  6 Sep 2018 19:27:02 +0000 (UTC)
Received: from localhost.localdomain (S010614dae980e3b8.cg.shawcable.net [68.147.236.72])
        by node.akkea.ca (Postfix) with ESMTPSA id 4B6F45420EE;
        Thu,  6 Sep 2018 19:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1536262022; bh=pl8iQv5Xs8vqp2I/bTrbJRdWs0RmqcAX9AMOI1isexs=;
        h=From:To:Cc:Subject:Date;
        b=pysE7kyT3weFKa5CX3ngo3RsB06CwlH4Ga5JMR9Lh0iehRrQIfhj/I+5A4cJ2QZN1
         BVyZWhyw8pe94KfSVnTJHRCE/IRiSRB/UHGB8NKMOeGYAynrszO/mMQSHbAgmbS5Om
         2G2ompKUGbekpeWoIZhwfrWeCg8A78cd3vlyfp/4=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH] usb: typec: don't disable sink or source on initialization
Date:   Thu,  6 Sep 2018 13:26:44 -0600
Message-Id: <20180906192644.24587-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the board is being powered by USB disabling the source and sink
can remove power from the board. Default to source and sink enabled.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/usb/typec/tcpm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index ca7bedb46f7f..a1b819cf31da 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -2462,9 +2462,11 @@ static int tcpm_init_vbus(struct tcpm_port *port)
 {
 	int ret;
 
-	ret = port->tcpc->set_vbus(port->tcpc, false, false);
-	port->vbus_source = false;
-	port->vbus_charge = false;
+	/* default to source and sink enabled in case USB is our only power
+	 * source */
+	ret = port->tcpc->set_vbus(port->tcpc, true, true);
+	port->vbus_source = true;
+	port->vbus_charge = true;
 	return ret;
 }
 
-- 
2.17.1

