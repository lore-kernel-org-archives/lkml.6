Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuunn+AAu40PGNehrKpxOP4qSbNqdSC5xWjkHsHpIYU3Dpz1OwoISOWEtmijHfOnUZwIg7T
ARC-Seal: i=1; a=rsa-sha256; t=1520955283; cv=none;
        d=google.com; s=arc-20160816;
        b=qAM/IwDXr4XsuRTQgHcwRFCzUFcloYmM5BTr38DRBhyf1iLJZv8IJ5Q5o3ukoGt+Cg
         2Z3Kw03/YwbGcYf1hDLTN7ZurKq0KMOJUQ5c/2VfZAwEy1yFuvmpUG0vaxP/XnHrQ/D4
         +7sEUovmsaMIx8JBW/u/3n1Rq0wgfhgPdhWBm4/kcJoO4yY9vF+y8Ksa+X/WambGWLom
         Oa5WMScJC0NkWPx5QEaBYtUp2ku+Llqr9SFTa0TgfgyDNrbAUFXDcjVXm2b7dG9CYxOT
         ky1pEE6EIfBf48jEfz91dMfxHYrTYyKRWk6CUbNM6v9hoGNc6gAFsJSVkj7uvKLf91LJ
         BwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Rte0/uiiS/0FgrvDOX0D9AIeysU577ZilEeozCvJKtc=;
        b=vDNwNgeDJHmrw6UjtfBzOXZU8Y51pgL9P5MsUGJS/OwMpwrDvZ7frXzwoRLY7X5Tru
         7p9Ix3dqdLtyYkxmN1lIAybtl7aWMPCxeK1H5btH2RQwkpYKkYvnJLDJhK5yhAWBMmsK
         o8K5/DzXo39kUV1OuPqnOwGUNcj9ADPx/Q75Xt3yj290nyn/B8RQ7M1JqdBuGFyHSvjL
         lYTz2gbS463gnxWhLzA9A0xj51490yw1aLCtv+CFh0XMrknCw0zE1FmujqxkCXhHEVzH
         jWdKV4sVXCQyiRREuEWwusBWwUHMXIibDPOTnRQUU7ddxFfYDLipd02EZNDlDgNxR3mw
         2Llg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sawan Chandak <sawan.chandak@cavium.com>,
	Himanshu Madhani <himanshu.madhani@cavium.com>,
	Hannes Reinecke <hare@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.15 132/146] scsi: qla2xxx: Fix NPIV host cleanup in target mode
Date: Tue, 13 Mar 2018 16:24:59 +0100
Message-Id: <20180313152330.341300494@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837207629830173?=
X-GMAIL-MSGID: =?utf-8?q?1594837207629830173?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sawan Chandak <sawan.chandak@cavium.com>

commit 3be63b1e1838e35ce93e83f19573e949f4b389b4 upstream.

Add check to make sure we are cleaning up global target host list only
for NPIV hosts

Fixes: bdbe24de281e2 ("scsi: qla2xxx: Cleanup NPIV host in target mode during config teardown")
Cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Sawan Chandak <sawan.chandak@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_target.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1561,8 +1561,11 @@ static void qlt_release(struct qla_tgt *
 
 	btree_destroy64(&tgt->lun_qpair_map);
 
-	if (ha->tgt.tgt_ops && ha->tgt.tgt_ops->remove_target)
-		ha->tgt.tgt_ops->remove_target(vha);
+	if (vha->vp_idx)
+		if (ha->tgt.tgt_ops &&
+		    ha->tgt.tgt_ops->remove_target &&
+		    vha->vha_tgt.target_lport_ptr)
+			ha->tgt.tgt_ops->remove_target(vha);
 
 	vha->vha_tgt.qla_tgt = NULL;
 
