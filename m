Return-Path: <amit.pundir@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524045927; cv=none;
        d=google.com; s=arc-20160816;
        b=KIqLP4E4uXgcqCIpbcJK1k97v9CDtKGT8eV8OvHm1m3724tXmOX1j+/54chmhGoNXh
         L6CQpDdH9xjX1KavdmfnnuUmCVytdYskBH4hqw43Exg+x4++AhommZ+/5wYaaxK6liVb
         Q5QW/CoYLnfFxSW+TMUdyYFZRk4gl0qHiQ266TerX+5wStrl+WzZVG3pae+s1wEPFUHQ
         1LyXy/wfZnThk6K+JvdWjj8xjFiMSh+2eocA/TibyUNDvFZumEDW2KCjg0+32/J09TeE
         XbOPePa4n3P2dPkBJNVx0GXBSKuh3Fkh/jj3ERLg/7WXzEflpfVWMJj0GYvFipjrun0f
         W0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=TZBj15vhcZkL16Ta0GEOKA6YFvs3QXuieY8qcfuQ2Dg=;
        b=elen/OtwQpl9lbLamgPZzR3ypoNa1asnfAyjX2ZFzOhtc437rpZdAiLyMn8UZpKT/Y
         8OhXWjQ59Fx/az2nXA0V4OOpkxKK9vv+GQk+gNgxp725lcUpgF9YobPYMZ3FPm+zbHPO
         MQFTRVGBTWAAlkEyt4i3Tyi8E8w81WUxC5KqOlLzFryXJRdmFqAvszr57OfDihIBVLlF
         AoI1kEkMtyBRD+YG+mLf7uyRYzGtEABitfHQ/obMoVutdSip3C7fF6llbLFvncdw0TMk
         yhZS8srWuscLHIpnsxXhIah+biMDSFf+3b+5Vkj3Hq7Kbn9M0T8zIa2+7mB3nrH1R986
         y5pQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=f4ScOL+k;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=f4ScOL+k;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/wJA2f4PXWmQ/HyIs86dfk067BezorzgzYu8L2MVMUwM/nNll0EifXy5tmKKEF7IbU3pQEJg==
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
Subject: [RESEND][PATCH 4/4] NFC: fdp: Fix possible buffer overflow in WCS4000 NFC driver
Date: Wed, 18 Apr 2018 15:35:04 +0530
Message-Id: <1524045904-7005-5-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524045904-7005-1-git-send-email-amit.pundir@linaro.org>
References: <1524045904-7005-1-git-send-email-amit.pundir@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598077982406018192?=
X-GMAIL-MSGID: =?utf-8?q?1598077982406018192?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Suren Baghdasaryan <surenb@google.com>

Possible buffer overflow when reading next_read_size bytes into
tmp buffer after next_read_size was extracted from a previous packet.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 drivers/nfc/fdp/i2c.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
index c4da50e07bbc..08a4f82a2965 100644
--- a/drivers/nfc/fdp/i2c.c
+++ b/drivers/nfc/fdp/i2c.c
@@ -176,6 +176,16 @@ static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
 		/* Packet that contains a length */
 		if (tmp[0] == 0 && tmp[1] == 0) {
 			phy->next_read_size = (tmp[2] << 8) + tmp[3] + 3;
+			/*
+			 * Ensure next_read_size does not exceed sizeof(tmp)
+			 * for reading that many bytes during next iteration
+			 */
+			if (phy->next_read_size > FDP_NCI_I2C_MAX_PAYLOAD) {
+				dev_dbg(&client->dev, "%s: corrupted packet\n",
+					__func__);
+				phy->next_read_size = 5;
+				goto flush;
+			}
 		} else {
 			phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;
 
-- 
2.7.4
