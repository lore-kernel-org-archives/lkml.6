Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AB8JxZpkWjYChf5ktBAQMG3jJsGPtB2aEB3IJkrSd7HyswO25PWKkqt7DFfGiPkh80fzvA529T57
ARC-Seal: i=1; a=rsa-sha256; t=1524505603; cv=none;
        d=google.com; s=arc-20160816;
        b=Ga+gHstIQvUVd1NqZeo/lbw528VKWI5ZPwSDK9RO4W4zN2rtw2JmeXj/QKtn+3i7v7
         33/lOkdbggW9ZUp7lTUR5Ks2v4c9ikFStCYQ0a+QOHwKV2VFD0/vEiT/fuK6KC1M748n
         05tiO9n/x4gHIN7ufdgJL+h18tR0PIyBTdjUOCc5cd77kdQvYq33lzHz/Hd46rn2TLrD
         /3YYRNlR61kJDxp7aSNzsWcsrTfj+eYmRpM15+xSbM/2yJD5knlwe/TtKktTgotgOPft
         LkcLKvQktA+e9Y+NnaEwGZFKDEOHkZ6g0s+E+7cx0mT7KJigXl5qSRQJ9AL8wcG2gY1h
         yi9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=pfYXqVzId+o+i8t60cZx8HhOztPNLZKuN4Es913u8yI=;
        b=GlJonjzoeMZ7Fm4zk8cj3Olr4mTRCNtE/00dDA2VrlDx42AJNGBGdKoA7wKpKyyGzp
         /wN14lQ/dq9U2HqQLN/ocnMK0XSzZ4ytb4wQ0ZYIRfdH/U2yu0mzVfRxJujvdBT3LSD1
         rD56Gj8/mB0d1M+gP571OTU6ZkRmNU1pMT3tZIrhHmS88m12lhmOLGrvwS7si8AxDCiG
         gawO6Mo0uAR6CEOSxHc9G1FZS2lG3F9vjaLVIMzUqQxZsBy/owPVofQ1H2sZd+Szd2Jl
         WGhwyejW4U5ml77F3TnZjWht5Wn5U+1u2Fg4eP9hdGVc9U6jhwkPCrKOH8zSwTMpSj+M
         aeGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nishanth Menon <nm@ti.com>,
	Suman Anna <s-anna@ti.com>,
	Tero Kristo <t-kristo@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 15/16] bus: ti-sysc: Tag sdio and wdt with legacy mode for suspend
Date: Mon, 23 Apr 2018 10:45:48 -0700
Message-Id: <20180423174549.57412-16-tony@atomide.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598559987090265513?=
X-GMAIL-MSGID: =?utf-8?q?1598559987090265513?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Looks like these two device drivers don't yet behave properly for suspend
unless configured with the legacy option.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -883,6 +883,14 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	/* Uarts on omap4 and later */
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x50411e03, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE),
+
+	/* These devices don't yet suspend properly without legacy setting */
+	SYSC_QUIRK("sdio", 0, 0, 0x10, -1, 0x40202301, 0xffffffff,
+		   SYSC_QUIRK_LEGACY_IDLE),
+	SYSC_QUIRK("wdt", 0, 0, 0x10, 0x14, 0x502a0500, 0xffffffff,
+		   SYSC_QUIRK_LEGACY_IDLE),
+	SYSC_QUIRK("wdt", 0, 0, 0x10, 0x14, 0x502a0d00, 0xffffffff,
+		   SYSC_QUIRK_LEGACY_IDLE),
 };
 
 static void sysc_init_revision_quirks(struct sysc *ddata)
-- 
2.17.0
