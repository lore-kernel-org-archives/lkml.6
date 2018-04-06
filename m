Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48QvSzr73TNRBBXm+96rrlynsb6zGukqjpgcgkhgcWittz+8MF2ekZcM5++sPzzD/ZEPbTs
ARC-Seal: i=1; a=rsa-sha256; t=1523021232; cv=none;
        d=google.com; s=arc-20160816;
        b=cXXEs57NiOLneyahKJVa3kUeLFTSyAS+fP96XpPjfLfZtRVmHYOydMK241uMcnFRdb
         fxTEwAxrsRmiEIWGD95z8hyZDDeIxf4HtjSm753Z3f2ROs6/psOPDiyC8a0+8zqeqXwx
         yupsNoZgX+xSzaCMpQABfwSHUJY3eYdWexhXeZlIjJtALye6AW5S40xEsJiGVCWJBRsR
         osq8WYmSo7PR9nhTpxwnZWChi7oYuddOCzX8gffr+ZWK7S35FuqoIv3cmWmIRviggvas
         +Eo++gUXaabSPzh2Grpc/Wi4dGx9VCX2hkYc5b+F0VpKmVPoBw8LiNTnC+w0oj2397cy
         4B7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yBBkGXUwVsmT1LVwOFK0YRA+xeGcE3gHcrcsWfEI9HM=;
        b=HRUjv1yLGifeqwjXByGCnWjOofa7TdOyF467QLEszSVSacWLEroDzlnO1DHhe8fm0S
         +igobJMyYkx0zr5y9YoWq4VrO/6eDiDl3SEBf05IXVfAjYhcnqj9hCNsQgQ1RkmXUyph
         WQS1AhXSnFUcIqWUW3Ikozbbw8RNtphxR//a7is2VjO/ToATkeOsWpSm3s857HVUMdwT
         R1fDC5R9Imi68SsSg4r4NHSqJYOVqwZeJ2QKg/3u4yYb3ZXNOnOTHs9dMMGZMH3I4ivh
         T1iWkNuhEpAyBh1GbUJyoOlwv7WVpDQkaVgXzXviTtIQvf8OCe8Cb980jgHCqdAczv4r
         yRjw==
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
Subject: [PATCH 3.18 56/93] scsi: virtio_scsi: always read VPD pages for multiqueue too
Date: Fri,  6 Apr 2018 15:23:25 +0200
Message-Id: <20180406084227.346162225@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003512073897792?=
X-GMAIL-MSGID: =?utf-8?q?1597003512073897792?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -794,6 +794,7 @@ static struct scsi_host_template virtscs
 	.change_queue_depth = virtscsi_change_queue_depth,
 	.eh_abort_handler = virtscsi_abort,
 	.eh_device_reset_handler = virtscsi_device_reset,
+	.slave_alloc = virtscsi_device_alloc,
 
 	.can_queue = 1024,
 	.dma_boundary = UINT_MAX,
