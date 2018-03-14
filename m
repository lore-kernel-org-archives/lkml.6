Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AG47ELuWdxDnzXDuvmYZu7kURbVanj9clU6VUdgWI+G864/BW3HBT6IdPK6Xhtw8atX1F65C+5/f
ARC-Seal: i=1; a=rsa-sha256; t=1521026794; cv=none;
        d=google.com; s=arc-20160816;
        b=CPZrOhTSuglgI+QKUw3OQYqiofIbFYaI2dZwRCVSGiqMnx/y91ge+pLxN+TnfCMRny
         X5gdwCqCELqy46OaAtZQe/l6D7mdFceITMIpGVuvLS5HP+uxqWtpbUkkYzCVnw0XG4hO
         xNIVr9CLiw/ww2rvuMIx8j/+LsjGIfAR5rPdQj0smTifKYdRTHgC4tuNDOUWuj0Orvo2
         VPURYvjxhclDk+BqLbcI9oyiR7A5Due0ds+3NSysqVfxB7a+KL5Ksph4ERxQFXzUBJFW
         ibghRtWExe9sUnsSqv8lRzUvhuemjyUSNuZ/taXdlNm0tbi1fMiuOGZzPbtbqBj/56oB
         nKqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=PW+J0CKC/CnP36PY02D4udZFc6bEa/bO8tynU2stVzo=;
        b=uphYT+gHGrmdjM/ZodQaHhKd8g8poYhqijEY1LvFNTNwMyeC1ThTeMxZh8qEQDkp3R
         u0GV3mJIHse9OSALEkWk1KIeVIb6/BaGyITFlNB2p0++WWuE8uABogUjyRAad19A8uC5
         Ub8dBq5mfuiaZfO229sZruEq8iA2K3NcrbEy/EqIuRE6Cko2VKu5aQE8dru+6QuR860a
         S2piwRchw6wSuqepOfOr89OYR2qm8GVgEhfZFTJW+9oThK+lshRQ4hYkVfHcyXcSraH2
         R94sfNdpshyder5myU7bHJ9YTyt5hshHgqqTiJY4dniPRC1hJNIuDh7osMYf83LPbFxu
         j3HQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:120:4::f00:15 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:120:4::f00:15 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 2/2] regulator: bd9571mwv: Add support for toggle power switches
Date: Wed, 14 Mar 2018 12:26:25 +0100
Message-Id: <1521026785-26456-3-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521026785-26456-1-git-send-email-geert+renesas@glider.be>
References: <1521026785-26456-1-git-send-email-geert+renesas@glider.be>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594912189945282587?=
X-GMAIL-MSGID: =?utf-8?q?1594912192433388308?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Extend the existing support for backup mode to toggle power switches.
With a toggle power switch (or level signal), the following steps must
be followed exactly:
   1. Configure PMIC for backup mode,
   2. Switch accessory power switch off, to prepare for system suspend,
      which is a manual step not controlled by software,
   3. Suspend system.
Hence the PMIC is configured for backup mode when "enabled" is written
to the PMIC's "wakeup" virtual file in sysfs, using the newly introduced
callback for wake-up change notification.
Unlike with momentary switches, backup mode is not enabled by default,
as enabling it prevents the board from being powered off using the power
switch, which may confuse the user.
Conversely, writing "disabled" reverts the role of the accessory switch
to a power switch.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/regulator/bd9571mwv-regulator.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/regulator/bd9571mwv-regulator.c b/drivers/regulator/bd9571mwv-regulator.c
index be574eb444ebda97..435c8da576b604cf 100644
--- a/drivers/regulator/bd9571mwv-regulator.c
+++ b/drivers/regulator/bd9571mwv-regulator.c
@@ -171,6 +171,24 @@ static int bd9571mwv_bkup_mode_write(struct bd9571mwv *bd, unsigned int mode)
 	return 0;
 }
 
+static void bd9571mwv_wakeup_change_notify(struct device *dev, bool enable)
+{
+	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
+
+	unsigned int mode;
+	int ret;
+
+	ret = bd9571mwv_bkup_mode_read(bdreg->bd, &mode);
+	if (ret)
+		return;
+
+	mode &= ~BD9571MWV_BKUP_MODE_CNT_KEEPON_MASK;
+	if (enable)
+		mode |= bdreg->bkup_mode_cnt_keepon;
+
+	bd9571mwv_bkup_mode_write(bdreg->bd, mode);
+}
+
 static int bd9571mwv_suspend(struct device *dev)
 {
 	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
@@ -277,6 +295,11 @@ static int bd9571mwv_regulator_probe(struct platform_device *pdev)
 		 * explicit user setup in level mode.
 		 */
 		device_set_wakeup_enable(&pdev->dev, bdreg->rstbmode_pulse);
+#ifdef CONFIG_PM_SLEEP
+		if (bdreg->rstbmode_level)
+			pdev->dev.power.wakeup_change_notify =
+				bd9571mwv_wakeup_change_notify;
+#endif /* CONFIG_PM_SLEEP */
 	}
 
 	return 0;
-- 
2.7.4
