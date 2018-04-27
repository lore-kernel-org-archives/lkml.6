Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqvBlMxgzNRkscpofMqENDNVBsomYoaUNR45/GMZvjzbDoBIXdH8mw2HCqx+20JHLwgcWSA
ARC-Seal: i=1; a=rsa-sha256; t=1524838330; cv=none;
        d=google.com; s=arc-20160816;
        b=eLgP+dMyKY1P0YrTGO1cjvtMhrE6bwpUsD0FjPNCBnq9cLJbYmYWGjXIVmdjytPzw9
         x+mFSJm4mS8Zd2rSGYE2CiyyWAnh9jsnMRp//Z8HfwtONEtxoi6ZIjQ3bVfY7fpF4Ghr
         zeclA48H8XG4bL/fokCUcCHQvgVOmH0FndKJc6zsautLGFNpu8Y7+IhYqX3jRR4mot3g
         lqGTOQTPKFPpaxI//1gUtpuSTpHk1nf1SYcobxXSfzTgYHyscJctOUz81GcDgYyuLtFA
         gBTENOM3cx9TvAlLwpmBYVn8SH4QWwso7quxpWnp2+1Ve9VnBOlnO8f1nXv0tqSGTgmE
         MFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=YIuAsNSH+cp+S1lXNtoeBj9NASwIEFlKrUFxd4XJlE0=;
        b=YuZHvu3EtH+gYrJHM7rP92CKK5B6iDWWcbiA2zD2c2XBelj8UyRoxoulwgdZCIWqIs
         qzRZNF6Ya/Z2PNYG+djLJ5zYD/IdGglHRH8gk4kUoTdi8ZQ8ZbyYPwzOmYx+RZ6vq+Ky
         btWGaEZ81sJOgj5ionxnZwG3MltZA894IbceN4Zg/pOJhQmjR2EPO9vflAOoZsHzsV7e
         OrCKJdMXa3+1nDYzAw7coPMJtmhzCe6hRBCnyzKJkDg2S7QzXXGyZi8n9zKdi7q5IOED
         DB1XR633BmCuZv3AfjLp5u0wqODcQMJnwOUzlvXnAc6TVaHOcQf1X5R1YebItrkB9N2s
         zkvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB452189E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.16 63/81] cdrom: information leak in cdrom_ioctl_media_changed()
Date: Fri, 27 Apr 2018 15:59:05 +0200
Message-Id: <20180427135747.011303979@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908127480472300?=
X-GMAIL-MSGID: =?utf-8?q?1598908876617459786?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
