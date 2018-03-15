Return-Path: <arend.vanspriel@broadcom.com>
X-Google-Smtp-Source: AG47ELtR+g7owxCQQBRhqqtfpoG17/tSc76i7Xridh79ur+NoxzvGImYLbuLfgxVWDsQNCLBRLAf
ARC-Seal: i=1; a=rsa-sha256; t=1521107737; cv=none;
        d=google.com; s=arc-20160816;
        b=kSrFD4z0+eZCOPBRzH/Znh7dZcCKZJX8FETpcprOIQNudsR99Zw8WPjkyWE/wGTYpe
         i0GNO06ncZdy5u8HPO8E8MM4kRXawvXnpLKcN64KsbFh4Jgvyb15WzAkr/QyPxnsGqbb
         I0gu14n9PS9JtGp+PA0lqivYbRQM2Y0HthB/yyR8ix3o2zSVRXzT8zHY6BK7ryOTgqDe
         m4hqkS2krws3uYpzOqYce5SIMfPW743ojr/WT83bhyH/oX4JJFjRj878hLWuC0gUmidQ
         LiEJUqlhjT9ngxfRb9MJyV1RpqTdKi/m7OyaOq0PmwBMoAeh3uIJaP8kKiZleHlgLo6d
         TIAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=9K7j7a1dFWc5fSFwiAeQRnvb6Tci4bbC0w5Q2kFcD2A=;
        b=CclxYvZ+vKBj2q3pNS9PDayJe0kj7HWDHo0VjbtVLScgVoSzhaYPE4GyrRujFND+yL
         d4QkDvGBrv2L3gy+5KOWpbXUV2Crd6m9NqYU+n5/JrqYtRNxQmCabBKTyIkG2LcspOC3
         t+5qeVoTLIE3y+/uqQd3uy0pHUO+Trhnz5xtkWukTD15k38Ske/tQ2oBfukA4QmUp6OQ
         NxpsZuIEDdGEfD8xDj2vNGgu3shR8zFvbMA0DzTu5tp401bly3E43dg4vcOJdib7qj/j
         0K1HrytbVEPF23NpDo6+992KpJ88ZooYEBPYxw3MBJwpG5fTtXse4X/wmfp4g3Wq7MV+
         8uyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 192.19.229.170 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 192.19.229.170 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
From: Arend van Spriel <aspriel@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Arend van Spriel <aspriel@gmail.com>
Subject: [PATCH for-4.16 3/3] drivers: base: remove check for callback in coredump_store()
Date: Thu, 15 Mar 2018 10:55:25 +0100
Message-Id: <1521107725-25027-4-git-send-email-aspriel@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521107725-25027-1-git-send-email-aspriel@gmail.com>
References: <1521107725-25027-1-git-send-email-aspriel@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594997067110053243?=
X-GMAIL-MSGID: =?utf-8?q?1594997067110053243?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The check for the .coredump() callback in coredump_store() is
redundant. It is already assured the device driver implements
the callback upon creating the coredump sysfs entry.

Signed-off-by: Arend van Spriel <aspriel@gmail.com>
---
 drivers/base/dd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index de6fd09..c9f5408 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -292,8 +292,7 @@ static ssize_t coredump_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
 	device_lock(dev);
-	if (dev->driver->coredump)
-		dev->driver->coredump(dev);
+	dev->driver->coredump(dev);
 	device_unlock(dev);

 	return count;
--
1.9.1
