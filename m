Return-Path: <amit.pundir@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524045919; cv=none;
        d=google.com; s=arc-20160816;
        b=PJuODyXJGQHFU4U/6zKUwFyBaZxRKByXoC+P8AzCXOwpSZoZ6oEKfS7oolO5IB87M5
         Qkul0XILeR3IOcykdkzsRgUNoaPZb4gbQZdoaeX0aV8VjXW3SWm8YJiwePwZoDa+DFyh
         U6qJQs1rVu0ckHgu7YQhglH04AKDFA3F/lIet+1DH1Zt184K+ptTzGkZdBbhfyIXtOdj
         hImGsHyws41lWFt66Pd6ezum10b/cE/TkSgVxeE3QfAKQF+cXvWUyd1pkflZZhO6pLz+
         N7w0K5TCEMBiV7Q/1KIoYGTz/dRHx0lhbTonRqGOcQucLoc4MMH7LpGeB1SxVaLcyweU
         ErSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Q7b33P81Dqi1buU+SZECfMgqa7so/MUyD350h11szic=;
        b=bENQxEqm9DAxEdCBayNrkJCobvFqBLnJL1iWrnyP8z2MyP3+h0nsd7vF0l4emrliQ3
         9MTmld5SA6WvJZyKQzYVyPriiqEKqk+U1oqRoVFLglfxo23+x1jTgi7m9o0R9aCOdptO
         fPTiHYgCnYTiqRB9A/t7FNLu/w6p08fgutFBmeFqZkHpi0y6BR7EjAw2UoOiULIOMpL+
         FWRGduftujHeNIk6Y+PVwyTxmnK/lkPpLP9qYDmhOKYsCh5SyeTU2uiyI6+IuvGwRzYO
         pcmmxtYlXQd4/jmAhc3nvw2npV1sw62jW7WUsVwEbntLYht1ASQ5ojO4IBW6jQQ6e0+T
         vnqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=i0/i+u1T;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=i0/i+u1T;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/BdggVBlRrjKqXOcVrSiF+OHugomcz+0XRy3ve7RSaN/nNRZQjJwBxJolsEd1E9gbusCQuHg==
From: Amit Pundir <amit.pundir@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>,
	linux-wireless@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	Christophe Ricard <christophe.ricard@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	John Stultz <john.stultz@linaro.org>,
	Dmitry Shmidt <dimitrysh@google.com>,
	Todd Kjos <tkjos@google.com>,
	Android Kernel Team <kernel-team@android.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: [RESEND][PATCH 2/4] NFC: st21nfca: Fix memory OOB and leak issues in connectivity events handler
Date: Wed, 18 Apr 2018 15:35:02 +0530
Message-Id: <1524045904-7005-3-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524045904-7005-1-git-send-email-amit.pundir@linaro.org>
References: <1524045904-7005-1-git-send-email-amit.pundir@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598077974606996222?=
X-GMAIL-MSGID: =?utf-8?q?1598077974606996222?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Suren Baghdasaryan <surenb@google.com>

Overflow on memcpy is possible in kernel driver for st21nfca's
NFC HCI layer when handling connectivity events if aid_len or
params_len are bigger than the buffer size.
Memory leak is possible when parameter tag is invalid.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 drivers/nfc/st21nfca/se.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/nfc/st21nfca/se.c b/drivers/nfc/st21nfca/se.c
index 4bed9e842db3..acdce231e227 100644
--- a/drivers/nfc/st21nfca/se.c
+++ b/drivers/nfc/st21nfca/se.c
@@ -322,23 +322,33 @@ int st21nfca_connectivity_event_received(struct nfc_hci_dev *hdev, u8 host,
 		 * AID		81	5 to 16
 		 * PARAMETERS	82	0 to 255
 		 */
-		if (skb->len < NFC_MIN_AID_LENGTH + 2 &&
+		if (skb->len < NFC_MIN_AID_LENGTH + 2 ||
 		    skb->data[0] != NFC_EVT_TRANSACTION_AID_TAG)
 			return -EPROTO;
 
+		/*
+		 * Buffer should have enough space for at least
+		 * two tag fields + two length fields + aid_len (skb->data[1])
+		 */
+		if (skb->len < skb->data[1] + 4)
+			return -EPROTO;
+
 		transaction = (struct nfc_evt_transaction *)devm_kzalloc(dev,
 						   skb->len - 2, GFP_KERNEL);
 
 		transaction->aid_len = skb->data[1];
 		memcpy(transaction->aid, &skb->data[2],
 		       transaction->aid_len);
+		transaction->params_len = skb->data[transaction->aid_len + 3];
 
-		/* Check next byte is PARAMETERS tag (82) */
+		/* Check next byte is PARAMETERS tag (82) and the length field */
 		if (skb->data[transaction->aid_len + 2] !=
-		    NFC_EVT_TRANSACTION_PARAMS_TAG)
+		    NFC_EVT_TRANSACTION_PARAMS_TAG ||
+		    skb->len < transaction->aid_len + transaction->params_len + 4) {
+			devm_kfree(dev, transaction);
 			return -EPROTO;
+		}
 
-		transaction->params_len = skb->data[transaction->aid_len + 3];
 		memcpy(transaction->params, skb->data +
 		       transaction->aid_len + 4, transaction->params_len);
 
-- 
2.7.4
