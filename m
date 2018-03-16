Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvBFUHN0f56765N3+Nsx1yPUnNsVN5Rr0tda5x1BdN3muhhASGEubBXket7s0Rvj5YqvVCG
ARC-Seal: i=1; a=rsa-sha256; t=1521215019; cv=none;
        d=google.com; s=arc-20160816;
        b=qIM8eF8S6DZL02RqlzNXZhSfwDpnPvBlBPquUjb0OpmANjOk/mY/VLoHrQT5fdayjN
         4KPn/QOu1GMJsxiMho2BXd1PPzsXIlM+2j35y/ZrlwHy8rG621MC+GjKhmPAH0QhjC6f
         7GlCJ0+KcY/ykTBpvvTlz+NbXB+nqsKtp0Ys7o8zTpBkJbvSAYS9Lz/k4D4Bg7iL/dLw
         JHYPo83Hehq8wuv9Mk1rCkfBTZLkiHmkeZzn62AkG3GYQ9I8vvpKDYJxE2l6xVMTMMTS
         bW59GnHJxYwOa5XabRBSZ6icK1TM2mFnkpkSjjdanvuNn03I/QjH7GvurZrf4JJBACBB
         35aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZV0NwuqYWQQ3BDmsxgRbyqTFjaHVTzDin/Nw/VTUc0U=;
        b=TumjjlJoXsXKEKU8HZtzYFmyvb2iyysR82XSQZ9FtRyw+AEr5u4VVGY335AkLZjVMA
         pSwldD2Mdncqjqy2JRIRg2Zig4apQSdq3SeC8boJ8QDKxX+dZ3dFoSJ3+TRueIFqHqHn
         xPjl6/h5leYlbJ1nORDsSKmuRpR4rfq3vO+R4dM163hpfDvD2GrXDGBQ6xsLll1YK/ph
         /1jCnbQ+jgCOyQ5zzOLEBm5epYQRsZd86c/iNQA6pF3WFWQ3M2WvknXCF6B5rDI80uUZ
         AmuJEM6s0sMi/t5iPAj3/lLl1IxEbuziDaPZcz+mWaZOm+A3bH/6++3ie2ktWJ7busIm
         ghvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 099/128] scsi: core: scsi_get_device_flags_keyed(): Always return device flags
Date: Fri, 16 Mar 2018 16:24:00 +0100
Message-Id: <20180316152341.489161158@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109192059346605?=
X-GMAIL-MSGID: =?utf-8?q?1595109560723341673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>


[ Upstream commit a44c9d36509c83cf64f33b93f6ab2e63822c01eb ]

Since scsi_get_device_flags_keyed() callers do not check whether or not
the returned value is an error code, change that function such that it
returns a flags value even if the 'key' argument is invalid.  Note:
since commit 28a0bc4120d3 ("scsi: sd: Implement blacklist option for
WRITE SAME w/ UNMAP") bit 31 is a valid device information flag so
checking whether bit 31 is set in the return value is not sufficient to
tell the difference between an error code and a flags value.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/scsi_devinfo.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -590,17 +590,12 @@ blist_flags_t scsi_get_device_flags_keye
 				int key)
 {
 	struct scsi_dev_info_list *devinfo;
-	int err;
 
 	devinfo = scsi_dev_info_list_find(vendor, model, key);
 	if (!IS_ERR(devinfo))
 		return devinfo->flags;
 
-	err = PTR_ERR(devinfo);
-	if (err != -ENOENT)
-		return err;
-
-	/* nothing found, return nothing */
+	/* key or device not found: return nothing */
 	if (key != SCSI_DEVINFO_GLOBAL)
 		return 0;
 
