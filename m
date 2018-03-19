Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsyY1ycswPU6ninnK/TX8FWwUhmQWztpof64p9zrxrV1kqnjhG72IFdG08q7Ye7xdhtSpAp
ARC-Seal: i=1; a=rsa-sha256; t=1521484107; cv=none;
        d=google.com; s=arc-20160816;
        b=HhZFvl13+OI6Aj/jUOOqHILXyjh2DP90Ccv9Z9o5mGGnCW00RIleUzBucdSI+Ur8Xy
         PxkRt/Hs6q9t6ZvRW4fBlTig9uv+VcDz9ao2ymVAa2e6/31KFIVodYnuZVaKXjJkce5G
         uKehVyw40CL95b/Cuq0Qf2q4EdbDjiCd4ZIh0bLH5mWs2l8Um5mTgkKo4fzvNYEwaeoG
         llWx05FpXE9B1MWcjwdtnB5PwwCKjrnNHnjHTpiHMiQsKAN66F8IuvZN+EhqpBP9H12z
         vFu3GhbOMRShRLkE5/eCByqa8qttts/RUEkdRLzvkR79FIpuv6ylatmYhHSqKOexubSi
         QSuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sbgtRBfCz4yyt/cKj5oeH0L6xLE3q636BqnYMRSYetE=;
        b=ZRLyExzsxdpVzErkgmcGl5G+pzgtJr/0KNDfo2tZaKiFQ7Wwrmst4hPoBl/ziby2ir
         RG158at7bRbs4dKJBpAs7fMoLvtRUInD2oCYzMhbuSDl0bNuuj5CLSuWW3mzOVzx1b6H
         uIY6qNXzGpc2BJsoIXfHIzDyYz2yniy9E4kA4J7JJKQBxITBNZLijnCGEfBoPVucFijL
         iemjqM69p7BIVkasMVrE//jSFS6a2wC4DJivqEzRKG4G/nHv1MRSm0NQ1IIdmzAaqwCc
         fYwpZB5/IkJt785i1ELGkd+dmjji/EalDwcwoazbCtZOeCB9IEgGxokAydU2Sa4TW18D
         b1zg==
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
Subject: [PATCH 4.9 234/241] scsi: sg: fix static checker warning in sg_is_valid_dxfer
Date: Mon, 19 Mar 2018 19:08:19 +0100
Message-Id: <20180319180800.864703866@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390665356823986?=
X-GMAIL-MSGID: =?utf-8?q?1595391718742028052?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -759,8 +759,11 @@ static bool sg_is_valid_dxfer(sg_io_hdr_
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
