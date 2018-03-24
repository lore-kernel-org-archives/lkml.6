Return-Path: <Valentin.Vidic@carnet.hr>
X-Google-Smtp-Source: AG47ELt7USCMO3TrLWGqr7guMl1YRpNb7Fos6n0Iq5FNc9aSWDpyIPCZsLKmxCfaQdSaqHvaEQIf
ARC-Seal: i=1; a=rsa-sha256; t=1521929371; cv=none;
        d=google.com; s=arc-20160816;
        b=FQyaKOyH6Li/wcT67SVfv+/rof9WZGxxAFVJoFqIoDrFPRGG2tAypwieWca8DyZt2j
         UvLCUXoONwli+ptSFKAyML7otlwwthVF0JI0pEpWHKQ/GPkW2MlDx/AVSOCyQCoYQFuJ
         EJC6ZGK+pPPEFRiYx5KeM+Xc3Cd4T1BdtgfF9cmCRWzkCjy8RLB9xg5xfe3zxCXQNd59
         qoVHYPxcpi/i5qnb2zTAL5CKMFXdKVbZV1TVVyeyRjdVHznn5qhZWhhCngNfdfvtESp2
         e3w+n2UJANK2Ng1RdHCkVNRb+1wHSWxWBxatU3z61UE8jhM23j8TkO7ARJMJUKo7ywbN
         CPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=OpoNPc+/ZnNBMKiExSySAX4PTA51SDjO8gq2cTceafs=;
        b=xjN4XklRx1OKF60Uto6INUvnSQDemL/q41j4B4rGkGtAjnT75yaSayd3WFJbWTT7H2
         ci6pQKQdsdyA/ki7LUX1qSDoApbPhmR4mkuGXtrFYO5GwL2iw8BnvMh5u/0zo9IiKzGE
         s7RDR9izQfz9YKnG0ZXaBm9XMRAKonyNBYiDDmLSQqqddn4F0c/S0V2NS2CZ/N1W61Eq
         Lwa2nFhPvMFe/R4cTGC7BjEI8zAtQACl9bxLlkJz7q3shnHH+cmBho+nRMnCCaQfoB/I
         wFPlOM2TjS/kj3iaD4K7C5iVSG3xiNdKH9aubNRmhYO7XCyt1CEwg5eaucDmx8PQx2Mh
         almg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of valentin.vidic@carnet.hr designates 2001:b68:ff:2::6 as permitted sender) smtp.mailfrom=Valentin.Vidic@carnet.hr
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of valentin.vidic@carnet.hr designates 2001:b68:ff:2::6 as permitted sender) smtp.mailfrom=Valentin.Vidic@carnet.hr
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Marcus Wolf <linux@Wolf-Entwicklungen.de>
Cc: =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Luca=20S=C3=B6the?= <luca@acul.me>,
	Marcin Ciupak <marcin.s.ciupak@gmail.com>,
	Michael Panzlaff <michael.panzlaff@fau.de>,
	Derek Robson <robsonde@gmail.com>,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Valentin Vidic <Valentin.Vidic@CARNet.hr>
Date: Sat, 24 Mar 2018 23:09:01 +0100
Message-Id: <20180324220901.28864-1-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323221821.GP31333@gavran.carpriv.carnet.hr>
References: <20180323221821.GP31333@gavran.carpriv.carnet.hr>
X-SA-Exim-Connect-IP: 2001:b68:ff:12::131
Subject: [PATCH] staging: pi433: cleanup tx_fifo locking
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595858611986140569?=
X-GMAIL-MSGID: =?utf-8?q?1595858611986140569?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

pi433_write requires locking due to multiple kfifo writers.  After
acquiring the lock check if enough free space is available in the kfifo
to write the whole message. This check should prevent partial writes to
kfifo so kfifo_reset is not needed anymore.

pi433_tx_thread is the only kfifo reader so it does not require locking
after kfifo_reset is also removed.

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
 drivers/staging/pi433/pi433_if.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index d1e0ddbc79ce..97239b0eb322 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -87,7 +87,7 @@ struct pi433_device {
 
 	/* tx related values */
 	STRUCT_KFIFO_REC_1(MSG_FIFO_SIZE) tx_fifo;
-	struct mutex		tx_fifo_lock; // TODO: check, whether necessary or obsolete
+	struct mutex		tx_fifo_lock; /* serialize multiple writers */
 	struct task_struct	*tx_task_struct;
 	wait_queue_head_t	tx_wait_queue;
 	u8			free_in_fifo;
@@ -589,19 +589,15 @@ pi433_tx_thread(void *data)
 		 * - size of message
 		 * - message
 		 */
-		mutex_lock(&device->tx_fifo_lock);
-
 		retval = kfifo_out(&device->tx_fifo, &tx_cfg, sizeof(tx_cfg));
 		if (retval != sizeof(tx_cfg)) {
 			dev_dbg(device->dev, "reading tx_cfg from fifo failed: got %d byte(s), expected %d", retval, (unsigned int)sizeof(tx_cfg));
-			mutex_unlock(&device->tx_fifo_lock);
 			continue;
 		}
 
 		retval = kfifo_out(&device->tx_fifo, &size, sizeof(size_t));
 		if (retval != sizeof(size_t)) {
 			dev_dbg(device->dev, "reading msg size from fifo failed: got %d, expected %d", retval, (unsigned int)sizeof(size_t));
-			mutex_unlock(&device->tx_fifo_lock);
 			continue;
 		}
 
@@ -634,7 +630,6 @@ pi433_tx_thread(void *data)
 				   sizeof(device->buffer) - position);
 		dev_dbg(device->dev,
 			"read %d message byte(s) from fifo queue.", retval);
-		mutex_unlock(&device->tx_fifo_lock);
 
 		/* if rx is active, we need to interrupt the waiting for
 		 * incoming telegrams, to be able to send something.
@@ -818,7 +813,7 @@ pi433_write(struct file *filp, const char __user *buf,
 	struct pi433_instance	*instance;
 	struct pi433_device	*device;
 	int                     retval;
-	unsigned int		copied;
+	unsigned int		required, available, copied;
 
 	instance = filp->private_data;
 	device = instance->device;
@@ -833,6 +828,16 @@ pi433_write(struct file *filp, const char __user *buf,
 	 * - message
 	 */
 	mutex_lock(&device->tx_fifo_lock);
+
+	required = sizeof(instance->tx_cfg) + sizeof(size_t) + count;
+	available = kfifo_avail(&device->tx_fifo);
+	if (required > available) {
+		dev_dbg(device->dev, "write to fifo failed: %d bytes required but %d available",
+			required, available);
+		mutex_unlock(&device->tx_fifo_lock);
+		return -EAGAIN;
+	}
+
 	retval = kfifo_in(&device->tx_fifo, &instance->tx_cfg,
 			  sizeof(instance->tx_cfg));
 	if (retval != sizeof(instance->tx_cfg))
@@ -856,7 +861,6 @@ pi433_write(struct file *filp, const char __user *buf,
 
 abort:
 	dev_dbg(device->dev, "write to fifo failed: 0x%x", retval);
-	kfifo_reset(&device->tx_fifo); // TODO: maybe find a solution, not to discard already stored, valid entries
 	mutex_unlock(&device->tx_fifo_lock);
 	return -EAGAIN;
 }
-- 
2.16.2
