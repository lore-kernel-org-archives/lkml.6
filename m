Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x224fJgJzKSOB95apRPePFRIZEDP/kxJpZFyjKHC60mtLyArRpHXUuYmoR2gvayd7u1L4XbyP
ARC-Seal: i=1; a=rsa-sha256; t=1518323646; cv=none;
        d=google.com; s=arc-20160816;
        b=GHGvGlCVzI/q6gP7FdQmqSQtQ46D5Pi7qX8uKOxsC2kk8k6wa+hjC2Q8OMX6XMSNmr
         zbe74/6RWW/jCZ/MdvISZJrqxZzEiWoqaD9b4zo6hRtZnmhrwVIzDHU9OYOkQw8GnSuy
         5N5Qj9ZfQmW/f1G8ku2OExA69eWOG6ygTSeu0vIFEaKWGreFL9Ry7bBAHsdRwTBselen
         5Y0RlrBxzdhL01PBEDRSFtUpRH+w5n6g/2lbJ9zdx5liZ6+4TLcP7hd7vz+Yyt0A3vlq
         T1HznEoVr2D3sHEn2a0vbJ7ptPxUn4DYPKKxTaVXgqIB4tCh5c5bKAI2TbftoA+IdnWA
         vGAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=NJLzYC9yaYnxSYQ62gTzM0qCi0Rk4fOSvC6etAKcZDQ=;
        b=NSSGs95O103KqazADMhHH8YXeEpBp/+70mhK8N2OdwIZA8zGIBqAHPYaVlIPa6FUsV
         6n94awi7/dC8FhWTai1yXE27FVYr41AxPyGfiFwRBRek7/6EVS8eTt315YWvmyPR/FBu
         Kbp4OvT/z4zcAPXkuwH1DzjSMGMCjy3nD4qTyyJSYnEd9K5M+X9RqDqxXaNyROkd3ioa
         ycyHXxA42MHYKwHl6hvA1ylf21wwQwNlhCypGtY74B3G9+c4FgNrHq8B3M8kbMG1T0Kq
         EGG5oru+UYikjckTyObfeuWIi2lWdCkTj2O0xXUwlEhcF43ihVCyXECzDvEsELW7BFI0
         lvzQ==
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
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.485248163@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 021/136] USB: serial: metro-usb: stop I/O after
 failed open
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077735628688366?=
X-GMAIL-MSGID: =?utf-8?q?1592077735628688366?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 2339536d229df25c71c0900fc619289229bfecf6 upstream.

Make sure to kill the interrupt-in URB after a failed open request.
Apart from saving power (and avoiding stale input after a later
successful open), this also prevents a NULL-deref in the completion
handler if the port is manually unbound.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: 704577861d5e ("USB: serial: metro-usb: get data from device in Uni-Directional mode.")
Signed-off-by: Johan Hovold <johan@kernel.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/serial/metro-usb.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/usb/serial/metro-usb.c
+++ b/drivers/usb/serial/metro-usb.c
@@ -217,7 +217,7 @@ static int metrousb_open(struct tty_stru
 		dev_err(&port->dev,
 			"%s - failed submitting interrupt in urb, error code=%d\n",
 			__func__, result);
-		goto exit;
+		return result;
 	}
 
 	/* Send activate cmd to device */
@@ -226,11 +226,16 @@ static int metrousb_open(struct tty_stru
 		dev_err(&port->dev,
 			"%s - failed to configure device, error code=%d\n",
 			__func__, result);
-		goto exit;
+		goto err_kill_urb;
 	}
 
 	dev_dbg(&port->dev, "%s - port open\n", __func__);
-exit:
+
+	return 0;
+
+err_kill_urb:
+	usb_kill_urb(port->interrupt_in_urb);
+
 	return result;
 }
 
