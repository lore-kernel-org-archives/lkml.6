Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
X-Google-Smtp-Source: AIpwx4+ikzNMiUR6AEbq6IL6CYg64zxqjK6eIK1tjnQoYYuSnNKY0Ovj5cGxWeozpWnPCQ5u8bOV
ARC-Seal: i=1; a=rsa-sha256; t=1523641380; cv=none;
        d=google.com; s=arc-20160816;
        b=ljhN/c36Wkrqf61rDcZ7uf9bMLtDBYK63fHgIK7ofeOtQS+AX+17AHpfR0QmxE8V7A
         cDnz20AB106vba3PCj0MCpmLSi198S4sBnKQQibUyKtcBFJIGDkWVYoBzxsYYNyAE0H5
         REiKXaXkfyf357E3bmi2K0EPD4QlMHMStgQUXnTPemYIrO/wnJ8lrGLxQmmQlQ/EoysQ
         9a3hsSHS5FB+FFMC8rbfc09j/AvVEGWuun4jDfiLPAHeSWkmNIOACMZZAu39wV/77kq4
         QhuDZtdkyqKYzl093MFr+Ugi93VrzsjU1BVocq5rjoAwiKK9bYXerqH3SQA4NVKZRCJo
         e0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=OwUClJWcXVfWZ68gPrzgOBQwOWy5gkukFzG4j2UCTkk=;
        b=gYQ3GTV0Bi/pvuAYJq1u2vMYA/XTIXBysdtPG9US0zlR+zkxEfiJu7xf6g599Cfdx5
         3DsUsnQ7A8XXVjTDQT/DUZQewncbYuEpg8PIcUuxhUPHY755lAq2RJip086c5fw9YeUH
         Mw9Sc1+mIydPdgq+E+iNIA+/NEODKcon3V+oolBDX9cGsJLtrfpZwHSZh9PvQBmGqfeM
         THHISDXIiwxRiW/2aKU4otuxrzplAOb/hCTJT5dahA9t5T6Bk9ke8to0QZ4o0Itk2BMg
         tJqJo21jEvvnKUOeOcdfAo9mVwfer3acYvr5iNTidMwE4IVmAHiHTKSJEngsAeoGZIAq
         SR3w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of sathyanarayanan.kuppuswamy@linux.intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=sathyanarayanan.kuppuswamy@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of sathyanarayanan.kuppuswamy@linux.intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=sathyanarayanan.kuppuswamy@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,446,1517904000";
   d="scan'208";a="33193566"
From: sathyanarayanan.kuppuswamy@linux.intel.com
To: gregkh@linuxfoundation.org,
	mathias.nyman@linux.intel.com,
	heikki.krogerus@intel.com,
	felipe.balbi@linux.intel.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sathyaosid@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	Dominik Bozek <dominikx.bozek@intel.com>
Subject: [PATCH v1 1/1] usb: hub: Don't wait for connect state at resume for powered-off ports
Date: Fri, 13 Apr 2018 10:42:31 -0700
Message-Id: <1087e55507b290d9d22d6d2d53cff0a11b152e1c.1523641017.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597653783604756095?=
X-GMAIL-MSGID: =?utf-8?q?1597653783604756095?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dominik Bozek <dominikx.bozek@intel.com>

wait_for_connected() wait till a port change status to
USB_PORT_STAT_CONNECTION, but this is not possible if
the port is unpowered. The loop will only exit at timeout.

Such case take place if an over-current incident happen
while system is in S3. Then during resume wait_for_connected()
will wait 2s, which may be noticeable by the user.

Signed-off-by: Dominik Bozek <dominikx.bozek@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/usb/core/hub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index c5c1f6c..bd2b136 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3367,6 +3367,10 @@ static int wait_for_connected(struct usb_device *udev,
 	while (delay_ms < 2000) {
 		if (status || *portstatus & USB_PORT_STAT_CONNECTION)
 			break;
+		if (!port_is_power_on(hub, *portstatus)) {
+			status = -ENODEV;
+			break;
+		}
 		msleep(20);
 		delay_ms += 20;
 		status = hub_port_status(hub, *port1, portstatus, portchange);
-- 
2.7.4
