Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+g1t2tvGuw/FLeJNpbwrTT07BmfX+CJhIOpvfWckn1eqziaEd2x/YemHKEjfXVGtzEnHLX
ARC-Seal: i=1; a=rsa-sha256; t=1522168954; cv=none;
        d=google.com; s=arc-20160816;
        b=bEnFolOsS8W0vgTh45fT2q2qDz6UXrVCEXhNYrv0WUyezF3sNOykLjYOydkZQs0EH8
         eA3qmX9XQjDHx6uvp4BNFhdGZV0Eu3/CKR4zv/8U8M8GXQPcpOtf/SCTVSfj2fq/GuA5
         MwnqvVzdZlZ7NIjWOO2zYSMFjvtNFXPeDix3lPCZsAaJUHDlFTTli8x2vL9bPbMWcitb
         nFAT0t4bLx4KAGZXLuubUbuY2KoMtliso36UNzx2vbxHeClsspDYoVi+rScUilXSC5sl
         KC9xFS7TjdpBywsLDqFR8GBKX8afk5h+kPcc2dsfvs0FnPDlgERiwge/Sa+/zwue0Q2l
         I23w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZY/25D/OpgHCB2j+UhQeArD7oXrkgOdsbfIPOeEkiEQ=;
        b=IiEv/sAd0MqPK2SNlWqouR5Dtojs1Z4LGfnxaBXFAvZ0Vi1t5/wUn3kasi3B6PF28+
         5AfoFfDuZstSaBuba714cdHETVgTSMFKfC+wDC0L1BWmrPOGpGUw56WbTCW9c3anu/sJ
         5Y8PyMaWl6FOu+DUDFO8rS0fjw9jpM98mMtVrZSd+T4sC1OmmSCVrqQQVrq7vAxRmRsb
         6hZU5XRhZ74C5nbObcQG4QBmHs0aLshNorFmF8AVVII0CvrQOJX8/KA+iErFCAcV7TRl
         pBaOpXuGvoidedyqBx4zoePr4KaCCj/X1gLs//iYG49weM6WTOLH8u9LBF2x94OmRAW4
         UHPA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.15 091/105] hwmon: (k10temp) Only apply temperature offset if result is positive
Date: Tue, 27 Mar 2018 18:28:11 +0200
Message-Id: <20180327162803.710447582@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109833790331801?=
X-GMAIL-MSGID: =?utf-8?q?1596109833790331801?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

commit aef17ca1271948ee57cc39b2493d31110cc42625 upstream.

A user reports a really bad temperature on Ryzen 1950X.

k10temp-pci-00cb
Adapter: PCI adapter
temp1: +4294948.3°C (high = +70.0°C)

This will happen if the temperature reported by the chip is lower than
the offset temperature. This has been seen in the field if "Sense MI Skew"
and/or "Sense MI Offset" BIOS parameters were set to unexpected values.
Let's report a temperature of 0 degrees C in that case.

Fixes: 1b50b776355f ("hwmon: (k10temp) Add support for temperature offsets")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwmon/k10temp.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -128,7 +128,10 @@ static ssize_t temp1_input_show(struct d
 
 	data->read_tempreg(data->pdev, &regval);
 	temp = (regval >> 21) * 125;
-	temp -= data->temp_offset;
+	if (temp > data->temp_offset)
+		temp -= data->temp_offset;
+	else
+		temp = 0;
 
 	return sprintf(buf, "%u\n", temp);
 }
