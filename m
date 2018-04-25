Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/foMHTiMDV0DsWuaDWbt3P671h1wEdO4mc/tgFdbrd8uhwCyFsZ2dPRoEGgPog7yDCBJnm
ARC-Seal: i=1; a=rsa-sha256; t=1524652893; cv=none;
        d=google.com; s=arc-20160816;
        b=gtey8rVCMsSg01ScEfOALDhoFReXBFzqWEyaX2LU+v5Hagqf3cL3NFHTS9umxDZCOb
         ePsMpn2mTmevsy//mrmaw8GKIvDuMFwTPN4weY0vBYU8wZ1sJ9hxA3oQIZLBw/TD3r/m
         dEhb4EGPuuh3fDliI3OI8EMUdzMMTbXxpjZ8+/T9wEtEBwsgh41Q03Ls7CeTLWn36dAP
         1ZgfSLQa6OdEbqyMm7mlRK9c9ZfnCGFzKESx0o7gGM2cW6DlrJpjvr8nYGYzTP/FtWtr
         KTwLRAoDQI8GPOqcv+d2rsWJS/HmFBpIKtZwfsDb7GokTsecr8JYqzLCsTGrVsJI/0fx
         XspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ObckVYM3tfrFxrjjkiEMrxv+6kiKeyWDL5657xqSA7I=;
        b=sSefAEOnqj3m+fHj/J/hbG6wUJENJ4b9BuHjicVPRWnWH24py4+LNqJke+t6J/Lwf7
         1cVFxSxuhQ8KuxCOUVhb+hxRbACqAGkPHXQ3ALtE1FKwR4QKJQtkd5rKvWB3r5jN8GBU
         I71QX8cnSJTV8lX2x85dgEXPY9KavQJWdXU6vm5MAyYlN6UREDP78sQCGWzdFaxIc+Oc
         dfhDOMiJ+q1yEIO2mdPVNJkqmkV7zheDK3g223YzOLQZ/oHgl3s5eCOaceQaw3jjgI5r
         kagNy5YvEDQofdMSJWRtgCz8JqCTUbUIb+25sFKItuHMW35nIZGHalnP02aqCTRDMWjS
         /8NA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 072/183] scsi: fas216: fix sense buffer initialization
Date: Wed, 25 Apr 2018 12:34:52 +0200
Message-Id: <20180425103245.413959802@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714432688256381?=
X-GMAIL-MSGID: =?utf-8?q?1598714432688256381?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>


[ Upstream commit 96d5eaa9bb74d299508d811d865c2c41b38b0301 ]

While testing with the ARM specific memset() macro removed, I ran into a
compiler warning that shows an old bug:

drivers/scsi/arm/fas216.c: In function 'fas216_rq_sns_done':
drivers/scsi/arm/fas216.c:2014:40: error: argument to 'sizeof' in 'memset' call is the same expression as the destination; did you mean to provide an explicit length? [-Werror=sizeof-pointer-memaccess]

It turns out that the definition of the scsi_cmd structure changed back
in linux-2.6.25, so now we clear only four bytes (sizeof(pointer))
instead of 96 (SCSI_SENSE_BUFFERSIZE). I did not check whether we
actually need to initialize the buffer here, but it's clear that if we
do it, we should use the correct size.

Fixes: de25deb18016 ("[SCSI] use dynamically allocated sense buffer")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/arm/fas216.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/arm/fas216.c
+++ b/drivers/scsi/arm/fas216.c
@@ -2011,7 +2011,7 @@ static void fas216_rq_sns_done(FAS216_In
 		 * have valid data in the sense buffer that could
 		 * confuse the higher levels.
 		 */
-		memset(SCpnt->sense_buffer, 0, sizeof(SCpnt->sense_buffer));
+		memset(SCpnt->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
 //printk("scsi%d.%c: sense buffer: ", info->host->host_no, '0' + SCpnt->device->id);
 //{ int i; for (i = 0; i < 32; i++) printk("%02x ", SCpnt->sense_buffer[i]); printk("\n"); }
 	/*
