Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/uK8uUs38Hk9jEKeRMF5oxErD+5eySgveBr8RpVZbifGOHhl/yffCJFGZI6tshMTB8tOj/
ARC-Seal: i=1; a=rsa-sha256; t=1523472943; cv=none;
        d=google.com; s=arc-20160816;
        b=RXPuofKBh2NOedSCKy5y5Suezpl3Bu4HJqTRLI2cRk34ReKAsVoyQFFcA0BI/7jwWV
         Wxh1UboIbvjYmBij9Debfjp9fgepeZNyZNDw1CBnl0aVLE8rCn7iJH4pqaVUBgAVUnty
         ntpeODnPaGyPePSinkosQN5cGeQJ5OpF48jQkJcokYUeXUUpqxy2BP7AJm9+U9BMBkdq
         FwUzdRiemyqofOTQ2NWe8AB20Fds4oHsrWYRLv3kadXYoEybde9PB7gP9K6ZZHxUteJj
         pWZWEIgGFEV6fgTVyV8OgRA+E2xI8x0/jQ1gMs8+k4hqgl/GVYMAUGsNO3qVYS+XgLFN
         TmnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4fOiSEcEhM1568ybFDuE7GEoRWmYFTbEtD4SCVa4E7Q=;
        b=AojRaSe6kbVDg4amyVcNA6ifXDeDu4yWbihOhN4svLgMWf3eUCs0sGJ5sKgC+0oQe3
         hepFwPYe6ULFvwb3LBwsF6uXUAnh2T9hK/XubqAxIQd9zl1f6OdQNGk55HXXHf4J6v//
         cLneJU+gp1SLUzL0L5Q1WeTBXmp8nCWWkYrHzBIMBYPhfMoBHYLQE4RTC72RMXxeFx53
         I44J8it5892iKvaaBVOPIqFz/n+dqvD6+W3WzP50zhMlh+lOOzD5wuIobsKK1th5UaMp
         RazYRkvO2ViBSkYV4ohg/xu833iPG+1CEAvb7I5XbivlF0ONxyExtQ0ny4Zjap2hmPwA
         VRVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jisheng Zhang <jszhang@marvell.com>,
	Peter Chen <peter.chen@nxp.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 065/310] usb: chipidea: properly handle host or gadget initialization failure
Date: Wed, 11 Apr 2018 20:33:24 +0200
Message-Id: <20180411183625.058549477@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476102299478040?=
X-GMAIL-MSGID: =?utf-8?q?1597477164810600656?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jisheng Zhang <jszhang@marvell.com>


[ Upstream commit c4a0bbbdb7f6e3c37fa6deb3ef28c5ed99da6175 ]

If ci_hdrc_host_init() or ci_hdrc_gadget_init() returns error and the
error != -ENXIO, as Peter pointed out, "it stands for initialization
for host or gadget has failed", so we'd better return failure rather
continue.

And before destroying the otg, i.e ci_hdrc_otg_destroy(ci), we should
also check ci->roles[CI_ROLE_GADGET].

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/chipidea/core.c |   29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -839,7 +839,7 @@ static inline void ci_role_destroy(struc
 {
 	ci_hdrc_gadget_destroy(ci);
 	ci_hdrc_host_destroy(ci);
-	if (ci->is_otg)
+	if (ci->is_otg && ci->roles[CI_ROLE_GADGET])
 		ci_hdrc_otg_destroy(ci);
 }
 
@@ -939,27 +939,35 @@ static int ci_hdrc_probe(struct platform
 	/* initialize role(s) before the interrupt is requested */
 	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
 		ret = ci_hdrc_host_init(ci);
-		if (ret)
-			dev_info(dev, "doesn't support host\n");
+		if (ret) {
+			if (ret == -ENXIO)
+				dev_info(dev, "doesn't support host\n");
+			else
+				goto deinit_phy;
+		}
 	}
 
 	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_PERIPHERAL) {
 		ret = ci_hdrc_gadget_init(ci);
-		if (ret)
-			dev_info(dev, "doesn't support gadget\n");
+		if (ret) {
+			if (ret == -ENXIO)
+				dev_info(dev, "doesn't support gadget\n");
+			else
+				goto deinit_host;
+		}
 	}
 
 	if (!ci->roles[CI_ROLE_HOST] && !ci->roles[CI_ROLE_GADGET]) {
 		dev_err(dev, "no supported roles\n");
 		ret = -ENODEV;
-		goto deinit_phy;
+		goto deinit_gadget;
 	}
 
 	if (ci->is_otg && ci->roles[CI_ROLE_GADGET]) {
 		ret = ci_hdrc_otg_init(ci);
 		if (ret) {
 			dev_err(dev, "init otg fails, ret = %d\n", ret);
-			goto stop;
+			goto deinit_gadget;
 		}
 	}
 
@@ -1024,7 +1032,12 @@ static int ci_hdrc_probe(struct platform
 
 	ci_extcon_unregister(ci);
 stop:
-	ci_role_destroy(ci);
+	if (ci->is_otg && ci->roles[CI_ROLE_GADGET])
+		ci_hdrc_otg_destroy(ci);
+deinit_gadget:
+	ci_hdrc_gadget_destroy(ci);
+deinit_host:
+	ci_hdrc_host_destroy(ci);
 deinit_phy:
 	ci_usb_phy_exit(ci);
 
