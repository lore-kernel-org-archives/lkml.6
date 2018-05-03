Return-Path: <amit.pundir@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525372746; cv=none;
        d=google.com; s=arc-20160816;
        b=rRXAGRZPe7KVsYMTd4mw7p+M9bYZyUWJ0fg1RjsiKusy9opE0MWAJeY77Q/SDBq2G5
         Ywr+ODU8bEuLla8eU5AhLogOasY2cs2OQjyvwgLvHLG4wUJFHF+s2gqJ1bay8B0R3GLP
         rYdoMrgq7AXGDV44PWD5rnSA7osqN1ABouyPlw5XIKb9Roz2/d687monLN/pBSwmLpDO
         w8jhLoAlVtn3GAzf7xhbPxZjVE7vkYObT7ipjxwsUgXQbM5T0bF4+j6SKEOCN6tZ8Q8u
         qxkSbFk7s48XmI39OgQqZ5T3yiox5vpw20gmtF6CdMdisalzUBF0Hqw26QB6tY4e+AUO
         n1tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=bQVjZYBsVQrcd9EmtkKcL4YPUtSEKCns/vDF2NvsVJQ=;
        b=DeFiYHKXRV/yBaAjOASWRnsJiBJmiJeGu4S6r1IoVjsej8Gd5OGLnXyhZCq/+Oc0zq
         whRYZ5t+9L3bE/DEyxU9QakFx9dTLFPDQXhvryjW+b6J/m8ARjkE9QoQT/9L61LU1FGG
         0lP3KEWPZnC0ehjh1aCwScCH356rgR5GjZ3by/T3uLi6Q95TJD9fFSKuZw+PWQfD+6Aa
         kDPuOqp/hI3ebyQJ4m050sBofBIJuYbP3YDg0bfksB5vLfSOvKj9FOGWO5IQRT9tqMjB
         g0j2fru6ipiSlRFuR1Cp8KpPEx4FQyPVlNn1cR+G7kbCHMnbTCsUyqKURZ7AJS4iLBnN
         BZxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=jsWz82eU;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=jsWz82eU;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZonBjbfVrJfdSQ2mzDF3IDb5ZEhljE6qQJ3WI3SOVLeulrzyHlPB8DYSM9qUQWs0dFxLqiPHg==
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
	Android Kernel Team <kernel-team@android.com>,
	Stable <stable@vger.kernel.org>
Subject: [PATCH v3 2/4] NFC: Fix possible memory corruption when handling SHDLC I-Frame commands
Date: Fri,  4 May 2018 00:08:54 +0530
Message-Id: <1525372736-25094-2-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525372736-25094-1-git-send-email-amit.pundir@linaro.org>
References: <1525372736-25094-1-git-send-email-amit.pundir@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599469253695427905?=
X-GMAIL-MSGID: =?utf-8?q?1599469253695427905?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Suren Baghdasaryan <surenb@google.com>

When handling SHDLC I-Frame commands "pipe" field used for indexing
into an array should be checked before usage. If left unchecked it
might access memory outside of the array of size NFC_HCI_MAX_PIPES(127).

cc: Stable <stable@vger.kernel.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3..v1:
Resend. No changes.

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
