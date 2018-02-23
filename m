Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv02L57diUz/emf+LsmRD+vDs7sehOUKTTYCCUAAwiepQJITMt5Co92ezWVBwKU62oWZ9++
ARC-Seal: i=1; a=rsa-sha256; t=1519411740; cv=none;
        d=google.com; s=arc-20160816;
        b=oChQ/QBKU1PBe4ksPyYjohtQPvjCOIKxMuJFPiM+sUHQRK27sS3qXqxrO5BRssFuf2
         hyA9CSo+5qujRsrVw3t08k01azjvzkTp/caD7J+hX9cc/KNK1gjZA2ynfrBoE/2PBMyF
         b7Q4ZlW6ng1K2XvJNK2njyX3L5i16+4zd/t1iG917CYH/GmHxp08f7wIYthqh9MndP9f
         3/ebwEDEsVeOjicP4DGfdbDOz71eTlrd1wrhJWZSL/WtU+dOkU+WhVJjYHkXGJWM6nim
         EtqzyKk42IyC+QMgMOpU5ggBvfgU2yvMZGdU4y4gVoqmMosb/yaQaZoSEDX4mEQOTlJI
         uMdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YZV9c+wUGHYyp7GvohWwRFKPLgARIhFSPKfExmVFB7Q=;
        b=hE4cQ1uYTO4DgjKPKeN7Icq2ifDrZ889wtKRDkBH6oaIRhjLbMxVrLreuYFF3R6UzW
         IumEWPTR2UhCZugDAFaIp5dZBasDJJUxlLR1Pt3/3CTLP75dv75nG6Ked9gAZMXfns/e
         R2jPNZ4R/UL4/RlcfSFDsA0bYOfEJKIXfqivnNl/8JPTNUPTf4wGMAMVjc8ytuPyPAU0
         iSypa0OPOS/DkwAxcBZIwNvYzkRiVR+vp5G7aqB63XstmNRluEOWmYzN/dRmTLU150ta
         jMNczpWrKmSne8LnqVK7hVq8vk3JoYYTb4DY4PQ3W2mpCOyLnG/G+Ir4MJYyAuOjzo+z
         Ehtw==
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
Subject: [PATCH 4.9 124/145] Input: tca8418_keypad - hide gcc-4.9 -Wmaybe-uninitialized warning
Date: Fri, 23 Feb 2018 19:27:10 +0100
Message-Id: <20180223170740.844933076@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218044096392002?=
X-GMAIL-MSGID: =?utf-8?q?1593218684343226544?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
