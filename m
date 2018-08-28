Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C06EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A7C214C1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A7C214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeH1FmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:42:14 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38759 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeH1FmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:42:13 -0400
Received: by mail-oi0-f65.google.com with SMTP id x197-v6so14338oix.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 18:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FIlqiwbxmyq+1NLBpi9+7kMnKdv5zmm5EjPQT9vSv2A=;
        b=CchUbzw/NPRx7d2VLCIcDtVYBfghcPNRIjz1N0eHqTDZKQwYVYGlZJXcIYiL6KMBW/
         1pwj3vyFyh0930aKAQn4kEhoIu3hnQ+Mc5YEy69oUWiZEvtQjRff9jq5GtHc/TXtb4N7
         H6AnanQd+FAH5+qKUhlrGiKlOQ/0DiLn253z3S2deLZmtWGejHYnS2nQxR9kQpArjtA3
         uPWvAhmmyNaQk/+tyWWs6Xr+f3eEVX6oYHPdEeXummlrCHPrkrg90Uk46NlO7GLRMRAP
         mLnoP9RLkOCYriVCJJ0MC/o6yWRx3DSN24IjkvzxsbGUR3o9W7tNTeC8Hs9DCHqoNbmz
         BucA==
X-Gm-Message-State: APzg51DhlukDEccS68KnaR1zrY/f0qONfffCTdxlIPQHR3CVi4DSF0/I
        P0C3ul1KzB+UAHiGmP3jCkjjp28=
X-Google-Smtp-Source: ANB0VdaGHvNfUC9yw4DZrBNHnoHN9mDN4WXaFVI0RPtKz+ultWcUAUl0MO1GqJy/xBikvrqCm7bZjg==
X-Received: by 2002:aca:3a57:: with SMTP id h84-v6mr1072882oia.336.1535421177409;
        Mon, 27 Aug 2018 18:52:57 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:52:56 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:05 -0500
