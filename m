Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt9+6Fvth9yH+N/c68MakhubWSSLJf+P58yTonsYvUzYJT+haZWNrjq8kGAnOOm+ut1088e
ARC-Seal: i=1; a=rsa-sha256; t=1521214109; cv=none;
        d=google.com; s=arc-20160816;
        b=j5ZmHj/lzGTZpf909IbnGLbS07AZN77Ps9hV67mAEUVH2J7J0T1BJiIa0/LsmgpJEj
         ab8HVIkTlB0WTl73QPkHrQtB2ISMkBce0hHMBZpeLtOsD35rQQWfuKwV/VRErkgtHsge
         1mRBC3F8kWbIkHz2HpnigyEGNrAhQVT4Mye2layCZzkUiQCASgORnX7eOizL9FxfDgGy
         /YuCARxPfTKAcmL5eYmNupjw7WPqpCe+14ma6B7T9/HtX3QJSFBxquP2kVsyKcTZnHXs
         pRCA7mfgwTMtGFc2CAzIoVTvp0cOp4wsl4wfAY8WM21zj6nda5Yai9bwNf83MwlgB6SM
         pq6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=82wkAr+oAxUqLHAYWMVLy4gBFBPJcamqubdu0GxGaqs=;
        b=uZRjPwutwgzwOVGwVRpgT70vNp9+bf2vbOdC+Q8Jii+zNRaQNVscKNTMdrnJAUNcUD
         IQNpOZ5zRRoBMSVO7RLSeEjFhvw/JB5uYP+qjlwOhcFs0XKy2ObTBeksS4TMUTxds84G
         owYzcFZpnlv/xyjD4VGPTGv+NonjJZRZPQqCGfosvL7d/I5A0F9LptRr9/SgMxwOCDTQ
         eyTGjZwif1ZyFp/rYi7xRncjOVckEtDwJTe+/VHvRgjeK5XaIKyoBYyvAE8In6BrET7z
         2QD8x4Puj7zAh0aHOP8GZkv9MAErppGasnAvUKwkYH9LYToe+KR4MzHsNTLstT3SPhe6
         x0CA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Zhang Bo <zbsdta@126.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.4 16/63] Input: matrix_keypad - fix race when disabling interrupts
Date: Fri, 16 Mar 2018 16:22:48 +0100
Message-Id: <20180316152301.844228094@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108290550581156?=
X-GMAIL-MSGID: =?utf-8?q?1595108606224434185?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -216,8 +216,10 @@ static void matrix_keypad_stop(struct in
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
