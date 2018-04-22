Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48emg4sXpawX9xkFwTcJUKuuJVKTwITZ9iMGoyidSj6uxVbji6YtnqgbGYODXuWYtUUWMNR
ARC-Seal: i=1; a=rsa-sha256; t=1524405920; cv=none;
        d=google.com; s=arc-20160816;
        b=v2tQCtIqKX2L2rXA1E1LvrLgEcb412LYDs276d5NBfEpLZCBx43geXVQlgeV42zPD7
         RKuBcVoSOCBbEgyNNl09Br2FR4pPNV5I4/7GCtyWLqplMRiArcWzfMlhpalObWzi3V0H
         nj5OmXKxhz58ugEc0IPfULXx0kmvKIWH9YIeFKMgomtA0khizuzRKqsJ5rsT9VVCNunX
         it1varCyTyDjom0OcvwdNvsQydODOIyknkhNqhR359EE2Sz0YPQ2APAMW/ZqitdP776Y
         PtUDq3cWF9qvhCwZKCJ+7TV4PZvIjdseTA50WP5qRs26wLIex5zkZfOIh3p8cTkPE7EW
         ziGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EV8i2OsW1Gs7sQymFcVs9H7ZAj9gVYzFpVCh03C/o8M=;
        b=bGgSeBibsfPK3IOH40vwH4Qy/aTO9EykAQePP36+RkoJsX2zuA0kIGHzAXydtFuG9L
         8RODDGI9cYncPuLtqh06UW3wirhUryJ2XyE0y39UqiIpH3QE93tt7v50mrOBH+NLcAp6
         CTK3lypvz1WAF5uvuvciJu5vdP8IEFmn5+RIxU9XZb/DbnJZzFftq85oYzj3TGu74GPP
         QRN0kiZa1QkYAZ6U5VETmx1SqqyJEZUbi4n+ZfaXYZiXm2R9zN9N0bFR5R34u498QU4v
         UDyPedWGBUk/Hsl6QvBAIhMu/ZxMvFa4U9WJmd5Sw8r/aV2Tl9Lsc0S2SqpBfHlfD2OX
         b2sQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jean Delvare <jdelvare@suse.de>,
	Jason Andryuk <jandryuk@gmail.com>,
	Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.14 047/164] i2c: i801: Restore configuration at shutdown
Date: Sun, 22 Apr 2018 15:51:54 +0200
Message-Id: <20180422135137.328084383@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454917246307724?=
X-GMAIL-MSGID: =?utf-8?q?1598455461825990779?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jean Delvare <jdelvare@suse.de>

commit f7f6d915a10f7f2bce17e3b1b7d3376562395a28 upstream.

On some systems, the BIOS expects certain SMBus register values to
match the hardware defaults. Restore these configuration registers at
shutdown time to avoid confusing the BIOS. This avoids hard-locking
such systems upon reboot.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Tested-by: Jason Andryuk <jandryuk@gmail.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-i801.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1700,6 +1700,15 @@ static void i801_remove(struct pci_dev *
 	 */
 }
 
+static void i801_shutdown(struct pci_dev *dev)
+{
+	struct i801_priv *priv = pci_get_drvdata(dev);
+
+	/* Restore config registers to avoid hard hang on some systems */
+	i801_disable_host_notify(priv);
+	pci_write_config_byte(dev, SMBHSTCFG, priv->original_hstcfg);
+}
+
 #ifdef CONFIG_PM
 static int i801_suspend(struct device *dev)
 {
@@ -1729,6 +1738,7 @@ static struct pci_driver i801_driver = {
 	.id_table	= i801_ids,
 	.probe		= i801_probe,
 	.remove		= i801_remove,
+	.shutdown	= i801_shutdown,
 	.driver		= {
 		.pm	= &i801_pm_ops,
 	},
