Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC95C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF47208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF47208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeH1FmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:42:19 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33223 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH1FmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:42:18 -0400
Received: by mail-oi0-f67.google.com with SMTP id 8-v6so46514oip.0;
        Mon, 27 Aug 2018 18:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zUZ0xxJM/1G1FFbtrT1BhDYi60fIfX55RpU7cbgPW0U=;
        b=aFQgd7jrdcp+xyKyYPc0nLcfOt3zSkz39F48sjjph5sq5S+7cOhez9UukqAfsU2TzF
         Lw9ixsXVJmTMNOiMEmdkq8q6hYvjzEGLAUo8RE87bAIos8BuEhRuw2e4E5cgtHTMPC5f
         LZ8yLWoJgEJN7LjgyYmXzJpA2QyuDD4/E2WDt7c8GjfBgv39CnV423E7jbNm9QybWSOx
         LGjUwzri68qXaKF8E5x4mw6sBUtlYBCLw03mK2aFERkRjqel0dPSxhvFljFWyNM7Da+p
         6FgTOU6eAYskbFAQ+jP+ZIYpe2gb9Z+XjkFId8su/Ae1wBLnFQ0IGKmLJ/Ub8Ra5HZ8V
         WcAA==
X-Gm-Message-State: APzg51CjL1k9wfU4uMft/cdpvDqt4Qk8H1HMX7xfOlbYvxYgJBhgSHtW
        9VnYKoSpGjrRv/iVEuYSS2u/qFk=
X-Google-Smtp-Source: ANB0VdYpQg9pSA42R0xDQwQBVymXqAg+J9wpifuHWeWL7PLhbzLSg5iVxBtED4Pv56N/HN8IA8Eiig==
X-Received: by 2002:aca:c74d:: with SMTP id x74-v6mr980572oif.97.1535421182518;
        Mon, 27 Aug 2018 18:53:02 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:53:01 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH] ata: ahci: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:10 -0500
Message-Id: <20180828015252.28511-9-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/ata/libahci_platform.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index c92c10d55374..8ac2be869dd9 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -303,8 +303,8 @@ static int ahci_platform_get_phy(struct ahci_host_priv *hpriv, u32 port,
 		/* No PHY support. Check if PHY is required. */
 		if (of_find_property(node, "phys", NULL)) {
 			dev_err(dev,
-				"couldn't get PHY in node %s: ENOSYS\n",
-				node->name);
+				"couldn't get PHY in node %pOFn: ENOSYS\n",
+				node);
 			break;
 		}
 		/* fall through */
@@ -316,8 +316,8 @@ static int ahci_platform_get_phy(struct ahci_host_priv *hpriv, u32 port,
 
 	default:
 		dev_err(dev,
-			"couldn't get PHY in node %s: %d\n",
-			node->name, rc);
+			"couldn't get PHY in node %pOFn: %d\n",
+			node, rc);
 
 		break;
 	}
-- 
2.17.1

