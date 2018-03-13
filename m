Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvrviQzA6mbZPWYxDRCKPWslKhRLhlGANd5/kc/7FhL83cHLaIR5R9Y+k1t3cE+ZoYoFq15
ARC-Seal: i=1; a=rsa-sha256; t=1520955631; cv=none;
        d=google.com; s=arc-20160816;
        b=EUa2hcsTEV/ToggSEOHeN/y7dbFVIX4nnKW5eqOEsNcxvH2zjlQ/QCR6A2fg0IVXU4
         dKa1NuBUuULfQP08qmIihUkc6/VSjDi+uljpM3cxBnrMyE2yKUKohw/uR+stJ3zIIXFX
         xUESLrWNhWJINu/SNdPqobuZIX3F95vQ7Eu7X/6Jj81rAYEpj8dvcxzi+Mem3j6uMEQp
         fAd7AKIecZ8VqHqIKFDUj+QT9G3jmuvYXiqF3051HdShL+WEDvSHcRyUGTrjMp2uOeLl
         UoeQ/JJoIOTUMPT4YCV8Cv1bhLqQsu3CXGWbYhXDeRpaSWGGtd4H7+xih0IOVz6V37lg
         5Ihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eMklzGWc8EQ2+DUxFGI5fIhOe6MKMYy0o5B0Em6drTY=;
        b=agtp1QO9qrGpnZkWT/Iw422o7712XOWFl/SE/1vrLpZfKtuebq6SNykNmIYg2Y5uLv
         0ZhpRw0wWL/adAZ02Qg3qBXoAqOcDy4wJAVQNSmdiHgHAUbdTll1DrESyOOXOPVPloyg
         AfeDJiKdfdfntqyPrE7eanYv9tq9gfh07QcA6aiBPuEKJqR0qMMMPi9grcwYvOeoN7Rx
         Wtjpr2IgFnwrS+lZEVPHKW93kw33Gw9NiFyp52qq3No7SenF1G7aTURT6449hxIN9Blm
         G1o+N/+mDD18G4oVwpkOnaLpyfnmLdkjF/UERztBVmXDMnj54bK7torUKqozKbc51M6Z
         D6Cw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Himanshu Madhani <himanshu.madhani@cavium.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 111/140] scsi: qla2xxx: Fix NULL pointer crash due to probe failure
Date: Tue, 13 Mar 2018 16:25:14 +0100
Message-Id: <20180313152505.614917029@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837058075181473?=
X-GMAIL-MSGID: =?utf-8?q?1594837571998071069?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: himanshu.madhani@cavium.com <himanshu.madhani@cavium.com>

commit d64d6c5671db5e693a0caaee79f2571b098749c9 upstream.

This patch fixes regression added by commit d74595278f4ab
("scsi: qla2xxx: Add multiple queue pair functionality.").

When driver is not able to get reqeusted IRQs from the system, driver will
attempt tp clean up memory before failing hardware probe. During this cleanup,
driver assigns NULL value to the pointer which has not been allocated by
driver yet. This results in a NULL pointer access.

Log file will show following message and stack trace

qla2xxx [0000:a3:00.1]-00c7:21: MSI-X: Failed to enable support, giving up -- 32/-1.
qla2xxx [0000:a3:00.1]-0037:21: Falling back-to MSI mode --1.
qla2xxx [0000:a3:00.1]-003a:21: Failed to reserve interrupt 821 already in use.
BUG: unable to handle kernel NULL pointer dereference at (null)
IP: [<ffffffffc010c4b6>] qla2x00_probe_one+0x18b6/0x2730 [qla2xxx]
PGD 0
Oops: 0002 [#1] SMP

Fixes: d74595278f4ab ("scsi: qla2xxx: Add multiple queue pair functionality.").
Cc: <stable@vger.kernel.org> # 4.10
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_os.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3003,9 +3003,6 @@ qla2x00_probe_one(struct pci_dev *pdev,
 	base_vha = qla2x00_create_host(sht, ha);
 	if (!base_vha) {
 		ret = -ENOMEM;
-		qla2x00_mem_free(ha);
-		qla2x00_free_req_que(ha, req);
-		qla2x00_free_rsp_que(ha, rsp);
 		goto probe_hw_failed;
 	}
 
@@ -3066,7 +3063,7 @@ qla2x00_probe_one(struct pci_dev *pdev,
 	/* Set up the irqs */
 	ret = qla2x00_request_irqs(ha, rsp);
 	if (ret)
-		goto probe_init_failed;
+		goto probe_hw_failed;
 
 	/* Alloc arrays of request and response ring ptrs */
 	if (!qla2x00_alloc_queues(ha, req, rsp)) {
@@ -3375,6 +3372,9 @@ probe_failed:
 	scsi_host_put(base_vha->host);
 
 probe_hw_failed:
+	qla2x00_mem_free(ha);
+	qla2x00_free_req_que(ha, req);
+	qla2x00_free_rsp_que(ha, rsp);
 	qla2x00_clear_drv_active(ha);
 
 iospace_config_failed:
