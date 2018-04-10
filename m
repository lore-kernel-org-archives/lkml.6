Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49mLwUndR2rqgIOAl1gAC+a7FCa+xTPxyY00GZG+5Zwo1UcZuWs8522qbzTO9fe5CG/Melk
ARC-Seal: i=1; a=rsa-sha256; t=1523399373; cv=none;
        d=google.com; s=arc-20160816;
        b=NltbIx2HnSyq49uvvt5eYDGrzbrF7QsA0mECeCwUyq1AVpUeHpQVUZQB9v3miLobsy
         cy842qE5di67K1Zy5cDOw2u/hxfMtzyanF4IUYR5HogcIllcCvd9CcQ0d17gRgUCICm5
         4zC5BChu3GmXVToYQO2n7UUB45HefMV1/jgOJ3P8er87tDQ9HVKbhCVMRnYQh+mbrsxv
         AOHpxb/m9VUREW4WpR6MV9PWMq/hz/QmnpJcIFHrhfT9CSIE57RY5m/2VRjv/kZ9gdgP
         qu8okhZPx3WCVvesfitAgPhcFEHr/Bp2CMf/izcecm6uOnPGamBRl1bvG5NmS6wFVY/n
         ebbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oqYhObxK3X1SGTAkxFnS52CbwKl1iAPVpAkXFAkylew=;
        b=ddVH6eYQsSq37L96mVD1fzBFh5hRBADnm3ziALUN1GZ/UCSvaZE2XvIuRdkw8ubt96
         J8e8aGI1Vp5xRMxIbnYKdyHV+qKfDhVPHhsi1HE02gb8sa0DBYN9O4idgsCKFHEEO5eN
         lS1dHplAmjmXrNFs9wiHFHDt6Lx2rSdtHIIFdpLvvlOcQgqNJzuCz9hUMhu8tf4x1X+y
         Ti6MPi9UkkzkidDA1cZT/YVxIyMnM2mGGoW/bmsTp1fdPjp5dtVY9dqOwPzSP23EgPwK
         SUFpMmpNybT1gJRHPR5nFdVGrEwlI1E8to3pACJvjTbQDs4VykVI5D1GZwnkNEagw5Us
         QybQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Johan Hovold <johan@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 084/168] serdev: Fix serdev_uevent failure on ACPI enumerated serdev-controllers
Date: Wed, 11 Apr 2018 00:23:46 +0200
Message-Id: <20180410212803.843359055@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400022293297428?=
X-GMAIL-MSGID: =?utf-8?q?1597400022293297428?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit 7d09995dcb0577b4a56aad7f2bb56f28604e8f1a ]

ACPI enumerated serdev-controllers do not have an ACPI companion, the ACPI
companion belongs to the serdev-device child of the serdev-controller, not
to the controller itself. This was causing serdev_uevent to always return
-ENODEV when called on a serdev-controller leading to errors like these:

kernel: serial serial0: uevent: failed to send synthetic uevent

being logged. This commit modifies serdev_uevent to directly return 0
when called on an ACPI enumerated serdev-controller fixing this.

Note: I do not think that setting a modalias on a devicetree enumerated
serdev-controller makes sense either. So perhaps the !dev->of_node part of
the check can be dropped too, but I'm not entirely sure that doing this
on devicetree too is correct.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serdev/core.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -54,6 +54,11 @@ static int serdev_uevent(struct device *
 	int rc;
 
 	/* TODO: platform modalias */
+
+	/* ACPI enumerated controllers do not have a modalias */
+	if (!dev->of_node && dev->type == &serdev_ctrl_type)
+		return 0;
+
 	rc = acpi_device_uevent_modalias(dev, env);
 	if (rc != -ENODEV)
 		return rc;
