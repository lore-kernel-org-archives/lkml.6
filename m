Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49osAfnPEW+fUIZwEo+SC8F4Af+vd5XMsZxknC3eX7Hf5QRTverHoCF30j/Rm5KiSrOvoNc
ARC-Seal: i=1; a=rsa-sha256; t=1523399318; cv=none;
        d=google.com; s=arc-20160816;
        b=bjhUmd0G6eetGDiIvOPdfreboFhBkQpxZmNpGh/Sg6YxOmqfH4lxTiIdlWtJ9iwe/T
         bWVILZFRlwylVwq94/jdSMd3dUm1XQM4x4+TN2cYCDeqwNd+Bo0+l0rry28aEdp+YHBk
         mzRXgPDsL+PKpBIFsQY0X3xJBYrS+qzkC/lpsmGu5TncKQnamw7xSTC/J+JSMbhjEgnl
         2L/rCrsOJSIlEDQx9HjLeYvNRpgN3AhMM8wSsbhvwWfXnL5bqbMfVDaGncy2kRVLB2bJ
         gCDdlFXBkeWGN/uRHYKwaiS+fZ10PekHbAwYzFdmj36UzAOG3fqT6Mneph354nBxlW+z
         UZ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2glE9qLglcjXLHbC+Mij9n7JhYo31uuvCr2KoAHToVY=;
        b=vDW2j50lbFGAYR2UfxW6Ry9U1F6Ic1XHh4v3qFvvRXl69VuZpb8XGSr2OAxkgs+PQ6
         c4iwS/TrT3cMZcEuiQVjFQJrJSJ8qtgzMWQnpzqBCZZuibPrZ+gqEdpml+y3ONI6mk1H
         mvwYLkpxNpwF+075pnPm2Uzgyw+DyFFvnPZn1IpBwHblpgoxBnLbOd72Wr7Ep4OfZnoc
         uRi/TKKjPC+H0fqjNRHsEEbaAsmtqSBZ2rvWNVS8uVX4qu0XxpQNQd0mVEqQhbiJ5PQL
         VJbglkEAhC5HNAaXw9kUN5vsQ5LpzaREclc3UQG2AhdG5eCidbU0A7mquwcpUUXGZBFA
         p8jQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chen-Yu Tsai <wens@csie.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 064/168] power: supply: axp288_charger: Properly stop work on probe-error / remove
Date: Wed, 11 Apr 2018 00:23:26 +0200
Message-Id: <20180410212802.923079752@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399963869125189?=
X-GMAIL-MSGID: =?utf-8?q?1597399963869125189?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit 165c2357744e41391902a2a72dd170beb60c28d5 ]

Properly stop any work we may have queued on probe-errors / remove.

Rather then adding a remove driver callback for this, and goto style
error handling to probe, use a devm_action for this.

The devm_action gets registered before we register any of the extcon
notifiers which may queue the work, devm does cleanup in reverse order,
so this ensures that the notifiers are removed before we cancel the work.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/axp288_charger.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -785,6 +785,14 @@ static int charger_init_hw_regs(struct a
 	return 0;
 }
 
+static void axp288_charger_cancel_work(void *data)
+{
+	struct axp288_chrg_info *info = data;
+
+	cancel_work_sync(&info->otg.work);
+	cancel_work_sync(&info->cable.work);
+}
+
 static int axp288_charger_probe(struct platform_device *pdev)
 {
 	int ret, i, pirq;
@@ -836,6 +844,11 @@ static int axp288_charger_probe(struct p
 		return ret;
 	}
 
+	/* Cancel our work on cleanup, register this before the notifiers */
+	ret = devm_add_action(dev, axp288_charger_cancel_work, info);
+	if (ret)
+		return ret;
+
 	/* Register for extcon notification */
 	INIT_WORK(&info->cable.work, axp288_charger_extcon_evt_worker);
 	info->cable.nb[0].notifier_call = axp288_charger_handle_cable0_evt;
