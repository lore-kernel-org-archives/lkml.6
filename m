Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpe8pXn/A5kJFs2Ks1ifJrJvTyJyDQAA3oCuUKzgCZKn9Y0lGTJq/Pd/fBE6NnsNfJwMRUa
ARC-Seal: i=1; a=rsa-sha256; t=1524837928; cv=none;
        d=google.com; s=arc-20160816;
        b=h4k1/t/DvwZ6dvoBTXizlHLsYbpPGC0YSwibYcq5vNQ1A8UzZ1IQm0ucZHl9LDlwk/
         R5WIh+E31dSqLn7Nnmg3vNF8ba3fZwRIi9NkFaEdH7Pnbq9zCGR/a3Lflav1Flr7/WOO
         dKYyohrgNYlDjXWbh4+FEGpVp4Nrisb9Tn9EdWd8wOqcbC9AIBUVj1aNqjznePT2T0+j
         W3vPXI6W0vaTiBWfGmqXgiqySHHZwU/v43s/cBnIaGkhCiH4LazDwnQngRm9WkkvZT2j
         DR0NOY0zkJq4UTkEWmnowmPaCsW1OINprWmyLVLWay5CmN4ThWElz/9rCvZHDI1iAYgO
         Q+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=b0t+nXZiKM1WqbuCAEzYLyd+xiciSzqP8JsFqP+NJxQ=;
        b=oa1lyiSxYFaztHCPUGtySk9j1sAmvXHoiC1wu7ZifHDL2UDoESVpIiTrdvVDxysvZ+
         /2EP9IRX1vTAEywypU06awVrCX/9D8e0Bhq4WG0Hjfs6CV8J/+XesLrTH9+MiU1KZQa7
         F46zkcZy4q1FQWnKbqvMoc/PNyQJJhmpn6zXw9VV0mEoS9sFHQtyXxHWfLJZV9ygoX/M
         jvbkmDRnmsrZd+sOduBVc0m2gZw3gtfWr1WI6evi6QFpf1IUigasT1J6Sbf+d4viGbej
         O0IvkTvyifvURQ9c04rIH0OiJ889MzVcVxtj/L9J1lRSt4PraO/j7SKBXC2XnHt1O3E9
         6IlA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596462189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.9 70/74] cdrom: information leak in cdrom_ioctl_media_changed()
Date: Fri, 27 Apr 2018 15:59:00 +0200
Message-Id: <20180427135712.842677560@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908127480472300?=
X-GMAIL-MSGID: =?utf-8?q?1598908455410849445?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2368,7 +2368,7 @@ static int cdrom_ioctl_media_changed(str
 	if (!CDROM_CAN(CDC_SELECT_DISC) || arg == CDSL_CURRENT)
 		return media_changed(cdi, 1);
 
-	if ((unsigned int)arg >= cdi->capacity)
+	if (arg >= cdi->capacity)
 		return -EINVAL;
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
