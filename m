Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47729C07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED622077C
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHJxI/iy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED622077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbeKOBOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:14:41 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33970 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbeKOBO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:14:29 -0500
Received: by mail-lj1-f195.google.com with SMTP id u6-v6so14408723ljd.1;
        Wed, 14 Nov 2018 07:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7dX1WRH3jtEm5JTUo2JHK+Tp2hTsey3zjvdsILBC6+U=;
        b=MHJxI/iyQJCtxvHOz6p123Wru63SmdTtHovIMRLw7tPhstFY94Lp+ukTNS+dguUJD/
         lOPCN1jhha6+CN5v0my2R7rjA4bqFLxLFwkRJ52Yo/QtgcUNwqC2uR9MqzYsr0EaAA4Y
         G6v+WJg0HBPeKbMdRbm7THMST7J4bHJe2gp0XDVR2qv44+qy4lK2I06YFvGuhPBaLkW7
         dJ5wo2BdIodaiP3I3zJcvJE6cNX8TZ+smnOtSUeP4AV0f8ngdaCEzO0VlAihoZMVIxgN
         +x3XP+72X5znCgNPraI0jpACtmVk/x7MRIfOjYQtYNJQe8dJ4fAu8EKrxabpDfBGbizm
         jo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7dX1WRH3jtEm5JTUo2JHK+Tp2hTsey3zjvdsILBC6+U=;
        b=qIj+iXZW3Q6zLk/vtKQiQ1xHn3PJhIwRmcjh7PAMlX4H/5MFMPrI5F7Bbeth1swPC+
         p+hsrAyDJC32CkUwI2Efz280uXoTRPHE1W3AJhfhnaNrxuFCPgmm9nsQJRWcPzQDgzZd
         jv1Yt1y4IWRF+bfiL89Ad14Wyw9jxuGeLfqUtJgbvWShROf6FjGrnRinq2LIZHXDyUzK
         K0ENR+9CL/3vGhkP3PuJGAPgcn3jayYxXSD55vdir1LDCUnUPqxdK3g4r76m+uhw1cXX
         jU+URrWAw6KwSnUtEf1ER+PKCoANE56gsl/usiLoMp7tyhiCqQXmsaJ+UmWebBZbkybS
         +cIw==
X-Gm-Message-State: AGRZ1gJEx5I/sihR0EjXa8huzsB0WNkrfWKOm8e+9BzLj34XWz3YUB5L
        kbH69Xk0pjUCPtmqu2q2lklsN4Hr
X-Google-Smtp-Source: AJdET5dB69hiOdlQ3MbXOIWwXtneVapqeAATXaW7fgR+EK/LXrPx+5OTe8GfkeXExg+MMPFRnM1fnA==
X-Received: by 2002:a2e:93ca:: with SMTP id p10-v6mr1513657ljh.158.1542208250792;
        Wed, 14 Nov 2018 07:10:50 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id c20sm3709985lfj.67.2018.11.14.07.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 07:10:48 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gMwoX-00058n-LZ; Wed, 14 Nov 2018 16:10:45 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] serdev: document the write functions using kernel-doc
Date:   Wed, 14 Nov 2018 16:09:04 +0100
Message-Id: <20181114150904.19653-5-johan@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114150904.19653-1-johan@kernel.org>
References: <20181114150904.19653-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the asynchronous serdev_device_write_buf() and synchronous
serdev_device_write() functions using kernel-doc.

Specifically, mention that writing data only means that data has been
buffered by the controller, and that the synchronous helper depends on
serdev_device_write_wakeup() being called in the driver write_wakeup()
callback.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/core.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index c7006bbb793a..a0ac16ee6575 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -217,6 +217,21 @@ void serdev_device_write_wakeup(struct serdev_device *serdev)
 }
 EXPORT_SYMBOL_GPL(serdev_device_write_wakeup);
 
+/**
+ * serdev_device_write_buf() - write data asynchronously
+ * @serdev:	serdev device
+ * @buf:	data to be written
+ * @count:	number of bytes to write
+ *
+ * Write data to the device asynchronously.
+ *
+ * Note that any accepted data has only been buffered by the controller; use
+ * serdev_device_wait_until_sent() to make sure the controller write buffer
+ * has actually been emptied.
+ *
+ * Return: The number of bytes written (less than count if not enough room in
+ * the write buffer), or a negative errno on errors.
+ */
 int serdev_device_write_buf(struct serdev_device *serdev,
 			    const unsigned char *buf, size_t count)
 {
@@ -229,6 +244,28 @@ int serdev_device_write_buf(struct serdev_device *serdev,
 }
 EXPORT_SYMBOL_GPL(serdev_device_write_buf);
 
+/**
+ * serdev_device_write() - write data synchronously
+ * @serdev:	serdev device
+ * @buf:	data to be written
+ * @count:	number of bytes to write
+ * @timeout:	timeout in jiffies, or 0 to wait indefinitely
+ *
+ * Write data to the device synchronously by repeatedly calling
+ * serdev_device_write() until the controller has accepted all data (unless
+ * interrupted by a timeout or a signal).
+ *
+ * Note that any accepted data has only been buffered by the controller; use
+ * serdev_device_wait_until_sent() to make sure the controller write buffer
+ * has actually been emptied.
+ *
+ * Note that this function depends on serdev_device_write_wakeup() being
+ * called in the serdev driver write_wakeup() callback.
+ *
+ * Return: The number of bytes written (less than count if interrupted),
+ * -ETIMEDOUT or -ERESTARTSYS if interrupted before any bytes were written, or
+ * a negative errno on errors.
+ */
 int serdev_device_write(struct serdev_device *serdev,
 			const unsigned char *buf, size_t count,
 			long timeout)
-- 
2.19.1

