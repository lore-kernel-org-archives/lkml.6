Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqMAQQZeGzU1mzzXJq38etkRUaPUp6EXFzup5YlKn82DQTKBNHGONbQBvJsZjGk5WprZ+NS
ARC-Seal: i=1; a=rsa-sha256; t=1524837615; cv=none;
        d=google.com; s=arc-20160816;
        b=eYUUSZPfjXggHXTozpT58p+UC0DKWVQMKEW/20fTiJe8jUrPqjdUmbj8ulVfMOhjBH
         91UaLwhZaZHLj9ygM7vfp8t7PCmSNw4r+MHwDiZyFCxblUSbnrjGHxjaPbiCGlHC1tn9
         rY5eFibXhlnI8voZ/LhTrGPcYUwS5QDhSpUluGC2Lk1Z/KijKunNqGJr4KnCXrb1Qul1
         QxPqwQyiXsApfF3VFLdVFE87ROFFbz3/ldzdjsYaksmOG3Ye38m9W2ejgaZDWC0wtJbF
         tOg/1ITCtyO3uDtk/4340Qxh0hksm4ecQ/3V54qW5sGuJxVNHMM+8f8rE1n4KIBXVncn
         tzoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=tkayf7Ly+0bP73JeoNM2ksCb6JVkhxLshVq6Ag8cHHg=;
        b=Lu6NP+fXe/vKKOjWt/FsCm4W5m+DAZsNNdX7vHnsvdKpJUy03KmpKeOmyfKrI9e/OR
         IVAX24VSg2NC+jPwAwchRDWh5IEj5GsUvJDx2wYw3DtfmtCb/wRnbZ5gMxS+bYPTqXSp
         N6v/9Ey7KnKVNcAJrxDwdHp5q3vqJ1AKnwdEtp73GqPNDWubE7bmWQXZ1q2NEpO7JYeV
         /w8g8wnBmg9gga24eD1xb4te4OM1sLoJ3eZyvu+A1Vaf2GT2SmT4cJgot7pbBYjDAf/2
         To1RcUajr1/jshcx6SfnhTBUbZUaMzN9+cxUvFR0pWOxsMhTNi1bELqbsWhani9Jy+tj
         iXqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEF421894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3.18 24/24] cdrom: information leak in cdrom_ioctl_media_changed()
Date: Fri, 27 Apr 2018 15:57:59 +0200
Message-Id: <20180427135632.574634449@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
References: <20180427135631.584839868@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908127480472300?=
X-GMAIL-MSGID: =?utf-8?q?1598908127480472300?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2357,7 +2357,7 @@ static int cdrom_ioctl_media_changed(str
 	if (!CDROM_CAN(CDC_SELECT_DISC) || arg == CDSL_CURRENT)
 		return media_changed(cdi, 1);
 
-	if ((unsigned int)arg >= cdi->capacity)
+	if (arg >= cdi->capacity)
 		return -EINVAL;
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
