Return-Path: <sudipm.mukherjee@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518032889; cv=none;
        d=google.com; s=arc-20160816;
        b=CIj7Agprr1tq2A+0mhkPjgLNyRIk6hJeZ1YEn40hLgi0gIZTnZanB+ySeOIbb78eEk
         5eQ9TdG+Jerh76rSRbuUp6Frix+w5W2ZsYeloSMWYuH2xpPF5C0cB8Y6ceB8wVBdzo4K
         rVilxY6uKZWT72usR2H9F4L8hot88Tja8ixnkUFhKPt1b3sHZfE3AIQDxiZ2LHHuWp+Z
         krrBjV3Pz2MiShxabg6x7h5Il3IqTIhfpBLTQ/Vso2XyIVH8zU7ha61TjBdIib+TgL9c
         et8UFymIRy897AnKYpf+MflMwR6ffyiEFxi8CeawpDJVmKc573swgk5gCpkAuf6A88lT
         u+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=/RgU6eyLvSWemOXpG/tcdoDOlkj5ibcr38fNeWCbPbk=;
        b=lKgirwoZcw8m/ydeLjDs+F0hNqk6k9IbOZFYsCxeTkS3rbDXu4i4zxjLrpvNvpDc21
         rKjfzBPoOtMPooozgDnAqur9xwmA+TJl8lpAN4CQOrZE7IBmLaGEOe6BTgE+Z7ar8Un2
         aXLWVnuFYap5YmWJElud8WfZHfXDBuxZaz0TTOuTvHdfxtnQwJLteL1DIohr2atAWYAJ
         3VRD+YOtFluCWRLvnW51BHqUb108ULz3C1mA+UF58jU15vOvQZXnPPQ2QZy1gqxW9YvQ
         K1qNu4I4EMan0n3GYQNouuLiqai/IwyomwftaQyvhe/YGh9UrGPWBK1JQLfUlTwA7lAF
         rPgA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UUTMxH15;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UUTMxH15;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x2255oeP/rEodgODvu8Rn16qx3SkLyn560wbHRdRLbl0eTYoDrgxQA5l8m08mHjgByILk1FvRVw==
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 07/12] parport: Don't shadow error codes in ->probe()
Date: Wed,  7 Feb 2018 19:47:54 +0000
Message-Id: <1518032879-5844-7-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591772854886441632?=
X-GMAIL-MSGID: =?utf-8?q?1591772854886441632?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

When ->probe() calls helper functions return theirs error codes
instead of shadowing them.

Tested-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_serial.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 050eeb0..c222698 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -539,12 +539,10 @@ static int serial_register(struct pci_dev *dev, const struct pci_device_id *id)
 	struct serial_private *serial;
 
 	board = &pci_parport_serial_boards[id->driver_data];
-
 	if (board->num_ports == 0)
 		return 0;
 
 	serial = pciserial_init_ports(dev, board);
-
 	if (IS_ERR(serial))
 		return PTR_ERR(serial);
 
@@ -630,14 +628,16 @@ static int parport_serial_pci_probe(struct pci_dev *dev,
 	if (err)
 		return err;
 
-	if (parport_register(dev, id))
-		return -ENODEV;
+	err = parport_register(dev, id);
+	if (err)
+		return err;
 
-	if (serial_register (dev, id)) {
+	err = serial_register(dev, id);
+	if (err) {
 		int i;
 		for (i = 0; i < priv->num_par; i++)
 			parport_pc_unregister_port (priv->port[i]);
-		return -ENODEV;
+		return err;
 	}
 
 	return 0;
-- 
2.7.4
