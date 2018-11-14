Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA79AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2882077C
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3Vx7sll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2882077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733308AbeKOBOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:14:30 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42486 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732906AbeKOBO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:14:28 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so8143244lfh.9;
        Wed, 14 Nov 2018 07:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J/c+w6z/yz43cYBFyZ3TL0i+G06NGqG/EL4mF7o7y7I=;
        b=j3Vx7sllB8YxseBOlF3Q5Jn9l4Duvep/pGg3c2eRz2VsyvGYKqv4V4Ct23iWEfTaT1
         MSK8dQEQkklDxNQ7Gyb19OOyMEaMgcLVkgrzm/jkauLomTA97cOzAh8cd2UN982h5CCN
         Vpc1cQO4CPjE2nNMN6oFUJJ4aGs3YsNLHmQeEcLShOdZcWMgHybqs8Nu7pmi3d4RJnmW
         ImRVEZOs4JSIFf+MWrjsPGpU1Kq1/wDaPBXfok41+TunNE3XAinJOTBB7KN6whPyVhv3
         a/joHRR06tO70CjhZ0s1eFxza0Xg4y18LPWPUYV5DDk+fxxMv9am7iGyMEFjDnlDBY0D
         nTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=J/c+w6z/yz43cYBFyZ3TL0i+G06NGqG/EL4mF7o7y7I=;
        b=gCHW1zSvLri9yCdhln+0STXu/mM1JJ5qzBfaSu6dqwXC38xxED1UHxvwjFk2jdLva0
         M4oNPHv8c/Pe2Ndkslb2eO6zI8pYjXWcBUEw5BfrLkwX/Yb27KqzXZgJ7tfbnq4E+ADa
         sVvJ9SmlUBxEBgER7qzQ8j+CglMArmjJrC6czvWzcOat5y3Mlf2vYburHpJEcgxHczVg
         tTU/ASZNjt0kOmhEGOLu8y6FDG2fW9X8fAIq1xi1el4kdbwhVO1MpW+tONELCYiHvGkM
         i+WG0r9YLNgqn1KvDDIaEf2XyOPBfBLGbjg8+bP1953bDpqZerWLzOrFP5164ERh1wA7
         pyDw==
X-Gm-Message-State: AGRZ1gLkklO0+iLGVTMoJGlKa09w4bTxhnaqbU5wUoI3TPgS9EPmZjjC
        PrU5cGWLhhi0Gswva07OGSA=
X-Google-Smtp-Source: AJdET5cjDZPbCyE/SL8lMxL2eDvhZuIOTBcPG7IDTrC0ECc0Gwavo2XPpRR1kPRGONxLuGBsw4FQhg==
X-Received: by 2002:a19:6514:: with SMTP id z20mr1217053lfb.31.1542208250107;
        Wed, 14 Nov 2018 07:10:50 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id 67-v6sm3990445ljc.26.2018.11.14.07.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 07:10:48 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gMwoX-00058h-JD; Wed, 14 Nov 2018 16:10:45 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] serdev: make synchronous write helper interruptible
Date:   Wed, 14 Nov 2018 16:09:03 +0100
Message-Id: <20181114150904.19653-4-johan@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114150904.19653-1-johan@kernel.org>
References: <20181114150904.19653-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the synchronous serdev_device_write() helper to be interrupted.

This is useful for cases where I/O is performed on behalf of user space
and we don't want to block indefinitely when using flow control.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/core.c | 20 ++++++++++++++------
 include/linux/serdev.h    |  2 +-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index ee4c40336633..c7006bbb793a 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -231,7 +231,7 @@ EXPORT_SYMBOL_GPL(serdev_device_write_buf);
 
 int serdev_device_write(struct serdev_device *serdev,
 			const unsigned char *buf, size_t count,
-			unsigned long timeout)
+			long timeout)
 {
 	struct serdev_controller *ctrl = serdev->ctrl;
 	int written = 0;
@@ -254,16 +254,24 @@ int serdev_device_write(struct serdev_device *serdev,
 		written += ret;
 		buf += ret;
 		count -= ret;
-	} while (count &&
-		 (timeout = wait_for_completion_timeout(&serdev->write_comp,
-							timeout)));
+
+		if (count == 0)
+			break;
+
+		timeout = wait_for_completion_interruptible_timeout(&serdev->write_comp,
+								    timeout);
+	} while (timeout > 0);
 	mutex_unlock(&serdev->write_lock);
 
 	if (ret < 0)
 		return ret;
 
-	if (timeout == 0 && written == 0)
-		return -ETIMEDOUT;
+	if (timeout <= 0 && written == 0) {
+		if (timeout == -ERESTARTSYS)
+			return -ERESTARTSYS;
+		else
+			return -ETIMEDOUT;
+	}
 
 	return written;
 }
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index f153b2c7f0cd..070bf4e92df7 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -210,7 +210,7 @@ void serdev_device_wait_until_sent(struct serdev_device *, long);
 int serdev_device_get_tiocm(struct serdev_device *);
 int serdev_device_set_tiocm(struct serdev_device *, int, int);
 void serdev_device_write_wakeup(struct serdev_device *);
-int serdev_device_write(struct serdev_device *, const unsigned char *, size_t, unsigned long);
+int serdev_device_write(struct serdev_device *, const unsigned char *, size_t, long);
 void serdev_device_write_flush(struct serdev_device *);
 int serdev_device_write_room(struct serdev_device *);
 
-- 
2.19.1

