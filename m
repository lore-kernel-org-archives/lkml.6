Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvHe9cBXa/JR7sHurkIbQvBrvRVJ/OBBwX6zfuJPAqrLLEA4Gv8cdTuSvVM+F4Hncag1IZu
ARC-Seal: i=1; a=rsa-sha256; t=1521483101; cv=none;
        d=google.com; s=arc-20160816;
        b=yR6RUcWUuBcj8Ob7Sz8vcac6fdTjKWgX3nEm15sqqGXqyWkkVAlnnAR00iUNqiZ2ZI
         OfyHsSURXh5XskOMEtiMgsV60Wlg4EvN4VTN904+xjaiJ1O3wlGpxQ2JD1i29SJKgd4a
         aetRtS5IskG32p9jn/RSZ24Z0xoaen2jaFUMgy3214SsUdWJX4Mu3DYEcPFk0z9dgUQJ
         93ifV1jhI6lS8sjKjvsNYfRwG95ROocXl/x7up5Jkr4MMqVdCGMSdbIBiUE2bv5j3ZaP
         2aWJjy+i5e/ox/01LDkvqiJpqF+f7aOukv5QRmjMzATm6JXo0cx8ZU8E1QeAsFgGtdPW
         JuwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=A0mFrQRB0nQ97//MhIOh2wZbykxlPK12KA+icTv+wAk=;
        b=t66sUufCcjt57EYypxSfEFGQXx6jJl4aB0LHDRBJFfcFGrW9VcH8O4pjSBUgz1ZKbW
         RBvYm8rT9Ph4rj+FoE6hJkOvdyp87NrYCckvmgu85FNda2/mcsj+qqpOLzmmloQgMSLO
         WhEv4aBwmlvpHThRCr0PQw+OhGYnhOn+w17Bqz8s0j2vkKsKAstCu/q3PwR3QMCT1fn4
         emW3S11upgQY2CDjSKTq4Q0b2uzWoZt9TXClKO6hEIa83+g7nBLFB+m9+64BYXyIa9pa
         P/IRdQpKaarL+iQ3Z/r5raXQK3Mvk7jGVpk0Z7t6HBnBSrkHeX/ZvIynTT1Mbk5o0sZn
         QB+g==
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
Subject: [PATCH 3.18 67/68] scsi: sg: fix static checker warning in sg_is_valid_dxfer
Date: Mon, 19 Mar 2018 19:06:45 +0100
Message-Id: <20180319171837.303799320@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390665356823986?=
X-GMAIL-MSGID: =?utf-8?q?1595390665356823986?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
