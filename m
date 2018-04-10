Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49yBN0aytofj319F5ZqEfON7e48Tc63eNDHRnhwECgKTqvGj33JD02brkt0e4ZRLxV9j4Nb
ARC-Seal: i=1; a=rsa-sha256; t=1523399804; cv=none;
        d=google.com; s=arc-20160816;
        b=YldB1hguZOTZcjg5JP4vuIqmsfycendoxEYEPS+CUnClOv+BV3QMQt7cWN6auQ95B2
         /gvKXuCXilT4L96ZdamG4SA6dfMnLkR/UQIQNlUNc7QdP6T94yu9L7mvBsEsUi8RKDes
         WLgy7k6WPmV6mOC4zTf3vWk304QRdSLSClrlOaDtdy0jt26cGPmmYoFgOC2FUZppI1HH
         s1BUByY3lx0jAa5n/W4yX6Ss4vLaPFX6aFiYP+uQOIdScO/7gixGUAvp3mFp082vXbfL
         zGjRE/rl2PvkLWNdXwyQnpmxwVdQzCvrDYnIOzH7DV5bjIiQTpVhsrTGVcM5s07VaoZW
         CMnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4RIVZnxHvMx2Q420PmsyvCiwQi8ChOR0djlnru9UcNE=;
        b=inRbyxbMqisCKflrrZA5ut03FcGyOGufWQVMfEpJrGeUUpkgbZFT2uKppQUZ+xDMVm
         ZnOE1mvbEX5oAskHBMZX7Iz8pkFqs+dAeQoqn1UgWqnWA5zr9ggons09tiBGvDkEa6nZ
         xAlQR2Tc5I+FtEjXQn3QsFiQOmPN+YQ1HmtLP0H43RoT23Mu8tyN+9/FUnsHJpHQKYbl
         mZh9k/BbSPrZ1WRXjfucXwcuBz5xODLV4WX+zKI60FNFw3lKjYl/GRPy13eh6HpltvPL
         C3AHbazqRA6O5mD+1Nr7FjjxKyvDR+8J4G16k8n/cXOs1Fmf3SUR/JBpHm91Oc29cD7+
         NDVw==
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
Subject: [PATCH 4.14 049/138] power: supply: axp288_charger: Properly stop work on probe-error / remove
Date: Wed, 11 Apr 2018 00:23:59 +0200
Message-Id: <20180410212907.798255607@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399963869125189?=
X-GMAIL-MSGID: =?utf-8?q?1597400473870100445?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
