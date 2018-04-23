Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AIpwx48meGDV2W8sNJXMxbiOS7nfhXZJ5Fk7XkoFEVPzf77y62oMdpHNMKIwn7DSOAw7D4A5MHNc
ARC-Seal: i=1; a=rsa-sha256; t=1524505600; cv=none;
        d=google.com; s=arc-20160816;
        b=QufWa1TaUgI1ZECddm8Rgm42irP21NQ46mgtUSBuqQBk0ZbPG9hQuiKoWjbw7NdSPp
         UDmbeZB4EP4Geb2kBNRYGkcy/lweszGOoYBuXiiWQY9Eg7c7KcmHkqcWa/oBbNJinZKK
         8D0hLTrnpTOfk1ZIL9UmCtuJklJdeXq4nKJUh3kVkJS3dXhjaz6CmB/C3VE60/pHcpDo
         dlrJxnofxLeGGSfoSaqdZ6Tw7nl7LZmaN1bmgbesyG9NRmncyxdRe7Sf+Yaq6S5LmQO6
         hzHfQQIjwmKRT+gTcnxsZ11oZ6mOZ6AxoWWjh6FCJMbNQRpwRuyGcemXhFPH4hZS9dUg
         LGIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=HEeKv8+CxP9hUgc1ZW8zYoJy3sJcY1TK5WDl/T0nEQE=;
        b=1JPHxBlIlYwAdoRNH7HGfeZJ7fUsvGGcq4xe8JiI6WEZeX+55qQIv1dXokv1HnK17m
         N0qp/TI03M9zX6F7i+eJLCCwUZD+ENRCI9Fc3PeK4u5K607xzA+Hm39qgDgI9SqjufiQ
         m0Ee+FhjYy1c27bYi++hSS1L0LSCMVzWjVJP3JiMrLx53FQjPwAdA5Dxc/dmnEpx2rEp
         j0WFRKF80WdV6YgiaRGhtfvrWZ1vh8AdJFNsLh5eDo2Yob2zplTb6ljYr3DwAmD4vo5G
         LK6q0L8DkMFhYtXmGrmMBow2JZemygH9+G6WNcRr3M+BEfWhmz15Vu1ycHu0ZndBqPpO
         qycg==
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
Subject: [PATCH 14/16] bus: ti-sysc: Detect UARTs for SYSC_QUIRK_LEGACY_IDLE quirk on omap4
Date: Mon, 23 Apr 2018 10:45:47 -0700
Message-Id: <20180423174549.57412-15-tony@atomide.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598559984232228924?=
X-GMAIL-MSGID: =?utf-8?q?1598559984232228924?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Starting with omap4, UARTs have different revision register that we need to
detect to enable SYSC_QUIRK_LEGACY_IDLE. Otherwise UARTs won't idle properly.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -880,6 +880,9 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 		   SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x00000052, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE),
+	/* Uarts on omap4 and later */
+	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x50411e03, 0xffffffff,
+		   SYSC_QUIRK_LEGACY_IDLE),
 };
 
 static void sysc_init_revision_quirks(struct sysc *ddata)
-- 
2.17.0
