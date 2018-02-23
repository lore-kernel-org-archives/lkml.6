Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2265Iu+gp+AoksllzHucsj/PH8NYRHbhQdzzL6yV8EPXCvXsfFo/k5rVKiF4KMMPvIZWgD7s
ARC-Seal: i=1; a=rsa-sha256; t=1519411128; cv=none;
        d=google.com; s=arc-20160816;
        b=M2CigToKItx7IL7F/e/qkK9OvuAX3dNQayCptDAaXwkVGRrKHuG9Q1nFWWYRcZJpkq
         LcpXEU3iFUAQ0UncdesEfzEhfwI6nUz2L6yp7jvqn+hfV9y23fYQIwKuBhuCKCPUX48Y
         TnsnWKMd0A6hxLANkmAxW0E0KqSP/DvSfbRM+qr4b9tC8bx4BfVSqkDr4e2f3YKblbrq
         M5mAIeBUxdDARKSEGnV/hKsSV3faFrxKI131x5cFN77yxYS+7l7kAWrrUfFe1R+11WPC
         DPc1dUHp1BubmKpQqWw11G+XrE0i9tu64gdKyqpOYBzQmOX6OwWhHHmMVh3Mu5YplmJW
         vBPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0TsSDW+1EfWDwrx+OzLaL8EQ5IVh06ixE2MRt4TpLRU=;
        b=rewevnViSbnAWHE5J8xWfx+NI3vj9hYlmjAXN32jsIRpJy+Spv3nzr4EUjno2olGAY
         YnSovhKnJcZhXyraJeMC4NL1SJfGCVdw+0ufBS0icx6KMEMBoLnMiIz1e4rnmKaBwydp
         wYR/w7ZybqHUQJfzdcu6ykRwqn3Jj3xtWJaVstxG4L72d95RsQ2yybQVb5/QsPeUqXSb
         tKag4RBtonTP447VUxCtGVqgzzD0zc31D+Y8QG0e3arNFUM50xQVxyIgE+CyL3Gm3LBb
         /u1RAQ+l5m0XHBay+8az1LfZzovlAKXoGZXC0EzbCmzsBShabxWOzVEQOdlw8SJauMus
         ocxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.4 132/193] Input: tca8418_keypad - hide gcc-4.9 -Wmaybe-uninitialized warning
Date: Fri, 23 Feb 2018 19:26:05 +0100
Message-Id: <20180223170346.468592232@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218044096392002?=
X-GMAIL-MSGID: =?utf-8?q?1593218044096392002?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit ea4348c8462a20e8b1b6455a7145d2b86f8a49b6 upstream.

Older versions of gcc warn about the tca8418_irq_handler function
as they can't keep track of the variable assignment inside of the
loop when using the -Wmaybe-unintialized flag:

drivers/input/keyboard/tca8418_keypad.c: In function ‘tca8418_irq_handler’:
drivers/input/keyboard/tca8418_keypad.c:172:9: error: ‘reg’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/input/keyboard/tca8418_keypad.c:165:5: note: ‘reg’ was declared here

This is fixed in gcc-6, but it's possible to rearrange the code
in a way that avoids the warning on older compilers as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/keyboard/tca8418_keypad.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -164,11 +164,18 @@ static void tca8418_read_keypad(struct t
 	int error, col, row;
 	u8 reg, state, code;
 
-	/* Initial read of the key event FIFO */
-	error = tca8418_read_byte(keypad_data, REG_KEY_EVENT_A, &reg);
+	do {
+		error = tca8418_read_byte(keypad_data, REG_KEY_EVENT_A, &reg);
+		if (error < 0) {
+			dev_err(&keypad_data->client->dev,
+				"unable to read REG_KEY_EVENT_A\n");
+			break;
+		}
+
+		/* Assume that key code 0 signifies empty FIFO */
+		if (reg <= 0)
+			break;
 
-	/* Assume that key code 0 signifies empty FIFO */
-	while (error >= 0 && reg > 0) {
 		state = reg & KEY_EVENT_VALUE;
 		code  = reg & KEY_EVENT_CODE;
 
@@ -184,11 +191,7 @@ static void tca8418_read_keypad(struct t
 
 		/* Read for next loop */
 		error = tca8418_read_byte(keypad_data, REG_KEY_EVENT_A, &reg);
-	}
-
-	if (error < 0)
-		dev_err(&keypad_data->client->dev,
-			"unable to read REG_KEY_EVENT_A\n");
+	} while (1);
 
 	input_sync(input);
 }
