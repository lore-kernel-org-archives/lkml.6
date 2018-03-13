Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtOl2f3IBpVf8KPjniW9yAJROdFL9BWhlemz9gDlMEO1UjGjTJotlBnpqU+NElmz6/RW/zc
ARC-Seal: i=1; a=rsa-sha256; t=1520955022; cv=none;
        d=google.com; s=arc-20160816;
        b=Foo71YHinZakvWPfFimudRSU8FaPO3gtQ7aWrA/Shbgm/oMFd7boTefEWJF3ZeoWBU
         Iu2UnVxHqHLL2KZ7prqVHn83h/aIUTGvkH3m+J2e/eXREdloTNY5bOUvv9PjQKQhhMNp
         vM2b2bhB9nEHRN4Nv9mPjg7AjWAa/8VYm+teHG+aGW2C26CWzudvabvEt17/suld8x7i
         nNI/SGlEcytI04HU0N4sTYWxBhcicIKGkhltOi0J+Kyk6D7ba4qwD3VGUJxhiStoBV0P
         G/SPwe3TXTaRwgbjCirfcK9Nk6qGJ6iX0aa8cjy4b9lKiNPO+2/amnGM1zznCYHCNx3T
         98Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=W9HGKjYW3mxWXZJHbACv5ROvJzGPJwABocFNF0lPmjM=;
        b=fh5WjNuEWS4Up59UjPx9PkLHCnKCju18kT1jaVkStae7T46jTx7oEMWsQiCLBMyAMQ
         KEnUnDLezaSOxZqn9sMAaI9G27NiSjBtkpGmBdDo9eTBOa9AeVF1YnnfLKnQEr+bk/iu
         36VhgS+metCGiYZr194DzyCY5p2aGQH7vXIRinTZzs59P2sSQHrKX0TGSzFaIk9EPz0c
         wYZkRuM58IE94fz33EDRjpiyu38d07w+YlikC71YImUe+qTApKPEbESsXBX95QyI05Si
         yEL92Uy0ARxIzFsWGeySyEO9exsZYTvPQne3SIPihYbyq/pSNCGA64fNk7TnsOWvXZAj
         QMHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Zhang Bo <zbsdta@126.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.15 044/146] Input: matrix_keypad - fix race when disabling interrupts
Date: Tue, 13 Mar 2018 16:23:31 +0100
Message-Id: <20180313152323.992035956@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836933161279881?=
X-GMAIL-MSGID: =?utf-8?q?1594836933161279881?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Bo <zbsdta@126.com>

commit ea4f7bd2aca9f68470e9aac0fc9432fd180b1fe7 upstream.

If matrix_keypad_stop() is executing and the keypad interrupt is triggered,
disable_row_irqs() may be called by both matrix_keypad_interrupt() and
matrix_keypad_stop() at the same time, causing interrupts to be disabled
twice and the keypad being "stuck" after resuming.

Take lock when setting keypad->stopped to ensure that ISR will not race
with matrix_keypad_stop() disabling interrupts.

Signed-off-by: Zhang Bo <zbsdta@126.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/keyboard/matrix_keypad.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -218,8 +218,10 @@ static void matrix_keypad_stop(struct in
 {
 	struct matrix_keypad *keypad = input_get_drvdata(dev);
 
+	spin_lock_irq(&keypad->lock);
 	keypad->stopped = true;
-	mb();
+	spin_unlock_irq(&keypad->lock);
+
 	flush_work(&keypad->work.work);
 	/*
 	 * matrix_keypad_scan() will leave IRQs enabled;
