Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82D7C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6348B20882
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APMAb0vU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6348B20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeIKUlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:41:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43254 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeIKUlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:41:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id v66-v6so12440078pgb.10;
        Tue, 11 Sep 2018 08:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pKEkc2tvcOE8G8y58khm5CYcoLAutEkQV+PTNPLvm00=;
        b=APMAb0vU7f4wZbLe3BamWnMXw+AQvtWDssjWUEdgVXdsyMYtqhZ+wSi2k4Qi1LFISZ
         bR5FAbWn7286EkDoX+fztJfgyeAi53MSKib1TJSqpOZJo2fjPU+8NcP2ZspmynhSLcdO
         gkQp9BDYc9Q+HeqVtz4yAEGogkHTzNn4PkZ45mddYuWThC44minf5b8UTxnU8a+fo6OP
         i25kdLNKhCdBKOZtHxKCXWnHYN5hW2HFEPW3whJoYCHFnajgxWXJfqWBLi4Rpu97CMJx
         dDWo3vy4/K4FmLslzLAw5bj5BRH1TBKCxnaTdtXvcVtvZyGeujFUF8w6PVlkWH5Q88Pz
         311w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pKEkc2tvcOE8G8y58khm5CYcoLAutEkQV+PTNPLvm00=;
        b=oP8tzAMo894gV2MuWBkQJz3bAvDUpDNfJyeq9OhrciJTvGlzlFGKTIpowYFeyheDMn
         tUvW366a8b6q0zLxVMr1Fjy/wSS4dxKZ3te0eKOhqAhPrtggFdFUlIi3w56Lt/AXpbgG
         J6RbmKL5qXn0wSg8Qj3Pr0fpstE4LDI/IsHhD2lv+6VHbzYpoZmzoCfo6v1NrlaUiunT
         1n4JvaM6FxoXMX6NHL3mJLb5P509XfdVKWJ1lQKSsbo6hKgix1zcuxN7ldlyTobwsQ27
         fkB7lsqWIxXmhrztzLcH01zTXY288VgQm2VDWqy09lN5oyBunaQIeYtino5Ka77m0+dy
         kh9w==
X-Gm-Message-State: APzg51D2SMDAp8360XwClLBRHvI2LrmUU7RNHKtQzyfSZc92yYzU2OrJ
        mz3y3WehEhfKUCCyjTuUvew=
X-Google-Smtp-Source: ANB0Vdb8MEMRNXSADNJg6nfdFkRxxLHpA3a8hdH14OFcE7Ghjl+QLmINRAkUiH7GCO8HPDO4VDmRgQ==
X-Received: by 2002:a63:9409:: with SMTP id m9-v6mr29221615pge.13.1536680485293;
        Tue, 11 Sep 2018 08:41:25 -0700 (PDT)
Received: from localhost.localdomain ([103.224.155.47])
        by smtp.googlemail.com with ESMTPSA id n83-v6sm35944434pfk.19.2018.09.11.08.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 08:41:24 -0700 (PDT)
From:   Jagdish Tirumala <t.jag587@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [PATCH] Bluetooth: hci_serdev: Fixed error space required before open paranethesis
Date:   Tue, 11 Sep 2018 08:40:38 -0700
Message-Id: <20180911154038.2142-1-t.jag587@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed error in space required before paranthesis
in drivers/bluetooth/hci_serdev.c

Signed-off-by: Jagdish Tirumala <t.jag587@gmail.com>
---
 drivers/bluetooth/hci_serdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index aa2543b3c286..d41c520e8970 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -94,7 +94,7 @@ static void hci_uart_write_work(struct work_struct *work)
 			hci_uart_tx_complete(hu, hci_skb_pkt_type(skb));
 			kfree_skb(skb);
 		}
-	} while(test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state));
+	} while (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state));
 
 	clear_bit(HCI_UART_SENDING, &hu->tx_state);
 }
-- 
2.17.1

