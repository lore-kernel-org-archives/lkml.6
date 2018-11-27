Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B26C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5048120873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LPvxfy+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5048120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbeK0WUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:20:12 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38007 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbeK0WUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 17:20:12 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so18676604ede.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 03:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xhM4mxpl6FFZ/rThS7YpFSaPWQ7uwJbzqsu3JPtVKbQ=;
        b=LPvxfy+y35jRGSNkF+j4PLckvO6VUIisTpP/6HtBQMvgv8nAp1JWXxM9cFsag02QYJ
         5e3ISVcvYxhCXUyY2M6nq7SECfUP+BzVwJ4LmNXpffolj4BYYR9mar6AFGy8uP4A3qfS
         Xbn8Ktgbr6QJWnGFLaNV628vX71IPen9d88FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xhM4mxpl6FFZ/rThS7YpFSaPWQ7uwJbzqsu3JPtVKbQ=;
        b=sDbTv6hOKJDMcOBE+KricjBOyTjtY9UfCQHhngSLI5LsudILaUOByHCdEAIRzq1aoS
         nsC9urO58B0RQQydJRQClOdYhpbKY/uuU/PWPB6dKO/+Xe657UcKq1huCKFERTcKiV48
         VUrMDBRccGndIsBtC7anw4CZclPH7b4YlhG/DAqBaSrOEflYlWGd6R+ZcR8dH2ZZ86sh
         iIH3edD/8xZPY/KDmTpx+glC1MvR/RJhrFPdGSujBAiZfqKYDyu8KxyLE1pVY4L+Hho7
         QrZpZ9vHedeeFT9/bU9Rb1kL4Baa7mN90JQ1CaSIUM373cECf245YrJXFHCTCMW59oU8
         jArQ==
X-Gm-Message-State: AA+aEWbLyfdc/hxu7bq639ZvcT9IvvASQuTT5rlHFtq4Zl9HKwc3MkJj
        kZGrfJyJQ6BVeko2OBkUxgMuyw==
X-Google-Smtp-Source: AFSGD/Wntr1PiMVM4oxiRsSwz4IxSoz4FROnk54Ri/lhtmGiITa/iHtydqPgrgtBKAssfqxxqzRasQ==
X-Received: by 2002:a50:a982:: with SMTP id n2mr10322240edc.236.1543317755637;
        Tue, 27 Nov 2018 03:22:35 -0800 (PST)
Received: from andrea.amarulasolutions.com (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id b2sm964538ede.30.2018.11.27.03.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 03:22:34 -0800 (PST)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH] bluetooth: Remove unnecessary smp_mb__after_atomic() barriers
Date:   Tue, 27 Nov 2018 12:22:25 +0100
Message-Id: <20181127112225.6177-1-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The barriers are redundant because atomic_test_and_clear_bit() already
provides the required full ordering for the cases in question (that is,
when the bit is cleared).

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 drivers/bluetooth/btusb.c     |  8 ++------
 drivers/bluetooth/hci_intel.c | 16 ++++------------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7439a7eb50acb..885e17a1a9a57 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1935,10 +1935,8 @@ static void btusb_intel_bootup(struct btusb_data *data, const void *ptr,
 	if (len != sizeof(*evt))
 		return;
 
-	if (test_and_clear_bit(BTUSB_BOOTING, &data->flags)) {
-		smp_mb__after_atomic();
+	if (test_and_clear_bit(BTUSB_BOOTING, &data->flags))
 		wake_up_bit(&data->flags, BTUSB_BOOTING);
-	}
 }
 
 static void btusb_intel_secure_send_result(struct btusb_data *data,
@@ -1953,10 +1951,8 @@ static void btusb_intel_secure_send_result(struct btusb_data *data,
 		set_bit(BTUSB_FIRMWARE_FAILED, &data->flags);
 
 	if (test_and_clear_bit(BTUSB_DOWNLOADING, &data->flags) &&
-	    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags)) {
-		smp_mb__after_atomic();
+	    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags))
 		wake_up_bit(&data->flags, BTUSB_DOWNLOADING);
-	}
 }
 
 static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 46ace321bf60e..8caa1a6619cea 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -909,10 +909,8 @@ static int intel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 			set_bit(STATE_FIRMWARE_FAILED, &intel->flags);
 
 		if (test_and_clear_bit(STATE_DOWNLOADING, &intel->flags) &&
-		    test_bit(STATE_FIRMWARE_LOADED, &intel->flags)) {
-			smp_mb__after_atomic();
+		    test_bit(STATE_FIRMWARE_LOADED, &intel->flags))
 			wake_up_bit(&intel->flags, STATE_DOWNLOADING);
-		}
 
 	/* When switching to the operational firmware the device
 	 * sends a vendor specific event indicating that the bootup
@@ -920,10 +918,8 @@ static int intel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 	 */
 	} else if (skb->len == 9 && hdr->evt == 0xff && hdr->plen == 0x07 &&
 		   skb->data[2] == 0x02) {
-		if (test_and_clear_bit(STATE_BOOTING, &intel->flags)) {
-			smp_mb__after_atomic();
+		if (test_and_clear_bit(STATE_BOOTING, &intel->flags))
 			wake_up_bit(&intel->flags, STATE_BOOTING);
-		}
 	}
 recv:
 	return hci_recv_frame(hdev, skb);
@@ -960,17 +956,13 @@ static int intel_recv_lpm(struct hci_dev *hdev, struct sk_buff *skb)
 		break;
 	case LPM_OP_SUSPEND_ACK:
 		set_bit(STATE_SUSPENDED, &intel->flags);
-		if (test_and_clear_bit(STATE_LPM_TRANSACTION, &intel->flags)) {
-			smp_mb__after_atomic();
+		if (test_and_clear_bit(STATE_LPM_TRANSACTION, &intel->flags))
 			wake_up_bit(&intel->flags, STATE_LPM_TRANSACTION);
-		}
 		break;
 	case LPM_OP_RESUME_ACK:
 		clear_bit(STATE_SUSPENDED, &intel->flags);
-		if (test_and_clear_bit(STATE_LPM_TRANSACTION, &intel->flags)) {
-			smp_mb__after_atomic();
+		if (test_and_clear_bit(STATE_LPM_TRANSACTION, &intel->flags))
 			wake_up_bit(&intel->flags, STATE_LPM_TRANSACTION);
-		}
 		break;
 	default:
 		bt_dev_err(hdev, "Unknown LPM opcode (%02x)", lpm->opcode);
-- 
2.17.1

