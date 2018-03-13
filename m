Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtLbonk0ymb2yxZmPXeL8l33tW9CVH+FcboEExIkdcP++XjkMGEua7TJNQ64t1MNipTCEMZ
ARC-Seal: i=1; a=rsa-sha256; t=1520955413; cv=none;
        d=google.com; s=arc-20160816;
        b=IiKjc8idHm5pW92imlcBbuB61sy5QPNx0LQR3IPPzF6gHCXWTstgG3PlrrjsF4VFqq
         LMky54knxS69ToXaUF5osUS1D24cGuS93kr5Os8fzJILShyu/XeVDHKbm0/1eMw3x41S
         n94R8UrYq+KBDEfg78MeF0T0VAC+khVRowWgfnkSnRr1VD+u4af1fceh9rOautHRmwVn
         8TqLPn+rpYMoq+iEoL63czpfKIU2uAELpI/lD9TtzjGwYJhybEybsTB38zi8tG7Utdcd
         I4z2qu4jti7rmNhtzjyZ1OHcFCUOwMqqf+ccXpS6LBBKjSooMaGu95yBLLjk6hn4jZ5d
         RAUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1UZrpghtiDRftR7DiDU+LjyPXbb436zfjNhHEI1NpD4=;
        b=JdkoCkFjlmevEhcKar9kE8IpDuRtYL7FqUwKMoAsnY+sTO163uqfBid2lv4Y1IRVMk
         mRr7pAe1XOKZWeFnLNrG++aSoOroxiy/HpFEq1cVgkmg3EHDge4Cp14BDLMwL2oj8ZmT
         UoHhTsv9kiyC8kBmEmqQiGq5QEzArYQZ7z74gOqi0RujgIeKaVWkmsBL0JEgXpkRtsjB
         cyb0dwAtGLaTsvP5DZXTuP8Ywb2WGtC3B89zIOES1J+2hziy/yz7WFTN32+iOOswzlo/
         qxgqTH3y8JUvqDnvkqWVbCbguEQpCMuUZpFQOR/AmakV8Yll4Wi6jgprts8OfwkSV2Pl
         e1sQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Himanshu Madhani <himanshu.madhani@cavium.com>,
	Hannes Reinecke <hare@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 042/140] scsi: qla2xxx: Fix memory leak in dual/target mode
Date: Tue, 13 Mar 2018 16:24:05 +0100
Message-Id: <20180313152500.944485328@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837180805822140?=
X-GMAIL-MSGID: =?utf-8?q?1594837343868346931?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: himanshu.madhani@cavium.com <himanshu.madhani@cavium.com>

commit 7867b98dceb7741065c9c1b645136facad5c2e93 upstream.

When driver is loaded in Target/Dual mode, it creates QPair to support
MQ and allocates resources for each QPair. This Qpair initialization is
delayed until the FW personality is changed to Dual/Target mode by
issuing chip reset. At the time of chip reset firmware is re-initilized
in correct personality all the QPairs are initialized by sending
MBC_INITIALIZE_MULTIQ (001Fh).

This patch fixes memory leak by adding check to issue
MBC_INITIALIZE_MULTIQ command only while deleting rsp/req queue when the
flag is set for initiator mode, and clean up QPair resources correctly
during the driver unload. This MBX does not need to be issued for
Target/Dual mode because chip reset will reset ISP.

Fixes: d65237c7f0860 ("scsi: qla2xxx: Fix mailbox failure while deleting Queue pairs")
Cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_init.c |    4 +---
 drivers/scsi/qla2xxx/qla_mid.c  |   18 ++++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -8092,9 +8092,6 @@ int qla2xxx_delete_qpair(struct scsi_qla
 	int ret = QLA_FUNCTION_FAILED;
 	struct qla_hw_data *ha = qpair->hw;
 
-	if (!vha->flags.qpairs_req_created && !vha->flags.qpairs_rsp_created)
-		goto fail;
-
 	qpair->delete_in_progress = 1;
 	while (atomic_read(&qpair->ref_count))
 		msleep(500);
@@ -8102,6 +8099,7 @@ int qla2xxx_delete_qpair(struct scsi_qla
 	ret = qla25xx_delete_req_que(vha, qpair->req);
 	if (ret != QLA_SUCCESS)
 		goto fail;
+
 	ret = qla25xx_delete_rsp_que(vha, qpair->rsp);
 	if (ret != QLA_SUCCESS)
 		goto fail;
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -575,14 +575,15 @@ qla25xx_free_rsp_que(struct scsi_qla_hos
 int
 qla25xx_delete_req_que(struct scsi_qla_host *vha, struct req_que *req)
 {
-	int ret = -1;
+	int ret = QLA_SUCCESS;
 
-	if (req) {
+	if (req && vha->flags.qpairs_req_created) {
 		req->options |= BIT_0;
 		ret = qla25xx_init_req_que(vha, req);
+		if (ret != QLA_SUCCESS)
+			return QLA_FUNCTION_FAILED;
 	}
-	if (ret == QLA_SUCCESS)
-		qla25xx_free_req_que(vha, req);
+	qla25xx_free_req_que(vha, req);
 
 	return ret;
 }
@@ -590,14 +591,15 @@ qla25xx_delete_req_que(struct scsi_qla_h
 int
 qla25xx_delete_rsp_que(struct scsi_qla_host *vha, struct rsp_que *rsp)
 {
-	int ret = -1;
+	int ret = QLA_SUCCESS;
 
-	if (rsp) {
+	if (rsp && vha->flags.qpairs_rsp_created) {
 		rsp->options |= BIT_0;
 		ret = qla25xx_init_rsp_que(vha, rsp);
+		if (ret != QLA_SUCCESS)
+			return QLA_FUNCTION_FAILED;
 	}
-	if (ret == QLA_SUCCESS)
-		qla25xx_free_rsp_que(vha, rsp);
+	qla25xx_free_rsp_que(vha, rsp);
 
 	return ret;
 }
