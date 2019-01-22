Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D58C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4806A217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548177807;
	bh=TT4EMJznOwO8CkgeiajaVYcLcpPlJnSljmspnajLiDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R1UqBf+cVu04JFbEzjWczVAieNHw4LR+LgeVKClk3Dvm3KaDFuwBOoS0TX81HhGFr
	 USniwmwj1XELxDqIfX2FM0EsLW8J31UkJhWvlKtFYYlodvETLXJ4B2q2L8hjExreqF
	 lXrXqEilQelKcdeRqj/9armqLuc5iC/34CpPU4cE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfAVRXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:23:25 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41162 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbfAVRXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 12:23:21 -0500
Received: by mail-lj1-f193.google.com with SMTP id k15-v6so21326784ljc.8;
        Tue, 22 Jan 2019 09:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=95vT/g8JD1V7rlRm4ZraLcTyL7OUHKZsnDUXHLxwHqo=;
        b=MYswCgPkx8yPLludpvoCz8WzQt5075xhaYI+fCU3BdwKEjIKqSoOjP2zJDqmufxyH/
         4eCsXK6ZSE9lyG1RuqYUmsicIcvuNlSc+zR6jqIuF2VE4XL3qR17Wz1EtX5o3oPHNu+H
         KiiV4/3MyhTvnGsJW6BG0wn+7/GOJvPzPwcLBmuxIJ0WIPUwTvaITmRyb6G9OtJU8Cym
         sPfDKfhJIKvud4FvFHti/f5byeJiM6ohynT34HxKXTmgWdd1fVIHvF/ix/lMv9ktMYo0
         szNyHZNpwZ1h3JLPAT6WnvAKp/8Dzie8i74zs4DDMBfRlKFCzib9mZn6X7Rx21aERDX8
         JuaA==
X-Gm-Message-State: AJcUukdWz1nwkgVFvIAcni5WTGLDgjAcVAPmDzCSKzm2RPjMagrWTHWn
        Dw0ygThqU6sOhECeHzURPVbv33No
X-Google-Smtp-Source: ALg8bN7hrm3PldmXaIjnW80rJCqnkKZ4Ni6RHcpYki3/ixdXwVBPgSWmzWqeJKuGL4zk2AoXZOK8zA==
X-Received: by 2002:a05:651c:c8:: with SMTP id 8mr21015706ljr.53.1548177799012;
        Tue, 22 Jan 2019 09:23:19 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id z15-v6sm115050ljb.9.2019.01.22.09.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 09:23:17 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1glzla-0004gE-RE; Tue, 22 Jan 2019 18:23:14 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>
Subject: [PATCH 1/3] gnss: sirf: fix premature wakeup interrupt enable
Date:   Tue, 22 Jan 2019 18:22:53 +0100
Message-Id: <20190122172255.17944-2-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122172255.17944-1-johan@kernel.org>
References: <20190122172255.17944-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure the receiver is powered (and booted) before enabling the
wakeup interrupt to avoid spurious interrupts due to a floating input.

Similarly, disable the interrupt before powering off on probe errors and
on unbind.

Fixes: d2efbbd18b1e ("gnss: add driver for sirfstar-based receivers")
Cc: stable <stable@vger.kernel.org>	# 4.19
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gnss/sirf.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index 226f6e6fe01b..8e3f6a776e02 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -310,30 +310,26 @@ static int sirf_probe(struct serdev_device *serdev)
 			ret = -ENODEV;
 			goto err_put_device;
 		}
+
+		ret = regulator_enable(data->vcc);
+		if (ret)
+			goto err_put_device;
+
+		/* Wait for chip to boot into hibernate mode. */
+		msleep(SIRF_BOOT_DELAY);
 	}
 
 	if (data->wakeup) {
 		ret = gpiod_to_irq(data->wakeup);
 		if (ret < 0)
-			goto err_put_device;
-
+			goto err_disable_vcc;
 		data->irq = ret;
 
-		ret = devm_request_threaded_irq(dev, data->irq, NULL,
-				sirf_wakeup_handler,
+		ret = request_threaded_irq(data->irq, NULL, sirf_wakeup_handler,
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				"wakeup", data);
 		if (ret)
-			goto err_put_device;
-	}
-
-	if (data->on_off) {
-		ret = regulator_enable(data->vcc);
-		if (ret)
-			goto err_put_device;
-
-		/* Wait for chip to boot into hibernate mode */
-		msleep(SIRF_BOOT_DELAY);
+			goto err_disable_vcc;
 	}
 
 	if (IS_ENABLED(CONFIG_PM)) {
@@ -342,7 +338,7 @@ static int sirf_probe(struct serdev_device *serdev)
 	} else {
 		ret = sirf_runtime_resume(dev);
 		if (ret < 0)
-			goto err_disable_vcc;
+			goto err_free_irq;
 	}
 
 	ret = gnss_register_device(gdev);
@@ -356,6 +352,9 @@ static int sirf_probe(struct serdev_device *serdev)
 		pm_runtime_disable(dev);
 	else
 		sirf_runtime_suspend(dev);
+err_free_irq:
+	if (data->wakeup)
+		free_irq(data->irq, data);
 err_disable_vcc:
 	if (data->on_off)
 		regulator_disable(data->vcc);
@@ -376,6 +375,9 @@ static void sirf_remove(struct serdev_device *serdev)
 	else
 		sirf_runtime_suspend(&serdev->dev);
 
+	if (data->wakeup)
+		free_irq(data->irq, data);
+
 	if (data->on_off)
 		regulator_disable(data->vcc);
 
-- 
2.20.1

