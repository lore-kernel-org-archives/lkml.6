Return-Path: <amit.pundir@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525283307; cv=none;
        d=google.com; s=arc-20160816;
        b=Frtc9FyhoSHvD/Fp/WN2Ar6XHkeQH8jMnL2k4TqKEtqPm8GAVQLtdSRZUKNbLrjD+w
         SIO8foXaFum6Mhz++uCZ/7tGt8nq6QwLeoQ/gvlpBA39pvf1U5uV9jp6MrU5t1fs9OiG
         zk04iK0P2eCqbr++OYkjmzuUE+264qrEupLOxEUPIVWQrBwp1P188KUAxzz5WvmxcSkW
         EkyHyGhyVP8b0Wl4GgB57WisJAp2uOd89UWY10hXqTjyy+32ixxuRt0mIBdqgZ6NBQY5
         MeI0pCpB+ORDI2Xhc++mj0DWDqr5JRJ8GEqAh0UCOe/5iqm2RJakmt/lUCpunEoLjiQZ
         c8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=vIbutGlUGmHHi1W8Vh0uYh/n/wIktrMraEjzwoOh+Cs=;
        b=M/WT6wkDRTBzVOFFjFj9+GDek9+tPV1kb9KbSgxofjw9MqmTZRa1yaxkrpFkLmFegJ
         4MF1F36KGUVH4fR+bkvglFkPgWRg1+b6oPAimhbYyNsqMjROPTDUhMmb9bT9EXzZ9tmY
         OVDXl1zUEFRVJCwoopKSDMhn093zZSP6IrTJC2+DSxfJtBiyazsACnGGLS49YzJOKZZN
         EKdHnYk5+jop+J0RsB6ZTyZjSPkLhIDPw1v6IRA0g2FEWA7BxAWc0pzKebmnsKbCjU3n
         wHKZbkmZ4DobmsCWNg0yWykczIp5tootBacLpdMivbahJ57/uK3GnWDZ8jD/5qp7iJ4R
         JqCg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=fJKe5FX7;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=fJKe5FX7;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZojhh0TbktAWfCoy1QIAaekckXeLu2iSzvhqfuLBAvALZiR1ypd5E1tZW/QNdw6uSDfHCdBJQ==
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
Subject: [PATCH v2 3/3] NFC: fdp: Fix possible buffer overflow in WCS4000 NFC driver
Date: Wed,  2 May 2018 23:18:08 +0530
Message-Id: <1525283288-7027-4-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525283288-7027-1-git-send-email-amit.pundir@linaro.org>
References: <1525283288-7027-1-git-send-email-amit.pundir@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599375469996220614?=
X-GMAIL-MSGID: =?utf-8?q?1599375469996220614?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Suren Baghdasaryan <surenb@google.com>

Possible buffer overflow when reading next_read_size bytes into
tmp buffer after next_read_size was extracted from a previous packet.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
v2:
Remove redundant __func__ from dev_dgb().

 drivers/nfc/fdp/i2c.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
index c4da50e..b80d1ad 100644
--- a/drivers/nfc/fdp/i2c.c
+++ b/drivers/nfc/fdp/i2c.c
@@ -176,6 +176,15 @@ static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
 		/* Packet that contains a length */
 		if (tmp[0] == 0 && tmp[1] == 0) {
 			phy->next_read_size = (tmp[2] << 8) + tmp[3] + 3;
+			/*
+			 * Ensure next_read_size does not exceed sizeof(tmp)
+			 * for reading that many bytes during next iteration
+			 */
+			if (phy->next_read_size > FDP_NCI_I2C_MAX_PAYLOAD) {
+				dev_dbg(&client->dev, "corrupted packet\n");
+				phy->next_read_size = 5;
+				goto flush;
+			}
 		} else {
 			phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;
 
-- 
2.7.4
