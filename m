Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELviJ/kxL2C+MPjXjTHQ6lKCfe+uKXO26jB+F9wtwAmu8mx9JUDzWVa7ibRnCgb8gY8mGFS5
ARC-Seal: i=1; a=rsa-sha256; t=1521483104; cv=none;
        d=google.com; s=arc-20160816;
        b=Pk+Es3OGBESmfp3AjUbmTFVcch68yXKlnWh5xJCDvdDxCf+8fK8DqOZSoszr4kTCSJ
         AAk9eVAK558XtsRkHErjQuJg5jul42ysViAhjxGF/KQguh3H6IPJ6wKaNPen2VCLQEYo
         i3SuKtfLtXvIpOt+eXWvVHTT/3mNk4xAlR4Rbyq9VngIkmTUY83b737Id2+Oaa5mBvfr
         jpLhr0xAAOHAWVBIuhRBhxiBcKW8hisMX8DE+9Gj8cZ0II+T5DulqQOH/pdN4eS+MB+T
         F8MzVfz/oaHGe08864EeqVKdP123YMSn5sMYtDkP7jqd4uNvnt/RBn0BjFeEzvq9q9UB
         IDsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IQOjlZX8Yi+mHtXOsvDqSHhp6JjNs+xNnO6eEFRq7x8=;
        b=iHgjwFM7NjOYMlO7ueJYyG/QCpFqkdTC71+xkCgEU3mORu4K16vLMkcRQuRm/mr9rw
         9oltX/Exlv+FAHAQj8NcJN7DbOuQzreN6RicIk82NMENru5sNz6iSXKNCZUZDW4YYJZo
         YFendYwmN7qo5vnAWsChSjq5p3w/od3TvnVhc76lIJXaZsOFhOGQRhAVCf8itCvY1TII
         zeLLt5uoFVaqSlnj6L5ZZFuVDoeQRXZtLp6TnxDRFO7uUcjQ5Qg55F0VLf2LBwGUDmXA
         1l4XHyMdIG4UkCkm0ckZan6k4wwi3NImFlqxjX80VCQctg09iEn+jx3aizvJWNLW0pv/
         guVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Jason L Tibbitts III <tibbs@math.uh.edu>,
	Doug Gilbert <dgilbert@interlog.com>,
	Hannes Reinecke <hare@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 3.18 68/68] scsi: sg: only check for dxfer_len greater than 256M
Date: Mon, 19 Mar 2018 19:06:46 +0100
Message-Id: <20180319171837.460756135@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390667692635257?=
X-GMAIL-MSGID: =?utf-8?q?1595390667692635257?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <jthumshirn@suse.de>

commit f930c7043663188429cd9b254e9d761edfc101ce upstream.

Don't make any assumptions on the sg_io_hdr_t::dxfer_direction or the
sg_io_hdr_t::dxferp in order to determine if it is a valid request. The
only way we can check for bad requests is by checking if the length
exceeds 256M.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Fixes: 28676d869bbb (scsi: sg: check for valid direction before starting the request)
Reported-by: Jason L Tibbitts III <tibbs@math.uh.edu>
Tested-by: Jason L Tibbitts III <tibbs@math.uh.edu>
Suggested-by: Doug Gilbert <dgilbert@interlog.com>
Cc: Doug Gilbert <dgilbert@interlog.com>
Cc: <stable@vger.kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sg.c |   32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -51,6 +51,7 @@ static int sg_version_num = 30536;	/* 2
 #include <linux/mutex.h>
 #include <linux/atomic.h>
 #include <linux/ratelimit.h>
+#include <linux/sizes.h>
 
 #include "scsi.h"
 #include <scsi/scsi_dbg.h>
@@ -762,35 +763,6 @@ sg_new_write(Sg_fd *sfp, struct file *fi
 	return count;
 }
 
-static bool sg_is_valid_dxfer(sg_io_hdr_t *hp)
-{
-	switch (hp->dxfer_direction) {
-	case SG_DXFER_NONE:
-		if (hp->dxferp || hp->dxfer_len > 0)
-			return false;
-		return true;
-	case SG_DXFER_FROM_DEV:
-		/*
-		 * for SG_DXFER_FROM_DEV we always set dxfer_len to > 0. dxferp
-		 * can either be NULL or != NULL so there's no point in checking
-		 * it either. So just return true.
-		 */
-		return true;
-	case SG_DXFER_TO_DEV:
-	case SG_DXFER_TO_FROM_DEV:
-		if (!hp->dxferp || hp->dxfer_len == 0)
-			return false;
-		return true;
-	case SG_DXFER_UNKNOWN:
-		if ((!hp->dxferp && hp->dxfer_len) ||
-		    (hp->dxferp && hp->dxfer_len == 0))
-			return false;
-		return true;
-	default:
-		return false;
-	}
-}
-
 static int
 sg_common_write(Sg_fd * sfp, Sg_request * srp,
 		unsigned char *cmnd, int timeout, int blocking)
@@ -811,7 +783,7 @@ sg_common_write(Sg_fd * sfp, Sg_request
 			"sg_common_write:  scsi opcode=0x%02x, cmd_size=%d\n",
 			(int) cmnd[0], (int) hp->cmd_len));
 
-	if (!sg_is_valid_dxfer(hp))
+	if (hp->dxfer_len >= SZ_256M)
 		return -EINVAL;
 
 	k = sg_start_req(srp, cmnd);
