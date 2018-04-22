Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/q5JsXQqRD3XqArALNNl5XS/fYO16TEFXC9AqekVJSHprAnGlIiOElOw9zsrSXN6bZhZYl
ARC-Seal: i=1; a=rsa-sha256; t=1524406235; cv=none;
        d=google.com; s=arc-20160816;
        b=ZKfKc1Vezh4KDz4KtWhavXPem+TSjTQD1QoTQHSF5qbg7H9XT6q+tzbv/rouqdp9Gr
         UBIVgnWj4Bteax64Zc6RXHUzYxBtX6CwETneR6KhR0g+x0dzhCo5C2FHAaYjioJBBSN1
         21ghJNRRQ+LAVwoY5x7KC0C3bZbndpG2W0Jlk3pClm74qqLvcz9pvUhQS+ge6TL4qAqg
         XHaJVpUg30FiqDg53xbbn81OqQLsA2eSNJnzBLheEgMcYbK15YLsZFyJEzeRUmZ1pO/P
         EtWuukchOR/t5xpIEVRJx/Bq3V575rDvYvw9Yof4LEggavjja5i53TpiIH2k0W/avB75
         GTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=F42ommjKoubOTKRHrSQPWINBcsfK+sMPI0nxNnBJDXk=;
        b=0259rF5OT2PA3zcUZ0FmvqkY9xn9vktJJQF4GvmzcBW0cdZKWOYnLtvUMq4jGb3hgQ
         U5nVPScXag1sY+oEIPujtn6vsGU3cJS8B2CMVnJHFi33Ak48py6Cqu0+6cSS8xNrmUyQ
         bLzHMgl8uqBjT77+0Xuwtuvt4bRzX19Py9RFxXDjcW/jQ8Uzow1lGVhluayzXoQH7IdJ
         noydHlLlP1dGReO8TmyVofRYt7FXpMziZXEgl3tDaviqyL5eUEgMV5wHBj3WMHOdx1XC
         HQ6z/ta8ZpWq2+IWkqiS/7P9jVcmaJHYpiIMAPqMbUxQTSA9R3cUlI7VFwUWcf0xnLT3
         /UPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Warren Sturm <warren.sturm@gmail.com>,
	Sean Young <sean@mess.org>
Subject: [PATCH 4.14 162/164] Revert "media: lirc_zilog: driver only sends LIRCCODE"
Date: Sun, 22 Apr 2018 15:53:49 +0200
Message-Id: <20180422135142.250357476@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455792446088014?=
X-GMAIL-MSGID: =?utf-8?q?1598455792446088014?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Young <sean@mess.org>

[not upstream as the driver is deleted in 4.16 - gregkh]

The lirc config documented here
https://www.blushingpenguin.com/mark/blog/?p=24 uses raw_codes for sending
IR. Each key only has one pulse, which in fact is an index into the
haup-ir-blaster.bin file. Changing the driver to LIRCCODE (although more
accurate) breaks this configuration.

This code has been replaced completely in kernel v4.16 by a new driver,
see commit acaa34bf06e9 ("media: rc: implement zilog transmitter"), and
commit f95367a7b758 ("media: staging: remove lirc_zilog driver").

This reverts commit 89d8a2cc51d1f29ea24a0b44dde13253141190a0.

Fixes: 615cd3fe6ccc ("[media] media: lirc_dev: make better use of file->private_data")

Cc: stable@vger.kernel.org # v4.14-v4.15
Reported-by: Warren Sturm <warren.sturm@gmail.com>
Tested-by: Warren Sturm <warren.sturm@gmail.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/media/lirc/lirc_zilog.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/staging/media/lirc/lirc_zilog.c
+++ b/drivers/staging/media/lirc/lirc_zilog.c
@@ -288,7 +288,7 @@ static void release_ir_tx(struct kref *r
 	struct IR_tx *tx = container_of(ref, struct IR_tx, ref);
 	struct IR *ir = tx->ir;
 
-	ir->l.features &= ~LIRC_CAN_SEND_LIRCCODE;
+	ir->l.features &= ~LIRC_CAN_SEND_PULSE;
 	/* Don't put_ir_device(tx->ir) here, so our lock doesn't get freed */
 	ir->tx = NULL;
 	kfree(tx);
@@ -1267,14 +1267,14 @@ static long ioctl(struct file *filep, un
 		if (!(features & LIRC_CAN_SEND_MASK))
 			return -ENOTTY;
 
-		result = put_user(LIRC_MODE_LIRCCODE, uptr);
+		result = put_user(LIRC_MODE_PULSE, uptr);
 		break;
 	case LIRC_SET_SEND_MODE:
 		if (!(features & LIRC_CAN_SEND_MASK))
 			return -ENOTTY;
 
 		result = get_user(mode, uptr);
-		if (!result && mode != LIRC_MODE_LIRCCODE)
+		if (!result && mode != LIRC_MODE_PULSE)
 			return -EINVAL;
 		break;
 	default:
@@ -1512,7 +1512,7 @@ static int ir_probe(struct i2c_client *c
 		kref_init(&tx->ref);
 		ir->tx = tx;
 
-		ir->l.features |= LIRC_CAN_SEND_LIRCCODE;
+		ir->l.features |= LIRC_CAN_SEND_PULSE;
 		mutex_init(&tx->client_lock);
 		tx->c = client;
 		tx->need_boot = 1;
