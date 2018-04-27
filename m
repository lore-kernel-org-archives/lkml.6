Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqAV1k+/vk44TZ036ZuwJMnlnNYp3P0FtHnPAVRQfMBs5EVqs6hFqFZlHVztEHI/pUMZucL
ARC-Seal: i=1; a=rsa-sha256; t=1524838117; cv=none;
        d=google.com; s=arc-20160816;
        b=e27N0LCvRkTc106eff3nB4At/9o6cysAqj0MOMMAi8DI6QU1GzZaanaCJi7yUaOYMD
         NOMB2X63+udMAkGRbuVzL4l//GgrQWmGE/kB2KV2rCgaftjimsLjCoHZ2l+DcMZtnrO0
         1lrDps5E8xuokzAsN+cJfFufOSPY5jtrU3ReI8WKY+mofh9WGlel8VdSCRZg4pO8Rkec
         fJRaO02rbs8wiME6Mq37jPZHziI3CnvX/zfkRLtnr/kSc9I40E0TQcSSOQ/V+ek/hJ7E
         uqcTpI6fkyTc97XqiNIp3vtTRKq7hrWkY6j+kuuxkq0lmZypvMkIlzRYuozvI06fXoEO
         k4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=etxLCa4C8vNuXkMt6qLDcjhtuUm3TNvjqgWbVhw8l2k=;
        b=ow5iar4+dGFgMemV79KVipjsArxRxWa2wBgUqv0zFe5OErdblwkH1Peognbh/OVQW6
         pGZgWYWKnASEiXMAOdDVs0Cjb4e5hlztpR4bsqbE8u2DBEGU0l37rTp7MygVNYeO2NlC
         tpuwGC/Qpmz+oVi+T8k48M7ZfU4X0QZHdRRvv0wX1l+UtfsvdbNtF8X35CD7DSCVc883
         UDCx6U6pG1kLWtNBijMM6SYGMKAs0Fqau2rZMpobLMJwXNXC223UdPvwTjVCnU9ov01g
         DAZEaLTFK705RmaQTBl0FIaC5JkGrhtzEz8pJSVwTc6u+lMlx8d92EuHiYVHmedtTnrj
         QAyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4750B218BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 66/80] cdrom: information leak in cdrom_ioctl_media_changed()
Date: Fri, 27 Apr 2018 15:58:59 +0200
Message-Id: <20180427135736.311428367@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908127480472300?=
X-GMAIL-MSGID: =?utf-8?q?1598908653439601985?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2374,7 +2374,7 @@ static int cdrom_ioctl_media_changed(str
 	if (!CDROM_CAN(CDC_SELECT_DISC) || arg == CDSL_CURRENT)
 		return media_changed(cdi, 1);
 
-	if ((unsigned int)arg >= cdi->capacity)
+	if (arg >= cdi->capacity)
 		return -EINVAL;
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
