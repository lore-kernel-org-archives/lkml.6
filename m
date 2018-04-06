Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+G2G2jdBczL7pKVbyUdG4OLTsUYOQXWUBob82PrG3PwW1AbR1aNUWpUseuwK+Va6daDfAQ
ARC-Seal: i=1; a=rsa-sha256; t=1523021554; cv=none;
        d=google.com; s=arc-20160816;
        b=z4eiX+s5TlnOWTZ/Ut3JZlDDMwMMkHHjCvyi0n1/eeBcEU726/X8aNBUFPZe81ynHs
         0oyQBshXA2y6VWOThOVVxL75JU7EC9ZbIkKByExgkNFxo4PJ1Sj+KrUAvTlmZRpkVAXe
         SmsOiYBO9wbY94piDblgK7HXPg5j7WbQLCm+umovg4pyP2l+0NEdPvfP7wBeQJNfjYCB
         E2FG97ylC2ORMqC9dichB7zMKHg5SGDyZEFXLtQHpMcyetHoV8z/cqkUZcc+Il73/0Tj
         8bvfWp/FE8WdoEi+JJ+cIJhkqoOEF2xtBYDdUm2VVeYaLhgyf463oAgGq0cqXJPU/978
         K3ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WPR0t3Y319y0Osk77ODrNQKLqXoitV/RDc0W4H/UqEs=;
        b=D4sExH7KfezKuTaRon6FzJheQSlWBDvK4B7Ydnc5y6hzxwgCgkKxcqxS3sSmWI9b0L
         CWCNtCufJDTp6mlVY3ExND/RQ8QBGykxFcpPA7Bv7aLLZKa5T+ZcmbQjrxSMKtxbMafR
         dL+ZXjyodHML9C7xlCrJSxoED647CFSI3lb3J4wp01JaOM+rUVWZyxp0JpPeIIOmOfUj
         rSKpDH8pCPiIXfgMz2J+qbyCGaEzD6kKCt+G/VzQKEWb5LwwSHPrIoM0c+4O+yMmRP+v
         r62IS99r3+B3KP7ZvFj5E0zM1N6Q0dpu/1u5bspOpOvUqFn1xBLOjlBa9D661v4TY+UZ
         THkA==
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
Subject: [PATCH 4.4 54/72] staging: comedi: ni_mio_common: ack ai fifo error interrupts.
Date: Fri,  6 Apr 2018 15:23:55 +0200
Message-Id: <20180406084309.806259873@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003849053166920?=
X-GMAIL-MSGID: =?utf-8?q?1597003849053166920?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1348,6 +1348,8 @@ static void ack_a_interrupt(struct comed
 		ack |= NISTC_INTA_ACK_AI_START;
 	if (a_status & NISTC_AI_STATUS1_STOP)
 		ack |= NISTC_INTA_ACK_AI_STOP;
+	if (a_status & NISTC_AI_STATUS1_OVER)
+		ack |= NISTC_INTA_ACK_AI_ERR;
 	if (ack)
 		ni_stc_writew(dev, ack, NISTC_INTA_ACK_REG);
 }
