Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELshrUQBdm0UNcT1o9W9yq2ItWP50/Pqu8B2k68G+1ukTmY+XHxgj7SN2r62aM4Pc3sJ3wnR
ARC-Seal: i=1; a=rsa-sha256; t=1521214225; cv=none;
        d=google.com; s=arc-20160816;
        b=MNcbX4k3TkqKJxEUtiUraf9eXWTFscHW4gb12NEHAYWptpfpVmU1Wmw194yln74Eot
         qrbEP+CDuZEqnFkRWgeRpOogitbKsVmWYBYr8ZKv2EggY6HP/XWtU8yHUzihen63r64K
         cHbyqo874EAzUolt0x9VSUwbV92HTSpg5HAniKjSNVTKMgCiK5Xy16F6dKDl/OrQQCOg
         6zAmJCt0PEQYsQyl5ZvoR/fFlPccTeKAgzfzkCq+rNWH/PRMrcWRHlSzWSXTLef3VAjk
         aV7b7S2x+5YTZRy7zJPT7XB3jT2+Ag9FyKEqOW3C+cGE5L9q9vM2VrkzgXgoIdpS5GXU
         yYHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=evm1RRKue0TfpYJNK3gOS4N1hjJLthoVZckHBcFjGmo=;
        b=jThLBWEiSu8E1FxCcpcYJR7Uwx2vAm5NQMznDRO9gQ5/vd8WuvM6+ecoWiiFFB+aDp
         d7JsgwOJMCtOYIcNw8ovj5wjpm4btmPBlrd9+Z+jSh6qSn1+yOqeDeVi99RS38RyMwEz
         0BqqHSN8BkO7umNG1w/FNE9SOXskYrDyxbs+qh6RnteZdw0QhF293m3aHN7VpIk1ZkXu
         4WrOQKIJoMpFxkSgEhIBx6MnNHQ52c5zJYdf+0JTn+yOpb6WCzpSbcYma3ItgfHv19bT
         2phLS6+NzOiUQEE47t7dWDEiKTqLO//GB0slYAxPiPENlYTGp1CsbcaovtKUz8Em52Wn
         FmRw==
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
Subject: [PATCH 4.9 20/86] Input: matrix_keypad - fix race when disabling interrupts
Date: Fri, 16 Mar 2018 16:22:43 +0100
Message-Id: <20180316152318.732409641@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108290550581156?=
X-GMAIL-MSGID: =?utf-8?q?1595108727359804500?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
