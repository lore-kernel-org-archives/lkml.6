Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtGqDw351jhQ8/EuAuXIzmaaPXsXmcPqm/BV3OcpGwTw+6+I9FSpeP6jkl69FFSeHx8A0Uu
ARC-Seal: i=1; a=rsa-sha256; t=1521800278; cv=none;
        d=google.com; s=arc-20160816;
        b=vEJZLOS0NiNzypLhKRzPO9eP36Wh9gvH5+aT7H7E9WdbY+7qIXV0V7bdSiXIglxou5
         NfkZ1b+eKpcWiuyEe/0SBLORiPFhwFFmgPFSIXDZ9ZSFidjhix8XMiFw9fHZyS6NBdvG
         aFMPHzLkCP3HaQ49VF9P6/EQuWfXxQpuxcMmFsEyV3u5LnuTk1+zGNIDBIOnsA02m0zt
         egBALdsr3sHhQtjZj/UuytAJWlTAgMN9BbExr0DohM+JqzWkPVyaOkVXVQ+x6wZxeGbb
         /KeyGVrxDr+SZsaufIFfkoqcis+aOQmtkXVZ52kfFlQm77ESFzPbxRNarUxa4zAZGjP4
         IYXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=B13j0NPpD4wwVnHBwioEIf1zbfq3h0cM/clJT7O5rt0=;
        b=qwMu0ojqpP9a5h4YkPz7lws9IRWuLmvAMZm1E+j434/N7GuKUF0uxZnenvtLn77yFq
         /00AnZ20S3eDbgft7ByZoST5SopHHTCOOfozksWfRbB6n2F4fGYwSNvgs/9VBDc/RfYZ
         TmqiEToJ0TSb30HYH99KisKX5GTlyltXjZVZJQykyT3XNbJCn7CJ4LkmJL3M10xEAhjg
         pNWxHgSbz4NZQFgh+FX/NIUXajra6n3ibqbWdNbM0Y2uKpc9dq6X/Bb+0EOYAm/zHWVE
         SDoggpkfusMhLeQmgsNpNuAX4w3+3/fGwYI1DJUdz3zM+9rQy3IQ6boaZDSZoBKgBZJs
         /ocA==
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
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 12/47] scsi: virtio_scsi: Always try to read VPD pages
Date: Fri, 23 Mar 2018 10:55:03 +0100
Message-Id: <20180323094248.649887397@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722488891049778?=
X-GMAIL-MSGID: =?utf-8?q?1595723248841673557?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Gibson <david@gibson.dropbear.id.au>


[ Upstream commit 25d1d50e23275e141e3a3fe06c25a99f4c4bf4e0 ]

Passed through SCSI targets may have transfer limits which come from the
host SCSI controller or something on the host side other than the target
itself.

To make this work properly, the hypervisor can adjust the target's VPD
information to advertise these limits.  But for that to work, the guest
has to look at the VPD pages, which we won't do by default if it is an
SPC-2 device, even if it does actually support it.

This adds a workaround to address this, forcing devices attached to a
virtio-scsi controller to always check the VPD pages.  This is modelled
on a similar workaround for the storvsc (Hyper-V) SCSI controller,
although that exists for slightly different reasons.

A specific case which causes this is a volume from IBM's IPR RAID
controller (which presents as an SPC-2 device, although it does support
VPD) passed through with qemu's 'scsi-block' device.

[mkp: fixed typo]

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/virtio_scsi.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -28,6 +28,7 @@
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_tcq.h>
+#include <scsi/scsi_devinfo.h>
 #include <linux/seqlock.h>
 
 #define VIRTIO_SCSI_MEMPOOL_SZ 64
@@ -664,6 +665,28 @@ static int virtscsi_device_reset(struct
 	return virtscsi_tmf(vscsi, cmd);
 }
 
+static int virtscsi_device_alloc(struct scsi_device *sdevice)
+{
+	/*
+	 * Passed through SCSI targets (e.g. with qemu's 'scsi-block')
+	 * may have transfer limits which come from the host SCSI
+	 * controller or something on the host side other than the
+	 * target itself.
+	 *
+	 * To make this work properly, the hypervisor can adjust the
+	 * target's VPD information to advertise these limits.  But
+	 * for that to work, the guest has to look at the VPD pages,
+	 * which we won't do by default if it is an SPC-2 device, even
+	 * if it does actually support it.
+	 *
+	 * So, set the blist to always try to read the VPD pages.
+	 */
+	sdevice->sdev_bflags = BLIST_TRY_VPD_PAGES;
+
+	return 0;
+}
+
+
 /**
  * virtscsi_change_queue_depth() - Change a virtscsi target's queue depth
  * @sdev:	Virtscsi target whose queue depth to change
@@ -752,6 +775,7 @@ static struct scsi_host_template virtscs
 	.change_queue_depth = virtscsi_change_queue_depth,
 	.eh_abort_handler = virtscsi_abort,
 	.eh_device_reset_handler = virtscsi_device_reset,
+	.slave_alloc = virtscsi_device_alloc,
 
 	.can_queue = 1024,
 	.dma_boundary = UINT_MAX,
