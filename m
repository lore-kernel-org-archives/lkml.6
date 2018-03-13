Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu2uwmKFGHZiOdf8gN86ZRF5r7E9kOeE+U7flnJdVF49P6ZspLIz/vtLSviM2eKione/NqM
ARC-Seal: i=1; a=rsa-sha256; t=1520955141; cv=none;
        d=google.com; s=arc-20160816;
        b=uVAMMQyzNBgKluBqHY6yu0uSWPLgN7ma9E43qRCCcwW5e1xjAZSPjLSO/+VB1enr/Q
         VJMES+Zp9+QzryHvNqibPajsVVrU7A3qCsHk9Ix5VMFpTHi67f5hAAk6izuJG6ykjKSb
         nJ8yjOrR8C24seu4vwVy1LeH7d5BoPeGE4J9d5hhUrtYKJX9HgjmKYKSjG5ClM+J3BDX
         Re8CDZ0/fvX5enF/389u/v9GIniFMMsGSqMLawVPm30CoCS+sxHDhxlLJkJ+vedDvZBE
         MW6HfljymPp4v00gz3YenpXWqQprzr+3fZiGfvzPyypnn/sogxV6v4oGY1c3e2zvWl0b
         5tig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ithzm7bOjV8wbNhNzEnLGR9nEC2NaqvU2/vT/qn4YDY=;
        b=eVU/xAfZkv7P4JY84YZiqG9VA+7/Xt0q93nwKH2jpn3nn9C0jZuH7a6c+D517Oi7vP
         f+okpGtq4sGkqnzITYUOtJ8WlWhccDJ9cizLJq6u/19zrxeH6m7bjRElSzBenVPCSIwt
         ruxEjPrxD2XX2w0UYy38seDgoq7jIxwhNJYpUj0EnEvG2+G9x9XHC9NYMnKfyqddbFZ6
         dtITp+lHUWaJGLskgzgYS2/0GwUUhWvXMnbnPy1jzJuaPWbT45rOiq/C8TUUMcbd3W5U
         kVJzMObJuZrSq5e+EpTozwMdDl/tbV82dam55z8e3MD84/hExRY9/UQ8V1VzryDDlnow
         hDbA==
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
Subject: [PATCH 4.15 076/146] scsi: qla2xxx: Fix NULL pointer crash due to probe failure
Date: Tue, 13 Mar 2018 16:24:03 +0100
Message-Id: <20180313152326.623263537@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837058075181473?=
X-GMAIL-MSGID: =?utf-8?q?1594837058075181473?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3011,9 +3011,6 @@ qla2x00_probe_one(struct pci_dev *pdev,
 	base_vha = qla2x00_create_host(sht, ha);
 	if (!base_vha) {
 		ret = -ENOMEM;
-		qla2x00_mem_free(ha);
-		qla2x00_free_req_que(ha, req);
-		qla2x00_free_rsp_que(ha, rsp);
 		goto probe_hw_failed;
 	}
 
@@ -3074,7 +3071,7 @@ qla2x00_probe_one(struct pci_dev *pdev,
 	/* Set up the irqs */
 	ret = qla2x00_request_irqs(ha, rsp);
 	if (ret)
-		goto probe_init_failed;
+		goto probe_hw_failed;
 
 	/* Alloc arrays of request and response ring ptrs */
 	if (!qla2x00_alloc_queues(ha, req, rsp)) {
@@ -3390,6 +3387,9 @@ probe_failed:
 	scsi_host_put(base_vha->host);
 
 probe_hw_failed:
+	qla2x00_mem_free(ha);
+	qla2x00_free_req_que(ha, req);
+	qla2x00_free_rsp_que(ha, rsp);
 	qla2x00_clear_drv_active(ha);
 
 iospace_config_failed:
