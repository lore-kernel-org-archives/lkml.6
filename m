Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuAKyc+U/q+md+LMO0N1Yz0JEhLjJEcmyLwWDICeJRMkASbZczZpJ0Hv2poRSY7sSgUVPAN
ARC-Seal: i=1; a=rsa-sha256; t=1521483449; cv=none;
        d=google.com; s=arc-20160816;
        b=vAQoMc9cIzaZLslL88GTIFHpo/L2BS29aWeOGhodXPaSIm6URYX+69EvICZwwFKi7f
         LOy/EQhFnQXEhVLryXqqmpPTFhSe3g2USMdqBe/feKWvqHO+VSCBff05DCLpPi3J8yYa
         XfGyRp+m8vppZsd7t1xqhXuljjJAISIPO3knLqgwhXbIYKJZq0Ry7gbYhS+vSa3hZetj
         XdYkZILPbC+s07IZ+r50PMBKI7448geXUSr3ulzVVpMxfTddUJUm/L5qKw4N/z/S08+Z
         yT2rwgFlB0nJzi0gJ0fXB596UQQc+znTnQqsQZk7JgNiSxyYkV+8buhXp+W24lPM0yAj
         IYZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ew1qcVvYOLA6/BYmMS8xbf9iA9E1Hr4zU//crB87vmQ=;
        b=HcJuYy2N3x2Vm+L5HZ19qz0Ppgp2Vgba3NmNPXQvMbz6AbNUfDTT1zmbZVgxSziJPF
         Qm8Oq9/wrv3e7YrQ73jnYbWDrQ3Py08+sKe9ZbLgs8Iop5pjuUmvPaBlopBv5l7kb4FI
         HKvIJ6LAqXHn/pX/xA/a5p5Bq5FEwJNFRbo4WSOsEYbufKKs1PhlIY0QAZLEktfTINIz
         2o27vxWrzLdUTZ7zWEj4RViD5Jq4e/XJRmfrwDFlOtn7W5tr5s4GmQgYgVxuB3P8e59Z
         lDQyKmdeSx/p6+U5PlHqTZujywfHxE2NODAx2xhZG6HdZw3RUIPKMFn4yc7KFw1VdVjM
         JDXA==
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
Subject: [PATCH 4.4 128/134] scsi: sg: only check for dxfer_len greater than 256M
Date: Mon, 19 Mar 2018 19:06:51 +0100
Message-Id: <20180319171907.770748258@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390667692635257?=
X-GMAIL-MSGID: =?utf-8?q?1595391029863093234?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/scsi/sg.c |   31 +------------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -762,35 +762,6 @@ sg_new_write(Sg_fd *sfp, struct file *fi
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
@@ -811,7 +782,7 @@ sg_common_write(Sg_fd * sfp, Sg_request
 			"sg_common_write:  scsi opcode=0x%02x, cmd_size=%d\n",
 			(int) cmnd[0], (int) hp->cmd_len));
 
-	if (!sg_is_valid_dxfer(hp))
+	if (hp->dxfer_len >= SZ_256M)
 		return -EINVAL;
 
 	k = sg_start_req(srp, cmnd);
