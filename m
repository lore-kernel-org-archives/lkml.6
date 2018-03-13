Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuMHaNQ6lBq7fT2aUlUy335Jxa36kUwCMQyk5wyu/Y/xi1BsocrHzrjCdQFWzJb7kk0RB8Y
ARC-Seal: i=1; a=rsa-sha256; t=1520955240; cv=none;
        d=google.com; s=arc-20160816;
        b=jR2/55STuSz6u3xXhQXt25oWZQXpOYJG/IA5ckI9E2ZCMvFfemlopXjMMRTHegyRNE
         IOnC8rLw/kKCcI8iv1nVN7DIoFiVRPajKEMMwiR9YDgVFlh5OXrMjwL/e64jrYgmq9UM
         o6XjgjDMhwkhnAcKqPI4oK/nSx+Y9J0z9Tp7GGoui0BE8+AgjTr+L6iEp/6ZiJhd8qtm
         0pOQ7dthHzBvs9tGwTWNrcJCi3YZNFqI7gd1rq0YezcQuq3fS6DcH5woaXATOPEbWVe/
         IcKNjPLV9dfHe0vYT+URp79Cyo0Ne6n9HNFTBqaWn9j4RIUfldDYyIyMije4Kp4JMBKA
         IBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wD4tTV3qQ/rtaCmL3kjhQcNfcfMttH5u12Y839+w5jI=;
        b=lJfB12845k3o68qqr3WWJU1qYIYj/Nprhv3FxFXZo2hhcUwrI58tMys5/xoaxO+LhY
         /ineFHUWbksuxwcJ+zeKxD+js8COUsRHRQLW3WqPDea7uHtPTO1FXpabEvXds3edVItS
         LAfwhRm8l6sgzU6pcu0mZO3aXZhInr3HYyOuHAs4Lqh4qlH4N6XDWQa8swGZFGz/VPa7
         hbobnTpVhum4m/eK5V0euE2yVXfqGStN5UfBkFjVtTeWgESSG3ITgquG13oEn8cDMh51
         KAEexiAqUlaxvpSkd4QQ/DdOv7HkR9PG7Veiu4ct0CekxReoZi3mBJwjtYjUwnjhGmDu
         +X0w==
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
Subject: [PATCH 4.15 137/146] scsi: qla2xxx: Replace fcport alloc with qla2x00_alloc_fcport
Date: Tue, 13 Mar 2018 16:25:04 +0100
Message-Id: <20180313152330.670470131@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837162674464832?=
X-GMAIL-MSGID: =?utf-8?q?1594837162674464832?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5782,7 +5782,7 @@ static fc_port_t *qlt_get_port_database(
 	unsigned long flags;
 	u8 newfcport = 0;
 
-	fcport = kzalloc(sizeof(*fcport), GFP_KERNEL);
+	fcport = qla2x00_alloc_fcport(vha, GFP_KERNEL);
 	if (!fcport) {
 		ql_dbg(ql_dbg_tgt_mgt, vha, 0xf06f,
 		    "qla_target(%d): Allocation of tmp FC port failed",
