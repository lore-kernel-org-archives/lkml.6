Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D062C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23BC20658
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23BC20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeH1Foc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:44:32 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41122 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbeH1Fob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:31 -0400
Received: by mail-oi0-f67.google.com with SMTP id k12-v6so1555oiw.8;
        Mon, 27 Aug 2018 18:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NZktRJlPfF/Z+FbZBVB7Rm97KZRfYNx+6jHhruSk10Y=;
        b=DcbhxfOsyOVRVf2uGHWIxQfNGa8NQWkYoQcV//aI9NlqdJSzudyxDgIVUI7HSEFjHO
         IT4BwzIKdsLosBvjshR+5DaJYVcT4V2iHX5nww9H170QmQNOw1LgYmoNjgacZrY4+2ZH
         YdfoqDKQn9tfeGbEX3ZWT8oWhl2YPKCNgyIwAIhTdLmltSx6ebRjzjrfKH+QFfDNU5Lg
         1g/Ial4yoZBQX6Cy7WVFHz+UMRhpfxZi5yuA0fNzwOOJL6TGyk2cS200VWXCDOl4TBd9
         ysMl6+f/VArT6VV1Be5o3IxNbqEsRt2rZ/NpqdgikbY2vqDlzhzYmnvByZDBmAC0u8mo
         yWug==
X-Gm-Message-State: APzg51CDFavmJIArZsc7/gWhrG/VLZOOUugf4pTDqVS7R5n7qAUBO4rz
        XnqBFZBeIFhchWWkH2bduFwJTjQ=
X-Google-Smtp-Source: ANB0VdZh9nynkNZmbboRVnKlpyen6fVhMf0UVVMig7iPC45snRM2PKOMNMsSlQvQmP5UfOC/D1xOqA==
X-Received: by 2002:aca:5905:: with SMTP id n5-v6mr1202898oib.232.1535421314964;
        Mon, 27 Aug 2018 18:55:14 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:55:14 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] tty: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:47 -0500
Message-Id: <20180828015252.28511-46-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-serial@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/tty/ehv_bytechan.c                  | 12 ++++++------
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |  8 ++++----
 drivers/tty/serial/pmac_zilog.c             |  4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
index eea4049b5dcc..769e0a5d1dfc 100644
--- a/drivers/tty/ehv_bytechan.c
+++ b/drivers/tty/ehv_bytechan.c
@@ -128,8 +128,8 @@ static int find_console_handle(void)
 	 */
 	iprop = of_get_property(np, "hv-handle", NULL);
 	if (!iprop) {
-		pr_err("ehv-bc: no 'hv-handle' property in %s node\n",
-		       np->name);
+		pr_err("ehv-bc: no 'hv-handle' property in %pOFn node\n",
+		       np);
 		return 0;
 	}
 	stdout_bc = be32_to_cpu(*iprop);
@@ -661,8 +661,8 @@ static int ehv_bc_tty_probe(struct platform_device *pdev)
 
 	iprop = of_get_property(np, "hv-handle", NULL);
 	if (!iprop) {
-		dev_err(&pdev->dev, "no 'hv-handle' property in %s node\n",
-			np->name);
+		dev_err(&pdev->dev, "no 'hv-handle' property in %pOFn node\n",
+			np);
 		return -ENODEV;
 	}
 
@@ -682,8 +682,8 @@ static int ehv_bc_tty_probe(struct platform_device *pdev)
 	bc->rx_irq = irq_of_parse_and_map(np, 0);
 	bc->tx_irq = irq_of_parse_and_map(np, 1);
 	if ((bc->rx_irq == NO_IRQ) || (bc->tx_irq == NO_IRQ)) {
-		dev_err(&pdev->dev, "no 'interrupts' property in %s node\n",
-			np->name);
+		dev_err(&pdev->dev, "no 'interrupts' property in %pOFn node\n",
+			np);
 		ret = -ENODEV;
 		goto error;
 	}
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index 24a5f05e769b..ea7204d75022 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1151,8 +1151,8 @@ static int cpm_uart_init_port(struct device_node *np,
 	if (!pinfo->clk) {
 		data = of_get_property(np, "fsl,cpm-brg", &len);
 		if (!data || len != 4) {
-			printk(KERN_ERR "CPM UART %s has no/invalid "
-			                "fsl,cpm-brg property.\n", np->name);
+			printk(KERN_ERR "CPM UART %pOFn has no/invalid "
+			                "fsl,cpm-brg property.\n", np);
 			return -EINVAL;
 		}
 		pinfo->brg = *data;
@@ -1160,8 +1160,8 @@ static int cpm_uart_init_port(struct device_node *np,
 
 	data = of_get_property(np, "fsl,cpm-command", &len);
 	if (!data || len != 4) {
-		printk(KERN_ERR "CPM UART %s has no/invalid "
-		                "fsl,cpm-command property.\n", np->name);
+		printk(KERN_ERR "CPM UART %pOFn has no/invalid "
+		                "fsl,cpm-command property.\n", np);
 		return -EINVAL;
 	}
 	pinfo->command = *data;
diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index 3d21790d961e..a4ec22d1f214 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1566,9 +1566,9 @@ static int pmz_attach(struct macio_dev *mdev, const struct of_device_id *match)
 	 * to work around bugs in ancient Apple device-trees
 	 */
 	if (macio_request_resources(uap->dev, "pmac_zilog"))
-		printk(KERN_WARNING "%s: Failed to request resource"
+		printk(KERN_WARNING "%pOFn: Failed to request resource"
 		       ", port still active\n",
-		       uap->node->name);
+		       uap->node);
 	else
 		uap->flags |= PMACZILOG_FLAG_RSRC_REQUESTED;
 
-- 
2.17.1

