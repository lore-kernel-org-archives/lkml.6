Return-Path: <tomeu.vizoso@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521711632; cv=none;
        d=google.com; s=arc-20160816;
        b=jQj3WtE4o+Yh3dJFtAUVTxZtI6z9HK2b4Gd+tZmA3WrGoAw8WGIZfQkz/btjgT8wIF
         8UXuHnV+lUaqK599afiGXDWiHAYUHKWvVH0vJDwIGKW7D+ONM31YQaHGqtIWx/GS9SKq
         FOtUBySadWddiqkvnnITuHOqoCDnlR6XveF1IkXesJJU+po7756jcqEMWx0O4MuA/BfE
         XHpyWeOnNhDbwjoztqISH+bKvVisR7fzTcxU8gGqrHEEtQdXoc4ICOYvG2lqqkPh6f0p
         9ZUPcc4zuX+E4w6iQry7oQAgdFKsPlspqCaROTLWWUjHUm+hE53vnMTsr9lxykSq1iWP
         4gqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:sender:dkim-signature
         :arc-authentication-results;
        bh=KFtokh40tYC4iXpDYYuuJY+bIiHjZ9En/cL9bX+B9Ho=;
        b=qMN5F364sgE9Yl9hHjtBU/pdH1Av7VyAEF5ZlZYJJYO5d69xCM/fIHYkFZhLQFBXmF
         GA805rXjVtMWx3lcRu3pR4L1YF02ddfvU92ZM8ocnsMykX+QN4M9Mx2ZQnkTvm9fAjEA
         qY6URqEADrtG5OahzeojQRmZr0I0bgGo1mXl618VhIn+3SzgfPCCguo5k+XdG2fy/6gK
         KVVotq3PCY9qewg7Hmu2CrDiYMactEEgGE0vud2LLGAgns2psUyU+xF0J/OOINXWJvUL
         rEO/6km6kRSHYKy0c6Y6VfC0Yi0UlaT9q6hK+qlAr4L4jKcyjlHJKxOMt+26fhEJFz84
         R3gw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WyQoGwwG;
       spf=pass (google.com: domain of tomeu.vizoso@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tomeu.vizoso@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=collabora.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WyQoGwwG;
       spf=pass (google.com: domain of tomeu.vizoso@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tomeu.vizoso@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=collabora.com
X-Google-Smtp-Source: AG47ELvtHGzOOI4ezvLGDZTk08VDBaumu8G2fqwCfEdCfjgpiulUwosbjS1EJE/75A9D+frki3LCGg==
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Amelie Delaunay <amelie.delaunay@st.com>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH] usb: dwc2: dwc2_vbus_supply_init: fix error check
Date: Thu, 22 Mar 2018 10:39:43 +0100
Message-Id: <20180322093943.49717-1-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595630296773142922?=
X-GMAIL-MSGID: =?utf-8?q?1595630296773142922?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

devm_regulator_get_optional returns -ENODEV if the regulator isn't
there, so if that's the case we have to make sure not to leave -ENODEV
in the regulator pointer.

Also, make sure we return 0 in that case, but correctly propagate any
other errors. Also propagate the error from _dwc2_hcd_start.

Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external vbus supply")
Cc: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/usb/dwc2/hcd.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index dcfda5eb4cac..4ae211f65e85 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -359,8 +359,13 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg *hsotg)
 static int dwc2_vbus_supply_init(struct dwc2_hsotg *hsotg)
 {
 	hsotg->vbus_supply = devm_regulator_get_optional(hsotg->dev, "vbus");
-	if (IS_ERR(hsotg->vbus_supply))
-		return 0;
+	if (IS_ERR(hsotg->vbus_supply)) {
+		hsotg->vbus_supply = NULL;
+		if (PTR_ERR(hsotg->vbus_supply) == -ENODEV)
+			return 0;
+		else
+			return PTR_ERR(hsotg->vbus_supply);
+	}
 
 	return regulator_enable(hsotg->vbus_supply);
 }
@@ -4342,9 +4347,7 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
 
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 
-	dwc2_vbus_supply_init(hsotg);
-
-	return 0;
+	return dwc2_vbus_supply_init(hsotg);
 }
 
 /*
-- 
2.14.3
