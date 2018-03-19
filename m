Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsiQCmuYDnjrbLzRFnEh1d3oRvGLgTOXRfhMqAu9lOjUh2jIhBkui0zW+508fKh5HIfIoC/
ARC-Seal: i=1; a=rsa-sha256; t=1521484109; cv=none;
        d=google.com; s=arc-20160816;
        b=O+oGrRUMoUjQlXRRrAWPdHBp1MHSmEuw9YuLfpZTh8pIHsdyaqz3Ke1aFOUL4B78kv
         jAEywFHnjSXZaLSf9SE3Q2f/Aaa4eNQm3inGmf/NxOirjzCxZgRR5ngwS/jWyFkkqWgU
         pEZAEo63xSbS0L2gBI6g7oXMYbWSoNYIsqFQANr5a1ALvWUT2o1L9oJwQIK5+3CuIgp2
         K/J+Bie2arNJgPIIFSVjqXkfotOSvY3p1pc1chqX6szozgotfXMX+YSWhFy9l+RmFD/K
         RtC01E9LedM50Y5S0YeSyivyLXZD5HNvmRDFuBXyCbJgncODTjdTcFvubd46j2jOPi2l
         v3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tsInwkYwrdrQAGRbVg7biklDWE1sM8I8330br5EqnQ0=;
        b=lNPQkezEHE7b56VjVWG7Qr0MIAb433qf7vowwHlvq5PY3naLU4k2i5w65ih4bVnQe7
         m2Mm+LhemlxUUNx+IOB6RB+Ag/wppK8evn1WxKXZ3eielxFXZIdBZCK6qlPiTS99BpAW
         4hEhKVYr6TDs8G8qdrbDFSMXEYwUBFPtjzDMoJvXSo73yYWskn3VjJmaYQjre7FWrCoj
         jzLz7SnONodPMJetxVrjQPg7FpzaqGkkhBOLPv8KJzQxgtvipsOXP4vaWBLfCqWgqKx2
         iZMSc8yscyrIkmKscNIRWUu9PguD82ASVT1/8KcU0vDw64TAut3GarwxQ2qq0Ydid/Oj
         jInw==
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
Subject: [PATCH 4.9 235/241] scsi: sg: only check for dxfer_len greater than 256M
Date: Mon, 19 Mar 2018 19:08:20 +0100
Message-Id: <20180319180800.907816485@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390667692635257?=
X-GMAIL-MSGID: =?utf-8?q?1595391721523441987?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -751,35 +751,6 @@ sg_new_write(Sg_fd *sfp, struct file *fi
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
@@ -800,7 +771,7 @@ sg_common_write(Sg_fd * sfp, Sg_request
 			"sg_common_write:  scsi opcode=0x%02x, cmd_size=%d\n",
 			(int) cmnd[0], (int) hp->cmd_len));
 
-	if (!sg_is_valid_dxfer(hp))
+	if (hp->dxfer_len >= SZ_256M)
 		return -EINVAL;
 
 	k = sg_start_req(srp, cmnd);
