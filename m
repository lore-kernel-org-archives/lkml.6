Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvD6aHAIoz5rLvf2dukBiCXrgbmnZnLDzLPgXLBG2COVoOCx7VQRIbgaPKFPXCJOYGt3ejT
ARC-Seal: i=1; a=rsa-sha256; t=1521214360; cv=none;
        d=google.com; s=arc-20160816;
        b=KPloupKx2h4T1fEeiBfC0yVd5C/VHFkOu6N1ARlEZl7GZmqiZTpRMdVP7NFvd1vnpz
         4jY7QU6zSLjQ4hp8NUCXiTg3CMCmTKIMlw3f1hw13Jq3nyCeB3liAjAAdsC5c/WMU4vc
         KbjtNrcbQO1UrK+ID2U9vOVZ+bKoTG6jaVLsLcuLdsZt3xGsmx4uTUDh64QJ6i3As3NG
         d7NK7ClLKV+2w+P6GhvpEjNmS+1AlIbIh9NTOIbm+a8k57/bJoVLTVvKsV/61BXNDh2P
         itn6e/6v18YkBMecqJm4NXv89VUeEEaQW20WKRRfEciA1tP7cn6UHjS5AXni5Vs+Pgd6
         pB7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5Npiv27qA39s1yZRz7RGXt+pH4SEkUem55OuY6V+4Hk=;
        b=c3C5j2iWwzdPNjp230g6ODPCWnOQhdMAOTdClc5Z3MmyWPUGtunrZ9/mItK+yJxAKZ
         ytB2R/CMV1sfcQ/j3rj3ymEW+5JFbOJife9pZx5l7ZZjbxwm8ZP5jwkJo69xYYtUU3U2
         jMHjVNppnEUqIyQkg/IRgvq0OwWHPkLRw1y9KIp2YgCeSdqX5soZv8yseK+GrNc//N/F
         AGLzSyTN6CHujiBR6DF7+oJA/JIjawRZ8PVXC6IWoT+yaa0HxDbUjKIhUb+MdtYyOWaD
         282aD0qz5oKL0oWou4zYNj9MGrsGAyaKBXU0lDe8OcWf+9SZuHJLdEhkbkegen2PcXXD
         06iw==
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
Subject: [PATCH 4.9 66/86] scsi: qla2xxx: Replace fcport alloc with qla2x00_alloc_fcport
Date: Fri, 16 Mar 2018 16:23:29 +0100
Message-Id: <20180316152321.840251254@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108683086425811?=
X-GMAIL-MSGID: =?utf-8?q?1595108869177959705?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5789,7 +5789,7 @@ static fc_port_t *qlt_get_port_database(
 	fc_port_t *fcport;
 	int rc;
 
-	fcport = kzalloc(sizeof(*fcport), GFP_KERNEL);
+	fcport = qla2x00_alloc_fcport(vha, GFP_KERNEL);
 	if (!fcport) {
 		ql_dbg(ql_dbg_tgt_mgt, vha, 0xf06f,
 		    "qla_target(%d): Allocation of tmp FC port failed",
