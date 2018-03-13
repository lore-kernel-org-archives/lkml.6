Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvFEJDcq0VCUOsSWoXFBXTyE0xe/h7JEA/bbv1IA/nDCax0A/tP+tL57lYnuwYUCDJ7ktQY
ARC-Seal: i=1; a=rsa-sha256; t=1520955243; cv=none;
        d=google.com; s=arc-20160816;
        b=w/HxRXHRqgxVWt+yVIIt93b6MXZYa9ZqRy0M7ZyJnTl5yLJ057WxLYRHtcLExk/BLP
         cLg0RKpqc6q9/dyVuYuipZjRcEWItec41S5s81bm8zQoHmIBEY4dJecC4UGFoPq4yYmr
         o76MJrh1hR5n/fb+akYB0qb8knGULLOypiXUnlgC4YLiEDOrP4q4Vx7eJRZfNzNus2Lj
         w/xuNfIRl/3wDAuSObibQZ8apEyeSv2lojXwlI1qA1fHCzlokRnO7/tc9GxRGEpx9RLB
         xv1/SCr86is2jhIRY9ndav2Nn8sWln5aiX6R2lyK0UUReUkzwDbUsp20DbKSO/00mAIS
         Yd2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sIBLHixZXeSj8iEo89qFATsepaEQwk+dWFiS9QYM868=;
        b=LxYXKCO+xE6LEEl3TgfVYF5LHPQRQ9P8+ge/Szsl37QoUq7G9UcUw5XYxaOKMlwcpd
         DWMDoX6r6WWqup1jJKL8b1ovEaBG0hw4Q48j+hLK6HfcS+1+x/Cl4ywu2IrVjE4PMKkF
         l1yrULggrbOhuKi4U0KY5ptbjXPq+W9b8fmHve+/VC4GwCIC6Cdi8rRtVi7EZ7Shsdp/
         bMZDsB02Il3JcBmCI1sdZ5Wqu43FVj91Juay4sM2OzqGU0Rqysb0s9+ghMCBwmC0kf26
         66yryJPp0K0n9IC4gRAm172czGsvRjs2HShmklBVjgquefGt6b+YUWVMw9QMMVmLf+zE
         TB+A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Quinn Tran <quinn.tran@cavium.com>,
	Himanshu Madhani <himanshu.madhani@cavium.com>,
	Hannes Reinecke <hare@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.15 138/146] scsi: qla2xxx: Fix scan state field for fcport
Date: Tue, 13 Mar 2018 16:25:05 +0100
Message-Id: <20180313152330.721572922@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837165411969531?=
X-GMAIL-MSGID: =?utf-8?q?1594837165411969531?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit 76f9a2dd4c60183879a1898bcd56a1dbab19a85d upstream.

Add correct value of scan_state field indicating state of the FC port

Fixes: 726b85487067d ("qla2xxx: Add framework for async fabric discovery")
Cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_target.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -5811,6 +5811,7 @@ static fc_port_t *qlt_get_port_database(
 		tfcp->port_type = fcport->port_type;
 		tfcp->supported_classes = fcport->supported_classes;
 		tfcp->flags |= fcport->flags;
+		tfcp->scan_state = QLA_FCPORT_FOUND;
 
 		del = fcport;
 		fcport = tfcp;
