Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+PXl96+SJ3oNKwZA3imflxo+72ht1floWn5p81x8UEnQF9lhy1+VWAMledKiLGrXAYMzai
ARC-Seal: i=1; a=rsa-sha256; t=1523021772; cv=none;
        d=google.com; s=arc-20160816;
        b=l9zmfvFX/q8e+rjQ2fdGJC9SaxlIIhanRVtkyFSWzGUd01CjUyBFMwoa1wjZNyOtqy
         BjPYlaJGfmgWGMlugDiGyIE2cEqQHmwBOw7qbp1CDlQ8w4B/wr1J7CS3hokG87IDrzDl
         PHk82hM6+keWgeTwFCJOV1lcDWuGS6uWLKIWmIASq0/NBcy2HCqMqZb9FzgXazrWkRjE
         Q2ZAU5eeraleDMwXIm1Ulvtdb2QEoMPxXxioL9hnnD8ECPR5SXENNtg+AfFnoazBHBi6
         GUgg4Mi9i+fLzyK+/tNPksOfxQ2WTYeXfnCWOvKyR3dL4Zq8Md3aMKatzN4lw9GgQ43x
         q/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=B2282KhlhKmCCumvQPi3G2LoXUW4iqqsHQoXvSqv6Tk=;
        b=cfWgnP1xTZEiE7n4GAramVPVqC+/KmyXyOzCIGGoZvhEi7kxGGzOxb8d1mLexH5v9t
         kdWX0FLyObBAKOrywKLfBnkNoCyzPDlFCrgEuqPMCyS/zALstAB248LeYKlfs5yTl3e4
         XdPScIwTx6F56BGrFrBzATmsULCtnybb3bC15GS9RFc0t8dGZqc/LudxCLJ3f3xlMAcU
         D27OJWymBowjiLGG14m7gIeuU5k6k+nnv5C6iRAOk4XlPOf6e7a/X0O3TC+zbjwrbJR9
         o/he9jdJgIf8F8hz4QUal/Y99wGtm0fv3vLekn3A3IKvYBTZGIzPyM0RL2fRreu5b4ik
         LTCQ==
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
Subject: [PATCH 4.9 085/102] staging: comedi: ni_mio_common: ack ai fifo error interrupts.
Date: Fri,  6 Apr 2018 15:24:06 +0200
Message-Id: <20180406084343.386535461@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003849053166920?=
X-GMAIL-MSGID: =?utf-8?q?1597004078216175819?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
