Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11D7C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691132077C
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQvWGK9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691132077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387415AbeKOBOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:14:31 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40874 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbeKOBO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:14:28 -0500
Received: by mail-lf1-f66.google.com with SMTP id v5so11753969lfe.7;
        Wed, 14 Nov 2018 07:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V2gDxG4MoSD1NzQkqxYtCAFDyRdNskut3Xu6T0fkwZQ=;
        b=CQvWGK9nwTDNldo2k2MncSCr3BEKRA/NlshmhQwrge6iu4KFTscNQMwNmRed6xcITv
         5GSMpU7Ejm/uLFYBU2xPh4MR1PTSj3yTWVf/t6BSdSF9K7J7RHWdaOKNJdeMh/v+z4Eb
         w3PQ5eoyn1G3yZZIzRxODGDSOUR1kL9SIIIW1fLVRvcZhBt2HFXhgoqRx49zACIxvU9b
         h3ryqeRJmoVtFo/Icdm/DiMQ87FHrqn+rm9FbD/GXu3NN2BNpYBS7F3bNHe5/fpAFSBh
         mO49wuS5k6+19MeaF1iGmlJd6WW/hF/iUMG4BQTMovC6+hJwflUAEqfPzsW5jjxygYmj
         JGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=V2gDxG4MoSD1NzQkqxYtCAFDyRdNskut3Xu6T0fkwZQ=;
        b=ZN5WdOP4YxfP1/1SXvFejCYfl/9Glw0bcM6geTKiOZVYl0EynaTvhAwXnPDwot6Jqi
         gA9Mk5DcISAnmQXTkN2oqLP+38ZQLLUQ0riKiyq/AF6SYniW3ZvgxZDcPE+LsjwlNgvT
         64+czAMz+MLJkM3yPA4WWTr/z+Q4zrjgiA4vNr1idTMoVEst+JEVpWGaj7D8e9KuVh+b
         W05TRZ/aATBHrSfDeGGyWjHtTojkO4b6l0NRfLHKFYvhvtJcgY9e198XWMbpgHXTgC+G
         vpQb71a46k9DrjYJoS7wwfqI0oIE6X2Yn8iIdfX+7S7XGtVD2Y8gMuDTELs0Zgi2rf3H
         C9pQ==
X-Gm-Message-State: AGRZ1gL5QsLxbYSkjvnEaEYCLvGrli1FC3ydcKj8IserUyojZtrO8B6y
        hvzakJxKOZ82/8NqCFbgkuU=
X-Google-Smtp-Source: AJdET5cpxF/0XDrK0HKSuQlPd+JFqUPdcMDa4a619ws3GBEX/DfD9zuzHFUIRmHweWZGg9awwoaRvg==
X-Received: by 2002:a19:24c6:: with SMTP id k189mr1317838lfk.77.1542208249366;
        Wed, 14 Nov 2018 07:10:49 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id g12-v6sm3770045lja.74.2018.11.14.07.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 07:10:47 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gMwoX-00058c-Gf; Wed, 14 Nov 2018 16:10:45 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] serdev: make synchronous write return bytes written
Date:   Wed, 14 Nov 2018 16:09:02 +0100
Message-Id: <20181114150904.19653-3-johan@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114150904.19653-1-johan@kernel.org>
References: <20181114150904.19653-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the synchronous serdev_device_write() helper behave analogous to
the asynchronous serdev_device_write_buf() by returning the number of
bytes written (or rather buffered) also on timeout.

This will allow drivers to distinguish the case where data was partially
written from the case where no data was written.

Also update the only two users that checked the return value.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gnss/serial.c     |  2 +-
 drivers/gnss/sirf.c       |  2 +-
 drivers/tty/serdev/core.c | 12 ++++++++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
index 31e891f00175..def64b36d994 100644
--- a/drivers/gnss/serial.c
+++ b/drivers/gnss/serial.c
@@ -65,7 +65,7 @@ static int gnss_serial_write_raw(struct gnss_device *gdev,
 
 	/* write is only buffered synchronously */
 	ret = serdev_device_write(serdev, buf, count, MAX_SCHEDULE_TIMEOUT);
-	if (ret < 0)
+	if (ret < 0 || ret < count)
 		return ret;
 
 	/* FIXME: determine if interrupted? */
diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index 71d014edd167..b3a4c0e91947 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -85,7 +85,7 @@ static int sirf_write_raw(struct gnss_device *gdev, const unsigned char *buf,
 
 	/* write is only buffered synchronously */
 	ret = serdev_device_write(serdev, buf, count, MAX_SCHEDULE_TIMEOUT);
-	if (ret < 0)
+	if (ret < 0 || ret < count)
 		return ret;
 
 	/* FIXME: determine if interrupted? */
diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index c7d637d2bc56..ee4c40336633 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -234,6 +234,7 @@ int serdev_device_write(struct serdev_device *serdev,
 			unsigned long timeout)
 {
 	struct serdev_controller *ctrl = serdev->ctrl;
+	int written = 0;
 	int ret;
 
 	if (!ctrl || !ctrl->ops->write_buf || !serdev->ops->write_wakeup)
@@ -250,14 +251,21 @@ int serdev_device_write(struct serdev_device *serdev,
 		if (ret < 0)
 			break;
 
+		written += ret;
 		buf += ret;
 		count -= ret;
-
 	} while (count &&
 		 (timeout = wait_for_completion_timeout(&serdev->write_comp,
 							timeout)));
 	mutex_unlock(&serdev->write_lock);
-	return ret < 0 ? ret : (count ? -ETIMEDOUT : 0);
+
+	if (ret < 0)
+		return ret;
+
+	if (timeout == 0 && written == 0)
+		return -ETIMEDOUT;
+
+	return written;
 }
 EXPORT_SYMBOL_GPL(serdev_device_write);
 
-- 
2.19.1

