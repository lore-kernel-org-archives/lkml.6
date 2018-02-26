Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELta2Je20lmbeQhPhTEPpeEw3satfbfLmknxwZcZnOLaYjOhVjdKLjxq4q1FtRBxInLF2LQT
ARC-Seal: i=1; a=rsa-sha256; t=1519676755; cv=none;
        d=google.com; s=arc-20160816;
        b=egmO0z+WTxEPiIshbsJz0GyTlrVqmU8bVBgoCwuKZjqhT5zwUsoJYrX9Dy7Ggkq6CZ
         h+ddKKaojQIBQhz+DOqja4/n4AnQUp4Mcr7PVLGjGbB284NWlfPDjFP5OCG8qEv48VPv
         dtTe9xNeB3E55Yw/YGf4bwabDgdqOt+iyl+Mq0SgzJm3J8cjdAzoWMhlLsw72CcWvrLs
         oTNVymYkBdWs2pn6P+y0eozICKhH/cW9fJVDOblpJSf7eAb64uWTSaYOi+iqwCm+0yXq
         YZNrRueOzEu7gHaGcHZlFNzpCEHinEk4t4LZPOJu4coH0c8wt6UjNAYcN7NBZrn6ZKFh
         dkmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ac+3pa5OSHajOyyjXsyeCyS5LX6++1G3mPTrmMww4ao=;
        b=1CdzwpD4d26oQ4wsI+Xse5+uNO6WiJ/jqJdKFMBADPJKz6QMzFQZfBNyPga2U1QidM
         N2CnscvB2Ca9MlcnDKQDAj/YvoG2zJybSb0qGDFoURJEE/gfeg0Q4+Ls3T6kQptjXccL
         qmEwznwy9+a/iTviGtTqv2ZoUUb0koIHJkddxEuiIibe5Xg3MEVXUzedt9CYmZTRkUAu
         /S7b/LUB6FK8ndQoLLgT5Vy+vsm2QtQnw4QLBLIHnWag1OHjZBmlO4PcDmYsvzLPo5JH
         pFLhghCv7dix1GrY0Y+dxZcNz9KVTsDOTS0lgxAd5mx/sXrvjC0Vakys3sVT32IOKLn1
         mQGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.14 42/54] Revert "usb: musb: host: dont start next rx urb if current one failed"
Date: Mon, 26 Feb 2018 21:22:19 +0100
Message-Id: <20180226202146.470724007@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496312946551337?=
X-GMAIL-MSGID: =?utf-8?q?1593496573186781225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bin Liu <b-liu@ti.com>

commit 44eb5e12b845cc8a0634f21b70ef07d774eb4b25 upstream.

This reverts commit dbac5d07d13e330e6706813c9fde477140fb5d80.

commit dbac5d07d13e ("usb: musb: host: don't start next rx urb if current one failed")
along with commit b5801212229f ("usb: musb: host: clear rxcsr error bit if set")
try to solve the issue described in [1], but the latter alone is
sufficient, and the former causes the issue as in [2], so now revert it.

[1] https://marc.info/?l=linux-usb&m=146173995117456&w=2
[2] https://marc.info/?l=linux-usb&m=151689238420622&w=2

Cc: stable@vger.kernel.org # v4.7+
Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musb_host.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -418,13 +418,7 @@ static void musb_advance_schedule(struct
 		}
 	}
 
-	/*
-	 * The pipe must be broken if current urb->status is set, so don't
-	 * start next urb.
-	 * TODO: to minimize the risk of regression, only check urb->status
-	 * for RX, until we have a test case to understand the behavior of TX.
-	 */
-	if ((!status || !is_in) && qh && qh->is_ready) {
+	if (qh != NULL && qh->is_ready) {
 		musb_dbg(musb, "... next ep%d %cX urb %p",
 		    hw_ep->epnum, is_in ? 'R' : 'T', next_urb(qh));
 		musb_start_urb(musb, is_in, qh);
