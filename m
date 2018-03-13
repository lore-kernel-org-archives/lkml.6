Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt8rdJrmggDokENGbH9za1KAM9iMnYJPtESotyIvc+1fDmmwwoI/uU0lTQIYvhuXo8kPJDD
ARC-Seal: i=1; a=rsa-sha256; t=1520955544; cv=none;
        d=google.com; s=arc-20160816;
        b=TAZsX3PgDGlPC7vDmVJNB6hP2ePSG0H0CawuluHz+ppjFHpH4OQyESMEj2J16BaljF
         BQ8pjnkgv8aIVrRQN1kTPSEYlhd+0PWoFX1z3oomv8qhYfKGu5mnRiPnTZRl9x1ok5EB
         1YZDQfRbxXOjFRdI+uWgDg5ZeD/7FvYmzS/dNkO6jPz1xiS186K0axy10aQGSfq6tCIQ
         d24xUXmyLd0A4eXYOg6IwNMyg2cSszO3/mrhMDBexFOQ1tMcyv9ll2j14cRWS8oIiT7M
         Q7c6g4yMWLXhHAu54lveqvhrQcwMH/pdw0ysWIAPmdvnemb50bB7wMoKXTbVEXsFtQ5e
         i1ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9WndTdS7Jv44zQ3rZhI3YdzFXUQG2oMJb2JpaTOQW3I=;
        b=I5eCuSBz+OPb9IKZzxDSDz1WlkbqAT3i3zw1ZipKTaSyEONWIfyu1CZmUJGMhH1q2K
         jKYlgKoVS5dfXqHzBXCoyn/5XdTOL9UoSD6sQ5hM/+e6Nwv5UYS8QWf0+j/vb2yTxiM9
         sdBp4NtugKMJn0iMt3lpXW7RRF1qNdxc+Zs3f1RjGDtkhsObQhov4OplQxwwGHag55ig
         TZp7g7WDrIzVRXacvBcF6ohC9bbSflsFYsKOtlEOSUVb58CMAB3VRHOzkpniyfn2un/e
         tryhGTSzeNPSStAXC63gmc6ETanI4DwjhajSXhIU1NBUntdxxQ3/8iNJe1b34TYUwER6
         b7tQ==
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
Subject: [PATCH 4.14 082/140] Input: matrix_keypad - fix race when disabling interrupts
Date: Tue, 13 Mar 2018 16:24:45 +0100
Message-Id: <20180313152503.702069224@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836933161279881?=
X-GMAIL-MSGID: =?utf-8?q?1594837480838606146?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
