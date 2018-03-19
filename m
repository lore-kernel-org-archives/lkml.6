Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvlvzfealDLjRZWY9meI94wusiCHGsYXYuoh4wZSrwgsNksN7Mkviv/7Q8tGHZBW3vbqH2W
ARC-Seal: i=1; a=rsa-sha256; t=1521483444; cv=none;
        d=google.com; s=arc-20160816;
        b=bQkNplw85E7vtlZ9CSs1P93DSIsh/AEG8mxwH7v9PfYoTuUxulyI4alw8eVqAnn0uA
         IyhusQapQBoSzdzAUYlH4VOx3/9YLc8U9hA5p1c4L4F3o44GN/K9wePCluPZHyMQz23+
         nYIoR873WK+T4sxnWJBIQv9DMm4UE1w9pxFNdrPvX79zTkigrmnLmoGW/jqOsKkTaZ8M
         vqPHH5wy+DOeuQcJmefEKCWhUaVob9sRFm5eNNE0hEPhHZACWODH9vr2SE0snU/rmUSl
         byY0e2ZjWQbxl9gzRaH6DmmDv3GwNP2nnciw1u9YS8r8D79Rs2NdsnFKsD1JOKQ4C5hR
         voIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yqh5vJIL7YBC6X0+3cHEM8QHMgKyP0RmDyyGJBsUWBI=;
        b=tVuvJoA1jZotdSHR8pagCsalzIQlRCn8kIrDXQY9O+ufYfV4WplaVah6yCtPez5lOd
         yXYFTA7ElP7/kLOAPk+lbqjuO56cMRdEqNFU3UTuFMYPFcRjv4Q/W35bcqr83RpYX/EP
         gkeyUs7Djpcyhq0DuX44afTg6o9kogaGQt6Cn2vRJ2Ur2TggEsH+DW10j2SOAH6/8TPD
         CiXZXTXHcfwPFe/JTlEMwE6doNwisFRYRXrAqkZ15ik1wwJsAuN4GFKNaYfVVJKONjXN
         7LV4E/O57KGT/OMQtCfCQ4pIqetp/uyA7VLYXYHJzj9hjWK2X6WRsyuy9fRfAs8BRw2R
         A9Jg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Colin Ian King <colin.king@canonical.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Douglas Gilbert <dgilbert@interlog.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.4 127/134] scsi: sg: fix static checker warning in sg_is_valid_dxfer
Date: Mon, 19 Mar 2018 19:06:50 +0100
Message-Id: <20180319171907.610726468@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390665356823986?=
X-GMAIL-MSGID: =?utf-8?q?1595391024280757324?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <jthumshirn@suse.de>

commit 14074aba4bcda3764c9a702b276308b89901d5b6 upstream.

dxfer_len is an unsigned int and we always assign a value > 0 to it, so
it doesn't make any sense to check if it is < 0. We can't really check
dxferp as well as we have both NULL and not NULL cases in the possible
call paths.

So just return true for SG_DXFER_FROM_DEV transfer in
sg_is_valid_dxfer().

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reported-by: Colin Ian King <colin.king@canonical.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sg.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -770,8 +770,11 @@ static bool sg_is_valid_dxfer(sg_io_hdr_
 			return false;
 		return true;
 	case SG_DXFER_FROM_DEV:
-		if (hp->dxfer_len < 0)
-			return false;
+		/*
+		 * for SG_DXFER_FROM_DEV we always set dxfer_len to > 0. dxferp
+		 * can either be NULL or != NULL so there's no point in checking
+		 * it either. So just return true.
+		 */
 		return true;
 	case SG_DXFER_TO_DEV:
 	case SG_DXFER_TO_FROM_DEV:
