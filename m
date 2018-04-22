Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48M95IEWegr8ooPCftWyZ2n7xNz0L6L2jDfTnyzGJs6YQ88HsITrWEdXGtWUtVkkz/HKpCE
ARC-Seal: i=1; a=rsa-sha256; t=1524405400; cv=none;
        d=google.com; s=arc-20160816;
        b=NTp6zzZT3AGwUM3vAY1Qf+U2HYZGnpuiEnOS42Mix4AE1TaxhrppbERKVaU5GV7IrF
         IugSctssHegWIGabfrVPoh+OhAYj649vg0hDfyYy0qcWm6B7o/Ix/W783FNB0kdqOBFT
         XFoZJRm4i3aCIuEZYIX/WZr3fjpcGHWVRgs3xnGwtuRXqbWX1UA9JbuJg6bfHAmKyHfB
         olQvqxyudz6sx2jdxy3tpIQFyl8Wrg2JRikMhNWODZ8gttBiNgADgud2RW8WIs7RAlkl
         idWZXJuRrR+gn2Uc/4/KdFJNwWPc1puqNNGMgT1NJQ2zQgG7RTl6rCCfFpUYoRdH+qkU
         mGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BFtS0v8XuSMskWdU1hMtdEG7sDdYMCOZDNCkFCzYkyA=;
        b=usy1zimIswrknPVE0AXmYNu1WPQd7oMc7GCzr7tjQv9u/c7Ro/KqX8oy1KRoM25Y1l
         k5UP2Sg2HHnOxeHg1IMS0sOj/ecFtm4beYgZR/dIgkPVv6B42nbCmKB9UixmKM17wBHO
         R+IlxXxlOBpATrmnXo9oeRO4R51Dt94PQ5jLH+sBcOk80cClLRpHCYeLiziJvtgpLVST
         h9YNChbQUa3LKILBnHeHu3DpdTLC+W/NRifrNhMasD+4GJ71tnDaloDnZobvqBUlj9cs
         2cFwNvZRwdANASbcL0dSPKS9o+hiiMH5eAvkSd6pL76y3hE89iU+3gAgEseY+7oCzkpo
         b0HA==
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
Subject: [PATCH 4.16 053/196] i2c: i801: Restore configuration at shutdown
Date: Sun, 22 Apr 2018 15:51:13 +0200
Message-Id: <20180422135106.851144563@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454917246307724?=
X-GMAIL-MSGID: =?utf-8?q?1598454917246307724?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1701,6 +1701,15 @@ static void i801_remove(struct pci_dev *
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
@@ -1730,6 +1739,7 @@ static struct pci_driver i801_driver = {
 	.id_table	= i801_ids,
 	.probe		= i801_probe,
 	.remove		= i801_remove,
+	.shutdown	= i801_shutdown,
 	.driver		= {
 		.pm	= &i801_pm_ops,
 	},
