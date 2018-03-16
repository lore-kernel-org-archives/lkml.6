Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELucL+k+KrvcrvXJI/Q3X1Ply/8PykCxf9iu97HtjHTMVkHXwxBJzYCtpOjXfxNW9rftqQyW
ARC-Seal: i=1; a=rsa-sha256; t=1521214668; cv=none;
        d=google.com; s=arc-20160816;
        b=NLe07RrPfZ+toLE2fy8mQyBH6iIGjVGXGmeC/qqinFXZchk0g4ZQ8+Z2O0aZz4smO4
         vWmH5myehL2469SfqgNVW8BND+up7X74Rx81OOG0FkL5C0q8MluzIFOL9SiiLzW+DpjY
         njabIacZqtpvAqug52J/rjs/M5NWebxEZuc760cVOyogWBSFpYPvuIN0t58TNRW/lVfM
         kVdL4h/tKFgSZBMvdjkiqQkugyQmYHsWHAgBYOLdqyurVF1E96w8BZdv/cjkdcQvtbpu
         cn2w4quFQu6ZCApMMEHTbn66tvNMTHlNb9bpRiWuomaSOJ7a+CzGAeQz0gG2wu89e85o
         N41w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SkWRxqovN4ALoiQCVv8HRiLpkcjt8cQTRSPaRqvgsXM=;
        b=zqMa+gmZJkXUZ9JXMFmBjSU4aC+qf3YUS4nJZoIymkhe9sYOUTekFuIQuIe0NoPCy8
         /Vr5L/WUMK0JMpimkDt+vwPwApjITFrGPLzHI2lfsbUrcFRbLPHs9qA8ruAOyuKcscRn
         vE9GykD4/oAifTi/IPm8I5FUdTRx8gjxsrsoMhByo3BYvE+/lsWal3PNsLl1wm89rZfv
         Q07VIwrdNuzZCIWf3zhFaVdwk9359n7vxBleEVVllKR1ucVta98MSMbbeBq+Fe+UPcsx
         GlefaVLMOEW+oZ6sSplklJ2f2YIbv8g3X8lR/CM62le+BwHOsaOvXpMeoq8Krjfhvcxc
         ToJg==
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
Subject: [PATCH 4.14 082/109] scsi: core: scsi_get_device_flags_keyed(): Always return device flags
Date: Fri, 16 Mar 2018 16:23:51 +0100
Message-Id: <20180316152334.415032962@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109192059346605?=
X-GMAIL-MSGID: =?utf-8?q?1595109192059346605?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -595,17 +595,12 @@ int scsi_get_device_flags_keyed(struct s
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
 
