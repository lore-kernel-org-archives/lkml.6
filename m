Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+fYoJULb5G7CouHRbabIJe8J6BNH01Bax7XeoluXqPSvysGHUtx5mhavO5liJNEXyXEI7f
ARC-Seal: i=1; a=rsa-sha256; t=1523399435; cv=none;
        d=google.com; s=arc-20160816;
        b=nbKdUlo/D+JUSctLAi5M9LaCO2rd99UBPgKHkO14dx0UXkAWVxwLHOMKg1CNdnVMOM
         IpDaUitlBfXzLcOqe6D90yjrbCkIBGKIIT2PogVh2h1EbAmOSShM3YQVYyP6YuHw9sPP
         D+X18pi+Myd1Mb6lmoPneZDgcE7hw0oPV/KYGI5BqT6AMrN4h1DtPVUIciIS5Mp0K1Py
         W3n+PJ4MT/AW13r71Sm2IXK2XR2wi6WGSZMCfLSE5siKihfiEKr8QzAv1QwdUMuhvZNV
         W7FOpt2SoPlcfyHMddxkPLRxGtEXz3Yu/6sHYTI9HI14Kl7oyZPtbGTgmuPv2quOsWXB
         KzaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3n3QSK4scBF3Nw5sHp7ENK6ZjByNYI5IIJOlbiOubog=;
        b=SN4oewIZbxfRD1jXtQqVwIPtjrczkKhxUu+KW4W1sORPR6n1K2Te6LW0QAox+JLghf
         GeuEA9L5OXY2dzN9YxISedF5DCE84bODReERKC9eAACTSR3yD3r25f4BaqrtCrHR6hYq
         Gu3bz8QBJ+aBJ3i3JPeteHxdmgmyYQtbGP/1spohoTqdzY9vMDRihZU8P0xCCuiF6qaC
         B3Dyn/fpGSG6LlI0WzYXKun77LAdUYhZRl6n89YsllKdXPZg8CfZFQu1N1qKAVL/Rka3
         33T3ABGF91dpSGqe7WS53JqKslW1f2eInbCYh/H5tX8VHkrJ3f3hmjid0Zkfz/DMBSG6
         sZuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Zhang Rui <rui.zhang@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 106/168] thermal: int3400_thermal: fix error handling in int3400_thermal_probe()
Date: Wed, 11 Apr 2018 00:24:08 +0200
Message-Id: <20180410212804.749830383@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400085798126685?=
X-GMAIL-MSGID: =?utf-8?q?1597400085798126685?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Khoroshilov <khoroshilov@ispras.ru>


[ Upstream commit 0be86969ae385c5c944286bd9f66068525de15ee ]

There are resources that are not dealocated on failure path
in int3400_thermal_probe().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thermal/int340x_thermal/int3400_thermal.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -319,17 +319,21 @@ static int int3400_thermal_probe(struct
 
 	result = sysfs_create_group(&pdev->dev.kobj, &uuid_attribute_group);
 	if (result)
-		goto free_zone;
+		goto free_rel_misc;
 
 	result = acpi_install_notify_handler(
 			priv->adev->handle, ACPI_DEVICE_NOTIFY, int3400_notify,
 			(void *)priv);
 	if (result)
-		goto free_zone;
+		goto free_sysfs;
 
 	return 0;
 
-free_zone:
+free_sysfs:
+	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
+free_rel_misc:
+	if (!priv->rel_misc_dev_res)
+		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
 	thermal_zone_device_unregister(priv->thermal);
 free_art_trt:
 	kfree(priv->trts);
