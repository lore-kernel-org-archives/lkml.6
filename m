Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoFAM3xuo+Bj7TvqjhWjttEAjItQjHyOflQKGPa/2hCFyZyH7U5z+0lTOoQLPyd1XPBUHvu
ARC-Seal: i=1; a=rsa-sha256; t=1524837933; cv=none;
        d=google.com; s=arc-20160816;
        b=LlZ3kTcjHJmanGtqcchnbD0CB/a8EFyEHy2SwWFgmJkfbPTV0Wo7nMYkjRyjHEq64Y
         q3P0FQDaSrk9Cc1zAt2VOpnbp3V4PW22NT8Wico47MywJpmcS6K43SjZ/MBhQXa31adJ
         WePixHrzl3izA71xoV1kTXXwuuDSYE3j8Y7PIUNLYeayji3ozd0I9RDlz3b94B9qJUnN
         jjTpRrIutOtuRPjp/Z2DfHybcH7YH0PoFWijOaHt+qib2F2Uxk6rdyo+xbnj8TOzxIGm
         6OYal5BU7J1JA+jmpzfqSFFnK2nJF6k6/aktvdSUOJDa/iZVgWkn940MAO1UpaU+uqw3
         MW1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=kxRwFz410lmJw6ZJ5UyefFsHGw03PX0eCCmz0S50pbQ=;
        b=zd8NVgfHkR4OxpyyYo0vMNq9dkI0bAYk6tPKihtaz1lSJY6XvEDcvHEfVqMI1iOlhu
         0f8XpCKh2WrHpUk8bdq30bN0wBlQxJS+ZLj7poPFgUojyC7jtczJf7rSPww3fSmSfhbR
         fZxIq1nNGppwo+tXKOMZu3aQe8alzEC2yHuWKr/S67G45tLfhiRC0SBH0o6PkP82ZJ+2
         2EnrvJDUo/O1WuU5NKLahUinKoT0IMKLj45PvewStWXyLu50hceOZLZ0Uy9yBluFc7Gb
         LHSuJQKXNgk8TMw5i38E1/QAJ5WwcxG5ZmB5tpGuaY3eHwX4wLF+FZYFtQXc2GHq+PWF
         y57g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6602B2189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Stefan Haberland <sth@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.9 72/74] s390/dasd: fix IO error for newly defined devices
Date: Fri, 27 Apr 2018 15:59:02 +0200
Message-Id: <20180427135712.929452161@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908460763749049?=
X-GMAIL-MSGID: =?utf-8?q?1598908460763749049?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Haberland <sth@linux.vnet.ibm.com>

commit 5d27a2bf6e14f5c7d1033ad1e993fcd0eba43e83 upstream.

When a new CKD storage volume is defined at the storage server, Linux
may be relying on outdated information about that volume, which leads to
the following errors:

1. Command Reject Errors for minidisk on z/VM:

dasd-eckd.b3193d: 0.0.XXXX: An error occurred in the DASD device driver,
		  reason=09
dasd(eckd): I/O status report for device 0.0.XXXX:
dasd(eckd): in req: 00000000XXXXXXXX CC:00 FC:04 AC:00 SC:17 DS:02 CS:00
	    RC:0
dasd(eckd): device 0.0.2046: Failing CCW: 00000000XXXXXXXX
dasd(eckd): Sense(hex)  0- 7: 80 00 00 00 00 00 00 00
dasd(eckd): Sense(hex)  8-15: 00 00 00 00 00 00 00 00
dasd(eckd): Sense(hex) 16-23: 00 00 00 00 e1 00 0f 00
dasd(eckd): Sense(hex) 24-31: 00 00 40 e2 00 00 00 00
dasd(eckd): 24 Byte: 0 MSG 0, no MSGb to SYSOP

2. Equipment Check errors on LPAR or for dedicated devices on z/VM:

dasd(eckd): I/O status report for device 0.0.XXXX:
dasd(eckd): in req: 00000000XXXXXXXX CC:00 FC:04 AC:00 SC:17 DS:0E CS:40
	    fcxs:01 schxs:00 RC:0
dasd(eckd): device 0.0.9713: Failing TCW: 00000000XXXXXXXX
dasd(eckd): Sense(hex)  0- 7: 10 00 00 00 13 58 4d 0f
dasd(eckd): Sense(hex)  8-15: 67 00 00 00 00 00 00 04
dasd(eckd): Sense(hex) 16-23: e5 18 05 33 97 01 0f 0f
dasd(eckd): Sense(hex) 24-31: 00 00 40 e2 00 04 58 0d
dasd(eckd): 24 Byte: 0 MSG f, no MSGb to SYSOP

Fix this problem by using the up-to-date information provided during
online processing via the device specific SNEQ to detect the case of
outdated LCU data. If there is a difference, perform a re-read of that
data.

Cc: stable@vger.kernel.org
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/block/dasd_alias.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -591,13 +591,22 @@ static int _schedule_lcu_update(struct a
 int dasd_alias_add_device(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
-	struct alias_lcu *lcu;
+	__u8 uaddr = private->uid.real_unit_addr;
+	struct alias_lcu *lcu = private->lcu;
 	unsigned long flags;
 	int rc;
 
-	lcu = private->lcu;
 	rc = 0;
 	spin_lock_irqsave(&lcu->lock, flags);
+	/*
+	 * Check if device and lcu type differ. If so, the uac data may be
+	 * outdated and needs to be updated.
+	 */
+	if (private->uid.type !=  lcu->uac->unit[uaddr].ua_type) {
+		lcu->flags |= UPDATE_PENDING;
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
+			      "uid type mismatch - trigger rescan");
+	}
 	if (!(lcu->flags & UPDATE_PENDING)) {
 		rc = _add_device_to_lcu(lcu, device, device);
 		if (rc)
