Return-Path: <tobias.regnery@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523350080; cv=none;
        d=google.com; s=arc-20160816;
        b=Oc9OxvetYR9dYcCArFoO8Q6WkT3sheyGCs2w/xyR9dEPZyCSZtUVakD8D7qClzrQ9u
         g50qzdLnpJGIlE8OocDyxi3b8FfasgVXMgM+tHW3Urbv3ARWlvzX5gluPjj3N00XB8l8
         E4RtfIL6QUvHyFqyGW8vw4TSaIyM2/qMXWN+YFinaRZfIH1DoyxOmdU8jMzhUQ3Plpfp
         VmtRfYpUNcION/8ZJsPQdT8ZjICNrCGiFxaN18kqs0qnr22i54jZGE8JAdbwi5wVQ9d5
         s88yAqLX5Pwi3z6HYYyeo9XSWb7WBmSWpNimiSJ7nU/hpjYaOro/cbZAj2mJd8/lLl0d
         LUwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=Lrm0oy3u72lqh7OfKxh5QW75f8a1C0xC99SgAqjp8SQ=;
        b=YlfvMDDbJj2n5WD6Ybb0UKxnHJjdgS3VK7uGm7Z3fiFls3GB4SHJR2GnGv2AbiBedM
         CRE2XufbaWoEpe6hvzf7/ghr74ObyAtPFkdzFocBuqUKoLROCbBWukBX3keyxzy8nuGD
         HEPzltRl4S8xWIp/kNtUPqOU2A9b/A9Yunava1WLPDhJ12Wje4SaBXaLGThCWQILEvYJ
         vy2O8vHawMr9TDSR+EcDuZkedjhLvemvlflxDx/JaY5aisXUqD64qbhdue+AmXcT872K
         L+sl6fEEujHvVXBP08VxRRD1elcVHrr0sUQCNYDQ2jluX4k8Z/INjE7tW6jtavXJ6Awn
         J4zA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Wh91j+nH;
       spf=pass (google.com: domain of tobias.regnery@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tobias.regnery@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Wh91j+nH;
       spf=pass (google.com: domain of tobias.regnery@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tobias.regnery@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/8YJU2Gc5++zE4GkN/N9D9akU9yKUEfC8yDrCBX+fwPLHELfxx0LZaBFsFqrqZXe3z/S2gzQ==
From: Tobias Regnery <tobias.regnery@gmail.com>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tobias Regnery <tobias.regnery@gmail.com>
Subject: [PATCH v2] usb: typec: ucsi: fix tracepoint related build error
Date: Tue, 10 Apr 2018 10:38:06 +0200
Message-Id: <20180410083806.27874-1-tobias.regnery@gmail.com>
X-Mailer: git-send-email 2.16.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597255028843539112?=
X-GMAIL-MSGID: =?utf-8?q?1597348334009325944?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There is the following build error with CONFIG_TYPEC_UCSI=m, CONFIG_FTRACE=y
and CONFIG_TRACING=n:

ERROR: "__tracepoint_ucsi_command" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
ERROR: "__tracepoint_ucsi_register_port" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
ERROR: "__tracepoint_ucsi_notify" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
ERROR: "__tracepoint_ucsi_reset_ppm" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
ERROR: "__tracepoint_ucsi_run_command" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
ERROR: "__tracepoint_ucsi_ack" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
ERROR: "__tracepoint_ucsi_connector_change" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!

This compination is quite hard to create because CONFIG_TRACING gets selected
only in rare cases without CONFIG_FTRACE.

The build failure is caused by conditionally compiling trace.c depending on
the wrong option CONFIG_FTRACE. Change this to depend on CONFIG_TRACING like
other users of tracepoints do.

Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
V2:
  - change condition of trace.o to the right symbol

---
 drivers/usb/typec/ucsi/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/Makefile
index b57891c1fd31..7afbea512207 100644
--- a/drivers/usb/typec/ucsi/Makefile
+++ b/drivers/usb/typec/ucsi/Makefile
@@ -5,6 +5,6 @@ obj-$(CONFIG_TYPEC_UCSI)	+= typec_ucsi.o
 
 typec_ucsi-y			:= ucsi.o
 
-typec_ucsi-$(CONFIG_FTRACE)	+= trace.o
+typec_ucsi-$(CONFIG_TRACING)	+= trace.o
 
 obj-$(CONFIG_UCSI_ACPI)		+= ucsi_acpi.o
-- 
2.16.3
