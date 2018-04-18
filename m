Return-Path: <amit.pundir@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524045923; cv=none;
        d=google.com; s=arc-20160816;
        b=UIw3gLQnqj9vf6AVqjOVWMEwv93IDPX5B35lBqJWZ6Ui7zX4QIIvX2HMobCs62qOMH
         RD2GFxKa81omshizSPstLWYcNFRtqZbW388NgudVe31j3aGfYV+4Fkd3Nr6iM2NwCFE0
         PSr2Jyd0XffzPuS+4/gkQfjcU157IJLs3vljq65COy69/EkySTTXL2jJJOjj8TESMTQ6
         mMhgw3AEerXYq2hnvqO2Tn3/gXqhiciuT3AHXRZtxYp2TrS1EFyeXxh8C5a0t3udeXLL
         ToheM8zhXTA44RgasDfFIxzw+TQprWIbR949tTvL9LhYHbp1YD1hSD6uj9Oi45mOApnj
         0Ssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=12mwkxYQZ7M7BIfATqchCZe1U9P8e+8jonsb/6NZX8k=;
        b=nWHSmpdYUwFWdvsXh3bqqW6Mmnu1h+z/WbNroRew62hgwfHgpmh5AmutcoXbRaViSb
         Yj/gTWIQLzSKzbigh70ehLtWdvD9wmPwGk6k2cCD9xmobytLg6C/wSyC5xZH7v2jy6E5
         62/H/+dLY/L1TPp1yc7xPzXyDMkYTtw7bca5129M/ac0H2TpfG1VlKBtAuEC2sLlGDXs
         hu2tiBWsW/O6P51DI1iCVhTRK9ENdpCIZKHeMhXlT9Gfn5eB0Z533EA9G8+pVCXC+Tn7
         4PZajg1iwl6Wc498SCR9Mwq7owTQdhD63HT5MoWLYjzZxgH0NdqRJtZLqcSHu2j8uOgE
         oK9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=dgoKY9QP;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=dgoKY9QP;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/MFzvpygyNaDfvhT4ovxWSIkvrc+6cih2Djin2yFEJlMAmYx15oG3McMRZ3vm+jK/m0Nc3vg==
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
Subject: [RESEND][PATCH 3/4] NFC: Fix possible memory corruption when handling SHDLC I-Frame commands
Date: Wed, 18 Apr 2018 15:35:03 +0530
Message-Id: <1524045904-7005-4-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524045904-7005-1-git-send-email-amit.pundir@linaro.org>
References: <1524045904-7005-1-git-send-email-amit.pundir@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598077978403817137?=
X-GMAIL-MSGID: =?utf-8?q?1598077978403817137?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Suren Baghdasaryan <surenb@google.com>

When handling SHDLC I-Frame commands "pipe" field used for indexing
into an array should be checked before usage. If left unchecked it
might access memory outside of the array of size NFC_HCI_MAX_PIPES(127).

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
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
2.7.4
