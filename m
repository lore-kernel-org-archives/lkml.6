Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvhFJTpcPHp8nPiD89fnxKh8uP7qnoUr/WNwfDycOMOAedOdNAK1s0bvGYxRc1ji8kvEPuk
ARC-Seal: i=1; a=rsa-sha256; t=1520955263; cv=none;
        d=google.com; s=arc-20160816;
        b=AI6GUxJtQLvRnJ/77p0CbsL/q43xEgZmgloptF/fd5gwk0Nv42qMVAeZb96C0R2ZuR
         Q/4ridUidGQDlhkytkiVIHP5RK6fmzNpHMNOYYp3z7oRMZkreR5+m8MgespriYUeXOC8
         LlUKjA/B81Ffh98gumPkPFhyfPQCXB3SQVtxFYpA8UBKKZOCWcCiH5X6CYEAb8lArsmD
         MgYGfIL1EcW7LKipFqIpTuWU8Dl+0GrUtcmYMDRGfThnrtDEWSE/giBoypA1VLaYQzGm
         8J2Us83C98rRTXLO9gC+yQru5u6r3ROpsLkZenZbZ7q2tpYGI02sw9J/rSB/fEEV1VO8
         jkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=p01M4sfppkSKVWYjUEM7mNTB+K36Apelp32dbahHGpo=;
        b=CnIsWLzGxEmahsemfiPyXOLZi1EwC+NcSB2lRAyHB/hCTPtLniY5d3InuyPTN5TamW
         7AOQ3CMcg7RuyuWPSIH6xQtZR/RnOknAvpY80wWoTv0qQHSv6IAAb/H6aNMMjALMrQME
         ZxPpoO57r8aKlYSIx4BlbMQWGsHC1afulX7y7ObFyEl45aWOfgZ7buCoDbRNTuf4HNng
         zIbZmCXCGqlC4YVi243ULlC+j735CccNU9UEW3/BultZIb6NWaTXc47N1rn1Aq5iiYdG
         xCUK/Fj/9lpONx0FHmFJVVMc42n4+qTb5Xa8+coiQtEeHLNKBk6pCW6rxzw4cAjuAomu
         59eA==
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
Subject: [PATCH 4.15 127/146] scsi: qla2xxx: Skip IRQ affinity for Target QPairs
Date: Tue, 13 Mar 2018 16:24:54 +0100
Message-Id: <20180313152329.981761635@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837186728182201?=
X-GMAIL-MSGID: =?utf-8?q?1594837186728182201?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit d68b850e1bfb9afb24b888a946165a186a710195 upstream.

Fix co-existence between Block MQ and Target Mode. Block MQ and
initiator mode requires midlayer queue mapping to check for IRQ to be
affinitized. For target mode, it's not the case.

Fixes: 09620eeb62c41 ("scsi: qla2xxx: Add debug knob for user control workload")
Cc: <stable@vger.kernel.org> # 4.12+
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_os.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -6609,9 +6609,14 @@ qla83xx_disable_laser(scsi_qla_host_t *v
 
 static int qla2xxx_map_queues(struct Scsi_Host *shost)
 {
+	int rc;
 	scsi_qla_host_t *vha = (scsi_qla_host_t *)shost->hostdata;
 
-	return blk_mq_pci_map_queues(&shost->tag_set, vha->hw->pdev);
+	if (USER_CTRL_IRQ(vha->hw))
+		rc = blk_mq_map_queues(&shost->tag_set);
+	else
+		rc = blk_mq_pci_map_queues(&shost->tag_set, vha->hw->pdev);
+	return rc;
 }
 
 static const struct pci_error_handlers qla2xxx_err_handler = {
