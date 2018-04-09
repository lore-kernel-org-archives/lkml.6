Return-Path: <tobias.regnery@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523261097; cv=none;
        d=google.com; s=arc-20160816;
        b=ZpZSABER9L2swFlpIWpEUfBCtk2cTTJ6R04IN7NEQvq3Fozbg9QFIwHOooeBuYGmCV
         Mn0z2k9QXLF+SUKtYA5V/uYu/O/PQ7IAbeRWW2c3GqH7ndQPAUnsHHfvmUC+K/Ibto3P
         EuZPOXJyoQxeqZVJpJd8+6R2Vwk/np0fJV4pYUOVsRkIk+vtmUOm7WsGk0ipGC4zYYZu
         m/lkZSmRdEwm/a+t+hOfaOzShzbXGhWG1aWYPK9EP7FtnXchOgvnc+KZiflSUaSVXtn9
         32dIDIl4+NP+IX2xdm8fpZ4XFBo0zX3l1LUdX4R4S+y2h1gspvlnDLJG3KD+Va0RY656
         3Urg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=qSiARZbZRngDlxoz1mn16m323zicXekSYsEU5fwx2IQ=;
        b=IqQcj/wEmd6VpT/QWOFi2UYXcfcM/jZa1mPtj56UbRfURJSFMFMyn3niiQs7OVxqgp
         i3dWAaDy6VBHRrer5miZabA7SQhNxPzoXaJ7o5/0clOwG0Mm7NfGdnJXOFufGM7VigJs
         A99EhSiy2cfQqOnnLR32RcUI2T+IuLP7PCVgYSwKOdDOTL8ZgQgrgiBul7zmLhMH+uVJ
         h7/OvHqR9Whw6bLf7QNJ4j7UK8/xn5U0F7cfHuz9vaJYr71+LOUyAQC484314e1+ojGu
         XRXXPHlHHtyCjIhboGKbppI6zDJOywFfgRGYJmEbGb9fYZP4ZCPBkPnIYj41prW+EUZf
         5BUg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cSZI8NnC;
       spf=pass (google.com: domain of tobias.regnery@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tobias.regnery@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cSZI8NnC;
       spf=pass (google.com: domain of tobias.regnery@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tobias.regnery@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49CLWlC3j31Io6WQdjKx7CgZOPau3s1GhGimWx0mw3cw28r8GVKRkAgV73PwO0POtzDyCNoiw==
From: Tobias Regnery <tobias.regnery@gmail.com>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tobias Regnery <tobias.regnery@gmail.com>
Subject: [PATCH] usb: typec: ucsi: fix tracepoint related build error
Date: Mon,  9 Apr 2018 09:55:17 +0200
Message-Id: <20180409075517.15362-1-tobias.regnery@gmail.com>
X-Mailer: git-send-email 2.16.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597255028843539112?=
X-GMAIL-MSGID: =?utf-8?q?1597255028843539112?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The ucsi driver defines several tracepoints, but the header file with the
tracepoint definition trace.h is only conditionally built depending on
CONFIG_FTRACE.

This leads to the following build error with CONFIG_FTRACE=n and
CONFIG_TYPEC_UCSI=m:

ERROR: "__tracepoint_ucsi_command" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
ERROR: "__tracepoint_ucsi_register_port" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
ERROR: "__tracepoint_ucsi_notify" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
ERROR: "__tracepoint_ucsi_reset_ppm" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
ERROR: "__tracepoint_ucsi_run_command" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
ERROR: "__tracepoint_ucsi_ack" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
ERROR: "__tracepoint_ucsi_connector_change" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!

With CONFIG_TYPEC_UCSI=y the build fails with several link errors.

Fix this by changing the Makefile to unconditionally build trace.o.
Tracepints are a runtime contruct and no other user of tracepoints depends
on CONFIG_FTRACE.

Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>
---
 drivers/usb/typec/ucsi/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/Makefile
index b57891c1fd31..971befbbc2a8 100644
--- a/drivers/usb/typec/ucsi/Makefile
+++ b/drivers/usb/typec/ucsi/Makefile
@@ -3,8 +3,6 @@ CFLAGS_trace.o			:= -I$(src)
 
 obj-$(CONFIG_TYPEC_UCSI)	+= typec_ucsi.o
 
-typec_ucsi-y			:= ucsi.o
-
-typec_ucsi-$(CONFIG_FTRACE)	+= trace.o
+typec_ucsi-y			:= ucsi.o trace.o
 
 obj-$(CONFIG_UCSI_ACPI)		+= ucsi_acpi.o
-- 
2.16.3
