Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AIpwx49rw4kl8c0b4hAAsES8b3hT1FJiCQbNqX15xnL6QAKTVoyHOO5TyPDF9HoW9x7vl+IOP5hd
ARC-Seal: i=1; a=rsa-sha256; t=1523178156; cv=none;
        d=google.com; s=arc-20160816;
        b=jMioQbRP2SnvhiojZku+MqF2cGwU4HLzQRAgvMb/bCEhKVPhAbmmLOjC18Bdvl+cYY
         4wFEIwpjKv7JnZHkWXcUBPyH4OI4KCI/wNQRkDsJtUFQWDMaIo+1lV3oMk5NjHmVMZUS
         i7HniV84Cfq3j85VKBIIJ0N8deLuK1Wqm8cND/uG5hzQcceF83iXRDE6YTJ63jYviSU0
         QHg7zE9ROZU4XB71SKhDuioGFZ+fWOyuRzDUcacsOytdUlB5dCJPBH1WFXdV2hTKoAko
         HhLpTrBEp8ECJz0IVVRuCWu73Nz0gKphOFafziskxXd10gbhB9vcTUyvkTQlvVbH2Tyi
         0veA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=gzBrBZiVI9bAp2QdWgbvCKhtH4+CsLd9tRHH6q+Vu6o=;
        b=tKh70cQ7YwHzHpqWhAC5dKENE8pv46ezBiS+mmG8ENPyfQmFn694wvxAmU0FjmrLpp
         5QExTYxRETrpek65HdlkK4IOoVKu37sP9Z7qzUO4xIrn/mZ4haBI4IxQ3AgLymRgA7PX
         Sb96pObO8PazjE5uf+NJtAlI+cCZQVy35Wx40rb2RZ6XPeR3+x0EI/LK5xHudwBUE9vy
         sDP/K6h95ZLGaGON39VXIYxTdxnrXt57Sy+ToIbggBoCo6kftsiDMQkJLevsDmw0HC3Q
         73ID6opydQoWLxifPISmqw0xfEsIqFaTAiZRk0toyz/uWjBRCHdg8qAJtPXlQE3nnBDT
         BX4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:18 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:18 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Brown <broonie@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] slimbus: Fix out-of-bounds access in slim_slicesize()
Date: Sun,  8 Apr 2018 11:02:34 +0200
Message-Id: <1523178154-1130-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597168058823337595?=
X-GMAIL-MSGID: =?utf-8?q?1597168058823337595?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

With gcc-4.1.2:

    slimbus/messaging.c: In function ‘slim_slicesize’:
    slimbus/messaging.c:186: warning: statement with no effect

Indeed, clamp() is a macro not operating in-place, but returning the
clamped value.  Hence the value is not clamped at all, which may lead to
an out-of-bounds access.

Fix this by assigning the clamped value.

Fixes: afbdcc7c384b0d44 ("slimbus: Add messaging APIs to slimbus framework")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: stable <stable@vger.kernel.org>
---
 drivers/slimbus/messaging.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 884419c37e8419c8..457ea1f8db309cb9 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -183,7 +183,7 @@ static u16 slim_slicesize(int code)
 		0, 1, 2, 3, 3, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7
 	};
 
-	clamp(code, 1, (int)ARRAY_SIZE(sizetocode));
+	code = clamp(code, 1, (int)ARRAY_SIZE(sizetocode));
 
 	return sizetocode[code - 1];
 }
-- 
2.7.4
