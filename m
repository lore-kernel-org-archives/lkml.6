Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvbWtEJvxTa3v48kMu9mZ5UGUtAl9xvUTPk7JVVV6enSiP3nBNzciho7SiNlWBaiIcXFDkd
ARC-Seal: i=1; a=rsa-sha256; t=1521483995; cv=none;
        d=google.com; s=arc-20160816;
        b=cnxriBswGahrCpfiGNeYjFdjosVi4XDeJc1rbIVKjjRjEW2d/8YueQa4yThlissI2P
         b93t3JToEXf8QR818oZ3qqNR9ZQQxjQBhdZM5yZ2hMFd1gXvGrw6yuBzybXmjyPlsGgD
         b2/uJpCGE7kOd9gaDt5NrRj4V1tUmCGOxNdgep1zOKMb7unvQK1SQZbDXPikQ6/728XV
         vE83bWMzPuYkl1moGoXghAM1YZLUejeiJQD9Iq1DtOEu6eRW4R5A95GXJEnxmUUZfJox
         AxKirVTSWip6DEpNL/fP4nHAYpmRNnmaw8k+HWIxcMyehWyDisqPMbOWOUTWiJPZGMdJ
         WM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=H5hoqJdcTQBvWPbdQC234Ur74fz9ltLD6ZXCr34hAdU=;
        b=UHG9lJqIb1uN1GfCuoLGD8cPfC6N09KFHuIPAlhSIdo3Qavs9gYxTsfagdTNHHvVOJ
         sAu2VBQeIg4QAFgPhL/pTzWoC4zeE1xHRSN0c5e9Lf+J/N/iCpO7oQOOeRHjEH11Rd8e
         jS8GuZM7hpcJpdfJMFNEEVlQQ2+2XVwXmpg752f4PpDAWJtMpEeNRoKfI8u+WndW2ih/
         W5RGpHYY3oHS0HXqKswnQLxE0GbQxKn3ENYnbEszumRKc9qAWU1ocV2a7yOhRbrbo1ld
         eWP6YguqZX7coSkbloRp2gRzCRmrp1IZFJasJaytR7QzqS7KwSnZqW5mKbwEnFl7gine
         2Ffw==
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
Subject: [PATCH 4.9 194/241] scsi: core: scsi_get_device_flags_keyed(): Always return device flags
Date: Mon, 19 Mar 2018 19:07:39 +0100
Message-Id: <20180319180759.187711196@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390945327424140?=
X-GMAIL-MSGID: =?utf-8?q?1595391602469456855?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -596,17 +596,12 @@ int scsi_get_device_flags_keyed(struct s
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
 
