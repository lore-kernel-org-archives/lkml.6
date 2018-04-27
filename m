Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrbO2NWvXWhlnOLfp1UHYmtVBUkoEmsxao3HcXJwdeSfnBgviJZzYvEZaAURf/oaD+mR5/t
ARC-Seal: i=1; a=rsa-sha256; t=1524838389; cv=none;
        d=google.com; s=arc-20160816;
        b=UClGP38m3uYymwRWCbMn8Kp3vj76lAHXsRTgUNyrHQf4uA/7tIoz0mAfG98vGfs20g
         7XfXNRAF2pk7Xf2Gl0JZjsl6As1hWJgMWZ1gpydhvNX1jvinvCgssQ98ZEOxuXDAgNFM
         DGkCgFPe6FmHTZn0vCFAhxs1C3eBKSAA3qV0L3uRy4FLwFwMMQF1XhXZnor/cAEgvKf9
         U3hU7jo18tDcW3t++UbAwFAx4ZLjHNHDQ8/7yjqu5aZu8P0Ts2Oc8tE4Jr65BT1t3yI1
         sG0L4jTdcbXWfhD2kLQiB1mykqn7gvBdZKaou1+zAvWknOUwQPQNTRwEGuNRbCaGkZhO
         7ioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=xUflj9CjFArosWRmZ8RBufa+4cZUFzqY/sDF7w3hHSU=;
        b=jTf5DKPN3RXsnjC7LX1Y1EQt8wVUAoKDuBgoo1pntjmIKYAapdj5tj0e/snvIz42jX
         txBW4R4VnXWVquIEU+qahD7LxumywFp/df+COHRbsME+4RD2svvFileERVCALnRf6Mqj
         jd++eAkSC1t3mHFSJCbpUo9EH2kI51WK0jc3Ex4NSBZiG3LqpqRpcSgYp2lBEoiTjTOe
         Z0KNFt6VXy6ZPBBv3A+oldGQO1BWs129htyTRo46jjbfN5pSvu7HbYvd+M8u4G70hejy
         oM/XkSCXlark1bmDLCq7rdIUepV0PpeWQtqnex3Rqd5DuXiEY5y31v4eWJB/tPwgCbLD
         Z3mw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1358E218CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.16 74/81] hwmon: (k10temp) Add temperature offset for Ryzen 2700X
Date: Fri, 27 Apr 2018 15:59:16 +0200
Message-Id: <20180427135747.577868131@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908939398468698?=
X-GMAIL-MSGID: =?utf-8?q?1598908939398468698?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

commit 1b59788979acd230b9627276c76f6e6ba2c4709c upstream.

Ryzen 2700X has a temperature offset of 10 degrees C. If bit 19 of the
Temperature Control register is set, there is an additional offset of
49 degrees C. Take this into account as well.

Cc: stable@vger.kernel.org # v4.16+
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwmon/k10temp.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -72,6 +72,7 @@ struct k10temp_data {
 	struct pci_dev *pdev;
 	void (*read_tempreg)(struct pci_dev *pdev, u32 *regval);
 	int temp_offset;
+	u32 temp_adjust_mask;
 };
 
 struct tctl_offset {
@@ -84,6 +85,7 @@ static const struct tctl_offset tctl_off
 	{ 0x17, "AMD Ryzen 5 1600X", 20000 },
 	{ 0x17, "AMD Ryzen 7 1700X", 20000 },
 	{ 0x17, "AMD Ryzen 7 1800X", 20000 },
+	{ 0x17, "AMD Ryzen 7 2700X", 10000 },
 	{ 0x17, "AMD Ryzen Threadripper 1950X", 27000 },
 	{ 0x17, "AMD Ryzen Threadripper 1920X", 27000 },
 	{ 0x17, "AMD Ryzen Threadripper 1900X", 27000 },
@@ -129,6 +131,8 @@ static ssize_t temp1_input_show(struct d
 
 	data->read_tempreg(data->pdev, &regval);
 	temp = (regval >> 21) * 125;
+	if (regval & data->temp_adjust_mask)
+		temp -= 49000;
 	if (temp > data->temp_offset)
 		temp -= data->temp_offset;
 	else
@@ -259,12 +263,14 @@ static int k10temp_probe(struct pci_dev
 	data->pdev = pdev;
 
 	if (boot_cpu_data.x86 == 0x15 && (boot_cpu_data.x86_model == 0x60 ||
-					  boot_cpu_data.x86_model == 0x70))
+					  boot_cpu_data.x86_model == 0x70)) {
 		data->read_tempreg = read_tempreg_nb_f15;
-	else if (boot_cpu_data.x86 == 0x17)
+	} else if (boot_cpu_data.x86 == 0x17) {
+		data->temp_adjust_mask = 0x80000;
 		data->read_tempreg = read_tempreg_nb_f17;
-	else
+	} else {
 		data->read_tempreg = read_tempreg_pci;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(tctl_offset_table); i++) {
 		const struct tctl_offset *entry = &tctl_offset_table[i];
