Return-Path: <amit.pundir@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525283303; cv=none;
        d=google.com; s=arc-20160816;
        b=E4fbIAsmQ2SdDoPUAukxQErZt0SQL37TG04HBRwQ7fOAks6DCRa9bNrsXqAkBtIAl1
         jjFhTp3hMOaSsRCNM1/v9Slx+MAuYWKauYsqFZPu1n58tefRxBsyqFka5jcpW717ftzQ
         F6I9u85VpKbJbTI//MWajD7LzpXsa2OS1jDoBVFyE5lR2rY06lzfDHBe5wkBQiD8b3Up
         4XkA7bRkAtybnFCrvVc0uHIU01BbXHg+e1JY5e0OT7i031sniZdDkKOY44bbpN+NcnI0
         ynuB9COHAW0zPxLNVT9NC6ThTeFFMxVyfkliP27HDuUlqpcpKwc7Vo+/OH4OdDad56gd
         vc6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=z47AkYrZrCYwdJHLcba161nVjfCLWE0I/WK1pjwAC5w=;
        b=NWycrBMq42ppP863YIHaovPA2+SpUgkAOudTFEsavEEzfRljNyEvONpHwu9XSbWkF2
         tK49CsvskUKcTEELeMppCCWlRzaupDZz7bGEOGsIzr+4zcUIUeMdaicwYocpxnmNqIPc
         F5zrqQSKwNxNLGw2yW8TMc7rJ/7a5k1MN2XFl3RjaZwM1tuIecmDBk1X4SL+ij4jdeZ/
         Vhr3IsuPhq1kVptzIj1wFyofPE6igJ8tMmZedgvjgcJpJI/7OynAzkQJD81xWN1F9yhd
         4hKRRyZ9Ku+LnTFV6qvT2NlKYomq0Btzg0vDbLKSh3rEZDjr6sjdxx9S/Jdc4zOlCcNA
         iP6g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=djnVsbdS;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=djnVsbdS;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpePEAO5Srxckv0RyNKCGQ9RbIbze61W4GYNhkxSQvrQN8shUf4O7++T6uz5lVv8naUoWyNNA==
From: Amit Pundir <amit.pundir@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>,
	linux-wireless@vger.kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Christophe Ricard <christophe.ricard@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	John Stultz <john.stultz@linaro.org>,
	Dmitry Shmidt <dimitrysh@google.com>,
	Todd Kjos <tkjos@google.com>,
	Android Kernel Team <kernel-team@android.com>
Subject: [PATCH v2 2/3] NFC: Fix possible memory corruption when handling SHDLC I-Frame commands
Date: Wed,  2 May 2018 23:18:07 +0530
Message-Id: <1525283288-7027-3-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525283288-7027-1-git-send-email-amit.pundir@linaro.org>
References: <1525283288-7027-1-git-send-email-amit.pundir@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599375465381931693?=
X-GMAIL-MSGID: =?utf-8?q?1599375465381931693?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Suren Baghdasaryan <surenb@google.com>

When handling SHDLC I-Frame commands "pipe" field used for indexing
into an array should be checked before usage. If left unchecked it
might access memory outside of the array of size NFC_HCI_MAX_PIPES(127).

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
v2:
Resend. No changes.

 net/nfc/hci/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/nfc/hci/core.c b/net/nfc/hci/core.c
index ac8030c4..19cb2e4 100644
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
2.7.4
