Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F01C43143
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921D020645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921D020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeIFAJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:09:23 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39618 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbeIFAJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:09:23 -0400
Received: by mail-oi0-f66.google.com with SMTP id c190-v6so15916934oig.6;
        Wed, 05 Sep 2018 12:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fYOg6CktF2xwcGxesRIbKcKZKAY1qmPWe//TJ6Jiv44=;
        b=jfJk8ISVLU/8vHZXiB/KdbiO6GEA8ZxuAqyaLVzMpEbn5PcIH+8ODxM/FASaLGfjS/
         fOwhh/Z/ImfSZLjgaI0OTTkw0vhj3W0EtEaIYCLsc8pz0fyWfDzsgPzXo4IIzcE/+FlI
         v7z4ZqhxhG0F+y+IzUWrR8lhZRO0YFeeAcB0l0ZRGwKID750uyUfgwlfwzOuC29rxccK
         8GbpEl6GHJUm+jeNL0bImQerepGRnPzP3VFG5mGaCcLuYHOPb52H2vpBzjWIM6Vx75t+
         GUsM6PMf5/zYSywThejnxtdq9LH5723vXl2TOQU4PJJQB/Q1JqZXDN3Syd2h+dMVJVSj
         Lz5w==
X-Gm-Message-State: APzg51AMCAl4KrKxYLOKMvMu5iHOy6gP3MzRblxKhRVbZ0DCu06Whg6N
        vE4VK9Ku8nYQo1si7lmS4Fx1wyE=
X-Google-Smtp-Source: ANB0VdY00GxhIZGZS6lmoqJG8rvuo9od539tY3aFC/aj35nIStsIU7yX6DwIA2lpLe4vzA3bwzg32Q==
X-Received: by 2002:aca:3ad4:: with SMTP id h203-v6mr30022138oia.294.1536176264613;
        Wed, 05 Sep 2018 12:37:44 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm2296053oie.22.2018.09.05.12.37.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:37:44 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/21] ARM: topology: remove unneeded check for /cpus node
Date:   Wed,  5 Sep 2018 14:37:21 -0500
Message-Id: <20180905193738.19325-5-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905193738.19325-1-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking for "/cpus" node is not necessary as of_get_cpu_node() will fail
later on anyways. The call to of_find_node_by_path() also leaks a
reference. So just remove the check.

Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 arch/arm/kernel/topology.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 24ac3cab411d..60e375ce1ab2 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -94,12 +94,6 @@ static void __init parse_dt_topology(void)
 	__cpu_capacity = kcalloc(nr_cpu_ids, sizeof(*__cpu_capacity),
 				 GFP_NOWAIT);

-	cn = of_find_node_by_path("/cpus");
-	if (!cn) {
-		pr_err("No CPU information found in DT\n");
-		return;
-	}
-
 	for_each_possible_cpu(cpu) {
 		const u32 *rate;
 		int len;
--
2.17.1
