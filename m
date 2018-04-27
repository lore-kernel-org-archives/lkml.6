Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoJnZjOjypxOPpqTDzc/muYkOe90BXBe0RQfp1WsaFJ8sD5Q4N5mboHQmEnBSCNlYSM4ZKq
ARC-Seal: i=1; a=rsa-sha256; t=1524837788; cv=none;
        d=google.com; s=arc-20160816;
        b=u+jftwt60fTs1pWj080YAGj6RMzpXO7RfLpOqMZH0zMKUsG6VRO5HVr+Di3UzSIUSY
         2Qn5+v7WxT36tVQwuHNMnrKdjqAPapuCk6BAQmecgq+EOVFmX5nql9lHSdGtJpPzKXAt
         DPoj1SftpvCmAVH+Bp2Kyyh/L5Uj+/LkbH9gk48a6/+6/d1B1SXAb/mgS6y9CkE19AIa
         bYpnoazsCKaun+6tdMPlQu8aiX/ma+5zHn34UVmrVdN/HA8wE/4+f+vgJqzjDYhRLJXm
         5sDo66T07wJ4w7/zj3xay2KSq40Aoti1UpByEBUDG9PeljAEx6CfJyxGQHrxq3cvSj6A
         NgUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=xqyIOYdG/ITJ3FSz8tj8dfHUkCi+YwJMqYHyGCmhSaU=;
        b=zOp3tOD8y0mbw2fRNvEk0hmSbyTBieNYryNdVn3baaCuabCLx3mRyJoSPSwgix9E8u
         87B3ZS3vE3u+0oeQ4fJ0kjvUyk0q6a9g00Exz0Yy9nh31zZzeHTlWbmtO9TSHCoNw09a
         CoOj0WH4uhoUabdXlUoKpZGlVXk7nAThEVCZ26LsjaHgMDG/tVAmWT29J9aZeHnvedt1
         ac74ekPndblEqFOPNY5ELqgcxts45AjWusf10Zl9plzlbqadap8mnSXiRrIwMBMzJNLN
         n4OEdwtK2gk0770oasz6TSzfW+zLK+KuR0xd01G92kb7lTj7w17RNlVfNOHMh3yWbTWG
         8m2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F2F218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jean Delvare <jdelvare@suse.de>,
	Jason Andryuk <jandryuk@gmail.com>,
	Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.9 07/74] i2c: i801: Restore configuration at shutdown
Date: Fri, 27 Apr 2018 15:57:57 +0200
Message-Id: <20180427135710.201572728@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908308826008681?=
X-GMAIL-MSGID: =?utf-8?q?1598908308826008681?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1696,6 +1696,15 @@ static void i801_remove(struct pci_dev *
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
@@ -1728,6 +1737,7 @@ static struct pci_driver i801_driver = {
 	.id_table	= i801_ids,
 	.probe		= i801_probe,
 	.remove		= i801_remove,
+	.shutdown	= i801_shutdown,
 	.driver		= {
 		.pm	= &i801_pm_ops,
 	},
