Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE01BC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DF121763
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="PLMC/yQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DF121763
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbeHNBYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:24:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44087 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730610AbeHNBYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:24:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so8308462pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 15:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MyutG6STgkyPSvO1DZljz9kCrJpmVK8nphfEPRDQ4l8=;
        b=PLMC/yQq/aFtXc0gy3jcAHqiv+BtDOqLY3CDpm8i2jncyjYWcvjmzE2ezLnzODDy4h
         A2Wtez9D6DeqsMkMtYJMRjnZHWuAdqDZi0AKMs9aV/fu2/Fq+ChNGl8RPuJPPqKI7U42
         09F+G1mCOh+/GaJZb5KL/sV4JPCiBiZqrMzfwT+aRPKTT2KAwSRCUdcP0Ok2AqeSxvDm
         A5mWWsUHCuEuEZFdvjMCAEruRsP0kSxrzny18Ag3KYJZjxS3hdL9ya6ay9DZ2iFH1vjk
         hTIWdDRW+JbZO8pVGG5GKK6AOzZebRL6SZY/Rr5lG5ACKQCCagjTF5ipot9Lrx859qw2
         WZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MyutG6STgkyPSvO1DZljz9kCrJpmVK8nphfEPRDQ4l8=;
        b=Ntpky6EaDmFuoGglbU8uU2AUfWviq7BDYeCSDTxcxpaNMO9j/G9HpyJ9rz8FPQM+Q3
         4bV1gkBpIjhEEyw2qFwyck9rgAx5V4XMvZorQplONNcAKi/feE8LqlcXe9u6dxZZQ5p0
         wETOjGciqpm7tPto1qipRXBLgZxeJJBrNqYcEsn1fmBNBGcYTwLjX/dBVa5FV79lvIs3
         lu1RDyY00pA0K1SEXiX18bEBSl6ayWl7MsB3CoaYQ4IoIrw1frN4FMdJC773RdlwMrcz
         DKcm9A59rhZEa/16oHppkdJVYjOrDHi0jvBQFydIP8UBXlABKHJtb5hPTu3+dgQ9n7S1
         huQg==
X-Gm-Message-State: AOUpUlHgWzNDoJ5RQNnUIN2iYbexTZDTo+tdohAnnfBC1NGbYdHf+Dmk
        4D529F0qqcOeVV8in7iRxJEoPw==
X-Google-Smtp-Source: AA+uWPzYf2l26aLzgy8Z9RN/wCRInQcAzVENrGS3uL7IkeVlklam4txLZIZBeQP3ybT2GfXk5AMqZA==
X-Received: by 2002:a65:614a:: with SMTP id o10-v6mr18154301pgv.387.1534200002225;
        Mon, 13 Aug 2018 15:40:02 -0700 (PDT)
Received: from surenb0.mtv.corp.google.com ([2620:0:1000:1612:45b2:1550:405f:3ba1])
        by smtp.gmail.com with ESMTPSA id q10-v6sm21764717pfh.124.2018.08.13.15.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 15:40:01 -0700 (PDT)
From:   Suren Baghdasaryan <surenb@google.com>
Cc:     security@kernel.org, kdeus@google.com, surenb@google.com,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Allen Pais <allen.pais@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] NFC: Fix possible memory corruption when handling SHDLC I-Frame commands
Date:   Mon, 13 Aug 2018 15:39:08 -0700
Message-Id: <20180813223910.26276-1-surenb@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When handling SHDLC I-Frame commands "pipe" field used for indexing
into an array should be checked before usage. If left unchecked it
might access memory outside of the array of size NFC_HCI_MAX_PIPES(127).

Malformed NFC HCI frames could be injected by a malicious NFC device
communicating with the device being attacked (remote attack vector),
or even by an attacker with physical access to the I2C bus such that
they could influence the data transfers on that bus (local attack vector).
skb->data is controlled by the attacker and has only been sanitized in
the most trivial ways (CRC check), therefore we can consider the
create_info struct and all of its members to tainted. 'create_info->pipe'
with max value of 255 (uint8) is used to take an offset of the
hdev->pipes array of 127 elements which can lead to OOB write.

Suggested-by: Kevin Deus <kdeus@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 net/nfc/hci/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/nfc/hci/core.c b/net/nfc/hci/core.c
index ac8030c4bcf8..19cb2e473ea6 100644
--- a/net/nfc/hci/core.c
+++ b/net/nfc/hci/core.c
@@ -209,6 +209,11 @@ void nfc_hci_cmd_received(struct nfc_hci_dev *hdev, u8 pipe, u8 cmd,
 		}
 		create_info = (struct hci_create_pipe_resp *)skb->data;
 
+		if (create_info->pipe >= NFC_HCI_MAX_PIPES) {
+			status = NFC_HCI_ANY_E_NOK;
+			goto exit;
+		}
+
 		/* Save the new created pipe and bind with local gate,
 		 * the description for skb->data[3] is destination gate id
 		 * but since we received this cmd from host controller, we
@@ -232,6 +237,11 @@ void nfc_hci_cmd_received(struct nfc_hci_dev *hdev, u8 pipe, u8 cmd,
 		}
 		delete_info = (struct hci_delete_pipe_noti *)skb->data;
 
+		if (delete_info->pipe >= NFC_HCI_MAX_PIPES) {
+			status = NFC_HCI_ANY_E_NOK;
+			goto exit;
+		}
+
 		hdev->pipes[delete_info->pipe].gate = NFC_HCI_INVALID_GATE;
 		hdev->pipes[delete_info->pipe].dest_host = NFC_HCI_INVALID_HOST;
 		break;
-- 
2.18.0.597.ga71716f1ad-goog

