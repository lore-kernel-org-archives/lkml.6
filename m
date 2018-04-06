Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49IzQ6DwaQqIaQAoyDGy6UlsAt1QOL88apEMb7BVwZT9jJhYkTgsJ0H2bhOxvF6kPUUosAk
ARC-Seal: i=1; a=rsa-sha256; t=1523021981; cv=none;
        d=google.com; s=arc-20160816;
        b=hieAEZ9pdqBJq4+IScPpZZ2wfJN0PCA8+qTxF+XgEKUuUjMxpeIECIPI9x8untfZPR
         4Zg0baS0IY1e/FN1OV/ff8SrD3QQiOTFKG21HEo+ZGUkI63MVvUwCgBTOuVOsoH8sQ4G
         /QRbkARRoFRnRy0miMOm3WT/EORjdmUUIBhf62Fyd/vGwcSZay46uIYGaHqxsHjvlY6M
         HCK7VMxAeZFWUaFL6/YmlP4oRcKIGnAbmI8mhVF4AlZtxxKvkbjQzK7JvYnLT9hRyOQY
         KYXu4+7iMO1uwVvM5aXPp85b2ZEcOWdozhSQplx7ACcpa+0TBKSyXEeIxZh8ShmeCBaC
         L0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qkLR2N4ebugq+ngMQKSP8N/LTVlqIaPWV2ZZdYr/rzI=;
        b=eoR2l7an8x5L57vsYZUty5bLtnWZ2W5e/n6X5IXrfvpYpOt6QNzU2SMJTjRAxOH6WY
         JtSm8J/w7E4AMhvvH7ooxeLO3pg6v+nutHzU39g1BKacd7gak297A0fyCZslay7nB6WK
         jICdA6nQHUyVR7FjaJTLJhhvhc+/ewHcrm3qP1IQHlMYcQ4fPvgD7z0KEzxfRUwfhwSZ
         E3Hpz/casC4ZM7uUCMVAp+pqtaJfMCfBmXgwH3yqB0bIXx7XlMk1Lh7s30KVhMRNV0Fm
         13wmR9VerLssrUZzIAKmkBz+jAXEX8S9Ae1IGmBYjPGkzWKCVQl8sYwlgv0pPEMb7zxC
         wv5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Frank Mori Hess <fmh6jj@gmail.com>,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4.14 55/67] staging: comedi: ni_mio_common: ack ai fifo error interrupts.
Date: Fri,  6 Apr 2018 15:24:25 +0200
Message-Id: <20180406084347.978784022@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003849053166920?=
X-GMAIL-MSGID: =?utf-8?q?1597004296982043445?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frank Mori Hess <fmh6jj@gmail.com>

commit e1d9fc04c41840a4688ef6ce90b6dcca157ea4d7 upstream.

Ack ai fifo error interrupts in interrupt handler to clear interrupt
after fifo overflow.  It should prevent lock-ups after the ai fifo
overflows.

Cc: <stable@vger.kernel.org> # v4.2+
Signed-off-by: Frank Mori Hess <fmh6jj@gmail.com>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/comedi/drivers/ni_mio_common.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/staging/comedi/drivers/ni_mio_common.c
+++ b/drivers/staging/comedi/drivers/ni_mio_common.c
@@ -1284,6 +1284,8 @@ static void ack_a_interrupt(struct comed
 		ack |= NISTC_INTA_ACK_AI_START;
 	if (a_status & NISTC_AI_STATUS1_STOP)
 		ack |= NISTC_INTA_ACK_AI_STOP;
+	if (a_status & NISTC_AI_STATUS1_OVER)
+		ack |= NISTC_INTA_ACK_AI_ERR;
 	if (ack)
 		ni_stc_writew(dev, ack, NISTC_INTA_ACK_REG);
 }
