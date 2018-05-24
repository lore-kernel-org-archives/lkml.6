Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp0K5sFwzGFWJ6ye60tjQbGcvMbIv4g6CWo5qbqCIrQqi9mLbp/17ICNZM0ss/H6jyfCYe7
ARC-Seal: i=1; a=rsa-sha256; t=1527156226; cv=none;
        d=google.com; s=arc-20160816;
        b=OGdEmynXXKXkSjlkxjUQ3qqHSRRb5nnlv75Uu/6Nh5pn98CqydbiyQJ+5tOH7GruBp
         5eAJy4hdzXJiNCatotz2qxRsmA+mrsbJPgMgRNOL10VUEhfsHVwfLb2tfDRwhR6cUM80
         OsNo98lYEAB2AD7/77H/4SOMyAWe4xa3aVG+j9H+nTjK6zJjTF06NXYrfPL68XE/HnMF
         8jhQAs8RCsheGnRa9HkrASOUImgcxRUFlJETNp4w1n7Wqg+djTiMfdOZMwcH5u39BwIp
         aEk/gn7/TeFub3ednDJPS3i/TJsuFw6yo0mcPO28MyIpQBAQl0/kG+ACOXrVeYGwwsAY
         8Q+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Qk+MBQhGMMQUCXIoUmloiNhT6VGn9Fd8xaaghzJ/si4=;
        b=fzd0+PkS52KWvJWFckc1MQ0GGBB7cAKsGGA3kfwKJ7RhlS6sEFWLIJVxBJ80pvh16E
         yrnZ+8J6m6qh3AtH5vNGojin/U0SdR1Qz8R+sGH9sEzTVPK4V5D16ifXse/jNEsIfHaT
         nH7z43Sg5+TxzpJ4Vx1jmGZtkDVpMegU4U1NUe4yISM1Iz1VznRPvDSC3Vxr7LdWTCbc
         TliDmPa7DXhS+YQian5Bb7pCFIxDieWfClORFV+LIpbSgFx3CiC6guJoHibUDgO03CIk
         yu2U+kKX4AhB2bXl/Tu7Af6alVJI+C3/9KmpeJC5eKnuovJ/kOq6xIJGebC0wLamS/jR
         /uiw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=K9i6jVHW;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=K9i6jVHW;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Douglas Gilbert <dgilbert@interlog.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 110/161] scsi: core: Make SCSI Status CONDITION MET equivalent to GOOD
Date: Thu, 24 May 2018 11:38:55 +0200
Message-Id: <20180524093031.545799659@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338983932544112?=
X-GMAIL-MSGID: =?utf-8?q?1601339367399507645?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Gilbert <dgilbert@interlog.com>

[ Upstream commit 1875ede02ed5e176a18dccbca84abc28d5b3e141 ]

The SCSI PRE-FETCH (10 or 16) command is present both on hard disks
and some SSDs. It is useful when the address of the next block(s) to
be read is known but it is not following the LBA of the current READ
(so read-ahead won't help). It returns two "good" SCSI Status values.
If the requested blocks have fitted (or will most likely fit (when
the IMMED bit is set)) into the disk's cache, it returns CONDITION
MET. If it didn't (or will not) fit then it returns GOOD status.

The goal of this patch is to stop the SCSI subsystem treating the
CONDITION MET SCSI status as an error. The current state makes the
PRE-FETCH command effectively unusable via pass-throughs.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/scsi_lib.c |   11 +++++++++++
 include/scsi/scsi.h     |    2 ++
 2 files changed, 13 insertions(+)

--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -856,6 +856,17 @@ void scsi_io_completion(struct scsi_cmnd
 		/* for passthrough error may be set */
 		error = BLK_STS_OK;
 	}
+	/*
+	 * Another corner case: the SCSI status byte is non-zero but 'good'.
+	 * Example: PRE-FETCH command returns SAM_STAT_CONDITION_MET when
+	 * it is able to fit nominated LBs in its cache (and SAM_STAT_GOOD
+	 * if it can't fit). Treat SAM_STAT_CONDITION_MET and the related
+	 * intermediate statuses (both obsolete in SAM-4) as good.
+	 */
+	if (status_byte(result) && scsi_status_is_good(result)) {
+		result = 0;
+		error = BLK_STS_OK;
+	}
 
 	/*
 	 * special case: failed zero length commands always need to
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -47,6 +47,8 @@ static inline int scsi_status_is_good(in
 	 */
 	status &= 0xfe;
 	return ((status == SAM_STAT_GOOD) ||
+		(status == SAM_STAT_CONDITION_MET) ||
+		/* Next two "intermediate" statuses are obsolete in SAM-4 */
 		(status == SAM_STAT_INTERMEDIATE) ||
 		(status == SAM_STAT_INTERMEDIATE_CONDITION_MET) ||
 		/* FIXME: this is obsolete in SAM-3 */
