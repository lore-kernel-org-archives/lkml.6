Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x224XKzOI49+IoFn1AaRoKHBERk9vLQPia6JRWL3HVDilgFhJqBt+qDehHluAlVL7MaeLnZKx
ARC-Seal: i=1; a=rsa-sha256; t=1518323621; cv=none;
        d=google.com; s=arc-20160816;
        b=mEXHa9fBKALkgI5rrlR53FOjSPH5wC21XKod2DVvNAdAGsziQlx8y/En8jYjZKu78c
         tggUJ+mA/zUqHYtP7PKTjJpqF7aAQ1vASuzA/DRDSthhHgmXWVRPNcQeKtK3kM2viTa8
         0qGQjGb9idvUCwpJpdRgROZUUwcnBC1tJ+b4ic5LDpA9unl4gpXRjMCXTIbB5DCocLet
         8EipnAJEUtVAREx3HN9bqDTX97Ap/CMT7TUwbEwMevrYzWkLA8QOuPzjEgN8Mek/Qkvu
         OvZF+JnulocGfAQc01f+GCLDClk58xBgXzEdOGNITd4LwsKNdIkWpT0pnd52WAE/X3/f
         N4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=+wrRxTYvawYHr1erA8hKk4EDh8RFvJgphf2biJVIVnc=;
        b=jenvXzduKpxZeg6FCHu2jpO7sm0j+IxJyodGW5giO3PQ1pBzs4vZMn7gmvgPqe5VUM
         kxs1nw73rY3NFT2LcE60IeL4gWo1jDQJ+keNHl8Zc5JymbAxeu5JbS68RoWB1+Q8RXmQ
         qcO+z9re1xoLb4fnoMib6ahToksitnZjCsl3kXP8J52zB7pe/15H0JO9bwA9afFEFXTZ
         EuCFW7uV/WinPu56OhE+/cQXHj9KIv6mGkBL0Cn6M7I1JIg7aLGbB99sdSdMIbDE4Ku8
         Rbo7QjLHIqr5+HD7BkarxsLyCBfu7VMRIsWIfT4X5Hn9+uL1VJXp0aXBkcgcA2cT6qJX
         lFrw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Johan Hovold" <johan@kernel.org>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.983870336@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 06/79] USB: serial: garmin_gps: fix memory leak on
 probe errors
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077709500496228?=
X-GMAIL-MSGID: =?utf-8?q?1592077709500496228?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 74d471b598444b7f2d964930f7234779c80960a0 upstream.

Make sure to free the port private data before returning after a failed
probe attempt.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/serial/garmin_gps.c | 6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/usb/serial/garmin_gps.c
+++ b/drivers/usb/serial/garmin_gps.c
@@ -1476,6 +1476,12 @@ static int garmin_attach(struct usb_seri
 	usb_set_serial_port_data(port, garmin_data_p);
 
 	status = garmin_init_session(port);
+	if (status)
+		goto err_free;
+
+	return 0;
+err_free:
+	kfree(garmin_data_p);
 
 	return status;
 }
