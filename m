Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49ZIKWqETPa8QIDkbtTCcpxsZVxHw5L+0ywfB8FlJ6VND4JPMFswa9v7XVXYbkuGenZTTp6
ARC-Seal: i=1; a=rsa-sha256; t=1523399839; cv=none;
        d=google.com; s=arc-20160816;
        b=hGQNy4qhm/OXqGYL+E4J3PJI55FEDXbwCmCGLmug3G6oXlNPIPVESUa/wdUaEewI9Z
         z4kISgMBDAgEJXWuyPMvePJpbJ2OO+x8bXAmBcs/sTkkzX3Mg/++PMNQece5Myyn/6f+
         SLOroVYZQPdci1FxWXbukDmAB8O5uF82nvwdQnNmkDkXEAeC96CP7c3P7sRbb3euDaic
         i5TWCa6Sgx84Lk1qd3FFJFzka6LDMp1XIhHFVmM3JveSX8aq2leCfqw+uYy5+3/2oAv0
         0cCAGKPwMwi172YCz+AlKtp3Su+87GpdIOnIx22NGts4K8ts9OhqBdxfEP5cSegED437
         RPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jdsO/0KbTrjtHHYMr5O3eNYlvkNzKCbHM9gGVd2mWGI=;
        b=bh4yKvz6bPw5YmvxnJuudCBxSFK7W6d27N+T6fhuPTHUvddAsGv+kL+GM5rV8OpRiV
         9fW8eN+kPbod0T+Yj0sMtTn7dcT4i7Gemb30FlMr2FlTnaYIZ4fHaCp2GZUH3lEVKGpK
         ECbr1EZm/j/n8WpAqPJGUvozuGQe5qBULNn2OGs+dhlploO6JKSzSzxtU+1IUjupIxbP
         I7X9KBd6FfNtt+St8bvrCTm9lu9uJF8a/2wofKwaQWjtertosNZ9dZHieNo0sYcDhalB
         Kx4q7FtxOT0ar+u7u5QHYsrHFPEU35Q0bui6bgtac5d+hsMrmE30B3HcJ+LGtannnJc6
         kaSQ==
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
Subject: [PATCH 4.14 082/138] thermal: int3400_thermal: fix error handling in int3400_thermal_probe()
Date: Wed, 11 Apr 2018 00:24:32 +0200
Message-Id: <20180410212911.704794542@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400085798126685?=
X-GMAIL-MSGID: =?utf-8?q?1597400510002268614?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
