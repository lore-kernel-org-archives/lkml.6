Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/JV57qNDhWO2t7Hxi1sK/0y4lYOQD9FLUHz2ZhIzliKBfj5gtK6dGLb+ms3v0sjKtV0UjT
ARC-Seal: i=1; a=rsa-sha256; t=1523021668; cv=none;
        d=google.com; s=arc-20160816;
        b=mHo8r9aQco7CoieNUypvcr/ZzUOYIagxjV27a/NKdouc/Tt5pnpd3c0CWGX7xOtTu8
         HotsIy3fIontbJ3rW5lZyzJTXqJsWGFC86DssCLsqHvtKYq1dLKRed6XsYSpQKWyeX2H
         njmTRnNgkE7CdAU3mnbdIhV7BPiCmNnqWzhMyYgsXCnfja2onTTuW0zGVti24eMV4zYK
         Y5R2lUAoPM1ENWj1PIKhy+NZbFZcYpYnsouS3RWQc1JYUgofnV2gzNWrXU5QY1PqzFJ0
         1YJabtW7X4hTep1GKAs2G1SIOVPLwtUf61XvESLbScTNTUbAMbJyywXkx3NKy/s0YC86
         jj2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ekvvzAzI9L/KMre4UP0xhVGJtuxFyE/ENmM197iB5sk=;
        b=nIs4Hxk8zILoVFzIrVcDKEMPfYOCBgXAsBCJ417KNAR6fa4Kbz9UjDUZyY3AyMQtCu
         Zy43HoHDQrCAr31H1U7E/m9v8F7nTBBEaxW9VWV2G+AzXxYEbm3Xu7wGjQMZIXXrU8sN
         NQBTdCOZhOUvPhacP9uNbv4ezjVb/A5muFxC1gg8vFrnE2hys6NONf5LLyBfvk6vg6yf
         qHAADnr/eY7uAQm2n9q4YhQ9eM/bYcYh4DhzRxEBO3W7TNMoz91eaeMBo3lSWSsQZFXg
         vzMK5Kn7Yfp5Hzm8HDSojqbJCyfATxp6KRsQ8IphJl8SbfRHwTrD+DxP8t69AoNvuv/f
         7+TQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Gibson <david@gibson.dropbear.id.au>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Fam Zheng <famz@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 048/102] scsi: virtio_scsi: always read VPD pages for multiqueue too
Date: Fri,  6 Apr 2018 15:23:29 +0200
Message-Id: <20180406084338.376839140@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003512073897792?=
X-GMAIL-MSGID: =?utf-8?q?1597003968992714071?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit a680f1d463aeaeb00d22af257a56e111967c2f18 upstream.

Multi-queue virtio-scsi uses a different scsi_host_template struct.  Add
the .device_alloc field there, too.

Fixes: 25d1d50e23275e141e3a3fe06c25a99f4c4bf4e0
Cc: stable@vger.kernel.org
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/virtio_scsi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -819,6 +819,7 @@ static struct scsi_host_template virtscs
 	.change_queue_depth = virtscsi_change_queue_depth,
 	.eh_abort_handler = virtscsi_abort,
 	.eh_device_reset_handler = virtscsi_device_reset,
+	.slave_alloc = virtscsi_device_alloc,
 
 	.can_queue = 1024,
 	.dma_boundary = UINT_MAX,
