Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELukluHTi4vlF+46oo6InsDI1kZbfKLwG6xhWpjgjemJAxdvEMPuzhEFjH2hBozpKc4hlfdL
ARC-Seal: i=1; a=rsa-sha256; t=1521800353; cv=none;
        d=google.com; s=arc-20160816;
        b=nppXn7WZ85kdubNwG2e+qp/NGDe82tDogeiq5WiwJhLWMRnxa2I3CdXuS+QaHH9hHM
         1CZ09+Xoc9wCm/sQCGn/SSsVF2ZKsaO54MDVCNSGH4GmXRn0roIRrMO6T1+kCGdwaOda
         ZHSi3bYkQ+n1ArQClyNqfR6e+2OYlzN+H4pmEhGOIjiSs8uVyjPVSvlaVNj16tbEMsWd
         TQ+m7bsrUAeAVPD8pRLIVZO3dx0oRi2IKK4XZffJpBdw8vPVoRlqX2rfPOYLKUizGnwB
         jPIwTW43obiDzc7yBpEOQq5sss3z105+ZYlYNoffa1BrPcC2vU+YGL6wFmsuaSKqmk1d
         447A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XD1g6vSnYvnj1tulIIB+ZU0tpbwTqrguHTwYm6nzg00=;
        b=wdu4sG9TIokrfxCNk4l2qFidXYGWqnUBwVyKxmTYPT6dzRPd7vWHifNw5PbZKGdnYI
         EAaD15TB9e+tIYG+lA1/NMHMrLDeLTnHqU+t1twFV/BcEfz2XoTxDuRBDYI593wd3c+7
         D6ZqXr3rLB54j4wTKuQBKUIT5I/4OFrFOo+92rv7y5eQM+3yJaSLvHkdfviJQuCWgN6/
         sZD1Qs0wnY9v6V0oTWvpl+kmPEIkpzYbDXz/zQuj8t8arRn1oqmI1/jw9kH428Yj6g3u
         OgN/GfW3+iUk/Ts6TWcJygecpcqRw+riLdVkqIyZuqmAVa5aBHAfg80dU6FaoLLZkAyZ
         nTjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Finn Thain <fthain@telegraphics.com.au>,
	Michael Schmitz <schmitzmic@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 23/47] scsi: mac_esp: Replace bogus memory barrier with spinlock
Date: Fri, 23 Mar 2018 10:55:14 +0100
Message-Id: <20180323094249.111998633@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722559181151791?=
X-GMAIL-MSGID: =?utf-8?q?1595723327368641818?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Finn Thain <fthain@telegraphics.com.au>


[ Upstream commit 4da2b1eb230ba4ad19b58984dc52e05b1073df5f ]

Commit da244654c66e ("[SCSI] mac_esp: fix for quadras with two esp
chips") added mac_scsi_esp_intr() to handle the IRQ lines from a pair of
on-board ESP chips (a normal shared IRQ did not work).

Proper mutual exclusion was missing from that patch. This patch fixes
race conditions between comparison and assignment of esp_chips[]
pointers.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/mac_esp.c |   33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

--- a/drivers/scsi/mac_esp.c
+++ b/drivers/scsi/mac_esp.c
@@ -55,6 +55,7 @@ struct mac_esp_priv {
 	int error;
 };
 static struct esp *esp_chips[2];
+static DEFINE_SPINLOCK(esp_chips_lock);
 
 #define MAC_ESP_GET_PRIV(esp) ((struct mac_esp_priv *) \
 			       platform_get_drvdata((struct platform_device *) \
@@ -562,15 +563,18 @@ static int esp_mac_probe(struct platform
 	}
 
 	host->irq = IRQ_MAC_SCSI;
-	esp_chips[dev->id] = esp;
-	mb();
-	if (esp_chips[!dev->id] == NULL) {
-		err = request_irq(host->irq, mac_scsi_esp_intr, 0, "ESP", NULL);
-		if (err < 0) {
-			esp_chips[dev->id] = NULL;
-			goto fail_free_priv;
-		}
+
+	/* The request_irq() call is intended to succeed for the first device
+	 * and fail for the second device.
+	 */
+	err = request_irq(host->irq, mac_scsi_esp_intr, 0, "ESP", NULL);
+	spin_lock(&esp_chips_lock);
+	if (err < 0 && esp_chips[!dev->id] == NULL) {
+		spin_unlock(&esp_chips_lock);
+		goto fail_free_priv;
 	}
+	esp_chips[dev->id] = esp;
+	spin_unlock(&esp_chips_lock);
 
 	err = scsi_esp_register(esp, &dev->dev);
 	if (err)
@@ -579,8 +583,13 @@ static int esp_mac_probe(struct platform
 	return 0;
 
 fail_free_irq:
-	if (esp_chips[!dev->id] == NULL)
+	spin_lock(&esp_chips_lock);
+	esp_chips[dev->id] = NULL;
+	if (esp_chips[!dev->id] == NULL) {
+		spin_unlock(&esp_chips_lock);
 		free_irq(host->irq, esp);
+	} else
+		spin_unlock(&esp_chips_lock);
 fail_free_priv:
 	kfree(mep);
 fail_free_command_block:
@@ -599,9 +608,13 @@ static int esp_mac_remove(struct platfor
 
 	scsi_esp_unregister(esp);
 
+	spin_lock(&esp_chips_lock);
 	esp_chips[dev->id] = NULL;
-	if (!(esp_chips[0] || esp_chips[1]))
+	if (esp_chips[!dev->id] == NULL) {
+		spin_unlock(&esp_chips_lock);
 		free_irq(irq, NULL);
+	} else
+		spin_unlock(&esp_chips_lock);
 
 	kfree(mep);
 
