Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AG47ELvm0C7relOyCDZpoSYfvYTvHRgLA0RnOf2lF4oQLWePy4cIwpVa41G2wGSAQ+f0ESJD65Vw
ARC-Seal: i=1; a=rsa-sha256; t=1521671677; cv=none;
        d=google.com; s=arc-20160816;
        b=thUroqjwiRQrSXAjuSt952l8MO1/rty3nA+D+kSeITsF/XKJf5VmeGTqCel4Yrj+X2
         VvziLJgMHlU7UtOh9RAQdMJf0M1HXVWz2Qgp93KFvgc22KUXHQ/4w2CnM6HmLby6WMNg
         bVq66eB8dVqQQpqErRXPAwj0bcc+FMbRH4kYCbSnOo0Q8Xji2kzW13dANdhmIuyuDfLn
         VUvc/0uyQZhYyxVmHqCQ7eXQ1tZVLdVbUDV6fxTHgMDSGhi6s4mZX+0SSbEWvPkRUhXl
         fhw77WSUSAE65s7/0SaUj+BNqv3iWJY+ihwSAG4WrqHWM/fBaZNXp3RH+Lx2RwB4coyR
         LvEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=VhtwOMh/23N22KUPBuePjUWPON0u2KbDIRpsklmQsIo=;
        b=hQbb1wgw0lXvEUkwSh80R4iGpNwafqa6rooRzHzwNdGvim82J1YsTDP1pEuHWl1ziA
         Eud20nOsVeHhvKPIPqIwqipCsqa0oCea5MtdnvaapRePZ/vjsDI0osVRXpItL3uMFcsK
         p6XaHp7LnjqWldhUBZ4UpFNSkYJdF7o9A+INi2rplr/LOwrK1CPrOL4DtYJ0Vncqxfq0
         5Q1c+0bTktwkcGg4P7NUtQ2jBDUrmwqNVKZGgBvcknjDPQ7tejYaq/ggOG/THxOFbkNN
         rL7AR76iwW6hOP4bPYOO7V52EuV4tVxiL5IYeVcjVLaBzQFYRBgaYi9lywwLfBmgvlM+
         GUJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4444E2183B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	cantabile.desu@gmail.com,
	kubakici@wp.pl,
	linux-wireless@vger.kernel.org,
	keescook@chromium.org,
	shuah@kernel.org,
	mfuzzey@parkeon.com,
	zohar@linux.vnet.ibm.com,
	dhowells@redhat.com,
	pali.rohar@gmail.com,
	tiwai@suse.de,
	arend.vanspriel@broadcom.com,
	zajec5@gmail.com,
	nbroeking@me.com,
	markivx@codeaurora.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	ast@fb.com,
	andresx7@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v4 3/3] mt7601u: use firmware_request_cache() to address cache on reboot
Date: Wed, 21 Mar 2018 15:34:30 -0700
Message-Id: <20180321223430.21388-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180321223430.21388-1-mcgrof@kernel.org>
References: <20180321223430.21388-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595588401280675569?=
X-GMAIL-MSGID: =?utf-8?q?1595588401280675569?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

request_firmware_cache() will ensure the firmware is available on resume
from suspend if on reboot the device retains the firmware.

This optimization is in place given otherwise on reboot we have to
reload the firmware, the opmization saves us about max 1s, minimum 10ms.

Cantabile has reported back this fixes his woes with both suspend and
hibernation.

Reported-by: Cantabile <cantabile.desu@gmail.com>
Tested-by: Cantabile <cantabile.desu@gmail.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/net/wireless/mediatek/mt7601u/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt7601u/mcu.c b/drivers/net/wireless/mediatek/mt7601u/mcu.c
index d9d6fd7eff5e..61705f679856 100644
--- a/drivers/net/wireless/mediatek/mt7601u/mcu.c
+++ b/drivers/net/wireless/mediatek/mt7601u/mcu.c
@@ -420,7 +420,7 @@ static int mt7601u_load_firmware(struct mt7601u_dev *dev)
 					 MT_USB_DMA_CFG_TX_BULK_EN));
 
 	if (firmware_running(dev))
-		return 0;
+		return firmware_request_cache(dev->dev, MT7601U_FIRMWARE);
 
 	ret = request_firmware(&fw, MT7601U_FIRMWARE, dev->dev);
 	if (ret)
-- 
2.16.2
