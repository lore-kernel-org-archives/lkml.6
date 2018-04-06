Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49TbjbHE6bbRojXi34j8xUEgCOhvQAzhjCupoc3LqWo3WO0G4r7p4+VfkHOUjmoxa0+GPmR
ARC-Seal: i=1; a=rsa-sha256; t=1523022299; cv=none;
        d=google.com; s=arc-20160816;
        b=RpPC/l3uVvTt8r3LM0/ipZ6L3OacYNua3+zpPTONOA2EiYqQvtvJ6dhC8lbNfPqdXW
         BuvWxwdEJ6hMS47K/9T9VjAhaGsMZ4wwnIBHzrXa8GST+puW5Isgg8aGHiuhPqwQyC+d
         099zsOK6NdNc2pk3m5+Su2jkRuftDqRgFbvaT9gDlRnwCSxlNUi9BUHreGC6CBudVuJf
         SR3fZgr7r56N/tEghQdVF+t44yeKK54qeG9Xa2ehmo56ebMAcCwIOjhvKRBAnzJ/qMSp
         ltQ4vsUZwZvHEbtfT3bvXxNqPRxu3J8Q5MlfdV6vnDIM9byXCH2HrEOyF+2mk0Uo5468
         OtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nu5qP71RM0oQTiGCA1S6+gcu5DHYa3toFm8q9FdnkJs=;
        b=HjVzkQq1vB/4RKaRtwJurpZ4AfQPucT+EFfOZDn5wWMhfiZHdtmrTsD02aWDlEUwrn
         WluUXE3Tzt++8SVDidsdcIHl0gy6SgSKkZFWxJ2uo83K/pX183giRuDXzXptXjIbKuOr
         2GnFd6TrlXFlUI1Pcv5dMXzOjBB1m3jgqx7clDLO9li8ttsAMv+aXcH3mtYkaIb4hU0f
         GwpamvWD33RZlE9LUJdkSAeiz5+MqgcOe3QUpHjx3hF6Br18HSXovbQb9Ego7lLPU5gf
         ir13LROhNNm8HqQNaGSoKAa0zlsNy31GDwf09qh4w9DnnPH1dsGxmgB8FLAXp+gV0dKs
         Hsqw==
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
Subject: [PATCH 4.16 24/31] staging: comedi: ni_mio_common: ack ai fifo error interrupts.
Date: Fri,  6 Apr 2018 15:24:49 +0200
Message-Id: <20180406084344.289281094@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003849053166920?=
X-GMAIL-MSGID: =?utf-8?q?1597004629874652763?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1275,6 +1275,8 @@ static void ack_a_interrupt(struct comed
 		ack |= NISTC_INTA_ACK_AI_START;
 	if (a_status & NISTC_AI_STATUS1_STOP)
 		ack |= NISTC_INTA_ACK_AI_STOP;
+	if (a_status & NISTC_AI_STATUS1_OVER)
+		ack |= NISTC_INTA_ACK_AI_ERR;
 	if (ack)
 		ni_stc_writew(dev, ack, NISTC_INTA_ACK_REG);
 }
