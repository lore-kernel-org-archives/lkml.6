Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx489uNVRkYiJfjINkTPqioE05+nEQe6koSU8HKiZ0OS3yGVc0mWSNWVr5nuWFJGBYmAH9b03
ARC-Seal: i=1; a=rsa-sha256; t=1523022195; cv=none;
        d=google.com; s=arc-20160816;
        b=OMKQLbcSeQZio7yw3qQCfYYW1BhBSzMYuMaNgPWWyh/Cc9bCCnQ50GBOpKbazF1tiw
         aUouKNTo6Kk877x4V3VApm3KhvZBODcjkO3+NppwxEtMnqfyXJYnv/AmurImgwuPHixx
         gNMd5u6N0Cdll7vF5dM/S8Hg2VOnasSSWKVAOubVQVj5Edp+96UqBvQRQuS5jH7bQRKZ
         dZr/EC8i9XZjSDLNW4hACwvzNm8adQeytEkkodTc0BCebmMhFLURv05d/9CXUiO1CKx3
         sES6oDMVyPBAe/3/vK+RUiaCz0nQ9bF2ec4IFb9tITshms32qMXzNRTL98qltWIOgAS2
         mQ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cagQhx069B8e23JYcrYzhJWhCbKsaTGtW3/6+ht8srg=;
        b=0rSRZaIekRljwZx2ZNKVHq0IC61S+bG9Km+UUNqZFcOXTrtxHYP6YWnl2RR5dIIjK9
         n3gbJcZ8vTf6sWxabaAfKt/c01gSQ0MHUsKxEZmAdnX/CpuVEGFHP33ZI2HYLvtbO2CH
         kLYzkI6saCG9mhc40KDJ0aUFY1PSdOgZVUVpBePKwU5IRcAjvhdMrJB3BXGVsTtE7Ug8
         K0v/fqmZl9ZrT1+iTGX6vMKX25WqP7WYH1nLIP9sccPjHzO206u8yntV464Ff7RgRlkM
         EiCYNqltdfOJ7c4MW3lqDSD/4o2rI0V4CF3N/xHsNZMHyX/b4fnEgMN3SLODApRCjSZq
         JGuA==
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
Subject: [PATCH 4.15 60/72] staging: comedi: ni_mio_common: ack ai fifo error interrupts.
Date: Fri,  6 Apr 2018 15:24:35 +0200
Message-Id: <20180406084353.478161938@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003849053166920?=
X-GMAIL-MSGID: =?utf-8?q?1597004522138789606?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
