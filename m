Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs47+B3nJnsC2zWo4vTVvQ9zc4SIikT+Luyp99veNMBonHsoNbImUlMcDGVluL8KML5QNHG
ARC-Seal: i=1; a=rsa-sha256; t=1521214183; cv=none;
        d=google.com; s=arc-20160816;
        b=cY3G0LSqqqF4qwbRCYAgEumZPGqj51jgd41WSSG9Rxvt1nWErCyKYXonJ59mk/gtal
         gxJPVkWORgFQVHLPorEA776Gqtdi8g7uKjHM5hst2DC7A3lH5MzqAWYoLsBFDhhRO8WG
         n13Obo5qzIrADsfCSIgThUHouevi6crQapOQYS8rqL3HoUwG7d8Z4E1rQaQP81LuQJcr
         ii5+uUUUJ7XZQkrhgZl6B1miz5yaTLFxC31b/HRhoxUluz+Nw3IxHfoIbOO6RUm16OpX
         2aKkYHXO6uRlTfWno+vPopGPXrCxdrMCq9Cgfo71BIbbuygdQsLK6OMDPF4ZBQjHb9G/
         NeOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PJQfOBHYk83aQ9sZhIBCxh6Ex4yAsznT3H1RmAmod4Q=;
        b=l58N3Ln+/P5UrbAjUPiK3iP1mtGwPlUEvSyKi1oHtCqOu53Uf+56PJW221LR6g2Gb/
         S+Tql4tg4tfh7eAQykE6+scXBYE/wVHKqQwxHwGUiHhyVwlvxWbj/BG4vHEwkoLyqAU0
         Blnm4PMCwoC105B9N4TbjPhKjICGPVjcl4Otru8QRP5kvagGC9t/SxloCDP08vXfcRD3
         kjX0hcIZ3dGXP0sJ+TyHBBv9E0Ta7EWpIYmjqGfqLjRhLeiC/1r+MApG9cCLUPWx7nCM
         ocYGz/sCZAXMlG/HydGYxRwDb6tZOhfMz4RXP5a2KFLMFDPCdMZtvrYofmAOS3p4qr6g
         u8ug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Quinn Tran <quinn.tran@cavium.com>,
	Himanshu Madhani <himanshu.madhani@cavium.com>,
	Hannes Reinecke <hare@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.4 47/63] scsi: qla2xxx: Replace fcport alloc with qla2x00_alloc_fcport
Date: Fri, 16 Mar 2018 16:23:19 +0100
Message-Id: <20180316152304.947780386@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108683086425811?=
X-GMAIL-MSGID: =?utf-8?q?1595108683086425811?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit 063b36d6b0ad74c748d536f5cb47bac2f850a0fa upstream.

Current code manually allocate an fcport structure that is not properly
initialize. Replace kzalloc with qla2x00_alloc_fcport, so that all
fields are initialized.  Also set set scan flag to port found

Cc: <stable@vger.kernel.org>
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_target.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -5502,7 +5502,7 @@ static fc_port_t *qlt_get_port_database(
 	fc_port_t *fcport;
 	int rc;
 
-	fcport = kzalloc(sizeof(*fcport), GFP_KERNEL);
+	fcport = qla2x00_alloc_fcport(vha, GFP_KERNEL);
 	if (!fcport) {
 		ql_dbg(ql_dbg_tgt_mgt, vha, 0xf06f,
 		    "qla_target(%d): Allocation of tmp FC port failed",
