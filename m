Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AG47ELuJ4ZytJneBuc0YaM1ldZ0e13noRLK06Vz/ClI28l3LTW1mW8mt8qxD7kN5WtCt1FXxFIV3
ARC-Seal: i=1; a=rsa-sha256; t=1520691337; cv=none;
        d=google.com; s=arc-20160816;
        b=EBqLDJ1ln+NfQ3dXrReLpBB97m2U9w1yzxUrm7tRjHMTg2VkQijH1ZfPOmS/oBHxdT
         hrn0B13OQS2xBwhfyfxDWN/kN/NxchO+02RKbSfr5x20NouV+cu68EehZA4gMddoDkL9
         fN0UOcpfbA7d2uigjRm0adfPfBKYgtLR6gPRs2iM0q6jX6LM+QYhsWSzbLwMRFViA80m
         AIHZ5JbI5H6kXZDP+TsLo0vYoFuuJAb/GAn62HxOgsqZD0LgKp4kY8JVtZqbK7PZOFc2
         kx69LNw9D2NVcFRaSLgiKsOypBs74Hq15dgZul/ZA1Txh9nyKlX8sfBayhCQ3pdBYwDi
         pWUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=8Mf4fjkkTPfisMzcJXsrCH8sa9cWfALOowm9x+HqpvE=;
        b=bB9EHlplRUaifmDcPLS+Pgfu/cDPUp2Tac7fXWKsgK6dJ4tHaMnMNB7dvX2NplmhL9
         FWwCuXGmfs9u/Zi14aw9NyzqX46VBd5vyrFaHtGW1+ZlBgfhi0b0OMyn4mP/YTEozJ4t
         a/S8gkzdVZUVu82vQvzvmQ6vtWEjLaK+FnmPy6ZrEa3Ff9CCS+GGoPjiH6m8mI3SG85a
         OzJJV7YG5XKzK6McdiFXt5UZE+yv1uHYS+ymFRwVNQikomaeOvGrMCdQ0UVu+j8jA0kd
         R2ghJGmAzTiCtnN6wM+9ApIe9k6T6CxWcVh2ndGAgNlqAP+rORdy3Th+o1GCJX+TKrRy
         mkFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC5221837
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
Subject: [PATCH v3 20/20] mt7601u: use request_firmware_cache() to address cache on reboot
Date: Sat, 10 Mar 2018 06:15:01 -0800
Message-Id: <20180310141501.2214-21-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180310141501.2214-1-mcgrof@kernel.org>
References: <20180310141501.2214-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594560440032815779?=
X-GMAIL-MSGID: =?utf-8?q?1594560440032815779?=
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
index 65a8004418ea..b90456a4b4d7 100644
--- a/drivers/net/wireless/mediatek/mt7601u/mcu.c
+++ b/drivers/net/wireless/mediatek/mt7601u/mcu.c
@@ -421,7 +421,7 @@ static int mt7601u_load_firmware(struct mt7601u_dev *dev)
 					 MT_USB_DMA_CFG_TX_BULK_EN));
 
 	if (firmware_running(dev))
-		return 0;
+		return request_firmware_cache(dev->dev, MT7601U_FIRMWARE);
 
 	ret = request_firmware(&fw, MT7601U_FIRMWARE, dev->dev);
 	if (ret)
-- 
2.16.2
