Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EA6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F478206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="maLsgR67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfBVAa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:30:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34602 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfBVAa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:30:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id i130so256447pgd.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 16:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yaipkiEto6//B2LCDASYez8pzOCmttYr63wlq8gTkQU=;
        b=maLsgR67ikjNc2kG8WnI8HNrhyQDIQvEhBLb35V0PYl5r/pNv1e28VgM4bqgPhjwtH
         K5g5IHc7RU82W7NO3+EmdvRe2SjpHEuwLu4tZl+UypLjx9O9GU/Tx1LTMAndcMCSGYHK
         70vLVOfKxvEr4HQs8vRvyYEzGwjBRQHDokVSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yaipkiEto6//B2LCDASYez8pzOCmttYr63wlq8gTkQU=;
        b=NMR+B0Us6kMrkFo3EhCvEQAsKvfxG2jlB9VzoV03n0vYmHkOWpyf0oxHLONoSw4FZg
         UgKxWfq0GT27ifx2nqGM9i5X+dSsraJk9tq6DqsY7ZzD74wsP+0MePYSt6iBeakKLwTF
         fzp1eT0tgLynkfBnfniO2OKc+AAmbxPpijQmECf3zhVAVgye2MEEEkL/2n80BAZfsxoD
         ip0CrpnZVHOTWPWrP6m3/GW3nEZTgSYtdVCGKuEmnKf8up+dK7c5VKwQojoTx9SVM2oz
         Qz/SbGx0JVNsXYxsEJWu9Bnk4/F8ON+hFZ5MyR8x61uX31rqhXIgPhMUmRYIUTsjpfpt
         MfDw==
X-Gm-Message-State: AHQUAuZzl4npMv8hwj6lN4z8LVmghuKYfZL2HTslZitIGmzGXJ0GRP3/
        951d5Rj7vss3JcwtrJrfVdgm6w==
X-Google-Smtp-Source: AHgI3IbKXeA+X4k8N3vzESXPqAJbPdlIPcsUsPoNYEVykZhyzus7ytZGbA1+vD3LZPtfoxneL7Oi3A==
X-Received: by 2002:a63:c64f:: with SMTP id x15mr1242421pgg.16.1550795455497;
        Thu, 21 Feb 2019 16:30:55 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id v15sm265674pfa.75.2019.02.21.16.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 16:30:54 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] Bluetooth: btusb: request wake pin with NOAUTOEN
Date:   Thu, 21 Feb 2019 16:30:51 -0800
Message-Id: <20190222003051.127006-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Badly-designed systems might have (for example) active-high wake pins
that default to high (e.g., because of external pull ups) until they
have an active firmware which starts driving it low. This can cause an
interrupt storm in the time between request_irq() and disable_irq().

We don't support shared interrupts here, so let's just pre-configure the
interrupt to avoid auto-enabling it.

Fixes: fd913ef7ce61 ("Bluetooth: btusb: Add out-of-band wakeup support")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4761499db9ee..470ee68555d9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2885,6 +2885,7 @@ static int btusb_config_oob_wake(struct hci_dev *hdev)
 		return 0;
 	}
 
+	irq_set_status_flags(irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(&hdev->dev, irq, btusb_oob_wake_handler,
 			       0, "OOB Wake-on-BT", data);
 	if (ret) {
@@ -2899,7 +2900,6 @@ static int btusb_config_oob_wake(struct hci_dev *hdev)
 	}
 
 	data->oob_wake_irq = irq;
-	disable_irq(irq);
 	bt_dev_info(hdev, "OOB Wake-on-BT configured at IRQ %u", irq);
 	return 0;
 }
-- 
2.21.0.rc0.258.g878e2cd30e-goog

