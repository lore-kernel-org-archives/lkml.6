Return-Path: <arvind.yadav.cs@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520854679; cv=none;
        d=google.com; s=arc-20160816;
        b=FGL20B1/ZwO6K3pKVSJFY32jHeeI0nhckG9/rhybIMQoqyO2284RaZoPWgnZRn4pDk
         T5k1CrRQa6ySE/GVjPyYbYSE/a+mHdZQle1f/N3pxxY1KrJouw9JsmoiBYBRgI11RmlP
         ZFt4sTqkkOSqqJAQ/tyD6cAG6h9KcKs4iwHVXDeleRfDesXT3DGEJEhwLywD0xFPSJLD
         KnOCimLPMKzFmHHMtAGyD39/LGzgUHPTgusZpJhor3s8nzHQMvVmqGGz3HUrrcBOZoRN
         fD9qcVsFsfVmy4votscjyfkfLBj+Y1wMVm5StTPBXq9O8FFi7W66fYCMm8cN1RNpx+6D
         Dwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=8+nXT9Ng+vl5F+TFhJk7+mnr+pM/3cc9EvNQaguChqg=;
        b=flpCki5fm40moN0uAhAFRQQTRxxkeHZSrfERVP2f9LxbpeWOxVpkNjuEsIxNULlhxr
         47pMTU3kP+YUmwNgO0WSMixoMR+uOSxAABK7vS3z2mh8qvtgONW4wmxK5b4zQX6kVZzg
         6KW3MW+uIHi8XsUfiKECP7FL0wIdgvwb+bUmAgPvWnXvaNd1dePIqqpsLwJeQ5+v3gwS
         Manojm7p9mgvFnsnQQ5cDPUp6j9Kn2GkIYIpLaqHIoLI131iebznpscc3PgqLZdvW+Eg
         90JW3iO/VVdzYaRZujTLpbfJ7EP0PYQcqONmAsVAvl9LwrreLsWsbZA9Oge9JkEDq6z4
         ITYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CS5hk9IK;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CS5hk9IK;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuGfdN22UNlGkHQ4cUCjnjZ0wJ8bik5dIz+sKbB+F+B14gGpGZqXkEb6jqv+UqFFEQO9Eynrg==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: sudeep.dutt@intel.com,
	ashutosh.dixit@intel.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	fbarrat@linux.vnet.ibm.com,
	andrew.donnellan@au1.ibm.com
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] misc: ocxl: use put_device() instead of device_unregister()
Date: Mon, 12 Mar 2018 17:06:53 +0530
Message-Id: <8c4d28703e408b71284af68d07c117e7b8c8a75a.1520849284.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1520849284.git.arvind.yadav.cs@gmail.com>
References: <cover.1520849284.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <cover.1520849284.git.arvind.yadav.cs@gmail.com>
References: <cover.1520849284.git.arvind.yadav.cs@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594731716562305768?=
X-GMAIL-MSGID: =?utf-8?q?1594731716562305768?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

if device_register() returned an error! Always use put_device()
to give up the reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 drivers/misc/ocxl/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ocxl/pci.c b/drivers/misc/ocxl/pci.c
index 0051d9e..21f4254 100644
--- a/drivers/misc/ocxl/pci.c
+++ b/drivers/misc/ocxl/pci.c
@@ -519,7 +519,7 @@ static struct ocxl_fn *init_function(struct pci_dev *dev)
 	rc = device_register(&fn->dev);
 	if (rc) {
 		deconfigure_function(fn);
-		device_unregister(&fn->dev);
+		put_device(&fn->dev);
 		return ERR_PTR(rc);
 	}
 	return fn;
-- 
1.9.1
