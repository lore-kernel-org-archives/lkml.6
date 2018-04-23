Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AIpwx48UCmaLzLUzajRhsK2b2VlZBJ5DS6D3VxvcqxRZpZIXQurAB9et4jOrSlDmgsq3mFdNijRB
ARC-Seal: i=1; a=rsa-sha256; t=1524505597; cv=none;
        d=google.com; s=arc-20160816;
        b=BIK9eeOM2l02+sqiEwAVXAmJnpkA6zfPAZt7Crco8Ut9pc8qFxgxdsyeq0aaO9a+p4
         OLOesJL4sA7eTIb73wnKqUedRw42P34SnaMpsQOYzdcp2cMIXjPG+VL5vwcdkRiW90ng
         8iX0KyK5uP1c/OzMxK+bIK2byc9YUzGm2URc6ae9TFzCxJHPlvZ+DZmOYkXIjI0dR0VD
         aHp7tsL59TQUOuPwupCUrzGfJ73GGKXbdwp3zc+U/BXbmhl2rZIY/pALteknmDtl9FpL
         OadWXPG7FvypsjCoWtMpeQYNGdQNu/1Ta6XPBDNcOnx1HMGmikoLdHJrUd8OOlarNZTT
         iaBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=j4FLq21F0mrEq6luwEIL9kqMrHusUS/i72yHOeTBdAU=;
        b=CXVW+3i5D3Mte+A5m1dT9vkLvT5BiEtGxeAlLq6L5IOO8iNNEUxXmnlNuQ6sbhMlIn
         VFeGbMxIKXTP5c5Nu2unSHJVDKD2OnY9q97WlWFwp0LFPIRqQA0TSVVvjhECdvWy3zqF
         LBzXK2MNXHEzhDCFUUCD1cxRtO9bIFH7lAFYdI/H/bjBdP9ug1wrvK2kz9VZOcm+rxt5
         fguoQ3asoUjTJBN2Y5Sg4qk+AsuBrrV0MYAMEMUuJYyTv+vZe6ItqR2srccXG9Zst8k8
         BOcjHGmbmSgbYsKOMjYLN3j8Y+Q2VSIOct+JygWav4vUchhBuWbnstrJcM0rP7HS+d2P
         6XgA==
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
Subject: [PATCH 13/16] bus: ti-sysc: Detect omap4 type timers for quirk
Date: Mon, 23 Apr 2018 10:45:46 -0700
Message-Id: <20180423174549.57412-14-tony@atomide.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598559981766852135?=
X-GMAIL-MSGID: =?utf-8?q?1598559981766852135?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Starting with omap4 some timers have different sysc registers (type2) compared
to the omap2 timers (type1). We need to detect these to enable the quirk for
SYSC_QUIRK_LEGACY_IDLE, otherwise these won't be idling properly.

Siganed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -875,6 +875,9 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 		   SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("timer", 0, 0, 0x10, 0x14, 0x00000015, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE),
+	/* Some timers on omap4 and later */
+	SYSC_QUIRK("timer", 0, 0, 0x10, -1, 0x4fff1301, 0xffffffff,
+		   SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x00000052, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE),
 };
-- 
2.17.0
