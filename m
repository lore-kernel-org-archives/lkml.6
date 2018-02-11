Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x22424q2I/0VRKP+fWJm68nguvCLgtLXng+OhOUOEsAu+QVbEOFxYAMiBKyZ5B60qkAIV2yHf
ARC-Seal: i=1; a=rsa-sha256; t=1518323639; cv=none;
        d=google.com; s=arc-20160816;
        b=zdgJ0oCG97L+EzRD6r8xAkW2s+ERiRYnyJeu2A+HK/t/IRT+OeiDS/u6wXXvCDQ0X8
         6YwYb7ok+DhYvlkunGFdPp3ksUGegiBa7RfjIjkDqZ/XkB0PXXrKRrteKdpHZ+v3hytl
         JaYeK5hkOsAi90t5WVIdc6zWrMedFO8JP4nd1LGY7zEZidQxyh/eImpQI7TLKP92J8Pr
         gosuYKh282VsMKPVrwADLOfcPtSAxphcmmMMEUMSAkwgtKmKM4eGoZ+73rUPG8loMT02
         /+ogbGLi2TU8CvQHcCPQ3jGSqmsLuWobzC575jLVso7P6qjJlgpOP1twgaxnog9T2GcZ
         68OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=0m5KZv4xiMwDQEg0SvwC5cm5NRyHadd/0h13L5BU0BA=;
        b=LS8EqOxWwXznPpLhghgXe/UgeMxOzdGfLXkg2hMhQRupi/e/Gl8AE+W2k0HYQkc/rq
         qQ2sSlwOXE1ovEzxO4AzaRikXc4ssKdAK1VvsDaT6YKSmHDUmNXqXLadtCQtfhj4X9Nu
         K8eWLH0CcRR/jgDTsPNlcG2OMbLJl9XE2kLyM0znHQve3F0N8Qp5hVG84vTxF/0RUTFG
         LzGRWEc/CO7Ow7vFasRIjcZ/QMski2LwySK0Qia0JCGr32mLYtfrtAskczbUaBlu0j/k
         aa5GimpbmGtxouSPwDwafktgUfHNK8x4qkW/SMK3NjMlEhX5LZoX2m1NGHp9s5Ww+0/Y
         LrcQ==
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
 "Johan Hovold" <johan@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.597037676@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 017/136] USB: serial: garmin_gps: fix memory leak on
 probe errors
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077709500496228?=
X-GMAIL-MSGID: =?utf-8?q?1592077727898777319?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -1414,6 +1414,12 @@ static int garmin_port_probe(struct usb_
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