Message-Id: <20180828015252.28511-4-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/mips/cavium-octeon/octeon-irq.c | 16 ++++++++--------
 arch/mips/netlogic/common/irq.c      | 14 +++++++-------
 arch/mips/ralink/cevt-rt3352.c       |  6 +++---
 arch/mips/ralink/ill_acc.c           |  2 +-
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 8272d8c648ca..cc1d8525e651 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -1180,8 +1180,8 @@ static int octeon_irq_gpio_xlat(struct irq_domain *d,
 		type = IRQ_TYPE_LEVEL_LOW;
 		break;
 	default:
-		pr_err("Error: (%s) Invalid irq trigger specification: %x\n",
-		       node->name,
+		pr_err("Error: (%pOFn) Invalid irq trigger specification: %x\n",
+		       node,
 		       trigger);
 		type = IRQ_TYPE_LEVEL_LOW;
 		break;
@@ -2271,8 +2271,8 @@ static int __init octeon_irq_init_cib(struct device_node *ciu_node,
 
 	parent_irq = irq_of_parse_and_map(ciu_node, 0);
 	if (!parent_irq) {
-		pr_err("ERROR: Couldn't acquire parent_irq for %s\n",
-			ciu_node->name);
+		pr_err("ERROR: Couldn't acquire parent_irq for %pOFn\n",
+			ciu_node);
 		return -EINVAL;
 	}
 
@@ -2283,7 +2283,7 @@ static int __init octeon_irq_init_cib(struct device_node *ciu_node,
 
 	addr = of_get_address(ciu_node, 0, NULL, NULL);
 	if (!addr) {
-		pr_err("ERROR: Couldn't acquire reg(0) %s\n", ciu_node->name);
+		pr_err("ERROR: Couldn't acquire reg(0) %pOFn\n", ciu_node);
 		return -EINVAL;
 	}
 	host_data->raw_reg = (u64)phys_to_virt(
@@ -2291,7 +2291,7 @@ static int __init octeon_irq_init_cib(struct device_node *ciu_node,
 
 	addr = of_get_address(ciu_node, 1, NULL, NULL);
 	if (!addr) {
-		pr_err("ERROR: Couldn't acquire reg(1) %s\n", ciu_node->name);
+		pr_err("ERROR: Couldn't acquire reg(1) %pOFn\n", ciu_node);
 		return -EINVAL;
 	}
 	host_data->en_reg = (u64)phys_to_virt(
@@ -2299,8 +2299,8 @@ static int __init octeon_irq_init_cib(struct device_node *ciu_node,
 
 	r = of_property_read_u32(ciu_node, "cavium,max-bits", &val);
 	if (r) {
-		pr_err("ERROR: Couldn't read cavium,max-bits from %s\n",
-			ciu_node->name);
+		pr_err("ERROR: Couldn't read cavium,max-bits from %pOFn\n",
+			ciu_node);
 		return r;
 	}
 	host_data->max_bits = val;
diff --git a/arch/mips/netlogic/common/irq.c b/arch/mips/netlogic/common/irq.c
index f4961bc9a61d..cf33dd8a487e 100644
--- a/arch/mips/netlogic/common/irq.c
+++ b/arch/mips/netlogic/common/irq.c
@@ -291,7 +291,7 @@ static int __init xlp_of_pic_init(struct device_node *node,
 	/* we need a hack to get the PIC's SoC chip id */
 	ret = of_address_to_resource(node, 0, &res);
 	if (ret < 0) {
-		pr_err("PIC %s: reg property not found!\n", node->name);
+		pr_err("PIC %pOFn: reg property not found!\n", node);
 		return -EINVAL;
 	}
 
@@ -304,21 +304,21 @@ static int __init xlp_of_pic_init(struct device_node *node,
 				break;
 		}
 		if (socid == NLM_NR_NODES) {
-			pr_err("PIC %s: Node mapping for bus %d not found!\n",
-					node->name, bus);
+			pr_err("PIC %pOFn: Node mapping for bus %d not found!\n",
+					node, bus);
 			return -EINVAL;
 		}
 	} else {
 		socid = (res.start >> 18) & 0x3;
 		if (!nlm_node_present(socid)) {
-			pr_err("PIC %s: node %d does not exist!\n",
-							node->name, socid);
+			pr_err("PIC %pOFn: node %d does not exist!\n",
+							node, socid);
 			return -EINVAL;
 		}
 	}
 
 	if (!nlm_node_present(socid)) {
-		pr_err("PIC %s: node %d does not exist!\n", node->name, socid);
+		pr_err("PIC %pOFn: node %d does not exist!\n", node, socid);
 		return -EINVAL;
 	}
 
@@ -326,7 +326,7 @@ static int __init xlp_of_pic_init(struct device_node *node,
 		nlm_irq_to_xirq(socid, PIC_IRQ_BASE), PIC_IRQ_BASE,
 		&xlp_pic_irq_domain_ops, NULL);
 	if (xlp_pic_domain == NULL) {
-		pr_err("PIC %s: Creating legacy domain failed!\n", node->name);
+		pr_err("PIC %pOFn: Creating legacy domain failed!\n", node);
 		return -EINVAL;
 	}
 	pr_info("Node %d: IRQ domain created for PIC@%pR\n", socid, &res);
diff --git a/arch/mips/ralink/cevt-rt3352.c b/arch/mips/ralink/cevt-rt3352.c
index 92f284d2b802..61a08943eb2f 100644
--- a/arch/mips/ralink/cevt-rt3352.c
+++ b/arch/mips/ralink/cevt-rt3352.c
@@ -134,7 +134,7 @@ static int __init ralink_systick_init(struct device_node *np)
 	systick.dev.min_delta_ticks = 0x3;
 	systick.dev.irq = irq_of_parse_and_map(np, 0);
 	if (!systick.dev.irq) {
-		pr_err("%s: request_irq failed", np->name);
+		pr_err("%pOFn: request_irq failed", np);
 		return -EINVAL;
 	}
 
@@ -146,8 +146,8 @@ static int __init ralink_systick_init(struct device_node *np)
 
 	clockevents_register_device(&systick.dev);
 
-	pr_info("%s: running - mult: %d, shift: %d\n",
-			np->name, systick.dev.mult, systick.dev.shift);
+	pr_info("%pOFn: running - mult: %d, shift: %d\n",
+			np, systick.dev.mult, systick.dev.shift);
 
 	return 0;
 }
diff --git a/arch/mips/ralink/ill_acc.c b/arch/mips/ralink/ill_acc.c
index 765d5ba98fa2..fc056f2acfeb 100644
--- a/arch/mips/ralink/ill_acc.c
+++ b/arch/mips/ralink/ill_acc.c
@@ -62,7 +62,7 @@ static int __init ill_acc_of_setup(void)
 
 	pdev = of_find_device_by_node(np);
 	if (!pdev) {
-		pr_err("%s: failed to lookup pdev\n", np->name);
+		pr_err("%pOFn: failed to lookup pdev\n", np);
 		return -EINVAL;
 	}
 
-- 
2.17.1

