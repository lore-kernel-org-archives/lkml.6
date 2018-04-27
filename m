Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrGlt9fCdL8syVBeIkiE+NpfRSPqfF+OdI2wnFaGYVA8/+fc3EyfPFieC0ZyCTEafxjuaZ9
ARC-Seal: i=1; a=rsa-sha256; t=1524837757; cv=none;
        d=google.com; s=arc-20160816;
        b=itj/q+PaG1+AStCJ+X54zxQYwRT8UgFBfapsybtpU5eRoMDi4FYmyQnXwoWOOdSXcA
         57x2CC2uYhI+fwTY1k6pXn7InRbscnf1KJyXBBkfEgREKx6WXNtiMiczwTqH51oIktUK
         B+nn4BLsuF0RGwDOcY4fI9Z5E+89CfNORqCTzQNP5T0yDTuFHEZX0P3vWUvMg561JQRM
         VH/koY3rNYjlX0vWVaEB6bzZqB0Bpb6tjPYRWSSyz1hQyHKw/G+7NKo3uIvOsHhN3nG1
         PtaYZlFjhDEXUWS5khbwJNH6KLERQ8IMq8jDq4vZB3Hw6NH1ttrE8iPscp0Yzg8geQ9Y
         fkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=8h2WZmkFy3UmyoZbiIw9CiXKO5LDgUcItS4UBd3z0/c=;
        b=mQ/NMPaXinSu4Z6oiJgs2Eva0KRk0dA/JMUP4rHHGqg3Mb/yqotpeKTMWu0RdhZMWh
         OJKnzW2Zi2XQK93tYwOtBOktabZAyMGBNAW7VdPzkvHAVk502gP8hOTdnVfZNMygpiFT
         un92CtyuLyPyTNPYJUnEOXhZ/oP+ozbBKtdQ/6VCMqXGhD10XaLvYPBh34qAZuVDQ3kR
         aj/jojubpE7/yURbKLXYLfoBhGyk0DFcnUopbmBRjQ0hMUl/KF7nfv3BNmoOE3JtQwpC
         NtCGktzbDygm4iDD7juULpxvc8yVyDBQ7vJ889mb+p3jsVIzRohkrP3cOlqRp7oTgHCU
         ATUg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBA72189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.4 48/50] cdrom: information leak in cdrom_ioctl_media_changed()
Date: Fri, 27 Apr 2018 15:58:50 +0200
Message-Id: <20180427135658.509947332@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908127480472300?=
X-GMAIL-MSGID: =?utf-8?q?1598908276772975084?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 9de4ee40547fd315d4a0ed1dd15a2fa3559ad707 upstream.

This cast is wrong.  "cdi->capacity" is an int and "arg" is an unsigned
long.  The way the check is written now, if one of the high 32 bits is
set then we could read outside the info->slots[] array.

This bug is pretty old and it predates git.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cdrom/cdrom.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2358,7 +2358,7 @@ static int cdrom_ioctl_media_changed(str
 	if (!CDROM_CAN(CDC_SELECT_DISC) || arg == CDSL_CURRENT)
 		return media_changed(cdi, 1);
 
-	if ((unsigned int)arg >= cdi->capacity)
+	if (arg >= cdi->capacity)
 		return -EINVAL;
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
